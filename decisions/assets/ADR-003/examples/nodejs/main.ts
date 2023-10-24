import { Octokit } from "octokit";
import { createAppAuth } from "@octokit/auth-app";
import * as fs from "fs";

export const getOctokit = async (
  appId: string,
  privateKey: string,
  orgName: string
): Promise<Octokit> => {
  const appOctokit = new Octokit({
    authStrategy: createAppAuth,
    auth: {
      appId,
      privateKey,
    },
  });
  const installations = await appOctokit.request("GET /app/installations");
  for (const d of installations.data) {
    //@ts-ignore
    if (d.account.login === orgName) {
      const installationId = d.id;
      const installationOctokit = new Octokit({
        authStrategy: createAppAuth,
        auth: {
          appId,
          privateKey,
          installationId,
        },
      });
      return installationOctokit;
    }
  }

  throw new Error(`No installation found for organization ${orgName}`);
};

const ghAppId = process.env.GITHUB_APP_ID;
const ghAppPkFile = process.env.GITHUB_APP_PK_FILE;
const ghOrg = process.env.GITHUB_ORG;

(async () => {
  if (!ghAppId || !ghAppPkFile || !ghOrg) {
    throw new Error(
      "Environment variables GITHUB_APP_ID, GITHUB_APP_PK_FILE, and GITHUB_ORG must be passed to this program."
    );
  }
  const octokit = await getOctokit(
    ghAppId,
    fs.readFileSync(ghAppPkFile, "utf8"),
    ghOrg
  );
  const repos = await octokit.request("GET /orgs/{org}/repos", {
    org: ghOrg,
  });

  console.log(repos.data);
})();

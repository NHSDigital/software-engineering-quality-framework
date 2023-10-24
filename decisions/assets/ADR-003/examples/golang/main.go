package main

import (
	"crypto/x509"
	"encoding/json"
	"encoding/pem"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"time"

	"github.com/go-resty/resty/v2"
	"github.com/golang-jwt/jwt"
)

type Installation struct {
	ID      int `json:"id"`
	Account struct {
		Login string `json:"login"`
	} `json:"account"`
}

func main() {

	ghAppId := os.Getenv("GITHUB_APP_ID")
	ghAppPkFile := os.Getenv("GITHUB_APP_PK_FILE")
	ghOrg := os.Getenv("GITHUB_ORG")

	if ghAppId == "" || ghAppPkFile == "" || ghOrg == "" {
		log.Fatalf("Environment variables GITHUB_APP_ID, GITHUB_APP_PK_FILE and GITHUB_ORG must be passed to this program.")
	}

	jwtToken := getJwtToken(ghAppId, ghAppPkFile)
	installationId := getInstallationId(jwtToken, ghOrg)
	accessToken := getAccessToken(jwtToken, installationId)

	fmt.Printf("GITHUB_TOKEN=%s\n", accessToken)
}

func getJwtToken(ghAppId string, ghAppPkFile string) string {

	pemContent, _ := ioutil.ReadFile(ghAppPkFile)
	block, _ := pem.Decode(pemContent)
	privateKey, _ := x509.ParsePKCS1PrivateKey(block.Bytes)
	token := jwt.NewWithClaims(jwt.SigningMethodRS256, jwt.MapClaims{
		"iat": time.Now().Unix(),
		"exp": time.Now().Add(10 * time.Minute).Unix(),
		"iss": ghAppId,
	})
	jwtToken, _ := token.SignedString(privateKey)

	return jwtToken
}

func getInstallationId(jwtToken string, ghOrg string) int {

	client := resty.New()
	resp, _ := client.R().
		SetHeader("Authorization", "Bearer "+jwtToken).
		SetHeader("Accept", "application/vnd.github.v3+json").
		Get("https://api.github.com/app/installations")

	var installations []Installation
	json.Unmarshal(resp.Body(), &installations)
	installationId := 0
	for _, installation := range installations {
		if installation.Account.Login == ghOrg {
			installationId = installation.ID
		}
	}

	return installationId
}

func getAccessToken(jwtToken string, installationId int) string {

	client := resty.New()
	resp, _ := client.R().
		SetHeader("Authorization", "Bearer "+jwtToken).
		SetHeader("Accept", "application/vnd.github.v3+json").
		Post(fmt.Sprintf("https://api.github.com/app/installations/%d/access_tokens", installationId))

	var result map[string]interface{}
	json.Unmarshal(resp.Body(), &result)

	return result["token"].(string)
}

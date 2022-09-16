config: githooks

githooks:
	echo "scripts/markdown-check-format.sh" > .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

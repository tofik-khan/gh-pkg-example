echo "Running script publish.sh...";

echo "publish.sh: Bump version in package.json";
## Bump version in package.json
version=$(npm version patch);

echo "publish.sh: package.json updated to version: $version";

#git commit -m "$messageTitle" -m "$messageBody";


echo "publish.sh: Pushing updated version to GitHub";
#git push;

#echo "publish.sh: Publishing to NPM registery";
##npm publish;
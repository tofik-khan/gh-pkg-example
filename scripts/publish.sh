echo "Running script publish.sh...";

echo "publish.sh: Bump version in package.json";
## Bump version in package.json
version=$(npm version patch);

echo "publish.sh: package.json updated to version: $version";

echo "publish.sh: Adding package.json to git repository";
git add package.json;

echo "publish.sh: Creating commit message";
messageTitle="AUTO PUBLISH: Publishing to npm package with version: $version";
messageBody="Auto-generate release commit\
\
Publish version $version to npm using publish.sh script.";

git commit -m "$messageTitle" -m "$messageBody";


echo "publish.sh: Pushing updated version to GitHub";
git push;

echo "publish.sh: Publishing to NPM registery";
npm publish;
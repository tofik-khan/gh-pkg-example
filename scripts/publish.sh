echo "Running script publish.sh...";

echo "publish.sh: Switching to master branch";
echo " >>> Potentially stashes uncommited work";
git stash;
git checkout master;

echo "publish.sh: Pulling latest changes";
git pull; 

echo "publish.sh: Bump version in package.json";

echo "Checking release type...";
if [ "$1" == "--release=major" ]; then
  echo "Setting as MAJOR release";
  version=$(npm version major);
elif [ "$1" == "--release=minor" ]; then
  echo "Setting as MINOR release";
  version=$(npm version minor);
else
  echo "Setting as PATCH release";
  version=$(npm version patch);
fi

echo "publish.sh: package.json updated to version: $version";

echo "publish.sh: Pushing updated version to GitHub";
git push;

echo "publish.sh: Publishing to NPM registry";
npm publish;
echo "Running script publish.sh...";

echo "publish.sh: Switching to master branch";
echo " >>> Potentially stashes uncommited work";
git stash;
git checkout master;

echo "publish.sh: Pulling latest changes";
git pull; 

echo "publish.sh: Bump version in package.json";
version=$(npm version patch);

echo "publish.sh: package.json updated to version: $version";

echo "publish.sh: Pushing updated version to GitHub";
git push;

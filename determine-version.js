const core = require("@actions/core");
const github = require("@actions/github");
const fs = require("fs");

async function run() {
  console.log("Running Script: `determine-version.js`");
  try {
    const token = process.env.GITHUB_TOKEN;
    const octokit = github.getOctokit(token);
    const { owner, repo } = github.context.repo;
    const releaseId = github.context.payload.release.id;
    console.log("Release ID:", releaseId);

    // Fetch labels for the release
    const response = await octokit.repos.listLabelsOnRelease({
      owner,
      repo,
      release_id: releaseId,
    });

    // Determine version based on labels (example logic)
    let version = getNextVersion();
    console.log("Version:", version);

    // Update package.json with the new version
    updatePackageJson(version);

    core.setOutput("version", version);
  } catch (error) {
    core.setFailed(error.message);
  }
}

function getNextVersion() {
  // Example logic, adjust as needed
  const currentVersion = JSON.parse(fs.readFileSync("package.json")).version;
  const [major, minor, patch] = currentVersion.split(".").map(Number);

  if (response.data.some((label) => label.name === "major")) {
    return `${major + 1}.0.0`;
  } else if (response.data.some((label) => label.name === "minor")) {
    return `${major}.${minor + 1}.0`;
  } else {
    return `${major}.${minor}.${patch + 1}`;
  }
}

function updatePackageJson(version) {
  // Read current package.json
  const packageJsonPath = "package.json";
  const packageJson = JSON.parse(fs.readFileSync(packageJsonPath));

  // Update version in package.json
  packageJson.version = version;

  // Write the updated package.json back to the file
  fs.writeFileSync(packageJsonPath, JSON.stringify(packageJson, null, 2));
}

run();

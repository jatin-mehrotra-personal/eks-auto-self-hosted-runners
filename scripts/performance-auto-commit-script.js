const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");

// Use absolute paths to ensure correct file locations
const currentDir = process.cwd();
const repoPath = path.join(currentDir, "eks-auto-self-hosted-runners");
const logFilePath = path.join(repoPath, "commit_log.txt");
const intervalTime = 45 * 1000; // Every 45 seconds
const maxRunTime = 10 * 60 * 1000; // 10 minutes

const setupGitConfig = () => {
    exec('git config user.name "Auto Commit Script"', { cwd: repoPath });
    exec('git config user.email "auto-commit@example.com"', { cwd: repoPath });
};

const makeCommit = () => {
    const timestamp = new Date().toISOString();

    try {
        // Write directly to commit_log.txt in the repository root
        fs.appendFileSync(
            logFilePath,
            `Auto commit at ${timestamp}\n`
        );
        console.log(`Updated log file at ${logFilePath}`);

        // Add, commit, and push changes
        exec(`git add commit_log.txt`, { cwd: repoPath }, (err) => {
            if (err) {
                console.error("Error adding file:", err);
                return;
            }

            console.log("File added to git");

            exec(
                `git commit -m "Auto commit at ${timestamp}"`,
                { cwd: repoPath },
                (err) => {
                    if (err) {
                        console.error("Error committing changes:", err);
                        return;
                    }

                    console.log("Changes committed");

                    exec("git push origin master --force", { cwd: repoPath }, (err) => {
                        if (err) {
                            console.error("Error pushing changes:", err);
                            return;
                        }
                        console.log("Changes pushed successfully");
                    });
                }
            );
        });
    } catch (err) {
        console.error("Error in makeCommit:", err);
    }
};

console.log("Starting auto-commit script...");
console.log(`Repository path: ${repoPath}`);
console.log(`Log file: ${logFilePath}`);

setupGitConfig();
console.log("Git config set up");

// Make an initial commit
makeCommit();

// Set up interval for regular commits
const interval = setInterval(makeCommit, intervalTime);
console.log(`Scheduled commits every ${intervalTime / 1000} seconds`);

// Stop the script after 10 minutes
setTimeout(() => {
    clearInterval(interval);
    console.log("Script completed after 10 minutes");
}, maxRunTime);

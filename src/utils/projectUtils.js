const { exec } = require('child_process');
const { promisify } = require('util');
const fs = require('fs').promises;
const path = require('path');

const execAsync = promisify(exec);

/**
 * Get Git information about the current repository
 */
async function getGitInfo() {
  try {
    const [branch, commit, author, date] = await Promise.all([
      execAsync('git rev-parse --abbrev-ref HEAD'),
      execAsync('git rev-parse HEAD'),
      execAsync('git log -1 --pretty=format:"%an"'),
      execAsync('git log -1 --pretty=format:"%ad" --date=iso')
    ]);

    return {
      branch: branch.stdout.trim(),
      commit: commit.stdout.trim().substring(0, 8),
      author: author.stdout.trim(),
      lastCommitDate: date.stdout.trim(),
      repository: 'Elevate-labs'
    };
  } catch (error) {
    return {
      error: 'Git information not available',
      message: 'This might not be a Git repository or Git is not installed',
      repository: 'Elevate-labs',
      author: 'tohidhanfi'
    };
  }
}

/**
 * Get project statistics
 */
async function getProjectStats() {
  try {
    const projectPath = path.join(__dirname, '..');
    
    // Count files by type
    const files = await getAllFiles(projectPath);
    const stats = {
      totalFiles: files.length,
      fileTypes: {},
      directories: [],
      lastModified: new Date().toISOString()
    };

    // Analyze file types
    files.forEach(file => {
      const ext = path.extname(file).toLowerCase();
      if (ext) {
        stats.fileTypes[ext] = (stats.fileTypes[ext] || 0) + 1;
      } else {
        stats.fileTypes['no-extension'] = (stats.fileTypes['no-extension'] || 0) + 1;
      }
    });

    // Get directory structure
    const dirs = await getDirectories(projectPath);
    stats.directories = dirs.map(dir => path.relative(projectPath, dir));

    return stats;
  } catch (error) {
    return {
      error: 'Failed to get project statistics',
      message: error.message
    };
  }
}

/**
 * Get all files in a directory recursively
 */
async function getAllFiles(dirPath) {
  const files = [];
  
  try {
    const items = await fs.readdir(dirPath);
    
    for (const item of items) {
      const fullPath = path.join(dirPath, item);
      const stat = await fs.stat(fullPath);
      
      if (stat.isDirectory()) {
        // Skip node_modules and other common directories
        if (!['node_modules', '.git', '.vscode', 'coverage'].includes(item)) {
          const subFiles = await getAllFiles(fullPath);
          files.push(...subFiles);
        }
      } else {
        files.push(fullPath);
      }
    }
  } catch (error) {
    // Ignore errors for inaccessible directories
  }
  
  return files;
}

/**
 * Get all directories in a path
 */
async function getDirectories(dirPath) {
  const dirs = [];
  
  try {
    const items = await fs.readdir(dirPath);
    
    for (const item of items) {
      const fullPath = path.join(dirPath, item);
      const stat = await fs.stat(fullPath);
      
      if (stat.isDirectory()) {
        if (!['node_modules', '.git', '.vscode', 'coverage'].includes(item)) {
          dirs.push(fullPath);
          const subDirs = await getDirectories(fullPath);
          dirs.push(...subDirs);
        }
      }
    }
  } catch (error) {
    // Ignore errors for inaccessible directories
  }
  
  return dirs;
}

/**
 * Get Git branch information
 */
async function getBranches() {
  try {
    const { stdout } = await execAsync('git branch -a');
    return stdout.split('\n')
      .map(line => line.trim())
      .filter(line => line && !line.startsWith('*'))
      .map(line => line.replace('remotes/origin/', ''));
  } catch (error) {
    return [];
  }
}

/**
 * Get recent commits
 */
async function getRecentCommits(limit = 5) {
  try {
    const { stdout } = await execAsync(`git log --oneline -${limit}`);
    return stdout.split('\n')
      .map(line => line.trim())
      .filter(line => line);
  } catch (error) {
    return [];
  }
}

module.exports = {
  getGitInfo,
  getProjectStats,
  getBranches,
  getRecentCommits
}; 
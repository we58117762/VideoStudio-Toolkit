#!/usr/bin/env node

import { execSync } from "node:child_process";
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const SCRIPT_DIR = dirname(fileURLToPath(import.meta.url));
const REPO_ROOT = resolve(SCRIPT_DIR, "..");
const PACKAGE_PATH = resolve(
  REPO_ROOT,
  "packages",
  "create-vibe-motion-3d",
  "package.json"
);

const bump = process.argv[2];
if (!["patch", "minor", "major"].includes(bump)) {
  console.error("Usage: node scripts/release.mjs <patch|minor|major>");
  process.exit(1);
}

const pkg = JSON.parse(readFileSync(PACKAGE_PATH, "utf8"));
const [major, minor, patch] = pkg.version.split(".").map(Number);

let next;
if (bump === "major") {
  next = `${major + 1}.0.0`;
} else if (bump === "minor") {
  next = `${major}.${minor + 1}.0`;
} else {
  next = `${major}.${minor}.${patch + 1}`;
}

pkg.version = next;
writeFileSync(PACKAGE_PATH, `${JSON.stringify(pkg, null, 2)}\n`, "utf8");
console.log(`bumped: ${next}`);

const run = (command) => execSync(command, { cwd: REPO_ROOT, stdio: "inherit" });

run("node scripts/sync-template-to-cli.mjs");
run("git add packages/create-vibe-motion-3d/package.json packages/create-vibe-motion-3d/template");
run(`git commit -m "v${next}"`);
run(`git tag -a v${next} -m "v${next}"`);
run("git push origin main --follow-tags");

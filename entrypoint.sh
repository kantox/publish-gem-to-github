#!/bin/sh -l

GITHUB_TOKEN=$1
OWNER=$2

[ -z "${GITHUB_TOKEN}" ] && { echo "Missing input.token!"; exit 2; }
[ -z "${OWNER}" ] && { echo "Missing input.owner!"; exit 2; }

echo "Setting up access to GitHub Package Registry"
mkdir -p ~/.gem
touch ~/.gem/credentials
chmod 600 ~/.gem/credentials
echo ":github: Bearer ${GITHUB_TOKEN}" >> ~/.gem/credentials

echo "Building the gem"
gem build *.gemspec
echo "Pushing the built gem to GitHub Package Registry"
gem push --key github --host "https://rubygems.pkg.github.com/${OWNER}" *.gem

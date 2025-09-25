#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

git switch main
version=$(nix eval --raw '.#nixosConfigurations.nixos-installer.config.system.nixos.version')
git commit --allow-empty --message "nixos-images $version"
git tag "$version"

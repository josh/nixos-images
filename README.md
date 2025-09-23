# nixos-images

Personal fork of [nix-community/nixos-images](https://github.com/nix-community/nixos-images).

## nixos-installer

Modified NixOS installer iso with **insecure** open ssh ready for [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) take over. For homelab and private network usage. Probably don't use on public cloud.

```sh
nix build github:josh/nixos-images#nixos-installer-iso
nixos-anywhere --flake github:josh/some-nixos-flake --target-host nixos@nixos-installer.local
```

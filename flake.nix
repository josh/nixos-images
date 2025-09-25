{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux = {
        nixos-installer-iso = self.nixosConfigurations.nixos-installer.config.system.build.isoImage;

        all-isos = nixpkgs.legacyPackages.x86_64-linux.runCommand "all-isos" { } ''
          mkdir $out
          ln -s ${self.packages.x86_64-linux.nixos-installer-iso}/iso/*.iso $out/
        '';
      };

      nixosModules.installer = ./installer.nix;

      nixosConfigurations.nixos-installer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ self.nixosModules.installer ];
      };

      checks.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        {
          nixos-installer-build = pkgs.runCommand "nixos-installer-build" {
            env.PKG = self.nixosConfigurations.nixos-installer.config.system.build.toplevel;
          } "touch $out";
        };
    };
}

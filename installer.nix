{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    "${modulesPath}/profiles/qemu-guest.nix"
  ];

  networking.hostName = "nixos-installer";
  isoImage.edition = "installer";

  environment.systemPackages = with pkgs; [
    disko
    gh
    nh
  ];

  boot.kernelParams = [ "console=ttyS0" ];
  boot.loader.timeout = lib.modules.mkForce 1;

  networking.firewall.enable = false;
  networking.useNetworkd = true;
  systemd.network.networks."99-ethernet-default-dhcp".networkConfig.MulticastDNS = "yes";

  services.acpid.enable = true;
  services.qemuGuest.enable = true;

  security.sudo.wheelNeedsPassword = false;
  services.getty.helpLine = lib.modules.mkForce "";
  users.users.nixos.initialHashedPassword = "";
  users.users.root.initialHashedPassword = "";

  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.openssh.settings.KbdInteractiveAuthentication = false;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitEmptyPasswords = true;
  services.openssh.settings.PermitRootLogin = "yes";
  security.pam.services.sshd.allowNullPassword = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.installer.channel.enable = false;
  system.stateVersion = config.system.nixos.release;
}

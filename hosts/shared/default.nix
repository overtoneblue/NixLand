{
  inputs,
  outputs,
  pkgs,
  lib,
  config,
  osConfig,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    # (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" "cenunix" ])
    ./options
    ../../core
    ./hm-alias.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs pkgs; };
    backupFileExtension = "backup";
    users = {
      cenunix = {
        imports = [
          ../../core/home.nix
          inputs.self.homeModules.myNeovim
        ];
      };
    };
  };

  programs.zsh.enable = true;

  users.users = {
    # FIXME: Replace with your username
    cenunix = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "changeme";
      isNormalUser = true;
      shell = pkgs.zsh;

      # openssh.authorizedKeys.keys = [
      #   # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      # ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [
        "wheel"
        "networkManager"
        "video"
      ]
      ++ ifTheyExist [
        "docker"
        "libvirtd"
        "kvm"
        "qemu-libvirtd"
        "wireshark"
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhMaC2Hg0H3VjCiFyOlQmn8OWRuKSR05LIP1jdp5zpu cenunix@europa"
      ];
    };
  };

  time = {
    timeZone = "America/Los_Angeles";
    hardwareClockInLocalTime = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services = {
    printing.enable = true;
  };

  security.rtkit.enable = true;

}

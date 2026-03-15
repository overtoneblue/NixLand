{
  config,
  pkgs,
  osConfig,
  ...
}:
{
  imports = [
    ./hardware-config.nix
    ./system.nix
    ../shared
  ];

  boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
      extraFiles = {
        "devicetree.dtb" =
          "${config.boot.kernelPackages.kernel}/dtbs/qcom/sc8280xp-lenovo-thinkpad-x13s.dtb";
      };
      extraPerEntryConfig = "devicetree ($drive1)//devicetree.dtb";
      extraConfig = ''
        terminal_input console
        terminal_output gfxterm
      '';
    };
    #loader.efi.canTouchEfiVariables = true;
    loader.efi.efiSysMountPoint = "/boot";

    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "efi=novamap,noruntime"
      "clk_ignore_unused"
      "pd_ignore_unused"
      "arm64.nopauth"
      "iommu.passthrough=0"
      "iommu.strict=0"
      "pcie_aspm.policy=powersupersave"
      "root=PARTUUID=89578242-4aef-8e4f-8ecc-99829a0611c8"
      #"dtb=${config.boot.kernelPackages.kernel}/dtbs/qcom/${dtbname}"
    ];
    initrd = {
      includeDefaultModules = false;
      availableKernelModules = [
        "nvme"
        "phy_qcom_qmp_pcie"
        # "pcie_qcom"
        "i2c_hid_of"
        "i2c_qcom_geni"
        "leds_qcom_lpg"
        "pwm_bl"
        "qrtr"
        "pmic_glink_altmode"
        "gpio_sbu_mux"
        "phy_qcom_qmp_combo"
        "panel-edp"
        "msm"
        "phy_qcom_edp"
        "v4l2_mem2mem"
        "venus_core"
        "venus_dec"
        "venus_enc"
      ];
    };
  };

  hardware = {
    # enableRedistributableFirmware = true;
    # firmwareCompression = "none";
    # firmware = [ pkgs.linux-firmware ];
    deviceTree.enable = true;
  };

  networking.hostName = "callisto"; # Define your hostname.

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}

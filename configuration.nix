# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

#UNTUK HARDWARE
	
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
      extraPackages = with pkgs; [
         mesa.drivers
         vulkan-loader
  ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
         mesa.drivers
         vulkan-loader
  ];
};

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vashlinux = {
    isNormalUser = true;
    description = "M. Radinka Kevan";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh; # WAJIB ADA UNTUK TERMINAL
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
    "qtwebengine-5.15.19"
    "ciscoPacketTracer8-8.2.2"
    "intel-media-sdk-23.2.2"
    
];
};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # UNTUK PKGS======================================================================
  environment.systemPackages = with pkgs; [
    #aplikasi biasa
    goverlay
    mangohud
    brave
    protonup-qt
    neofetch
    ciscoPacketTracer8
    git

    #bahan-bahan zsh
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
  ];

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #=================================================================================
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

 #UNTUK PROGRAM=====================
 
 programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true;
    extraPackages = with pkgs; [
      mesa        #OpenGL/Vulkan support
      vulkan-tools #includes vkcube, vulkaninfo
      gperftools  #Libtcmalloc
      libunwind   #64 bit fix crashes
      libthai     #Text Rendering (sometimes needed)
  ];
};

#ZSH sebagai shell, auto-suggestions, prediksi abu abu, dan pilih-pilih tab
 programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    interactiveShellInit = ''
    zstyle ':completion:*' menu select
    bindkey '^[[Z' reverse-menu-complete
          #GANTI PROMPT JADI >
          PROMPT='%n@%m:%~ > '
   '';
};
    
 #===================================
 #UNTUK SERVICE
 
 services.tlp = {
    enable = true;
    settings = {
 #==Disini Tempat Settingan Tambahan==
    CPU_SCALING_GOVERNOR_ON_AC="powersave";
    CPU_SCALINGx_GOVERNOR_ON_BAT="powersave";
    
    CPU_ENERGY_PERF_POLICY_ON-AC="balance_performance"; 
    CPU_ENERGY_PERF_POLICY_ON_BAT="power";

    CPU_MIN_PERF_ON_AC=0;
    CPU_MAX_PERF_ON_AC=80;
    CPU_MIN_PERF_ON_BAT=0;
    CPU-MAX_PERF_ON_BAT=70;

    CPU_BOOST_ON_AC=0;
    CPU_BOOST_ON_BAT=0;
 
    CPU_HWP_DYN_BOOST_ON_AC=1;
    CPU_HWP_DYN_BOOST_ON_BAT=0;

    MEM_SLEEP_ON_AC="deep";
    MEM_SLEEP-ON_BAT="deep";

    DISK_APM_LEVEL_ON_AC="254 254";
    DISK_APM_LEVEL_ON_BAT="128 128";

    SATA_LINKPWR_ON_AC="max_performance";
    SATA_LINKPWR_ON_BAT="med_power_with_dipm";
  
    AHCI_RUNTIME_PM_ON_AC="on";
    AHCI_RUNTIME_PM_ON_BAT="auto";

    PCIE_ASPM_ON_AC="performance";
    PCIE_ASPM_ON_BAT="default";
 
    RUNTIME_PM_ON_AC="on";
    RUNTIME_PM-ON_BAT="auto";

    INTEL_GPU_MIN_FREQ_ON_BAT = 300;
    INTEL-GPU_MAX_FREQ_ON_BAT = 750;

    USB_AUTOSUSPEND=1;
    }; #Kurung Tutup Settings
}; #Kurung Tutup Services.tlp

  
 services.undervolt = {
    enable = true;
 #Setting===== 
    coreOffset = -80;
    gpuOffset = -50;
    uncoreOffset = -80;
    analogioOffset = 0;
    temp = 90;
}; #Kurung Tutup services.undervolt

zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50; #Dia bakal pakai maksimal 50% dari total RAM untuk dikompresi
}; #Kurung Tutup ZramSwap

services.flatpak.enable = true;


services.power-profiles-daemon.enable = false;


#Optimisasi Otomatis==== (nix.gc)
    nix.settings.auto-optimise-store = true;
    nix.gc = {
        automatic = true;                       #Bersih-Bersih Otomatis
        dates = "weekly";                       #Setiap Seminggu Sekali
        options = "--delete-older-than 7d";     #Hapus File Jika Umur Di Atas 7 hari
};


} #KURUNG TUTUP RAKSASA (JANGAN DIHAPUS)

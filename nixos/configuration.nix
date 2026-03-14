{config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; 
  fileSystems."/home/karson/hdd-mount" = {
   device = "/dev/disk/by-uuid/0101-3AC2";
   fsType = "exfat";
   options = [ # If you don't have this options attribute, it'll default to "defaults" 
     # boot options for fstab. Search up fstab mount options you can use
     "users" # Allows any user to mount and unmount
     "nofail" # Prevent system from failing if this drive doesn't mount
     
   ];
 };
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "cs_CZ.UTF-8";
    LC_IDENTIFICATION = "cs_CZ.UTF-8";
    LC_MEASUREMENT = "cs_CZ.UTF-8";
    LC_MONETARY = "cs_CZ.UTF-8";
    LC_NAME = "cs_CZ.UTF-8";
    LC_NUMERIC = "cs_CZ.UTF-8";
    LC_PAPER = "cs_CZ.UTF-8";
    LC_TELEPHONE = "cs_CZ.UTF-8";
    LC_TIME = "cs_CZ.UTF-8";
  };
  i18n.inputMethod = {
  enable = true;
  type = "ibus";
  ibus.engines = with pkgs.ibus-engines; [ pinyin ];
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  programs.dconf.profiles.user.databases = [
    {
      settings."org/gnome/desktop/interface" = {
        gtk-theme = "Adwaita";
        icon-theme = "Flat-Remix-Red-Dark";
        font-name = "Noto Sans Medium 11";
        document-font-name = "Noto Sans Medium 11";
        monospace-font-name = "Noto Sans Mono Medium 11";
      };
    }
  ];

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,cn,cz";
    variant = "";
  };
  # Enable CUPS to print documents.
  services.printing.enable = true;
  hardware.bluetooth = {
  enable = true;
  settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };
};

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true; # replaces PulseAudio
    jack.enable = true;

    # Optional: Enable Bluetooth extensions
    wireplumber.enable = true;

    extraConfig.pipewire."context.modules" = [
      {
        name = "libpipewire-module-bluez5";
        args = {
          "bluez5.msbc-support" = true;
          "bluez5.sbc-xq-support" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
        };
      }
    ];
  };
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  # fingerprint enable
  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;


  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.karson = {
    isNormalUser = true;
    description = "karson";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  services.flatpak.enable = true;
  programs.firefox.enable = true;
  services.mullvad-vpn.enable = true;
  # power management + charging limit
  services.auto-cpufreq = {
  enable = true;
  settings = {
    ideapad_laptop_conservation_mode = {
    enabled = true;
    };
  };
};

  programs.steam = {
  	enable = true;
	extraCompatPackages = [ pkgs.proton-ge-bin ];
	protontricks.enable = true;
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
  (final: prev: {
    libsecret = prev.libsecret.overrideAttrs (oldAttrs: {
      doCheck = false;
    });
  })
];
  programs.npm.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	waybar # systembar for hyprland
	dunst
	spotube
	swww
	kitty # terminal
	rofi # applauncher
	networkmanagerapplet
	vim
	wget
	discord
	librespot
	wineWowPackages.staging
	winetricks
	# gnome-extension-manager GNOME
	# gnome-extensions-cli GNOME
	git
	anki-bin
	mpv
	ibus
	chatterino7
	pkg-config
	tmux
	vlc
	prismlauncher
	davinci-resolve
	mullvad-vpn
	mullvad-browser
	ffmpeg
	blueman
	brightnessctl
	pwvucontrol
	brave	# chromium based browser as backup
	libreoffice
	# lutris - 5.19 deprecated, using flatpak instead
	iproute2
	htop
	nethogs
	p7zip
	hyprshot
	obs-studio
	sfm
	gparted
	parted
	disko
	exfatprogs
	f3
	hyprlock
	hypridle
	# 25.11 dependency fail retroarch-full
	linuxKernel.packages.linux_xanmod_stable.xone
	vscodium
	krita
	ngrok
	peazip
	yazi
	qimgv
	cava
	easyeffects
	kodi-wayland
	libcec
	tabula-java
	tor-browser
  ];
  fonts = {
  enableDefaultPackages = true;  # Basic system fonts
  packages = with pkgs; [
    noto-fonts  # General coverage
    noto-fonts-color-emoji
    noto-fonts-cjk-sans  # CJK support (optional)
    liberation_ttf  # Fallback sans/serif
    font-awesome
  ];
  fontconfig.enable = true;  # Enable font rendering and caching
};
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  environment.variables = {
	GTK_IM_MODULE = "ibus";
	QT_IM_MODULE = "ibus";
	XMODIFIERS = "@im=ibus";
  };
  hardware.graphics = {
   enable = true;
   extraPackages = with pkgs; [
     rocmPackages.clr.icd
    ];
  };
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
    networking.firewall.allowedTCPPorts = [ 25565 ];
    networking.firewall.allowedUDPPorts = [ 25565 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05"; # Did you read the comment?

}

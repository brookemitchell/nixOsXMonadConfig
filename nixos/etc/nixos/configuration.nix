# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  # networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Pacific/Auckland";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  programs.bash.enableCompletion = true;
  environment.systemPackages = with pkgs; [
    emacs
    firefox
    git    
    gmrun
    haskellPackages.xmobar
    neovim
    rxvt_unicode
    stalonetray
    stow
    xclip
    xscreensaver
  ];

  nixpkgs.config = {
    allowUnfree = true;
  }; 
 
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      anonymousPro
      corefonts
      dejavu_fonts
      font-droid
      freefont_ttf
      google-fonts
      inconsolata
      liberation_ttf
      powerline-fonts
      source-code-pro
      terminus_font
      ttf_bitstream_vera
      ubuntu_font_family
    ];
  };
  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us";
        
     windowManager.xmonad = {
       enable = true;
       enableContribAndExtras = true;
     };		       
	
    desktopManager.default = "none";
    

    displayManager.slim.enable = true;
    displayManager.slim.defaultUser = "brooke";
    displayManager.sessionCommands =  ''
       xrdb "${pkgs.writeText  "xrdb.conf" ''
          URxvt.font:                 xft:Dejavu Sans Mono for Powerline:size=12
          URxvt.iconFile:             /usr/share/icons/elementary/apps/24/terminal.svg
          URxvt.letterSpace:          0

          URxvt.background:           #121214
          URxvt.foreground:           #FFFFFF
          ! black
          URxvt.color0  :             #2E3436
          URxvt.color8  :             #555753
          ! red
          URxvt.color1  :             #CC0000
          URxvt.color9  :             #EF2929
          ! green
          URxvt.color2  :             #4E9A06
          URxvt.color10 :             #8AE234
          ! yellow
          URxvt.color3  :             #C4A000
          URxvt.color11 :             #FCE94F
          ! blue
          URxvt.color4  :             #3465A4
          URxvt.color12 :             #729FCF
          ! magenta
          URxvt.color5  :             #75507B
          URxvt.color13 :             #AD7FA8
          ! cyan
          URxvt.color6  :             #06989A
          URxvt.color14 :             #34E2E2
          ! white
          URxvt.color7  :             #D3D7CF
          URxvt.color15 :             #EEEEEC

          URxvt*saveLines:            32767

          URxvt.colorUL:              #AED210
          URxvt.perl-ext:             default,url-select
          URxvt.keysym.M-u:           perl:url-select:select_next
          URxvt.url-select.launcher:  /usr/bin/firefox -new-tab
          URxvt.url-select.underline: true

          Xft*dpi:                    96
          Xft*antialias:              true
          Xft*hinting:                full

          URxvt.scrollBar:            false
          URxvt*scrollTtyKeypress:    true
          URxvt*scrollTtyOutput:      false
          URxvt*scrollWithBuffer:     false
          URxvt*scrollstyle:          plain
          URxvt*secondaryScroll:      true

          Xft.autohint: 0
          Xft.lcdfilter:  lcddefault
          Xft.hintstyle:  hintfull
          Xft.hinting: 1
          Xft.antialias: 1 
      
       ''}"
    '';
  };

  # Enable the KDE Desktop Environment.
  # services.xserver.desktopManager.plasma5.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.brooke =
    { isNormalUser = true;
      home = "/home/brooke";
      extraGroups = [ "wheel"];
    };

  # virtualisation +1s
  boot.initrd.checkJournalingFS = false;
  virtualisation.virtualbox.guest.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
  system.autoUpgrade.enable = true;
}

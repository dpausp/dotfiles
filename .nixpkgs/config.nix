pkgs: {

    allowUnfree = true;

    vim = { netbeans = false;
            tcl = false;
          };

    firefox = {
      icedtea = true;
    };

    chromium = {
       enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
    };
          
    packageOverrides = pkgs : with pkgs;
    rec {
      vim_configurable = vimUtils.makeCustomizable (pkgs.vim_configurable.override {
         flags = ["python"];
      });
      
      vim_configurable_nox = vimUtils.makeCustomizable (pkgs.vim_configurable.override {
         libX11 = null;
         libXext = null;
         libSM = null; 
         libXpm = null;
         libXt = null;
         libXaw = null;
         libXau = null;
         libXmu = null;
         libICE = null;
         gtk = null;
         gui = "no";
         flags = ["python"];
      });

      idea.pycharm-professional = pkgs.idea.pycharm-professional.override rec {
        name = "pycharm-professional-${version}";
        version = "5.0.1";
        build = "143.595";
        src = fetchurl {
          url = "https://download.jetbrains.com/python/${name}.tar.gz";
          sha256 = "102sfjvchk80911w3qpjsp30wvq73kgpwyqcqdgqxcgm2vqh3183";
        };
      };
      
      mumble = pkgs.mumble.override {
        jackSupport = true;
        speechdSupport = true;
      };

      vlc = pkgs.vlc.override {
        jackSupport = true;
      };

      common = with pkgs; buildEnv {
        name = "common";
        paths = [
          python
          gnupg
          keychain
          sharutils
          openssl
          openssh
          silver-searcher
        ];
      };

      desktop = with pkgs; buildEnv {
        name = "desktop";
        paths = [
          vim_configurable
          kde4.kde_gtk_config
          kde4.kwalletmanager
          gtk_engines
          gajim
          firefox-wrapper
          thunderbird
          vlc
          youtube-dl
          kde4.okular
        ];
      };
      
      dev = with pkgs; buildEnv {
        name = "dev";
        paths = [
          pgadmin
          eclipses.eclipse_cpp_45
          python27Packages.pip
          python27Packages.virtualenv
          python27Packages.virtualenvwrapper
          wireshark
          nginx
          git
          gitAndTools.qgit
          nix-repl
          telnet
          postgresql94
        ];
      };
      
      telepathy = with pkgs; buildEnv {
        name = "telepathy";
        paths = [
          kde4.telepathy.accounts_kcm
          kde4.telepathy.auth_handler
          kde4.telepathy.contact_list
          kde4.telepathy.desktop_applets
          kde4.telepathy.text_ui
          telepathy_haze
          telepathy_gabble
        ];
      };
    };
}

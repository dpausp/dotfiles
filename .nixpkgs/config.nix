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

      eclipse-platform-46 = pkgs.eclipses.buildEclipse {
          name = "eclipse-cpp-4.6RC4a";
          description = "Eclipse IDE Platform 4.6 Release Candidate 4a";
          src =
            fetchurl {
              url = http://www.eclipse.org/downloads/download.php?r=1&nf=1&file=/eclipse/downloads/drops4/S-4.6RC4a-201606061100/eclipse-platform-4.6RC4a-linux-gtk-x86_64.tar.gz;
              sha256 = "14d1b3dq6li6vhqagb8l8616w7cwryrlk4vmdis0avxviqlr1l6c";
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
          diffoscope
          file
          gnupg
          keychain
          openssl
          python27Full
          sharutils
          silver-searcher
          unrar
          zip
        ];
      };

      desktop = with pkgs; buildEnv {
        name = "desktop";
        paths = [
          fira-code
          fira-mono
          firefox
          gajim
          geeqie
          gtk_engines
          kde4.kde_gtk_config
          kde4.kwalletmanager
          kde4.ksnapshot
          kde4.okular
          thunderbird
          vim_configurable
          vlc
          youtube-dl
        ];
      };
      
      dev = with pkgs; buildEnv {
        name = "dev";
        paths = [
          cloc
          eclipse-platform-46
          git
          gitAndTools.qgit
          graphviz
          hexedit
          httpie
          nginx
          nix-repl
          nodePackages.grunt-cli
          patchelf
          pgadmin
          postgresql95
          python27Packages.devpi-common
          python27Packages.pip
          python27Packages.virtualenv
          python27Packages.virtualenvwrapper
          sassc
          sqlite
          sqlitebrowser
          telnet
          wireshark
          zeal
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

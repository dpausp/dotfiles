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

      when-changed = pkgs.python35Packages.buildPythonPackage {
        name = "when-changed-0.3.0";
        doCheck = false;
        propagatedBuildInputs = with pkgs.python35Packages; [watchdog];
        src = fetchurl {
          url = "https://pypi.python.org/packages/83/33/80d220730dddda0cc99eac3c76409d9d8a60a799d0e0fcc6e010c14c2834/when-changed-0.3.0.tar.gz";
          md5 = "39fa3fd9789b7fe3f6db711307af318e";
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
          apg
          file
          gnupg
          ipcalc
          keychain
          openssl
          sharutils
          silver-searcher
          tree
          unison
          unrar
          unzip
          zip
        ];
      };

      desktop = with pkgs; buildEnv {
        name = "desktop";
        paths = [
          clearlooks-phenix
          fira-code
          fira-mono
          firefox
          gajim
          geeqie
          gtk_engines
          kde4.kde_gtk_config
          kde4.ksnapshot
          kde4.kwalletmanager
          kde4.okular
          thunderbird
          vim_configurable
          vlc
          xdg-user-dirs
          youtube-dl
        ];
      };
      
      dev = with pkgs; buildEnv {
        name = "dev";
        paths = [
          cloc
          eclipses.eclipse-platform
          fileschanged
          git
          gitAndTools.qgit
          graphviz
          hexedit
          html-tidy
          httpie
          jq
          nix-prefetch-scripts
          nix-repl
          nodePackages.grunt-cli
          patchelf
          pgadmin
          postgresql95
          # doesn't compile atm
          #haskellPackages.postgrest
          redis
          sassc
          sqlite
          sqlitebrowser
          telnet
          universal-ctags
          wireshark
          wrk
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

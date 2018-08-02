pkgs: {

    allowUnfree = true;

    vim = { netbeans = false;
            tcl = false;
            ftNix = false;
            python = true;
          };

    firefox = {
      icedtea = true;
    };

    chromium = {
       enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
    };
          
    packageOverrides = pkgs : with pkgs;
    rec {
      myVim = pkgs.vim_configurable.customize {
        name = "vim";
        vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix vimPlugins.elm-vim ];
        vimrcConfig.customRC = builtins.readFile ../.dotfiles/.vimrc;
      };
      
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

      when-changed = pkgs.python36Packages.buildPythonPackage {
        name = "when-changed-0.3.0";
        doCheck = false;
        propagatedBuildInputs = with pkgs.python36Packages; [watchdog];
        src = fetchurl {
          url = "https://pypi.python.org/packages/83/33/80d220730dddda0cc99eac3c76409d9d8a60a799d0e0fcc6e010c14c2834/when-changed-0.3.0.tar.gz";
          sha256 = "98bb1b943e5936bcd60bed8189f7d7494b52095dc92d2a804be49603b6b9a372";
        };
      };

      mumble = pkgs.mumble.override {
        speechdSupport = true;
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
          eclipses.eclipse-platform
          fira-code
          fira-mono
          gajim
          geeqie
          gitAndTools.qgit
          gtk_engines
          kdeApplications.kwalletmanager
          kdeApplications.okular
          myVim
          pgadmin
          spectacle
          sqlitebrowser
          thunderbird
          vlc
          wireshark
          xdg-user-dirs
          youtube-dl
          xclip
          zeal
        ];
      };
      
      dev = with pkgs; buildEnv {
        name = "dev";
        paths = [
          cloc
          fileschanged
          git
          graphviz
          hexedit
          html-tidy
          httpie
          jq
          nix-prefetch-scripts
          nix-repl
          nodePackages.grunt-cli
          patchelf
          # doesn't compile atm
          #haskellPackages.postgrest
          redis
          sassc
          sqlite
          telnet
          universal-ctags
          wrk
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

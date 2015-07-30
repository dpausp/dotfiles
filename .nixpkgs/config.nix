pkgs: {
    vim = { netbeans = false;
            tcl = false;
          };
    packageOverrides = pkgs : with pkgs;
    rec {
      vim_configurable = vimUtils.makeCustomizable (pkgs.vim_configurable.override {
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
      
      common = with pkgs; buildEnv {
        name = "common";
        paths = [
          vim_configurable
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
          kde4.kde_gtk_config
          kde4.kwalletmanager
          gtk_engines
          gajim
          firefox
          thunderbird
          vlc
          libreoffice
          youtube-dl
          kde4.okular
        ];
      };
      
      dev = with pkgs; buildEnv {
        name = "dev";
        paths = [
          pgadmin
          eclipses.eclipse_cpp_44
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

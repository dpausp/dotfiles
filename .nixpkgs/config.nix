let
  commonPkgs = pkgs: with pkgs; 
  let
    visidata = pkgs.visidata.overrideAttrs(oldAttrs: rec {
      version = "2.1dev";
      name = "visidata-${version}";

      src = pkgs.fetchFromGitHub {
        owner = "saulpw";
        repo = "visidata";
        rev = "667d570024b0d259c7635be3978e186d1308200f";
        sha256 = "0lrxfv25383hivznxhd0bd5mx8wgy810ldlkzzk7010s0m1yx0x7";
      };

      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ pkgs.python37Packages.setuptools ];
    });

  in [
    apg
    bat
    bc
    exa
    fd
    file
    fzf
    gnupg
    ipcalc
    keychain
    magic-wormhole
    nix-index
    openssl_1_1
    pass
    python37Packages.python
    qrencode
    ripgrep
    sharutils
    sshuttle
    tree
    unison
    unrar
    unzip
    visidata
    zip
  ];

  desktopPkgs = pkgs: with pkgs;
  let
    mumble = pkgs.mumble.override {
      speechdSupport = true;
    };

    myVim = pkgs.vim_configurable.customize {
      name = "vim";
      vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix vimPlugins.elm-vim ];
      vimrcConfig.customRC = builtins.readFile ../.dotfiles/.vimrc;
    };

  in [
    amarok
    clearlooks-phenix
    chromium
    dmenu
    digikam
    fira-code
    fira-mono
    gajim
    geeqie
    gimp
    gitAndTools.qgit
    gtk_engines
    img2pdf
    kdeApplications.kwalletmanager
    mumble
    myVim
    okular
    qutebrowser
    pdftk
    simplescreenrecorder
    spectacle
    sqlitebrowser
    thunderbird
    vlc
    wireshark
    xdg-user-dirs
    youtube-dl
    xsane
    xclip
    zeal
  ];

  develAllPkgs = pkgs: with pkgs; [
    cloc
    cookiecutter
    dhall
    graphviz
    hexedit
    html-tidy
    httpie
    jq
    mercurial
    nix-prefetch-scripts
    nodePackages.grunt-cli
    patchelf
    redis
    sassc
    sqlite
    telnet
    universal-ctags
    wrk
  ];

  develPkgs = pkgs: ( develAllPkgs pkgs ) ++ (with pkgs; [
    fileschanged
    git
    vscode
  ]);

  develMacPkgs = pkgs: develAllPkgs pkgs;

in pkgs: {
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

      httpbin = pkgs.python37Packages.httpbin.overrideAttrs(oldAttrs: {
        patchPhase = ''
          sed -i "/os.mkdir('static')/d" httpbin/core.py
        '';
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ pkgs.python37Packages.setuptools ];
      })
      ;

      pip-tools = pkgs.callPackage ./pip-tools.nix {};

      all_pkgs_amorphis = pkgs.buildEnv {
        name = "all_pkgs";
        pathsToLink = [ "/bin" "/share" "/lib" ];
        paths = (commonPkgs pkgs) ++ (desktopPkgs pkgs) ++ (develPkgs pkgs) ++ ( with pkgs; [
          gitAndTools.git-annex
          libreoffice
          pandoc
          sshfs-fuse
          wirelesstools
        ]);
      };

      all_pkgs_mayan = all_pkgs_amorphis;

      all_pkgs_mac = pkgs.buildEnv {
        name = "all_pkgs";
        pathsToLink = [ "/bin" "/share" ];
        paths = (commonPkgs pkgs) ++ (develMacPkgs pkgs) ++ ( with pkgs; [
          git
          ( haskell.lib.dontCheck gitAndTools.git-annex )
          pandoc
          tmux
        ]);
      };
    };
}

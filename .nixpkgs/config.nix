let 
  commonPkgs = pkgs: with pkgs; [
    apg
    bat
    bc
    fd
    file
    fzf
    gnupg
    ipcalc
    keychain
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

      myVim = pkgs.vim_configurable.customize {
        name = "vim";
        vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix vimPlugins.elm-vim ];
        vimrcConfig.customRC = builtins.readFile ../.dotfiles/.vimrc;
      };

      when-changed = pkgs.python37Packages.buildPythonPackage {
        name = "when-changed-0.3.0";
        doCheck = false;
        propagatedBuildInputs = with pkgs.python37Packages; [watchdog];
        src = fetchurl {
          url = "https://pypi.python.org/packages/83/33/80d220730dddda0cc99eac3c76409d9d8a60a799d0e0fcc6e010c14c2834/when-changed-0.3.0.tar.gz";
          sha256 = "98bb1b943e5936bcd60bed8189f7d7494b52095dc92d2a804be49603b6b9a372";
        };
      };

      httpbin = pkgs.python37Packages.httpbin.overrideAttrs(oldAttrs: {
        patchPhase = ''
          sed -i "/os.mkdir('static')/d" httpbin/core.py
        '';
      })
      ;

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

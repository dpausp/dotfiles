let
  commonPkgs = pkgs: with pkgs;
  let
  in [
    amber
    apg
    bat
    bc
    entr
    exa
    fd
    file
    thefuck
    fzf
    gnupg
    ipcalc
    keychain
    magic-wormhole
    mailutils
    mosh
    nix-index
    ngrok
    openssl_1_1
    pass
    python37Packages.python
    ripgrep
    sharutils
    sshuttle
    tmux
    tree
    unison
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
    korganizer
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
    lorri
    mercurial
    nixfmt
    nix-prefetch-scripts
    nodePackages.grunt-cli
    patchelf
    redis
    remarshal
    sassc
    sqlite
    telnet
    universal-ctags
    vagrant
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

    packageOverrides = pkgs: with pkgs;
    let
      vim_configurable_nox = vimUtils.makeCustomizable (pkgs.vim_configurable.override {
         config = {
           netbeans = false;
           vim = {
             gui = "no";
           };
         };
         libX11 = null;
         libXext = null;
         libSM = null;
         libXpm = null;
         libXt = null;
         libXaw = null;
         libXau = null;
         libXmu = null;
         libICE = null;
         gtk2-x11 = null;
         gtk3-x11 = null;
      });

    in rec {

      serverProfile = (commonPkgs pkgs) ++ [ vim_configurable_nox ];

      inherit vim_configurable_nox;

      httpbin = pkgs.python37Packages.httpbin.overrideAttrs(oldAttrs: {
        patchPhase = ''
          sed -i "/os.mkdir('static')/d" httpbin/core.py
        '';
        propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ pkgs.python37Packages.setuptools ];
      })
      ;

      visidata = pkgs.visidata.overrideAttrs(oldAttrs: rec {
        version = "2.-3";
        name = "visidata-${version}";

        src = pkgs.fetchFromGitHub {
          owner = "saulpw";
          repo = "visidata";
          rev = "a4f3dc5e317c476d1958194eecd5bf9071ee3cb9";
          sha256 = "1m7lya3xbzn7b4w6lm8463kq7yb9x5yisahhlw8ra1s0j6wck8a3";
        };

      propagatedBuildInputs = oldAttrs.propagatedBuildInputs ++ [ pkgs.python37Packages.setuptools ];
    });

      all_pkgs_amorphis = pkgs.buildEnv {
        name = "all_pkgs";
        pathsToLink = [ "/bin" "/share" "/lib" ];
        paths = (commonPkgs pkgs) ++ (desktopPkgs pkgs) ++ (develPkgs pkgs) ++ ( with pkgs; [
          gitAndTools.git-annex
          kubectl
          libreoffice
          nixops
          pandoc
          pgcli
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

      all_pkgs_vader = all_pkgs_amorphis;
    };
}

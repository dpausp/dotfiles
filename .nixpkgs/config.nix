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
    mosh
    nix-index
    ngrok
    openssl
    pass
    ripgrep
    sharutils
    socat
    tmux
    tree
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
      vimrcConfig.packages.thisPackage.start = [ vimPlugins.vim-nix ];
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
    pre-commit
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
    graphviz
    hexedit
    html-tidy
    httpie
    jq
    lorri
    nixfmt
    niv
    nix-update
    nix-prefetch
    nix-prefetch-scripts
    patchelf
    redis
    remarshal
    sassc
    sqlite
    wrk
  ];

  develPkgs = pkgs: ( develAllPkgs pkgs ) ++ (with pkgs; [
    git
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

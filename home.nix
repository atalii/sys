{ config, pkgs, ... }:

let
  backgroundColor = "#e5e9f0";
  activeColor = "#2e3440";
  inactiveColor = "#4c566a";
in {
  home.username = "atalii";
  home.homeDirectory = "/home/atalii";
  home.stateVersion = "23.05";

  home.file.".mkshrc".text = ''
   PS1='$([ $? -eq 0 ] && printf "\\x1b[32m✓\\x1b[0m [$PWD]: " || printf "\\x1b[31mx\\x1b[0m [$PWD]: ")'
  '';

  xdg.userDirs = {
    enable = true;

    createDirectories = true;
    desktop   = "${config.home.homeDirectory}/dsk";
    documents = "${config.home.homeDirectory}/doc";
    download  = "${config.home.homeDirectory}/dwn";
    music     = "${config.home.homeDirectory}/mus";
    pictures  = "${config.home.homeDirectory}/pic";
    publicShare = "${config.home.homeDirectory}/pub";
    templates   = "${config.home.homeDirectory}/tpl";
    videos      = "${config.home.homeDirectory}/vid";
  };

  xdg.configFile."kitty/kitty.conf".text = ''
    window_padding_width 4

    font_family Hack

    foreground            #D8DEE9
    background            #2E3440
    selection_foreground  #000000
    selection_background  #FFFACD
    url_color             #0087BD
    cursor                #81A1C1
    color0   #3B4252
    color8   #4C566A
    color1   #BF616A
    color9   #BF616A
    color2   #A3BE8C
    color10  #A3BE8C
    color3   #EBCB8B
    color11  #EBCB8B
    color4  #81A1C1
    color12 #81A1C1
    color5   #B48EAD
    color13  #B48EAD
    color6   #88C0D0
    color14  #8FBCBB
    color7   #E5E9F0
    color15  #ECEFF4
  '';

  programs.neovim.enable = true;
  programs.neovim.extraConfig = ''
    autocmd FileType ada setlocal shiftwidth=3 softtabstop=3 expandtab
  '';
}

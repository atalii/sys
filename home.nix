{ config, pkgs, ... }:

let
  backgroundColor = "#e5e9f0";
  activeColor = "#2e3440";
  inactiveColor = "#4c566a";
in {
  home.username = "atalii";
  home.homeDirectory = "/home/atalii";
  home.stateVersion = "23.05";

  home.file.".xinitrc".text = ''
    xrandr --dpi 90
    ${pkgs.hsetroot}/bin/hsetroot -solid '${backgroundColor}'
    discord & thunderbird &
    i3bar &
    xrandr --output HDMI-0 --auto --rotate right
    xrandr --output DP-0 --auto --right-of HDMI-0
    exec ${pkgs.i3}/bin/i3
  '';

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

  xdg.configFile."i3blocks/config".text = ''
    [notifs]
    command=painted
    interval=persist

    btn_left_cmd=clear
    btn_right_cmd=expand

    [time]
    command=date +"%H:%M, %d %B %Y"
    interval=10
  '';

  xdg.configFile."i3/config".text = ''
    set $mod Mod4

    set $ws_a "I"
    set $ws_b "II"
    set $ws_c "III"
    set $ws_d "IV"
    set $ws_e "V"
    set $ws_f "VI"

    workspace $ws_a output HDMI-0
    workspace $ws_b output DP-0
    workspace $ws_c output DP-0
    workspace $ws_d output DP-0
    workspace $ws_e output DP-0
    workspace $ws_f output DP-0

    floating_modifier $mod

    bindsym $mod+a reload

    bindsym $mod+m exec kitty
    bindsym $mod+w exec firefox
    bindsym $mod+v exec thunderbird
    bindsym $mod+z exec discord

    bindsym $mod+b kill

    bindsym $mod+h focus left
    bindsym $mod+t focus right
    bindsym $mod+n focus up
    bindsym $mod+s focus down

    bindsym $mod+g move left
    bindsym $mod+c move right 
    bindsym $mod+r move up
    bindsym $mod+l move down

    bindsym $mod+f split v
    bindsym $mod+d split h

    bindsym $mod+1 workspace $ws_a
    bindsym $mod+2 workspace $ws_b
    bindsym $mod+3 workspace $ws_c
    bindsym $mod+4 workspace $ws_d
    bindsym $mod+5 workspace $ws_e
    bindsym $mod+6 workspace $ws_f

    bindsym $mod+shift+1 move container to workspace $ws_a
    bindsym $mod+shift+2 move container to workspace $ws_b
    bindsym $mod+shift+3 move container to workspace $ws_c
    bindsym $mod+shift+4 move container to workspace $ws_d
    bindsym $mod+shift+5 move container to workspace $ws_e
    bindsym $mod+shift+6 move container to workspace $ws_f

    gaps inner 16px
    smart_gaps off

    for_window [class="^.*"] border normal 0
    client.focused ${backgroundColor} ${backgroundColor} ${activeColor} ${backgroundColor}
    client.focused_inactive ${backgroundColor} ${backgroundColor} ${activeColor} ${backgroundColor}
    client.unfocused ${backgroundColor} ${backgroundColor} ${inactiveColor} ${backgroundColor}
    client.urgent #aebebf ${backgroundColor} ${inactiveColor} ${backgroundColor}
    client.placeholder ${backgroundColor} ${backgroundColor} ${inactiveColor} ${backgroundColor}
    client.background ${backgroundColor}

    font pango:Hack 12

    bar {
        status_command ${
	  pkgs.i3blocks.overrideAttrs (old: {
            src = pkgs.fetchFromGitHub {
	      owner = "atalii";
	      repo = "i3blocks";
	      rev = "mouse-aliases";
	      hash = "sha256-VezpAVDAoeJBqdWTGZXvqFhwfxl6q/zvwgsx2hy6/n4=";
	    };
	  })
	}/bin/i3blocks

        padding 2px 16px 0
	position top
	font pango:Hack 12

	tray_output none

	colors {
	    background ${backgroundColor}
	    statusline ${activeColor}
	    separator ${inactiveColor}

            focused_workspace ${backgroundColor} ${backgroundColor} ${activeColor}
            inactive_workspace ${backgroundColor} ${backgroundColor} ${inactiveColor}
            urgent_workspace ${backgroundColor} ${backgroundColor} ${inactiveColor}
	}
    }
  '';

  programs.neovim.enable = true;
  programs.neovim.extraConfig = ''
    autocmd FileType ada setlocal shiftwidth=3 softtabstop=3 expandtab
  '';
}

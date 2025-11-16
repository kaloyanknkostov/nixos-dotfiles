{pkgs, ...}:

{
  home.packages = with pkgs;[

  (pkgs.dmenu.overrideAttrs(  {
 		src = ../config/dmenu;	
		patches = [];
 	}))
  ];
  }

let
  pkgs = import <nixpkgs> { };
in
''
  return {
    bin = "${pkgs.sumneko-lua-language-server}/bin/lua-language-server",
    main = "${pkgs.sumneko-lua-language-server}/extra/main.lua"
  }
''

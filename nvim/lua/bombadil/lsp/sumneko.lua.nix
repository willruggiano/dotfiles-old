let
  pkgs = import <nixpkgs> { };
in
''
  -- NOTE: This command is a wrapper that includes the -E /path/to/main.lua
  return "${pkgs.sumneko-lua-language-server}/bin/lua-language-server"
''

{
  description = ''Youtube data extractor'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-ytextractor-master.flake = false;
  inputs.src-ytextractor-master.owner = "thisago";
  inputs.src-ytextractor-master.ref   = "refs/heads/master";
  inputs.src-ytextractor-master.repo  = "ytextractor";
  inputs.src-ytextractor-master.type  = "github";
  
  inputs."ajax".owner = "nix-nim-pkgs";
  inputs."ajax".ref   = "master";
  inputs."ajax".repo  = "ajax";
  inputs."ajax".type  = "github";
  inputs."ajax".inputs.nixpkgs.follows = "nixpkgs";
  inputs."ajax".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-ytextractor-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-ytextractor-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
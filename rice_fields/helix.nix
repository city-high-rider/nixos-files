{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "everforest_light";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
      };
    };

    languages = {
      language-server.texlab.config.texlab.build.onSave = true;
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt";
        }

        {
          name = "elm";
          auto-format = true;
          formatter.command = "elm-format";
          formatter.args = [ "--stdin" ];
        }

        {
          name = "mcfunction";
          file-types = [ "mcfunction" ];
          scope = "source.mcfunction";
          comment-token = [ "#" ];
          roots = [ "pack.mcmeta" ];
        }
      ];
      grammar = [{
        name = "mcfunction";
        source.git = "https://github.com/IoeCmcomc/tree-sitter-mcfunction";
        source.rev = "5bf1f08320697c24f395af76422a845f9f627fb0";
      }];
    };
  };
}

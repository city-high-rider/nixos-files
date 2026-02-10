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
      keys.normal = {
        d = "move_char_left";
        h = "move_line_down";
        t = "move_line_up";
        n = "move_char_right";
        q = "delete_selection";
        A-q = "delete_selection_noyank";
        space.q = "replay_macro";
        space.Q = "record_macro";
        k = "find_till_char";
        K = "till_prev_char";
      };
      keys.select = {
        q = "delete_selection";
        A-q = "delete_selection_noyank";
        space.q = "replay_macro";
        space.Q = "record_macro";
        l = "extend_search_next";
        L = "extend_search_prev";
        k = "extend_till_char";
        K = "extend_till_prev_char";
      };
    };

    languages = {
      language-server.texlab.config.texlab.build.onSave = true;
      language-server.haskell-language-server.config.haskell.plugin.stan.globalOn =
        true;
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
          name = "haskell";
          auto-format = true;
          roots = [ "Setup.hs" "stack.yaml" "*.cabal" "backend.cabal" ];
          formatter.command = "fourmolu";
          formatter.args = [ "--stdin-input-file" "%{buffer_name}" ];
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

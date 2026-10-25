
{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    defaultEditor = false;

    mutableUserSettings = true;
    mutableUserKeymaps = true;

    # Zed 扩展
    # 扩展 ID 应以 Zed 扩展市场为准
    extensions = [
      "nix"
      "toml"
      "rust"
      "python"
    ];

    # Zed 启动环境中的额外工具
    extraPackages = with pkgs; [
      nixd
      nixfmt
      clang-tools
      typstyle
      tinymist
      rust-analyzer
      texlab
    ];

    userSettings = {
      # Panels
      project_panel.dock = "left";
      outline_panel.dock = "left";
      collaboration_panel.dock = "left";
      git_panel.dock = "left";

      # Edit predictions
      edit_predictions.provider = "zed";

      # Session
      session.trust_all_worktrees = false;

      # Keymap
      base_keymap = "JetBrains";

      # AI Agent
      agent = {
        dock = "right";

        default_model = {
          enable_thinking = true;
          provider = "google";
          model = "gemini-3-pro-preview";
        };

        inline_assistant_model = {
          provider = "zed.dev";
          model = "claude-sonnet-4";
        };
      };

      agent_servers = {
        github-copilot-cli.type = "registry";
      };

      # UI
      icon_theme = {
        mode = "dark";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };

      theme = {
        mode = "dark";
        light = "Catppuccin Mocha - No Italics";
        dark = "Catppuccin Mocha";
      };

      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrainsMono Nerd Font";

      # SSH
      ssh_connections = [
        {
          host = "ubuntu";
          projects = [ ];
        }
      ];

      # Editor
      tabs = {
        file_icons = true;
        git_status = true;
      };

      inlay_hints.enabled = true;
      indent_guides.coloring = "indent_aware";

      tab_size = 4;
      format_on_save = "on";
      vertical_scroll_margin = 7;
      restore_on_startup = "none";
      extend_comment_on_newline = true;

      # Project exclusions
      file_scan_exclusions = [
        "**/.git"
        "**/.svn"
        "**/.hg"
        "**/CVS"
        "**/.DS_Store"
        "**/Thumbs.db"
        "**/.classpath"
        "**/.settings"
      ];

      # 保留原始键名
      "search.exclude" = {
        "**/*.snap" = true;
        "**/.git" = true;
        "**/.github" = false;
        "**/.nuxt" = true;
        "**/.output" = true;
        "**/.pnpm" = true;
        "**/.vscode" = true;
        "**/.yarn" = true;
        "**/node_modules" = true;
        "**/out/**" = true;
        "**/package-lock.json" = true;
        "**/pnpm-lock.yaml" = true;
        "**/temp" = true;
        "**/yarn.lock" = true;
        "**/CHANGELOG*" = true;
        "**/LICENSE*" = true;
      };

      # Terminal
      terminal = {
        font_family = "JetBrainsMonoNL Nerd Font Propo";
        copy_on_select = true;
      };

      # Git
      git = {
        enabled = true;
        autoFetch = true;
        autoFetchInterval = 300;
        autoFetchOnFocus = true;
        autoFetchOnWindowChange = true;
        autoFetchOnBuild = true;
        git_status = true;

        autoFetchOnBuildEvents = [
          "build"
          "run"
          "debug"
        ];

        autoFetchOnBuildEventsDelay = 1500;
        autoFetchOnBuildDelay = 1500;
        git_gutter = "tracked_files";

        inline_blame = {
          enabled = false;
          position = "right";
        };
      };

      # Privacy
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      # Language-specific settings
      languages = {
        "C++" = {
          formatter.external = {
            command = "clang-format";
            arguments = [
              "-style={BasedOnStyle: Google, IndentWidth: 2}"
            ];
          };
        };

        Typst = {
          show_edit_predictions = false;
          format_on_save = "on";

          formatter.external = {
            command = "typstyle";
          };
        };
      };

      # Language servers
      lsp = {
        rust-analyzer = {
          initialization_options = {
            inlayHints = {
              maxLength = null;

              lifetimeElisionHints = {
                enable = "skip_trivial";
                useParameterNames = true;
              };

              closureReturnTypeHints.enable = "always";
            };
          };
        };

        eslint = {
          settings.codeActionOnSave.rules = [
            "import/order"
          ];
        };

        texlab = {
          settings.texlab = {
            build = {
              onSave = false;
              forwardSearchAfter = true;
            };

            forwardSearch = {
              executable = "zathura";
              args = [
                "--synctex-forward"
                "%l:1:%f"
                "-x"
                "zed %%{input}:%%{line}"
                "%p"
              ];
            };
          };
        };

        tinymist = {
          settings = {
            exportPdf = "onSave";
            outputPath = "$root/$name";
          };
        };
      };
    };
  };
}


# Zellij

Add a dev.kdl configuration to use within the Nix configuration.
Quickly spin up a window environment.

> Ref: [nix-zellij](https://github.com/rosera/nix-shell-pack/blob/main/development/nix-zellij/README.md)

1. Create a `dev.kdl` file

2. Add the following script to this file:
```bash
layout {
    // Define a template so every tab looks like an IDE
    default_tab_template {
        pane size=1 borderless=true {
            plugin location="zellij:tab-bar"
        }
        children // This is where your "Hugo Blogging" panes will live
        pane size=2 borderless=true {
            plugin location="zellij:status-bar"
        }
    }

    tab name="Hugo Blogging" {
        pane name="Blogger" size="80%" focus=true
        pane name="Server" size="20%" {
            command "hugo"
            args "server" "-D" "-p" "8080"
            start_suspended true
        }

        // This is the correct way to define floating panes in a layout
        floating_panes {
            pane name="Hugo Version" {
                command "hugo"
                args "version"
                // Optional: set the size/position of the float
                x "20%"
                y "20%"
                width "60%"
                height "30%"
            }
        }
    }
}
```

{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  catppuccinCss = pkgs.fetchurl {
    url = "https://github.com/CalfMoon/signal-desktop/raw/658cb182d49dc6ba3085c7b63db0987e875a29bf/themes/catppuccin-mocha.css";
    sha256 = "sha256-G+SXzbqgdd4DMoy6L+RW5xdoMMj3oCfd6hyalVnPkR4=";
  };
in
{
  hm.home.packages = [
    (pkgs.signal-desktop.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.asar ];

      postInstall = (old.postInstall or "") + ''
        set -euo pipefail

        echo "Patching packaged Signal app.asar..."

        tmp="$(mktemp -d)"
        appdir="$tmp/app"

        cp "$out/share/signal-desktop/app.asar" "$tmp/app.asar"
        if [ -d "$out/share/signal-desktop/app.asar.unpacked" ]; then
          cp -r "$out/share/signal-desktop/app.asar.unpacked" "$tmp/app.asar.unpacked"
          chmod -R u+w "$tmp/app.asar.unpacked"
        fi
        chmod u+w "$tmp/app.asar"

        (
          cd "$tmp"
          asar extract ./app.asar ./app
        )

        test -d "$appdir/stylesheets"

        cp ${catppuccinCss} "$appdir/stylesheets/catppuccin-mocha.css"

        substituteInPlace "$appdir/stylesheets/catppuccin-mocha.css" \
          --replace-fail "#1e1e2e" "${colors.base00}" \
          --replace-fail "#181825" "${colors.base00}" \
          --replace-fail "#11111b" "${colors.base00}"

        for f in "$appdir/stylesheets/manifest.css" "$appdir/stylesheets/manifest_bridge.css"; do
          if [ -f "$f" ] && ! grep -Fq 'stylix theme override' "$f"; then
            {
              cat "$f"
              printf '\n\n/* stylix theme override */\n'
              cat "$appdir/stylesheets/catppuccin-mocha.css"
            } > "$f.new"
            mv "$f.new" "$f"
          fi
        done

        rm -f "$out/share/signal-desktop/app.asar"
        rm -rf "$out/share/signal-desktop/app.asar.unpacked"

        (
          cd "$tmp"
          asar pack --unpack '*.node' ./app ./new.asar
        )

        cp "$tmp/new.asar" "$out/share/signal-desktop/app.asar"
        if [ -d "$tmp/app.asar.unpacked" ]; then
          cp -r "$tmp/app.asar.unpacked" "$out/share/signal-desktop/app.asar.unpacked"
        fi
      '';
    }))
  ];
}

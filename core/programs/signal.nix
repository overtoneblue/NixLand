{ pkgs, config, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  catpuccin-css = pkgs.fetchurl {
    url = "https://github.com/CalfMoon/signal-desktop/raw/658cb182d49dc6ba3085c7b63db0987e875a29bf/themes/catppuccin-mocha.css";
    sha256 = "sha256-G+SXzbqgdd4DMoy6L+RW5xdoMMj3oCfd6hyalVnPkR4=";
  };
in
{
  hm.home.packages = [
    (pkgs.signal-desktop.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        echo "Looking for Signal stylesheet locations..."
        find . -path '*stylesheets*' -o -name 'manifest.css'

        cssdir="$(dirname "$(find . -name manifest.css | head -n1)")"

        if [ -z "$cssdir" ]; then
          echo "Could not find manifest.css"
          exit 1
        fi

        cp ${catpuccin-css} "$cssdir/catppuccin-mocha.css"

        substituteInPlace "$cssdir/catppuccin-mocha.css" \
          --replace-fail "#1e1e2e" "${colors.base00}" \
          --replace-fail "#181825" "${colors.base00}" \
          --replace-fail "#11111b" "${colors.base00}"

        sed -i '1i @import "catppuccin-mocha.css";' "$cssdir/manifest.css"
      '';
    }))
  ];
}

final: prev:

{
  chatgpt = prev.chatgpt.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ final.makeWrapper ];

    postFixup = (oldAttrs.postFixup or "") + ''
      mv "$out/bin/chatgpt" "$out/bin/.chatgpt-original"

      makeWrapper "$out/bin/.chatgpt-original" "$out/bin/chatgpt" \
        --add-flags "--ozone-platform=wayland" \
        --add-flags "--enable-wayland-ime" \
        --add-flags "--wayland-text-input-version=3"
    '';
  });
}

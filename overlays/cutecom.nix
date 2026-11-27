final: prev:

{
  cutecom = prev.cutecom.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace main.cpp \
        --replace-fail \
          'QApplication a(argc, argv);' \
          'QApplication a(argc, argv);
           a.setDesktopFileName("cutecom");'
    '';
  });
}

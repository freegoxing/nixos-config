{ ... }:

{
  programs.texlive = {
    enable = true;

    extraPackages = tpkgs: {
      inherit (tpkgs)
        # LaTeX 基础与扩展
        collection-basic
        collection-latex
        collection-latexrecommended
        collection-latexextra
        collection-plaingeneric

        # 编译引擎
        collection-xetex
        collection-luatex

        # 中文及其他语言
        collection-langchinese
        collection-langcjk
        collection-langgreek
        collection-langother

        # 字体
        collection-fontsrecommended
        collection-fontutils

        # 数学、图形与科学文档
        collection-mathscience
        collection-pictures

        # 参考文献与出版模板
        collection-bibtexextra
        collection-publishers

        # 常用构建工具
        latexmk
        ;
    };
  };
}

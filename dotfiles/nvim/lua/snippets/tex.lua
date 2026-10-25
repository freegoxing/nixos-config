local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local r = require("luasnip.extras").regex

return {
    -- enviroment
    s(
        { trig = "beg", snippetType = "autosnippet" },
        fmt("\\begin{{{}}}\n{}\n\\end{{{}}}", {
            i(1, "environment"),
            i(2, ""),
            rep(1),
        })
    ),
    s({ trig = "mk", snippetType = "autosnippet" }, fmt("${}$", { i(1, "") })),
    s({ trig = "dm", snippetType = "autosnippet" }, fmt("\\[\n{}\n\\]", { i(1, "") })),
    s({ trig = "\\\\\\", snippetType = "autosnippet" }, t(" \\leavevmode\\par{}")),

    -- 希腊字母

    s({ trig = "aa", wordTrig = false, snippetType = "autosnippet" }, t("\\alpha")),
    s({ trig = "bb", snippetType = "autosnippet" }, t("\\beta")),
    s({ trig = "gg", wordTrig = false, snippetType = "autosnippet" }, t("\\gamma")),
    s({ trig = "GG", wordTrig = false, snippetType = "autosnippet" }, t("\\Gamma")),
    s({ trig = "dd", wordTrig = false, snippetType = "autosnippet" }, t("\\delta")),
    s({ trig = "DD", wordTrig = false, snippetType = "autosnippet" }, t("\\Delta")),
    s({ trig = "ee", wordTrig = false, snippetType = "autosnippet" }, t("\\epsilon")),
    s({ trig = "ve", wordTrig = false, snippetType = "autosnippet" }, t("\\varepsilon")),
    s({ trig = "zz", wordTrig = false, snippetType = "autosnippet" }, t("\\zeta")),
    s({ trig = "tt", wordTrig = false, snippetType = "autosnippet" }, t("\\theta")),
    s({ trig = "TT", wordTrig = false, snippetType = "autosnippet" }, t("\\Theta")),
    s({ trig = "vt", wordTrig = false, snippetType = "autosnippet" }, t("\\vartheta")),
    s({ trig = "ii", wordTrig = false, snippetType = "autosnippet" }, t("\\iota")),
    s({ trig = "kk", wordTrig = false, snippetType = "autosnippet" }, t("\\kappa")),
    s({ trig = "ll", wordTrig = false, snippetType = "autosnippet" }, t("\\lambda")),
    s({ trig = "LL", wordTrig = false, snippetType = "autosnippet" }, t("\\Lambda")),
    s({ trig = "ss", wordTrig = false, snippetType = "autosnippet" }, t("\\sigma")),
    s({ trig = "SS", wordTrig = false, snippetType = "autosnippet" }, t("\\Sigma")),
    s({ trig = "uu", wordTrig = false, snippetType = "autosnippet" }, t("\\upsilon")),
    s({ trig = "UU", wordTrig = false, snippetType = "autosnippet" }, t("\\Upsilon")),
    s({ trig = "oo", wordTrig = false, snippetType = "autosnippet" }, t("\\omega")),
    s({ trig = "OO", wordTrig = false, snippetType = "autosnippet" }, t("\\Omega")),
    s({ trig = "ome", wordTrig = false, snippetType = "autosnippet" }, t("\\omega")),
    s({ trig = "Ome", wordTrig = false, snippetType = "autosnippet" }, t("\\Omega")),
    s({ trig = "pi", wordTrig = false, snippetType = "autosnippet" }, t("\\pi")),
    s({ trig = "pp", wordTrig = false, snippetType = "autosnippet" }, t("\\varphi")),
    s({ trig = "xx", wordTrig = false, snippetType = "autosnippet" }, t("\\xi")),
    s({ trig = "XX", wordTrig = false, snippetType = "autosnippet" }, t("\\Xi")),
    s({ trig = "tau", wordTrig = false, snippetType = "autosnippet" }, t("\\tau")),
    -- text enviroment
    s({ trig = "text", wordTrig = "false", snippetType = "autosnippet" }, fmt("\\text{{{}}}", { i(1, "") })),
    s({ trig = "quad", wordTrig = "false", snippetType = "autosnippet" }, t("\\quad")),
    s({ trig = "qquad", wordTrig = "false", snippetType = "autosnippet" }, t("\\qquad")),

    -- singal
    s({ trig = "\\omegao", wordTrig = false, snippetType = "autosnippet" }, t("\\infty")),
    s("prod", t("\\prod")),

    s({ trig = "sum", snippetType = "autosnippet", wordTrig = false }, t("\\sum")),
    s(
        { trig = "\\summ", snippetType = "autosnippet", wordTrig = false },
        fmt("\\sum_{{{}}}^{{{}}} {}", { i(1, "n=1"), i(2, " \\infty"), i(3) })
    ),
    s("prod", fmt("\\prod_{{{}}}^{{{}}} {}", { i(1, "i=1"), i(2, "N"), i(3) })),
    s(
        { trig = "\\limm", snippetType = "autosnippet", wordTrig = false },
        fmt("\\lim_{{ {} \\to {} }} {}", { i(1, "n"), i(2, "\\infty"), i(3) })
    ),
    s({ trig = "lim", snippetType = "autosnippet", wordTrig = false }, t("\\lim")),
    s({ trig = "to", snippetType = "autosnippet", wordTrig = false }, t("\\to")),
    -- 优先最长匹配放前面
    s({ trig = "\\leq>", snippetType = "autosnippet", wordTrig = false }, t("\\Leftrightarrow")),
    s({ trig = "<=", snippetType = "autosnippet", wordTrig = false }, t("\\leq")),
    s({ trig = ">=", snippetType = "autosnippet", wordTrig = false }, t("\\geq")),
    s({ trig = "===", snippetType = "autosnippet", wordTrig = false }, t("\\equiv")),
    s({ trig = "=>", snippetType = "autosnippet", wordTrig = false }, t("\\implies")),
    s({ trig = "=<", snippetType = "autosnippet", wordTrig = false }, t("\\impliedby")),
    s({ trig = "->", snippetType = "autosnippet", wordTrig = false }, t("\\to")),
    s({ trig = "!>", snippetType = "autosnippet", wordTrig = false }, t("\\mapsto")),
    s({ trig = "!=", snippetType = "autosnippet", wordTrig = false }, t("\\neq")),
    s({ trig = ">>", snippetType = "autosnippet", wordTrig = false }, t("\\gg")),
    s({ trig = "<<", snippetType = "autosnippet", wordTrig = false }, t("\\ll")),

    -- 不存在前缀冲突的保持原样
    s({ trig = "+-", snippetType = "autosnippet", wordTrig = false }, t("\\pm")),
    s({ trig = "-+", snippetType = "autosnippet", wordTrig = false }, t("\\mp")),
    s({ trig = "...", snippetType = "autosnippet", wordTrig = false }, t("\\cdots")),
    s({ trig = "nabl", snippetType = "autosnippet", wordTrig = false }, t("\\nabla")),
    s({ trig = "del", snippetType = "autosnippet", wordTrig = false }, t("\\nabla")),
    s({ trig = "\\xix", snippetType = "autosnippet", wordTrig = false }, t("\\times")),
    s({ trig = "**", snippetType = "autosnippet", wordTrig = false }, t("\\cdot")),
    s({ trig = "\\cdot*", snippetType = "autosnippet", wordTrig = false }, t("\\ast")),
    s({ trig = "para", wordTrig = false }, t("\\parallel")),
    s({ trig = "simm", snippetType = "autosnippet", wordTrig = false }, t("\\sim")),
    s({ trig = "sim=", snippetType = "autosnippet", wordTrig = false }, t("\\simeq")),
    s({ trig = "prop", snippetType = "autosnippet", wordTrig = false }, t("\\propto")),
    s({ trig = "and", snippetType = "autosnippet", wordTrig = false }, t("\\cap")),
    s({ trig = "orr", snippetType = "autosnippet", wordTrig = false }, t("\\cup")),
    s({ trig = "inn", snippetType = "autosnippet", wordTrig = false }, t("\\in")),
    s({ trig = "sr", snippetType = "autosnippet", wordTrig = false }, t("^2")),
    s({ trig = "sd", snippetType = "autosnippet", wordTrig = false }, fmt("^{{{}}}", i(1, ""))),
    s({ trig = "a\\lambdal", snippetType = "autosnippet", wordTrig = false }, t("\\forall")),

    -- Derivatives
    s(
        { trig = "\\partial ar", snippetType = "autosnippet", wordTrig = false },
        fmt("\\frac{{ \\partial {} }}{{ \\partial {} }} {}", {
            i(1, "y"),
            i(2, "x"),
            i(3),
        })
    ),
    s({ trig = "\\deltat", snippetType = "autosnippet", wordTrig = false }, t("\\frac{\\mathrm{d}}{\\mathrm{d}t} ")),

    -- Integrals
    s({ trig = "int", snippetType = "autosnippet" }, t("\\int")),
    s(
        { trig = "oinf", snippetType = "autosnippet", wordTrig = "false" },
        fmt("\\int_{{0}}^{{\\infty}} {} \\, \\mathrm{{d}} {}", {
            i(1),
            i(2, "x"),
        })
    ),
    s(
        { trig = "infi", snippetType = "autosnippet", wordTrig = false },
        fmt("\\int_{{-\\infty}}^{{+\\infty}} {} \\, \\mathrm{{d}} {}", {
            i(1),
            i(2, "x"),
        })
    ),
    -- Basic integral symbols (自动触发)
    s({ trig = "oint", snippetType = "autosnippet", wordTrig = false }, t("\\oint")),
    s({ trig = "oiint", snippetType = "autosnippet", wordTrig = false }, t("\\oiint")),
    s({ trig = "iint", snippetType = "autosnippet", wordTrig = false }, t("\\iint")),
    s({ trig = "iiint", snippetType = "autosnippet", wordTrig = false }, t("\\iiint")),

    -- Trigonometry functions
    s({ trig = "sin", snippetType = "autosnippet" }, fmt("\\sin {}", { i(1) })),
    s({ trig = "cos", snippetType = "autosnippet" }, fmt("\\cos {}", { i(1) })),
    s({ trig = "tan", snippetType = "autosnippet" }, fmt("\\tan {}", { i(1) })),
    s({ trig = "cot", snippetType = "autosnippet", wordTrig = false }, fmt("\\cot {}", { i(1) })),
    s({ trig = "sec", snippetType = "autosnippet", wordTrig = false }, fmt("\\sec {}", { i(1) })),
    s({ trig = "csc", snippetType = "autosnippet", wordTrig = false }, fmt("\\csc {}", { i(1) })),
    s({ trig = "ln", snippetType = "autosnippet", wordTrig = false }, fmt("\\ln {}", { i(1) })),
    s({ trig = "Ln", snippetType = "autosnippet", wordTrig = false }, fmt("\\operatorname{{Ln}} {}", { i(1) })),
    s({ trig = "arg", snippetType = "autosnippet", wordTrig = false }, t("\\arg")),
    s({ trig = "Arg", snippetType = "autosnippet", wordTrig = false }, t("\\Arg")),
    s({ trig = "sqr", snippetType = "autosnippet", wordTrig = false }, t("\\sqrt ")),

    -- Inverse trig functions
    s({ trig = "arcsin", snippetType = "autosnippet" }, fmt("\\arcsin {}", { i(1) })),
    s({ trig = "Arcsin", snippetType = "autosnippet" }, fmt("\\operatorname{{Arcsin}} {}", { i(1) })),
    s({ trig = "Arccos", snippetType = "autosnippet", wordTrig = false }, fmt("\\operatorname{{Arccos}} {}", { i(1) })),
    s({ trig = "arccos", snippetType = "autosnippet", wordTrig = false }, fmt("\\arccos {}", { i(1) })),
    s({ trig = "arctan", snippetType = "autosnippet" }, fmt("\\arctan {}", { i(1) })),
    -- s({ trig = "arc\\tan ", snippetType = "autosnippet", wordTrig = true }, fmt("\\arctan {}", { i(1) })),

    -- Hyperbolic functions
    s({ trig = "sinh", snippetType = "autosnippet", wordTrig = false }, fmt("\\sinh {}", { i(1) })),
    s({ trig = "cosh", snippetType = "autosnippet", wordTrig = false }, fmt("\\cosh {}", { i(1) })),
    s({ trig = "tanh", snippetType = "autosnippet", wordTrig = false }, fmt("\\tanh {}", { i(1) })),
    s({ trig = "coth", snippetType = "autosnippet", wordTrig = false }, fmt("\\coth {}", { i(1) })),

    -- Quantum mechanics
    s({ trig = "dag", snippetType = "autosnippet", wordTrig = false }, t("^{\\dagger}")),
    s({ trig = "bar", snippetType = "autosnippet", wordTrig = false }, fmt("\\bar{{{}}} {}", { i(1), i(2) })),
    s({ trig = "bra", snippetType = "autosnippet", wordTrig = false }, fmt("\\bra{{{}}} {}", { i(1), i(2) })),
    s({ trig = "ket", snippetType = "autosnippet", wordTrig = false }, fmt("\\ket{{{}}} {}", { i(1), i(2) })),
    s(
        { trig = "brk", snippetType = "autosnippet", wordTrig = false },
        fmt("\\braket{{ {} | {} }} {}", { i(1), i(2), i(3) })
    ),
    s(
        { trig = "outer", snippetType = "autosnippet", wordTrig = false },
        fmt("\\ket{{{}}} \\bra{{{}}} {}", { i(1, "\\psi"), i(2, "\\psi"), i(3) })
    ),

    -- Real/Imaginary parts
    s({ trig = "Re", snippetType = "autosnippet", wordTrig = false }, t("\\operatorname{Re} ")),
    s({ trig = "Im", snippetType = "autosnippet", wordTrig = false }, t("\\operatorname{Im} ")),
    s({ trig = "\\deltad", snippetType = "autosnippet", wordTrig = false }, t("\\, \\mathrm{d} ")),
    s({ trig = "\\varphip", snippetType = "autosnippet", wordTrig = false }, t("\\partial ")),
    s(
        { trig = "fra", snippetType = "autosnippet", wordTrig = false },
        fmt("\\frac{{{}}}{{{}}}{}", { i(1, "分子"), i(2, "分母"), i(3) })
    ),
    -- Environments
    s("gather", fmt("\\begin{{gather}}\n{}\n\\end{{gather}}", { i(1) })),
    s("pmat", fmt("\\begin{{pmatrix}}\n{}\n\\end{{pmatrix}}", { i(1) })),
    s("bmat", fmt("\\begin{{bmatrix}}\n{}\n\\end{{bmatrix}}", { i(1) })),
    s("Bmat", fmt("\\begin{{Bmatrix}}\n{}\n\\end{{Bmatrix}}", { i(1) })),
    s("vmat", fmt("\\begin{{vmatrix}}\n{}\n\\end{{vmatrix}}", { i(1) })),
    s("Vmat", fmt("\\begin{{Vmatrix}}\n{}\n\\end{{Vmatrix}}", { i(1) })),
    s("matrix", fmt("\\begin{{matrix}}\n{}\n\\end{{matrix}}", { i(1) })),

    -- Inline environments (no newlines)
    s("pmat", fmt("\\begin{{pmatrix}}{}\\end{{pmatrix}}", { i(1) })),
    s("bmat", fmt("\\begin{{bmatrix}}{}\\end{{bmatrix}}", { i(1) })),
    s("Bmat", fmt("\\begin{{Bmatrix}}{}\\end{{Bmatrix}}", { i(1) })),
    s("vmat", fmt("\\begin{{vmatrix}}{}\\end{{vmatrix}}", { i(1) })),
    s("Vmat", fmt("\\begin{{Vmatrix}}{}\\end{{Vmatrix}}", { i(1) })),
    s("matrix", fmt("\\begin{{matrix}}{}\\end{{matrix}}", { i(1) })),

    -- Additional environments
    s("cases", fmt("\\begin{{cases}}\n{}\n\\end{{cases}}", { i(1) })),
    s("align", fmt("\\begin{{align}}\n{}\n\\end{{align}}", { i(1) })),
    s("array", fmt("\\begin{{array}}\n{}\n\\end{{array}}", { i(1) })),

    -- Angle brackets
    s("avg", fmt("\\langle {} \\rangle {}", { i(1), i(2) })),

    -- Norms
    s("norm", fmt("\\lvert {} \\rvert {}", { i(1), i(2) })),
    s("Norm", fmt("\\lVert {} \\rVert {}", { i(1), i(2) })),

    -- Ceil/Floor
    s("ceil", fmt("\\lceil {} \\rceil {}", { i(1), i(2) })),
    s("floor", fmt("\\lfloor {} \\rfloor {}", { i(1), i(2) })),

    -- Absolute value (non-LaTeX)
    s({ trig = "mod", snippetType = "autosnippet" }, fmt("\\left|{}\\right|{}", { i(1), i(2) })),
    -- Basic parens with insert nodes
    s("(", fmt("({}){}", { i(1), i(2) })),
    s("{", fmt("{{{}}}{}", { i(1), i(2) })),
    s("[", fmt("[{}]{}", { i(1), i(2) })),

    -- \left and \right
    s({ trig = "lr(", snippetType = "autosnippet", wordTrig = false }, fmt("\\left( {} \\right) {}", { i(1), i(2) })),
    s({ trig = "lr[", snippetType = "autosnippet", wordTrig = false }, fmt("\\left[ {} \\right] {}", { i(1), i(2) })),
    s({ trig = "lr|", snippetType = "autosnippet", wordTrig = false }, fmt("\\left| {} \\right|{}", { i(1), i(2) })),
    s(
        { trig = "lr{", snippetType = "autosnippet", wordTrig = false },
        fmt("\\left\\{{ {} \\right\\}} {}", { i(1), i(2) })
    ),
    s({ trig = "lra", snippetType = "autosnippet", wordTrig = false }, fmt("\\left< {} \\right>{}", { i(1), i(2) })),
    s({ trig = "val", snippetType = "autosnippet", wordTrig = false }, fmt("\\left. {} \\right |", { i(1) })),
    -- Font/formatting commands
    s({ trig = "cal", snippetType = "autosnippet", wordTrig = false }, fmt("\\mathcal{{{}}}", { i(1) })),
    s({ trig = "scr", wordTrig = false }, fmt("\\mathscr{{{}}}", { i(1) })),
    s({ trig = "frk", snippetType = "autosnippet", wordTrig = false }, fmt("\\mathfrak{{{}}}", { i(1) })),
    s({ trig = "mbb", snippetType = "autosnippet", wordTrig = false }, fmt("\\mathbb{{{}}}", { i(1) })),
    s({ trig = "mbf", snippetType = "autosnippet", wordTrig = false }, fmt("\\mathbf{{{}}}", { i(1) })),
    s({ trig = "it", wordTrig = false }, fmt("\\mathit{{{}}}", { i(1) })),
    s({ trig = "rm", snippetType = "autosnippet", wordTrig = false }, fmt("\\mathrm{{{}}}", { i(1) })),

    s(
        { trig = "ol", snippetType = "autosnippet" }, -- underleftarrow
        fmt("\\overline{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ub", snippetType = "autosnippet" }, -- underbrace
        fmt("\\underbrace{{{}}}_{{{}}}", { i(1, "表达式"), i(2, "下标") })
    ),
    s(
        { trig = "os", snippetType = "autosnippet" }, -- underbrace
        fmt("\\overset{{{}}}{{{}}}", { i(1, "上标"), i(2, "表达式") })
    ),

    s(
        { trig = "ob", snippetType = "autosnippet" }, -- overbrace
        fmt("\\overbrace{{{}}}^{{{}}}", { i(1, "表达式"), i(2, "上标") })
    ),

    s(
        { trig = "ula", snippetType = "autosnippet" }, -- underleftarrow
        fmt("\\underleftarrow{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ura", snippetType = "autosnippet" }, -- underrightarrow
        fmt("\\underrightarrow{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ola", snippetType = "autosnippet" }, -- overleftarrow
        fmt("\\overleftarrow{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ora", snippetType = "autosnippet" }, -- overrightarrow
        fmt("\\overrightarrow{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ubarr", snippetType = "autosnippet" }, -- underbar
        fmt("\\underbar{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "uhat", snippetType = "autosnippet" }, -- underhat
        fmt("\\underhat{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "utilde", snippetType = "autosnippet" }, -- undertilde
        fmt("\\undertilde{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "obar", snippetType = "autosnippet" }, -- overbar
        fmt("\\overbar{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "ohat", snippetType = "autosnippet" }, -- overhat
        fmt("\\overhat{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "otilde", snippetType = "autosnippet" }, -- overtilde
        fmt("\\overtilde{{{}}}", { i(1, "表达式") })
    ),

    s(
        { trig = "stk", snippetType = "autosnippet" }, -- stackrel
        fmt("\\stackrel{{{}}}{{{}}}", { i(1, "上标"), i(2, "表达式") })
    ),

    s(
        { trig = "mmpage", snippetType = "autosnippet" },
        fmt(
            [[
\begin{{center}}
    \begin{{minipage}}[t]{{0.45\textwidth}}
        {}
    \end{{minipage}}
    \hfill
    \begin{{minipage}}[t]{{0.45\textwidth}}
            {}
    \end{{minipage}}
\end{{center}}
]],
            {
                i(1, "左侧内容"),
                i(2, "右侧内容"),
            }
        )
    ),
}

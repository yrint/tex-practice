#!/usr/bin/env perl

# 共通オプション
my $common_opts = '-synctex=1 -interaction=nonstopmode %S';

# LaTeXエンジン設定
$latex    = "lualatex %O $common_opts";
$pdflatex = "pdflatex %O $common_opts";
$lualatex = "lualatex %O $common_opts";
$xelatex  = "xelatex %O $common_opts";

# ビブリオグラフィー設定
$biber  = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'bibtexu %O %B';

# インデックス・変換ツール
$makeindex = 'upmendex %O -o %D %S';
$dvipdf    = 'dvipdfmx %O -o %D %S';
$dvips     = 'dvips %O -z -f %S | convbkmk -u > %D';
$ps2pdf    = ($^O eq 'MSWin32') ? 'ps2pdf.exe %O %S %D' : 'ps2pdf %O %S %D';

# ビルド設定
$pdf_mode     = 3;
$max_repeat   = 5;
$out_dir      = '../out/pdf';
$aux_dir      = '../out/.tex_intermediates';
$directory    = 'tex';
@default_files = ("tex/main.tex");
$clean_full_ext = '../out/*';

# 自動処理
add_cus_dep('bib', 'bbl', 0, 'run_biber');
sub run_biber {
    system("biber $_[0]");
}


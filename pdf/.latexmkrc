# 使用するエンジンを指定
$pdflatex = 'lualatex -shell-escape -file-line-error -interaction=nonstopmode';

# エラー停止しないモードを有効化
$pdf_mode = 1;

# 必要に応じてbibtexやbiberも設定
$bibtex = 'bibtex %O %B';
$biber = 'biber %O %B';

# 自動的にループしてエラー解消
$max_repeat = 5;

# 出力フォルダ指定
$out_dir = "out";

# 中間ファイルを別フォルダに隠しておける
$emulate_aux = 1;
$aux_dir = ".tex_intermediates";
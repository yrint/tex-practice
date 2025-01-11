# 使用するエンジンを指定
$pdflatex = 'lualatex -shell-escape -interaction=nonstopmode';

# エラー停止しないモードを有効化
$pdf_mode = 1;

# 必要に応じてbibtexやbiberも設定
$bibtex = 'bibtex %O %B';
$biber = 'biber %O %B';

# 自動的にループしてエラー解消
$max_repeat = 5;

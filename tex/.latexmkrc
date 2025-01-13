# 使用するエンジンを指定
$pdflatex = 'lualatex -shell-escape -file-line-error -interaction=nonstopmode';

# エラー停止しないモードを有効化
$pdf_mode = 1;

# 必要に応じてbibtexやbiberを設定
$bibtex = 'bibtex %O %B';
$biber = 'biber %O %B';

# エラー解消のための自動ループの最大回数
$max_repeat = 5;

# 出力ディレクトリの指定
$out_dir = "../out/pdf";

# 中間ファイルを別フォルダに保存
$aux_dir = "../out/.tex_intermediates";

# 入力ファイルのディレクトリを明示的に指定
# プロジェクトルートの`tex/`ディレクトリ配下のリソースを検索対象に含める
$search_path_separator = ":"; # Linux/Unix用
$ENV{'TEXINPUTS'} = "tex/contents:tex/figures:tex/bibliography:tex/style:";

# デフォルトのターゲットファイルを指定
@default_files = ("tex/main.tex");

# MakeIndexやMakeGlossariesの設定（必要なら追加）

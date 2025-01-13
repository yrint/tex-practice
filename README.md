# Artifacts
mainブランチにプッシュするとmain.texからPDFが生成され、生成されたPDFは[https://use_rname.github.io/repository_name/pdf/main.pdf](https://yrint.github.io/tex-practice/pdf/main.pdf)にアップロードされます。

# このTeXプロジェクトのディレクトリ構成
```
tex-project/
├── .git/                      # Git管理用のディレクトリ (自動生成される)
├── .github/                   # GitHub Actionsなどの設定
├── Dockerfile                 # Dockerコンテナの設定ファイル
├── docker-compose.yml         # 複数コンテナの設定 (オプション)
├── tex/                       # TeXソースコードを格納するディレクトリ
│   ├── main.tex               # 主なTeXファイル
│   ├── contents/              # 分割したTeXファイル
│   ├── figures/               # 図のファイル (画像など)
│   ├── bibliography/          # 参考文献用のファイル
│   ├── style/                 # スタイルファイル (.sty) や設定ファイル
│   └── .latexmkrc             # latexmk
├── out/                       # 出力ディレクトリ (.gitignoreの対象)
│   ├── pdf/                   # ローカルでビルドしたPDFファイル
│   └── .tex_intermediates/    # ローカルでビルドした際の中間生成ファイル
├── docs/                      # ドキュメント (説明書やプロジェクトの概要)
├── scripts/                   # スクリプトファイル (ビルドスクリプトなど)
├── .gitignore                 # Gitに無視させるファイルやディレクトリ
└── README.md                  # このファイル
```
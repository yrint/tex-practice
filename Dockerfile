# ベースイメージとして軽量なTeX Liveを使用
FROM debian:bullseye-slim

# 必要な環境変数の設定
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    perl \
    xz-utils \
    fontconfig \
    fonts-noto-cjk \
    fonts-noto-cjk-extra && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# TeX Liveのインストール
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    cd install-tl-* && \
    echo "selected_scheme scheme-small" > texlive.profile && \
    echo "tlpdbopt_install_docfiles 0" >> texlive.profile && \
    echo "tlpdbopt_install_srcfiles 0" >> texlive.profile && \
    ./install-tl --profile=texlive.profile && \
    cd .. && rm -rf install-tl-* install-tl-unx.tar.gz

# 必要なパッケージをTeX Liveでインストール
RUN tlmgr install \
    collection-luatex \
    collection-latexrecommended \
    collection-latexextra \
    luatexja \
    biblatex \
    latexmk \
    l3build \
    collection-fontsrecommended

# フォントキャッシュの更新
RUN fc-cache -fv

# 非rootユーザーを作成
ARG USERNAME=nonrootuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID --shell /bin/bash --create-home $USERNAME && \
    mkdir -p /workdir && chown $USERNAME:$USERNAME /workdir

# 非rootユーザーに切り替え
USER $USERNAME

# 作業ディレクトリ
WORKDIR /workdir

# コンテナ起動時にデフォルトのシェルを使用
CMD ["bash"]

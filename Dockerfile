FROM ubuntu:22.04

# 環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV TEXLIVE_VERSION=2023
ENV PATH=/usr/local/texlive/${TEXLIVE_VERSION}/bin/x86_64-linux:$PATH

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y \
    curl \
    perl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# TeX Liveのインストール
RUN mkdir /tmp/install-tl-unx && \
    curl -L https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz -o /tmp/install-tl-unx.tar.gz && \
    tar -xzvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1 && \
    echo -e "selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0" > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl --repository http://mirror.ctan.org/systems/texlive/tlnet/ --profile /tmp/install-tl-unx/texlive.profile && \
    rm -rf /tmp/install-tl-unx /tmp/install-tl-unx.tar.gz

# TeX Live パッケージの更新とインストール
RUN tlmgr update --self --all && \
    tlmgr install \
        collection-luatex \
        collection-langenglish \
        collection-langjapanese \
        collection-latexrecommended \
        collection-latexextra \
        latexmk \
        latexindent \
        biber \
        siunitx \
        physics2 \
        fixdif \
        derivative && \
    fmtutil-sys --byfmt lualatex && \
    mktexlsr

# ユーザーの作成とディレクトリ設定
RUN useradd -m -u 1000 -s /bin/bash latex && \
    mkdir -p /workdir/out/pdf /workdir/out/.tex_intermediates && \
    chown -R latex:latex /workdir

USER latex
WORKDIR /workdir

FROM ubuntu:22.04

# 必要な環境変数の設定
ENV DEBIAN_FRONTEND=noninteractive
ENV TEXLIVE_VERSION=2023
ENV PATH="/usr/local/texlive/${TEXLIVE_VERSION}/bin/x86_64-linux:$PATH"

# 必要な依存関係をインストール
RUN apt-get update && apt-get install -y \
    curl \
    perl \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# TeX Liveのインストール
RUN mkdir /tmp/install-tl-unx && \
    curl -L https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz -o /tmp/install-tl-unx.tar.gz && \
    tar -xzvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1 && \
    /bin/echo -e 'selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0' > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
    --repository http://mirror.ctan.org/systems/texlive/tlnet/ \
    -profile /tmp/install-tl-unx/texlive.profile && \
    rm -r /tmp/install-tl-unx && \
    ln -sf /usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux /usr/local/texlive/bin

# 基本的なパッケージをインストール
RUN tlmgr update --self --all && \
    tlmgr install \
        collection-luatex \
        collection-langenglish \
        collection-langjapanese \
        collection-latexrecommended \
        collection-latexextra \
        latexmk \
        latexindent

# 使用するパッケージをインストール
RUN tlmgr install \
        biber \
        siunitx \
        physics2 \
        fixdif \
        derivative

# 他に使用するパッケージがある場合ここに記述

# 以下をまとめて一度に実行してレイヤーを削減
RUN useradd -m -u 1000 -s /bin/bash latex && \
    mkdir -p /workdir/out/pdf /workdir/out/.tex_intermediates && \
    chown -R latex:latex /workdir && \
    mkdir -p /out/pdf /out/.tex_intermediates && \
    chown -R latex:latex /out

USER latex
WORKDIR /workdir

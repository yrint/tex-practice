FROM ubuntu:22.04

ARG TEXLIVE_VERSION=2024

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/bin:$PATH"
ENV LC_ALL=C

# curl と Perl の依存関係をインストール
RUN apt-get update && \
    apt-get install -y curl perl && \
    rm -rf /var/lib/apt/lists/*

# TeX Live frozen 版のインストール
RUN mkdir /tmp/install-tl-unx && \
    curl -L https://ftp.jaist.ac.jp/pub/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz -o /tmp/install-tl-unx.tar.gz && \
    tar -xzvf /tmp/install-tl-unx.tar.gz -C /tmp/install-tl-unx --strip-components=1 && \
    /bin/echo -e 'selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0' > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl \
    --repository http://mirror.ctan.org/systems/texlive/tlnet/ \
    -profile /tmp/install-tl-unx/texlive.profile && \
    rm -r /tmp/install-tl-unx && \
    ln -sf /usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux /usr/local/texlive/bin

RUN tlmgr update --self --all && \
    tlmgr install \
    collection-bibtexextra \
    collection-fontsrecommended \
    collection-langenglish \
    collection-langjapanese \
    collection-latexextra \
    collection-latexrecommended \
    collection-luatex \
    collection-mathscience \
    collection-plaingeneric \
    latexmk \
    latexdiff \
    siunitx \
    newtx \
    svg \
    latexindent && \
    mktexlsr && \
    useradd -m -u 1000 -s /bin/bash latex

USER latex

WORKDIR /workdir
FROM yzhaowei/toolkit-base:v0.1

USER root

RUN install2.r --error \
    --deps TRUE \
    ggpubr pheatmap \
    Seurat \
    # benchmark
    tictoc \
    # dependency for immunarch
    heatmap3 factoextra fpc circlize shinythemes treemap airr ggseqlogo UpSetR ggalluvial \
    # install github packages
    && installGithub.r immunogenomics/harmony yycunc/SMNN satijalab/seurat-wrappers satijalab/seurat-data \
      timoast/signac hms-dbmi/conos \
    ## from bioconductor
    && R -e "BiocManager::install(c('phyloseq', 'DESeq2', 'scran', 'scater', 'limma', 'sva', 'org.Hs.eg.db'))" \
    && wget "https://github.com/immunomind/immunarch/releases/download/latest/immunarch.tar.gz" \
    && install2.r immunarch.tar.gz \
    && rm immunarch.tar.gz \
    && rm ~/.wget-hsts

RUN pip3 install --no-cache-dir \
    umap-learn==0.3.9 bbknn==1.3.5 scanorama==1.4

USER ${NB_USER}

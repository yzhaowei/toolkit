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
    && installGithub.r immunogenomics/harmony  \
    ## from bioconductor
    && R -e "BiocManager::install(c('phyloseq', 'scran', 'scater', 'limma', 'sva', 'org.Hs.eg.db'))" \
    && wget "https://github.com/immunomind/immunarch/releases/download/latest/immunarch.tar.gz" \
    && install2.r immunarch.tar.gz \
    && rm immunarch.tar.gz

USER ${NB_USER}

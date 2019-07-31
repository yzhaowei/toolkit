FROM yzhaowei/toolkit-base:v0.1

USER root

RUN install2.r --error \
    --deps TRUE \
    ggpubr \
    pheatmap \
    Seurat \
    # dependency for immunarch
    heatmap3 factoextra fpc circlize shinythemes treemap airr ggseqlogo UpSetR ggalluvial \
    ## from bioconductor
    && R -e "BiocManager::install('phyloseq')" \
    && wget "https://github.com/immunomind/immunarch/releases/download/latest/immunarch.tar.gz" \
    && install2.r immunarch.tar.gz \
    && rm immunarch.tar.gz

USER ${NB_USER}

FROM yzhaowei/toolkit-base:R3.6.2

USER root

RUN install2.r --error \
    --deps TRUE \
    ggpubr pheatmap msigdbr \
    # benchmark
    tictoc \
    # dependency for immunarch
    heatmap3 factoextra fpc circlize shinythemes treemap airr ggseqlogo UpSetR ggalluvial \
    # dependency for Signac
    && R -e "BiocManager::install(c('AnnotationFilter', 'GenomeInfoDb', 'GenomicFeatures', 'GenomicRanges', 'IRanges', 'Rsamtools', 'TFBSTools', 'ggbio', 'motifmatchr', 'AnnotationDbi', 'Biostrings', 'BSgenome', 'GSVA', 'BiocGenerics','DelayedArray','DelayedMatrixStats','SingleCellExperiment','SummarizedExperiment'))" \
    # install github packages
    && installGithub.r immunogenomics/harmony yycunc/SMNN satijalab/seurat satijalab/seurat-wrappers satijalab/seurat-data chris-mcginnis-ucsf/DoubletFinder \
      timoast/signac hms-dbmi/conos sjessa/ggmin \
    ## from bioconductor
    && R -e "BiocManager::install(c('phyloseq', 'DESeq2', 'scran', 'scater', 'limma', 'sva', 'org.Hs.eg.db', 'org.Mm.eg.db', 'GSVA'))" \
    && wget "https://github.com/immunomind/immunarch/raw/master/immunarch.tar.gz" \
    && install2.r immunarch.tar.gz \
    && rm immunarch.tar.gz \
    && rm ~/.wget-hsts \
    && rm -rf /tmp/*

RUN pip install nose snaptools limix --no-cache-dir \
    && rm -rf /var/lib/apt/lists/*  \
    && rm -rf /tmp/*

RUN pip3 install --no-cache-dir \
    umap-learn==0.3.9 bbknn==1.3.5 scanorama==1.4 \
    scanpy==1.4.3 \
    scrublet \
    && rm -rf /var/lib/apt/lists/*  \
    && rm -rf /tmp/*

RUN install2.r --error \
    --deps TRUE \
    doParallel future psych citr ggnewscale ape scatterplot3d  \
    && R -e "BiocManager::install(c('batchelor', 'scRNAseq','esATAC','mygene','ComplexHeatmap','tidytree','treeio','ggtree'))" \
    && installGithub.r cole-trapnell-lab/leidenbase cole-trapnell-lab/monocle3 \
    && rm -rf /var/lib/apt/lists/*  \
    && rm -rf /tmp/*

USER ${NB_USER}

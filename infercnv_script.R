#!/usr/bin/env Rscript

options(error = function() traceback(2))

library("infercnv")
# create the infercnv object
infercnv_obj = CreateInfercnvObject(raw_counts_matrix=readRDS("sc.merged.counts.matrix.rds"),
                                    annotations_file="Merged_cel.metadata.txt",
                                    delim="\t",
                                    gene_order_file="cellranger_grh38_gen_pos.txt",
                                    ref_group_names=c("REF"))

out_dir="output_dir"
# perform infercnv operations to reveal cnv signal
infercnv_obj = infercnv::run(infercnv_obj,
                             cutoff=0.1, # cutoff=1 works well for Smart-seq2, and cutoff=0.1 works well for 10x Genomics
                             out_dir=out_dir, 
                             cluster_by_groups=TRUE, 
                             plot_steps=FALSE,
                             denoise=TRUE,
                             HMM=TRUE
                             )


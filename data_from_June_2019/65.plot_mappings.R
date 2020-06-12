#/usr/bin/env Rscript

library(ggplot2)
df <- read.table("/data/projects/mdc-971/data_from_June_2019/50.aligned_to_L1_HBB/type_lengths.txt", header = T)
type_lengths <- df[, c(1, 4)]

dir="/data/projects/mdc-971/data_from_June_2019/50.aligned_to_L1_HBB"

files <- list.files(dir)

for (cls in c("HBB", "HPV")) {
  pdf(paste0(dir, "/Mapping_locations_visualized_", cls, ".pdf"))
  for (i in 1:96) {
    print(i)
    dat <- read.table(paste0(dir,"/", files[i], "/Base-wise-summary.txt"), sep = "\t")
    colnames(dat) <- c("GeneID", "Nucleotide", "Counts")
    dat$RefSeq <- map(dat$GeneID, 
                      function(x) strsplit(as.character(x), split = "_")[[1]][1]) 
    dat$RefSeq <- laply(strsplit(as.character(dat$RefSeq), split = "HPV"), 
                        function(x) if (length(x) > 1) x[2] else x)
    this_lengths <- subset(type_lengths,
                           Geneid %in% as.character(unique(dat$GeneID)))
    colnames(this_lengths) <- c("RefSeq", "Length")
    this_lengths$RefSeq <- map(this_lengths$RefSeq, 
                               function(x) strsplit(as.character(x), split = "_")[[1]][1]) 
    this_lengths$RefSeq <- laply(strsplit(as.character(this_lengths$RefSeq), split = "HPV"), 
                                 function(x) if (length(x) > 1) x[2] else x)
    
    xlims <- c(0, 2000)
    dat <- subset(dat, if (cls == "HBB") RefSeq == "HBB" else RefSeq != "HBB") 
    this_lengths <- subset(this_lengths,  
                           if (cls == "HBB") RefSeq == "HBB" else RefSeq != "HBB")
    if (!nrow(dat)) next
    this_coord <- subset(target_coord, RefSeq %in% this_lengths$RefSeq)
    print(ggplot(dat, aes(x = Nucleotide, y = Counts)) + 
            geom_bar(stat = "identity") +
            facet_grid(RefSeq ~ .)+
            coord_cartesian(xlim = xlims)+
            geom_rect(aes(xmin = Length+1), xmax = Inf, ymin = -Inf, ymax = Inf,
                      data = this_lengths, inherit.aes = F, fill = "white")+
            ggtitle(strsplit(files[i], split = "_S")[[1]][1])+
            geom_rect(aes(xmin = Start-0.5, xmax = End + 0.5),
                      ymin = -Inf, ymax = Inf, data = this_coord,
                      fill = "red", alpha = 0.1, inherit.aes = F))
    
    
  }
  dev.off()
  
}


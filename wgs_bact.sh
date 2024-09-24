# remove hashes before start to working on new system
#module load anaconda
#conda config --add channels conda-forge
#conda config --add channels daler
#conda config --add channels bioconda
#conda config --add channels defaults
#sudo apt install git

git clone https://github.com/vappiah/bacterial-genomics-tutorial.git
cd bacterial-genomics-tutorial/
conda env create --quiet -f environment.yaml
pip install -r pip-requirements.txt
source activate bacterial-genomics-tutorial
PS="(bacterial-genomics-tutorial)" 
export PS1 
pip install -r pip-requirements.txt
mkdir apps
wget https://github.com/broadinstitute/pilon/releases/download/v1.23/pilon-1.23.jar -O apps/pilon.jar
chmod +x *.{py,sh,pl}
./download.sh

./qc_raw_reads.sh

 ls QC_RAW_READS/

 ./trim_reads.sh

./qc_trimmed_reads.sh 
./assemble.sh

./polish.sh

./qc_assembly.sh 

ls QC_ASSEMBLY/

./reorder_contigs.sh

./mlst.sh
./amr.sh

python get_annot_stats.py P7741_annotation P7741

./annotate.sh

./dendogram.sh
nano get_genome_gffs.sh 
./get_genome_gffs.sh
./get_pangenome.sh

python gene_count_summary.py P7741 Agy99 Liflandii pangenome/gene_presence_absence.csv
mv gene_count_summary.png P7741_Agy99_Liflandii.png
 python gene_count_summary.py P7741 H37Rv Liflandii pangenome/gene_presence_absence.csv
mv gene_count_summary.png P7741_H37Rv_Liflandii.png
./zip_results.sh 


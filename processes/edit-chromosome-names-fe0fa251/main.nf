$HOSTNAME = ""
params.outdir = 'results'  


if (!params.fasta){params.fasta = ""} 
if (!params.gtfFile){params.gtfFile = ""} 
// Stage empty file to be used as an optional input where required
ch_empty_file_1 = file("$baseDir/.emptyfiles/NO_FILE_1", hidden:true)
ch_empty_file_2 = file("$baseDir/.emptyfiles/NO_FILE_2", hidden:true)

g_1_0_g_0 = params.fasta && file(params.fasta, type: 'any').exists() ? file(params.fasta, type: 'any') : ch_empty_file_1
g_2_1_g_0 = params.gtfFile && file(params.gtfFile, type: 'any').exists() ? file(params.gtfFile, type: 'any') : ch_empty_file_2

//* autofill
if ($HOSTNAME == "default"){
    $CPU  = 1
    $MEMORY = 15
}
//* platform
//* platform
//* autofill

process edit_chromosome_names {

publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /genome.fa$/) "fasta__12574/$filename"}
publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /annotation.fa$/) "gtfFile__12575/$filename"}
input:
 path genome
 path annotation

output:
 path "genome.fa"  ,emit:g_0_fasta00 
 path "annotation.fa"  ,emit:g_0_gtfFile11 

container "python:3.9.19-alpine"

script:
	
prefix = params.edit_chromosome_names.prefix
postfix = params.edit_chromosome_names.postfix
delimiter = params.edit_chromosome_names.delimiter

"""
edit_chromosome.py --fasta ${genome} --gtf ${annotation} --prefix ${prefix} --postfix ${postfix} --delimiter ${delimiter}

"""

}


workflow {



edit_chromosome_names(g_1_0_g_0,g_2_1_g_0)
g_0_fasta00 = edit_chromosome_names.out.g_0_fasta00
g_0_gtfFile11 = edit_chromosome_names.out.g_0_gtfFile11


}

workflow.onComplete {
println "##Pipeline execution summary##"
println "---------------------------"
println "##Completed at: $workflow.complete"
println "##Duration: ${workflow.duration}"
println "##Success: ${workflow.success ? 'OK' : 'failed' }"
println "##Exit status: ${workflow.exitStatus}"
if (params.outdir?.toString()?.startsWith('s3://')) {
    try {
        file("${params.outdir}/.foundry/run-status.txt").text = "##Success: ${workflow.success ? 'OK' : 'failed'}\n##Exit status: ${workflow.exitStatus}\n##Completed at: ${workflow.complete}\n"
    } catch (Exception e) {
        println "WARN: could not write the run status file: ${e.message}"
    }
}
}

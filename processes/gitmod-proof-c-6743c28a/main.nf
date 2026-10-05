$HOSTNAME = ""
params.outdir = 'results'  


if (!params.fixture_result){params.fixture_result = ""} 

g_1_0_g_0 = file(params.fixture_result, type: 'any')


process gitmod_proof_c {

publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /final.txt$/) "fixture_final/$filename"}
input:
 path infile

output:
 path 'final.txt'  ,emit:g_0_fixture_final00 

"""
cat ${infile} > final.txt
echo done >> final.txt

"""
}


workflow {


gitmod_proof_c(g_1_0_g_0)
g_0_fixture_final00 = gitmod_proof_c.out.g_0_fixture_final00


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

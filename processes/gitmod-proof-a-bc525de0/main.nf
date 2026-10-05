$HOSTNAME = ""
params.outdir = 'results'  


if (!params.fixture_value){params.fixture_value = ""} 

Channel.value(params.fixture_value).set{g_1_0_g_0}


process gitmod_proof_a {

publishDir params.outdir, mode: 'copy', saveAs: {filename -> if (filename =~ /a.txt$/) "fixture_result/$filename"}
input:
 val value

output:
 path 'a.txt'  ,emit:g_0_fixture_result00 

"""
echo "a ${value}" > a.txt

"""
}


workflow {


gitmod_proof_a(g_1_0_g_0)
g_0_fixture_result00 = gitmod_proof_a.out.g_0_fixture_result00


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

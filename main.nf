nextflow.enable.moduleBinaries = true
nextflow.preview.output = true

process TOUCH_FILES {
    container "staphb/bbtools:39.01"
    output:
        path("flat_file.txt"), emit: file
        path("file_dir"), emit: dir
    shell:
        '''
        mkdir file_dir
        touch flat_file.txt
        touch file_dir/dir_file.txt
        '''
}

// Workflow
workflow {
    TOUCH_FILES()
    publish:
        TOUCH_FILES.out.file >> "results"
        TOUCH_FILES.out.dir  >> "results"
}

// Output
output {
    "results" {
        path "results"
        tags nextflow_file_class: "publish", "nextflow.io/temporary": "false"
    }
}

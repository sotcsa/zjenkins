pipelineJob('monorepo') {
    definition {
        cps {
            script(readFileFromWorkspace('src/pipelines/monorepo-pipeline.groovy'))
        }
    }
}
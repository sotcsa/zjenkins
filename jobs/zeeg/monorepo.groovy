pipelineJob('job-dsl-plugin') {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url('codecommit::/monorepo')
          }
          branch('*/main')
        }
      }
      lightweight()
    }
  }
}

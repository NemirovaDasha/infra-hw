const core = require('@actions/core');
const github = require('@actions/github');

const TOKEN = core.getInput('github-ref', {required: true});
console.log(TOKEN)
console.log(github.context.payload.ref_name)
process.exit(0);
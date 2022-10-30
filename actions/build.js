import * as core from '@actions/core';
const github = require('@actions/github');

// {required: true} выкинет ошибку, если input не передан
const TOKEN = core.getInput('github-ref', {required: true});
console.log(TOKEN)
console.log(github.context.payload.ref_name)
process.exit(0);
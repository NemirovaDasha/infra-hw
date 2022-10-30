const OAUTH_TOKEN = process.env.OAUTH_TOKEN;
const X_ORG_ID = process.env.X_ORG_ID;
const TAG = process.env.GITHUB_REF_NAME;
const PREV_TAG = process.env.PREV_TAG;

const ticketTitle = `Релиз ${TAG} - ${new Date().toLocaleDateString()}`;

console.log(OAUTH_TOKEN)
console.log(X_ORG_ID)
console.log(TAG)
console.log(PREV_TAG)
console.log(ticketTitle)

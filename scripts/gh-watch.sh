id=$(gh run list --json databaseId -q '.[0].databaseId')
gh run watch $id && gh run view $id --log-failed > failed.log
cat failed.log | cut -c 150-

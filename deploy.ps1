
param($comment)

git add -A

if ($comment) {
    git commit -m "[Specified] Content Synchronization"
} else {
    git commit -m "[Default] Content Synchronization"
}

git push

mkdocs gh-deploy
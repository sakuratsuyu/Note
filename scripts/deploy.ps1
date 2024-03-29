# deploy scripts by powershell

param($comment)

git add -A

if ($comment) {
    git commit -m "[Specified] $comment"
} else {
    git commit -m "[Default] Synchronization"
}

git push -u origin main

conda activate notes

mkdocs gh-deploy
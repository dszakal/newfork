# newfork
newfork.sh - github does not support forking your own projects or forking a project more than once with the same account. But you can still create any number of forks easily with this bash script
This is practically an automation of the solution suggested as a top answer here: http://stackoverflow.com/questions/10963878/how-do-you-fork-your-own-project-on-github

usage: 
```bash
    cd path/to/my_dev_projects_folder/
    git clone git@github.com:dszakal/newfork.git
    chmod +x ./newfork/newfork.sh
    ./newfork/newfork.sh git@github.com/something/projecttofork.git git@github.com/something/newfork.git
```

Only ssh git@github.com urls are supported, no https

Optional maintenance - merging back from upstream master (the one you forked from) to origin master (your project after fork):

```bash
    git fetch upstream
    git merge upstream/master
    git push    
```

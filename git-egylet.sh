#!/bin/bash
# script for git

#links:
#https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging
#http://gitref.org/basic/#commit
#https://github.com/Kunena/Kunena-Forum/wiki/Create-a-new-branch-with-git-and-manage-branches
#http://stackoverflow.com/questions/1687262/link-to-github-issue-number-with-commit-message
#https://www.atlassian.com/git/tutorials/undoing-changes/git-revert
#https://confluence.atlassian.com/bitbucket/resolve-issues-automatically-when-users-push-code-221451126.html

while true
do
    echo "Which command do you like? \n
            GENERAL                       BRANCHES              ISSUES            
            [s]  - status                  [lb] - list           [li] - issues
            [l]  - log                     [sb] - select
            [d]  - diff                    [nb] - new   
            [c]  - commit                  [mb] - merge
            [u]  - undo (last commit)      [db] - del
            [ps] - push
            [pl] - pull\n 
            [q]  - quit"
         
    read gitcommand
    if [ ! -z $gitcommand ]; then
         if [ $gitcommand = "quit" ] || [ $gitcommand = "q" ]; then
            exit  
         elif [ $gitcommand = "issues" ] || [ $gitcommand = "li" ]; then
           #status of git changes
           #npm git-issues is necessary to install (npm install -g git-issues or npm install git-issues --save) 
           git issues
         elif [ $gitcommand = "status" ] || [ $gitcommand = "s" ]; then
           #status of git changes
           git status
         elif [ $gitcommand = "log" ] || [ $gitcommand = "l" ]; then
           git log --reverse --oneline
         elif [ $gitcommand = "diff" ] || [ $gitcommand = "d" ]; then
           #status of git changes
           git diff
        elif [ $gitcommand = "list" ] || [ $gitcommand = "lb" ]; then
           #list git branches
           git branch
        elif [ $gitcommand = "commit" ] || [ $gitcommand = "c" ]; then
                #add newly created files
                git add --all
                #git status
                git status -s
                #read comment
                echo "Type the comment of the git commit [ENTER]:"
                read comment
                #read issue
                echo "Type the reference number of the git issue [ENTER]:"
                read issue
                    #read issue command if issue is not empty
                    #https://confluence.atlassian.com/bitbucket/resolve-issues-automatically-when-users-push-code-221451126.html
                    if [  ! -z $issue ]; then
                        issue="#"$issue
                        echo "Which issue command do you like? \n [h] - hold \n [f] - fixed"
                        read issueCommand
                        if [ $issueCommand = "f" ] || [ $issueCommand = "fixed" ]; then  
                             issueCommand="fixed"
                        else   
                             issueCommand="hold" 
                             #read issue comment
                             echo "Type any comment to issue [ENTER]:"
                             read issueComment
                        fi   
                    fi
                git commit -am "$comment $issueCommand $issue $issueComment"
          elif [ $gitcommand = "undo" ] || [ $gitcommand = "4" ]; then
                #undo previous unpushed commit
                git reset --soft HEAD~ 
         elif [ $gitcommand = "push" ] || [ $gitcommand = "push" ] || [ $gitcommand = "merge" ] || [ $gitcommand = "select" ] || [ $gitcommand = "new" ] || [ $gitcommand = "del" ] ||
              [ $gitcommand = "ps" ] || [ $gitcommand = "pl" ] || [ $gitcommand = "mb" ] || [ $gitcommand = "sb" ] || [ $gitcommand = "nb" ] || [ $gitcommand = "db" ]; then
                #read target branch
             if [ $gitcommand = "push" ] || [ $gitcommand = "ps" ]; then
                  echo "Type the name of the target git branch [ENTER]:"
                  read targetbranch
                  git push -f origin $targetbranch
             elif [ $gitcommand = "pull" ] || [ $gitcommand = "pl" ]; then
                  echo "Type the name of the target git branch [ENTER]:"
                  read targetbranch               
                  git checkout $targetbranch
                  git pull --rebase origin
             elif [ $gitcommand = "merge" ] || [ $gitcommand = "mb" ]; then
                 echo "Type the name of the source git branch. \n Please be sure the destination branch is selected. Press [ENTER] to continue..."
                 read targetbranch
                 git merge $targetbranch
             elif [ $gitcommand = "select" ] || [ $gitcommand = "sb" ]; then
                 echo "Type the name of the target git branch [ENTER]:"
                 read targetbranch
                 git checkout $targetbranch
             elif [ $gitcommand = "new" ] || [ $gitcommand = "nb" ]; then
                 echo "Type the name of the new git branch [ENTER]:"
                 read targetbranch
                 git checkout -b $targetbranch
             elif [ $gitcommand = "del" ] || [ $gitcommand = "db" ]; then
                 echo "Type the name of the target git branch [ENTER]:"
                 read targetbranch
                 git checkout master
                 git push origin --delete $targetbranch
                 git branch -D $targetbranch
            fi     
        fi
        #end while
        echo "Press [ENTER] to continue..."
        read cont
         #exit point
         if  [  ! -z $cont ] && ([ $cont = "q" ] || [ $cont = "q" ]); then
                exit  
         fi 
    fi
done


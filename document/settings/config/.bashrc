alias c='clear'
alias open='start .'
alias workspace='cd D:/phuong'
alias reload='source ~/.bash_profile'
alias vs='code .'

# default
# alias ll='ls -l'
# alias ls='ls -F --color=auto --show-control-chars'

## Colorize the ls output ##
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la'
 
## Show hidden files ##
alias l.='ls -d .* --color=auto'

alias lt1='ls --human-readable --size -1 -S --classify'

# git
alias show-history-by-file-name='f(){ tig $1;  unset -f f; }; f'
alias show-history-by-file-name2='f(){ gitk $1;  unset -f f; }; f'

# git difftool -t meld --dir-diff  [COMMIT_A] [COMMIT_B]

# git difftool -d branch_name1..branch_name2
alias difftool-dir='git difftool --dir-diff --tool=meld'
# git difftool -d branch_name
alias difftool-head='git difftool -d head'

# $ git difftool -d stash@{1}
# git difftool -d stash@{2} -- filename
alias difftool-stash='git difftool -d stash'

alias conflict='git difftool --tool=meld'
alias mergetool-fix='git mergetool --tool=meld'

# pass parameter
alias wrap-args='f(){ echo before "$@" after;  unset -f f; }; f'
alias wrap-args-2='f(){ echo before "$1", "$2" after;  unset -f f; }; f'
alias find-from-to-def='f(){ echo before "date from 2020-01-02 -> date to 2020-01-23" after;  unset -f f; }; f'
# date from 2020-01-02 -> date to 2020-01-23
alias find-by-date='f(){ find . -type f -newermt $1 ! -newermt $2 -printf "%T@ %Tc %p\n" | sort -n;  unset -f f; }; f'
# date from 2020-01-02 -> date to 2020-01-23
alias find-by-date2='f(){ find . -type f -newermt $1 ! -newermt $2 -type f -printf "%T@\t%p\n" | sort -n | cut -f 2- | xargs -I{} ls -Glath --si {};  unset -f f; }; f'
# find . -iname "*.txt"
alias find-by-file-name='f(){  find . -iname $1;  unset -f f; }; f'
# find . -type f -exec grep "forinstance" '{}' \; -print
alias find-by-content='f(){ find . -type f -exec grep --color=auto "$1" '{}' \; -print;  unset -f f; }; f'
# find . -name '*MapperImpl*.java' -delete
alias find-by-file-name-and-delete='f(){ find . -name "$1" -delete;  unset -f f; }; f'


## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ssh server 
alias sshubiid='ssh ops@ubiid.ubitec.local'
alias sshwir='ssh ops@wir-ivy.ubitec.local'
alias sshcic='ssh ops@cic-ivy.ubitec.local'
alias sshabs='ssh ops@abs-ivy.ubitec.local'
alias sshvz='ssh ops@vz-ivy.ubitec.local'
# cd /okd4_volume
alias sshop='ssh ops@nfs.aws.ubitec.io'
alias oc-phuong='oc login --insecure-skip-tls-verify https://api.os.aws.ubitec.io:6443 -u phuong.tran'

# logs
alias logs='tail -f $1'
# $2: line number
alias logs-n='f(){ tail -f -n$2 $1;  unset -f f; }; f'
alias logs-and-search='f(){ tail -f -n1000 $1 | grep --color=auto $2;  unset -f f; }; f'

# k^6
alias k66='k6 run --insecure-skip-tls-verify $1 --summary-export=test-result-data.json'

# CURL
# get web server headers # Use the -I option to fetch only the HTTP headers of the specified resource:
alias header='curl -I'

# -o : saves the downloaded file on the local machine with the name provided in the parameters.
# curl -o hello.zip ftp://speedtest.tele2.net/1MB.zip
# -O : This option downloads the file and saves it with the same name as in the URL.
# curl -O [URL...]
alias download='f(){ echo before "
    # -o : saves the downloaded file on the local machine with the name provided in the parameters.
    # curl -o hello.zip ftp://speedtest.tele2.net/1MB.zip
    # -O : This option downloads the file and saves it with the same name as in the URL.
    # curl -O [URL...]
    " after;  unset -f f; }; f'
alias post='f(){ echo before "
    curl -H "Content-Type: application/json" -X POST -d '{"user":"bob","pass":"123"}' http://URL/
    # no data
    curl -X POST http://URL/example.php
    " after;  unset -f f; }; f'
 
# find out if remote server supports gzip / mod_deflate or not #
alias headerc='curl -I --compress'

# 21: Control web servers
# also pass it via sudo so whoever is admin can reload it without calling you #
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'
alias nginx-help-me='f(){ echo before "
    $ sudo nginx -s reload
    $ sudo nginx -t

    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
    You can test the Nginx configuration, dump it and exit using the -T flag as shown.
    $ sudo nginx -T

    $ docker-compose exec gateway sh
    / $ nginx -T | grep client_max
    2021/02/18 11:59:13 [warn] 42#42: "ssl_stapling" ignored, no OCSP responder URL in the certificate "/etc/nginx/tls/fullchain.pem"
    nginx: [warn] "ssl_stapling" ignored, no OCSP responder URL in the certificate "/etc/nginx/tls/fullchain.pem"
    nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
    nginx: configuration file /etc/nginx/nginx.conf test is successful
        client_max_body_size 150m;
    / $ exit
    " after;  unset -f f; }; f'

alias lightyload='sudo /etc/init.d/lighttpd reload'
alias lightytest='sudo /usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'
alias httpdreload='sudo /usr/sbin/apachectl -k graceful'
alias httpdtest='sudo /usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'

# Create a Python virtual environment
alias ve='python3 -m venv ./venv'
alias va='source ./venv/bin/activate'

# docker
#docker version
#docker info
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias d='docker'
alias stopdocks='docker stop $(docker ps -a -q)'
alias rmdocks='docker rm $(docker ps -a -q)'
alias docker-help-me='f(){ 
    echo before "
    # Build an image
    docker build -t <image-name> <location-of-Dockerfile>

    # run an image or run a container directly from a specific image
    docker run -it -d -p <host-port>:<container-port> --name <container-name> <image-name>:tag

    -i (interactive)
    -t (TTY)
    -d (Detached) : Run it in detached mode or else the life time of the container will be only as long as you run the terminal.
    -P : Docker assigned default ports which will access the required port in the container (meaning the host machine can get assigned 32769 : pointing to default port of the image)
    --name : represents a default name, if it is not specified the docker daemon will allocate a unique name
    image-name : specifies the image to download from the repostory
    tag : defaults to latest, a version for the given image can be specified.
            

    # allows you to view the logs in the container
    docker logs <container-id>

    # Allow you to tail logs
    docker logs -ft <container-id>

    # List all containers running and stopped
    docker ps -a

    # List all containers running
    docker ps

    # List all images available
    docker images

    # stop a specified container
    docker stop <container-id>

    # stop all containers

    # remove image (note: no containers for this image should be running)
    docker rmi <image-id>

    # remove all images

    #Remove a specific container
    docker rm <container-id>

    #Remove all containers

    # log in to the shell of the container. Typically entry-point refers to /bin/bash
    docker exec -it <container-name> <entry-point>


    docker login 
    docker tag <currentimage>:<tag> <repository-name>/<image-name>:<tag>
    docker commit <container-id> <repository-name>/<image-name>:<tag>
    docker push <repository-name>/<image-name>:<tag>
    docker inspect <container-name>
    docker inspect <image-name>
    "
     after;  unset -f f; 
    }; f'

# docker-compose
alias docker-compose-reload='docker-compose down && docker-compose up -d'
alias docker-compose-help-me='f(){ 
    echo before "
    # Runs the container
    docker-compose up

    # Runs in detached mode
    docker-compose up -d

    # Builds the image
    docker-compose build

    # Stops the container
    docker-compose stop <service-name>

    # Starts the container
    docker-compose start <service-name>

    # Equivalent to docker exec
    docker-compose run <service-name> /bin/bash 

    # Build a specific image.
    docker-compose up --build

    # View logs
    docker-compose logs <service-name>

    # Tail logs
    docker-compose logs -ft <service-name>

    # Update specific container
    docker-compose up -d --no-deps <service-name>

    # Stop all containers
    docker-compose down

    #Remove errored out images
    docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

    # Shut down containers, remove all images and rebuild images with docker-compose
    docker-compose down
    docker-compose rm -f
    docker-compose pull
    docker-compose up --build -d
    "
     after;  unset -f f; 
    }; f'


# port
alias kill-port='f(){ echo before "
    netstat -ano | findstr 8080
    TCP    0.0.0.0:8080           0.0.0.0:0              LISTENING       17880
    TCP    [::]:8080              [::]:0                 LISTENING       17880
    # PID
    taskkill /pid 17880 /f
    " after;  unset -f f; }; f'

# Maven
alias maven-help-me='f(){ echo before "
    # Show logs debug
    $ mvn generate-sources -X
    $ mvn package | tee /tmp/maven.log
    [INFO] Scanning for projects...
    " after;  unset -f f; }; f'

# Vim
alias vim-help-me='f(){ echo before "
https://vimhelp.org/
https://www.youtube.com/watch?v=IiwGbcd8S7I&t=2993s
    w and b : go to next/ back word
    W and B : go to next/ back word faster
    2w: go to next 2 words

    yy : copy a line
    p: paste
    x: delete single char
    dd: delete = SHIFT V + d
    dw: delete word
    d2w: delete 2 words
    . : repeat lastest command
    %: go to the next bracket

    shift d: delete the rest to the end of the line
    u: undo >< CTRL r: redo
    v: select words
    shift v: highlight a line
    33G = :33: line 33

    i: insert
    G: go to end line
    gg: go to first line
    shift i: go to first of the line >< shift a

    # To suspend your running Vim
    CTRL Z + fg
    # Run command quickly
    :! <command>

    # Set line number
    :set number

    # --- file ---
    you can open another file while vim is open with 
        :tabe filename 
    and to switch to the other file you type 
        :tabn or :tabp
    for next and previous accordingly.

    # --- search ---
    /text
    It is n for next and N for previous.
    Search for a word named “bar” in backwards direction:
    1. Press ESC key
    2. Type ?bar

    In normal mode, move the cursor to any word say 254. Press * to search forwards for the next occurrence of word 254, or press # to search backwards:
    /\<254\>
    ---

" after;  unset -f f; }; f'

eval "$(starship init bash)"
bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'


# Load Angular CLI autocompletion.
source <(ng completion script)

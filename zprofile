alias gist='gist -c -p'
alias psql='psql -h localhost'
export DOCKER_OPTS="--dns 137.72.16.81 --dns 137.72.16.9 --dns 137.72.16.1 --dns 8.8.8.8 --dns 8.8.4.4"
alias docker-stop="docker ps -a -q | xargs  -L1 docker stop"
alias docker-rm="docker ps -a -q | xargs  -L1 docker rm"
alias docker-gc="docker-stop && docker-rm"

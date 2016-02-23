
#export DOCKER_TLS_VERIFY="1"
#export DOCKER_HOST="tcp://192.168.103.137:2376"
#export DOCKER_CERT_PATH="/Users/bryanhunt/.docker/machine/machines/local"
#export DOCKER_MACHINE_NAME="local"


use Mix.Config



config :docker,
        base_url: "https://localhost:2376",
        ssl_options: [
          {:ca_file,  'docker.crt'},
          {:cert_file,'docker.crt'},
          {:key_file, 'ca.crt'},
        ],
        machine_name: "local"

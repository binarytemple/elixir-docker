

use Mix.Config

config :docker,
        base_url: "",
        ssl_options: [
          {:ca_file,   ""},
          {:cert_file, ""},
          {:key_file,  ""},
        ],
        machine_name: ""


#{:success, keylist} = DockerMachine.get_env
#
#m = Map.new(keylist)
#
#config :docker,
#        base_url: m[:docker_host],
#        ssl_options: [
#          {:ca_file,   m[:docker_cert_path] <> "/docker.crt"},
#          {:cert_file, m[:docker_cert_path] <> "/docker.crt"},
#          {:key_file,  m[:docker_cert_path] <> "/ca.crt"},
#        ],
#        machine_name: m[:docker_machine_name]

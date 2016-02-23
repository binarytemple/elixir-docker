# Get the env - if it is not dev then bail....

ENV["DEV"]

# Get the docker config

require Application[:get_env]

base_url=get_env(:docker,:base_url)

config :docker,
        base_url: "https://localhost:2376",
        ca_file: 'docker.crt',
        cert_file: 'docker.crt',
        key_file: 'ca.crt',
        machine_name: "local"
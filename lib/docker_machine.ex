defmodule Docker.DockerMachine do 

  def get_env() do
    case System.cmd("docker-machine", ["env","local"]) do
      {output,0} -> {
                    :success, output |> 
                    String.split("\n") |> 
                    Enum.filter(fn x -> x =~ "export DOCKER" end) |>
                    Enum.map( fn l ->  
                      String.replace(l, ~r/export (.*)/,"\\1") |> 
                      String.replace(~r/\"/,"") |> 
                      String.split("=") |> 
                      List.to_tuple end)|>
                    Enum.map(
                     fn 
                       {"DOCKER_TLS_VERIFY", docker_tls_verify} ->    {:docker_tls_verify, docker_tls_verify}
                       {"DOCKER_HOST", docker_host} ->                {:docker_host, docker_host} 
                       {"DOCKER_CERT_PATH", docker_cert_path} ->      {:docker_cert_path, docker_cert_path} 
                       {"DOCKER_MACHINE_NAME",docker_machine_name} -> {:docker_machine_name,docker_machine_name} 
                       other -> {:error, other}
                     end 
                    )
                   }
      {output,number} -> {:error,output,number}
      other -> {:error,other}
    end
  end



end

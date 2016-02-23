defmodule Stack do
  use GenServer

  def start_link(state, opts \\ []) do
    GenServer.start_link(__MODULE__, state, opts)
  end

  def handle_call(:pop, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_cast({:push, h}, t) do
    {:noreply, [h|t]}
  end

  def pop(), do: GenServer.call(:sup_stack, :pop)
  def pop(pid) when is_pid(pid), do: GenServer.call(pid, :pop)

  def push(token), do: GenServer.cast(:sup_stack, {:push, token})
  def push(pid, token) when is_pid(pid), do: GenServer.cast(pid, {:push, token})

end


defmodule DockerMachine do 

def init() do

DockerMachineUtil.get_env



end

end

defmodule DockerMachineUtil do 

  def get_env() do
    case System.cmd("docker-machine", ["env","local"]) do
      {output,0} -> {
                    :ok, output |> 
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

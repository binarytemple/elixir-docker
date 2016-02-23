defmodule DockerApplication do

  defmodule Stack do
    use GenServer
  
    # Callbacks
  
    def handle_call(:pop, _from, [h|t]) do
      {:reply, h, t}
    end
  
    def handle_cast({:push, item}, state) do
      {:noreply, [item|state]}
    end
  end

  defmodule DSupervisor do
    use Supervisor
  
    def start_link(), do: 
      Supervisor.start_link(__MODULE__, [] )
  
    def start_link(arg) do
      Supervisor.start_link(__MODULE__, arg)
    end
  
    def init(arg) do
      children = [
        worker(Stack, [], restart: :temporary)
      ]
  
      supervise(children, strategy: :simple_one_for_one)
    end
  end

  use Application

  def start(_type, _args) do
     DSupervisor.start_link()
  end

end





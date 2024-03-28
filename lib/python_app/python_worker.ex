defmodule PythonWorker do

  use GenServer

  require Logger

  @timeout 10_000

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  def message(pid, my_string) do
    GenServer.call(pid, {:hello, my_string})
  end

  #--------------recursive call ----------#

  def recursive_call(msg, count \\10)
  def recursive_call(msg,0) do
    PythonWorker.call(msg)
  end

  def recursive_call(msg, count) do
    PythonWorker.call(msg)
    recursive_call(msg, count - 1)
  end

  #--------------------------------------#

  def call(caller, my_string) do # dire che caller deve essere un pid
    Task.async(fn ->
      :poolboy.transaction(
        :python_worker,
        fn pid ->
          GenServer.call(pid, {:hello, my_string})
          send(caller, my_string)
        end,
        @timeout
      )
    end)
    |> Task.await(@timeout)
  end

  #############
  # Callbacks #
  #############

  @impl true
  def init(_) do
    # path =
    #   [:code.priv_dir(:interoperability_test), "external_code","python"] |> Path.join()

    path = "/home/nico/project/tesi/interoperability_test/external_code/python"

    # with {:ok, pid} <- :python.start([{:python_path, to_charlist(path)}, {:python, 'python3'}]) do
    with {:ok, pid} <- :python.start([{:python_path, to_charlist(path)}]) do
      Logger.info("[#{__MODULE__}] Started python worker: #{inspect(pid)}")
      {:ok, pid}
    end
  end

  # callback sincrona
  @impl true
  def handle_call({:hello, my_string}, _from, pid) do
    result = :python.call(pid, :example, :hello, [my_string])
    Logger.info("[#{__MODULE__}] Handled call from pid: #{inspect(pid)}" )
    {:reply, {:ok, result}, pid}
  end

  @impl true
  def handle_info(msg, state) do
    receive do
      _ -> Logger.info(msg)
    end

  end

end

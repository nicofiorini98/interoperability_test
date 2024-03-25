defmodule Examples.Counter4Supervisor do
  def start() do
    children = [
      # The Counter is a child started via Counter.start_link(0)
      %{
        id: Counter,
        start: {Counter, :start_link, [0]}
      }
    ]

    # Now we start the supervisor with the children and a strategy
    {:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)

    # After started, we can query the supervisor for information
    Supervisor.count_children(pid)
    #=> %{active: 1, specs: 1, supervisors: 0, workers: 1}
  end

end

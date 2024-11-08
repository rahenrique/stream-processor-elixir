defmodule LogStream.Application do
  use Application

  def start(_type, _args) do
    children = [
      %{
        id: Kaffe.GroupMemberSupervisor,
        start: {Kaffe.GroupMemberSupervisor, :start_link, []},
        type: :supervisor
      }
    ]

    opts = [strategy: :one_for_one, name: LogStream.Consumer]
    Supervisor.start_link(children, opts)
  end
end

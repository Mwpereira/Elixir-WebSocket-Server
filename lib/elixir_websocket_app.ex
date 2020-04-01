defmodule ElixirWebSocketApp do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: ElixirWebSocketApp.Router,
        options: [
          dispatch: dispatch(),
          port: 8000
        ]
      ),
      Registry.child_spec(
        keys: :duplicate,
        name: Registry.ElixirWebSocketApp
      )
    ]

    opts = [strategy: :one_for_one, name: ElixirWebSocketApp.Application]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
        [
          {"/ws/[...]", ElixirWebSocketApp.SocketHandler, []},
          {:_, Plug.Cowboy.Handler, {ElixirWebSocketApp.Router, []}}
        ]
      }
    ]
  end
end

defmodule Codex.StartupWorker do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    send(self(), :work)
    {:ok, %{}, {:continue, :reset_socket_perm}}
  end

  def handle_continue(:reset_socket_perm, state) do
    endpoint = Application.get_env(:codex, CodexWeb.Endpoint)

    with {:local, socket} <- endpoint[:http][:ip] do
      File.chmod!(socket, 0o666)
    end

    {:stop, :shutdown, state}
  end
end

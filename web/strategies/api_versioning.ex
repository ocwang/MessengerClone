defmodule MessengerClone.Strategies.APIVersioning do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, opts) do
    version = Keyword.fetch!(opts, :version)
    assign(conn, :version, version)
  end
end

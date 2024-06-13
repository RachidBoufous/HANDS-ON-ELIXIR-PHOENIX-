defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller # telling this module that u will be acting like a controller

  def home(conn, _params) do
    # conn holds all the request informations.
    # _params holding any parameters that were passed in the request.
    render(conn, :home, layout: false)
  end


  def about(conn, _params) do
    render(conn, :about, layout: false)
  end
end

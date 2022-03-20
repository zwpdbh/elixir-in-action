defmodule Ch09 do
  # code segments from ch09
  def extending_phoenix_with_protocols do
    # Testing if our route could generate URL using id and slug 
    video = %Rumbl.Multimedia.Video{id: 1, slug: "hello"}

    alias RumblWeb.Router.Helpers, as: Routes
    Routes.watch_path(%URI{}, :show, video)


    url = URI.parse("http://example.com/prefix")
    Routes.watch_path(url, :show, video)
    Routes.watch_url(url, :show, video)

    # find the struct_url
    url = RumblWeb.Endpoint.struct_url()
    Routes.watch_url(url, :show, video)
  end

  def extending_schemas_with_ecto_types do
    alias Rumbl.Multimedia.Permalink, as: P

    P.cast("13-hellow-world")
    P.cast(13)
    P.cast("hello-world-13")
  end
end

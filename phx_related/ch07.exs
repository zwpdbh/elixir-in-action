# Run those commands in each method(titled as section) in iex-shell
defmodule Ch07 do
  def associate_videos_and_categories do
    import Ecto.Query
    alias Rumbl.Repo
    alias Rumbl.Multimedia.Category

    query = from c in Category, select: c.name
    Repo.all query

    Repo.all from c in Category,
      order_by: c.name,
      select: {c.name, c.id}

    # query can be composable
    query = Category
    query = from c in query, order_by: c.name
    query = from c in query, select: {c.name, c.id}
    Repo.all(query)
  end

  def dive_deeper_into_ecto_queries do
    import Ecto.Query
    alias Rumbl.Repo
    alias Rumbl.Accounts.User
    alias Rumbl.Multimedia.Video

    username = "zhaowei"
    # The ^ (caret) is used for injecting a value or expression for interpolation into an Ecto query
    Repo.one(from u in User, where: u.username == ^username)
    
  end

  def write_query_with_keywords_syntex do
    # counting all users with usernames starting with z or m.
    users_count = from u in User, select: count(u.id)
    j_users = from x in users_count, where: ilike(x.username, ^"%z%") or  ilike(x.username, ^"%m%")

    Repo.all(j_users)
  end

  def use_query_with_the_pipe_syntex do
    User
    |> select([u], count(u.id))
    |> where([u], ilike(u.username, ^"%z%") or ilike(u.username, ^"%m%"))
    |> Repo.all()
  end

  def fragments_and_raw_query do
    # This doesn't work
    # from u in User, where: fragment("lower(username) = ?", ^String.downcase(name))

    # sql raw power
    Ecto.Adapters.SQL.query(Repo, "SELECT power($1, $2)", [2, 10])
  end

  def query_relationship do
    video = Repo.one(from v in Video, limit: 1)
    video.user

    video = Repo.preload(video, :user)
    video.user

    # avoid preload associations
    video = Repo.one(from v in Video, limit: 1, preload: [:user])
    video.user

    # join
    Repo.all from v in Video,
      join: u in assoc(v, :user),
      join: c in assoc(v, :category),
      where: c.name == "Sci-fi",
      select: {u, v}
  end

  def test_constraint do
    import Ecto.Query
    alias Rumbl.Repo
    alias Rumbl.Multimedia.{Video, Category}

    category = Repo.get_by(Category, name: "Drama")
    video = Repo.one(from v in Video, limit: 1)

    changeset = Video.changeset(video, %{category_id: category.id})
    Repo.update(changeset)

    # try update video with a category that does't exist
    changeset = Video.changeset(video, %{category_id: 9999})
    #?? it should fail, but why it pass?
  end

  def test_constraint_delete do
    alias Rumbl.Repo
    alias Rumbl.Multimedia.Category

    category = Repo.get_by(Category, name: "Drama")
    Repo.delete(category)
  end
  
end

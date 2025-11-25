# Fix Race Conditions with Atomic Updates in Ecto

When you have a read-modify-write pattern like incrementing a counter, you're vulnerable to race conditions:

```elixir
# BAD: Race condition - two concurrent requests could both read likes=5,
# compute 6, and write 6, losing one like
post = Repo.get_by!(Post, slug: slug)
likes = post.likes + 1
changeset = Post.changeset(post, %{likes: likes})
Repo.update!(changeset)
```

Instead, use `Repo.update_all` with the `inc` option for atomic increment:

```elixir
# GOOD: Atomic increment - PostgreSQL executes SET likes = likes + 1
from(p in Post, where: p.slug == ^slug, select: %{max_likes: p.max_likes})
|> Repo.update_all(
  inc: [likes: 1],
  set: [max_likes: fragment("GREATEST(likes + 1, max_likes)")]
)
```

This generates `UPDATE ... SET likes = likes + 1` which PostgreSQL executes atomically, eliminating the race condition.

Note: You'll need `import Ecto.Query` to use the `from/2` macro and `fragment/1` for raw SQL expressions.

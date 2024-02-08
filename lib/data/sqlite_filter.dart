final class SqliteFilter {
  const SqliteFilter._(this.text, this.args);

  SqliteFilter.byId(int id)
      : text = 'id = ?',
        args = [id];

  final String text;
  final List<Object?> args;

  SqliteFilter operator +(SqliteFilter other) =>
      SqliteFilter._('$text, ${other.text}', args + other.args);
}

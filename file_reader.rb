module FileReader
  extend self

  def call(filename)
    File
      .foreach(filename)
      .each_entry { |row| yield(row) }
  end
end

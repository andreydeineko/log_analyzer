class OptionsValidator
  ALLOWED_EXTENSION = ".log".freeze
  UnexpectedNumberOfArgumentsError = Class.new(StandardError)
  UnexpectedFileExtenstionError = Class.new(StandardError)
  FileDoesNotExistError = Class.new(StandardError)

  private_constant(
    :ALLOWED_EXTENSION,
    :UnexpectedNumberOfArgumentsError,
    :UnexpectedFileExtenstionError,
    :FileDoesNotExistError
  )

  def initialize(args)
    @args = args
  end

  def call
    unless args.size == 1
      raise(
        UnexpectedNumberOfArgumentsError,
        "Expected 1 argument, received #{args.size} arguments"
      )
    end

    filename = args.first

    unless File.extname(filename) == ALLOWED_EXTENSION
      raise(
        UnexpectedFileExtenstionError, "Expected file with #{ALLOWED_EXTENSION}" \
        " extension, received #{File.extname(filename)}"
      )
    end

    unless File.file?(filename)
      raise(FileDoesNotExistError, filename)
    end

    filename
  end

  private

  attr_reader(:args)
end

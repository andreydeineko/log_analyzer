module LogAnalyzer
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
      with_valid_args_size do
        filename = args.first

        with_valid_file_extension(filename) do
          with_file(filename) do
            filename
          end
        end
      end
    end

    private

    attr_reader(:args)

    def with_valid_args_size
      return yield if args.size == 1

      raise(
        UnexpectedNumberOfArgumentsError,
        "Expected 1 argument, received #{args.size} arguments"
      )
    end

    def with_valid_file_extension(filename)
      return yield if File.extname(filename) == ALLOWED_EXTENSION

      raise(
        UnexpectedFileExtenstionError, "Expected file with #{ALLOWED_EXTENSION}" \
        " extension, received #{File.extname(filename)}"
      )
    end

    def with_file(filename)
      return yield if File.file?(filename)

      raise(FileDoesNotExistError, filename)
    end
  end
end

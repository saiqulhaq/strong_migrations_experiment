module StrongMigrations
  module Migration
    def migrate(direction)
      strong_migrations_checker.direction = direction
      super
      connection.begin_db_transaction if strong_migrations_checker.transaction_disabled
    end

    def method_missing(method, *args)
      return super if is_a?(ActiveRecord::Schema)

      # Active Record 7.0.2+ versioned schema
      return super if defined?(ActiveRecord::Schema::Definition) && is_a?(ActiveRecord::Schema::Definition)

      catch(:safe) do
        strong_migrations_checker.perform(method, *args) do
          super
        end
      end
    end
    ruby2_keywords(:method_missing) if respond_to?(:ruby2_keywords, true)

    def safety_assured
      strong_migrations_checker.safety_assured do
        yield
      end
    end

    # TODO
    # 1. Modify Rails route to create a new endpoint to list out the ignored columns
    # 2. Create a new Controller, related to number 1
    # Good to have feature is ability to customize the route and how to make it secure
    def remove_column(table_name, column_name, type = nil, **options)
      binding.pry
      super(table_name, column_name, type, options)
    end

    def stop!(message, header: "Custom check")
      raise StrongMigrations::UnsafeMigration, "\n=== #{header} #strong_migrations ===\n\n#{message}\n"
    end

    private

    def strong_migrations_checker
      @strong_migrations_checker ||= StrongMigrations::Checker.new(self)
    end
  end
end

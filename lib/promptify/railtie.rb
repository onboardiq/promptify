require "pry-rails"

module Promptify
  class Railtie < Rails::Railtie
    initializer "promptify.initialize" do |app|
      Pry.config.should_load_plugins = false

      Pry.config.prompt_name = app_name

      show_pretty_prompt
    end

    private

    def show_pretty_prompt
      old_prompt = Pry.config.prompt

      Pry.config.prompt = [
        proc { |*a| "[#{app_name}]#{heroku_app}[#{environment}]> " },
        proc { |*a| "[#{app_name}]#{heroku_app}[#{environment}]> " },
      ]
    end

    def app_name
      Rails.application.class.parent_name.underscore.dasherize
    end

    def heroku_app
      return unless ENV["HEROKU_APP_NAME"]

      "[#{Pry::Helpers::Text.cyan(ENV['HEROKU_APP_NAME'])}]"
    end

    def environment
      # Distinguish "preview" apps from production/staging apps.
      if Rails.application.config.try(:preview_app)
        Pry::Helpers::Text.yellow("PREVIEW")
      elsif Rails.env.staging?
        Pry::Helpers::Text.yellow(Rails.env.upcase)
      elsif Rails.env.production?
        Pry::Helpers::Text.red(Rails.env.upcase)
      elsif Rails.env.development?
        # "DEVELOPMENT" was too long to always display locally.
        Pry::Helpers::Text.white("DEV")
      else
        # Test, etc.
        Pry::Helpers::Text.white(Rails.env.upcase)
      end
    end
  end
end


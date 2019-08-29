require "pry-rails"

module Promptify
  class Railtie < Rails::Railtie
    initializer "promptify.initialize" do |app|
      Pry.config.prompt_name = app_name

      show_pretty_prompt
    end

    private

    def show_pretty_prompt
      old_prompt = Pry.config.prompt

      Pry.config.prompt = [
        proc { |*a| "[#{environment}/#{app_name}] #{old_prompt.first.call(*a)}" },
        proc { |*a| "[#{environment}/#{app_name}] #{old_prompt.second.call(*a)}" },
      ]
    end

    def app_name
      Rails.application.class.parent_name.underscore.dasherize
    end

    def environment
      # Distinguish "preview" apps from production/staging apps.
      if Rails.application.config.preview_app
        Pry::Helpers::Text.yellow("PREVIEW")
      elsif Rails.env.staging?
        Pry::Helpers::Text.yellow(Rails.env.upcase)
      elsif Rails.env.production?
        Pry::Helpers::Text.red(Rails.env.upcase)
      else
        # Development, test, etc.
        Pry::Helpers::Text.white(Rails.env.upcase)
      end
    end
  end
end


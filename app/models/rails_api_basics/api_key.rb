module RailsApiBasics
  class ApiKey < ActiveRecord::Base
    self.table_name = "api_keys"

    enum source: [:web, :dashboard, :mobile]
    validates :source, presence: true

    include TokenGenerator.new(prefix: "ak", attribute: :token)
  end
end
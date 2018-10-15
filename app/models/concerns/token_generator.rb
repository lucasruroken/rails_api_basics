class TokenGenerator < Module
  attr_accessor :prefix, :attribute, :length, :only_numbers

  def initialize(opts = {})
    @prefix = opts.fetch(:prefix, "u")
    @attribute = opts.fetch(:attribute, :uuid)
    @length = opts.fetch(:length, 12)
    @only_numbers = opts.fetch(:only_numbers, false)
  end

  def included(host)
    generator_instance = self

    host.class_eval do
      validates(generator_instance.attribute, presence: true, uniqueness: { allow_blank: true })

      before_create do |instance|
        begin
          instance.send("#{generator_instance.attribute}=", generator_instance.send(:generate_token))
        end while instance.class.exists?(generator_instance.attribute => instance.send(generator_instance.attribute))
      end
    end
  end

  private

  def generate_token
    return "#{prefix}#{rand.to_s[2..length]}" if only_numbers

    "#{prefix}-#{SecureRandom.alphanumeric(length)}".downcase
  end
end
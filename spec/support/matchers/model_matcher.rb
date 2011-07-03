RSpec::Matchers.define :be_valid do
  match do |obj|
    obj.valid?
  end

  failure_message_for_should do |obj|
    " expected to be valid, but had the following errors: #{obj.errors.full_messages.to_sentence}"
  end
end

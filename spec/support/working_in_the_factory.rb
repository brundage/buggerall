shared_examples_for :working_in_the_factory do
  it 'makes a valid record' do
    record.should be_valid "Expected valid #{record.class.model_name}, got #{record.valid? ? "" : record.errors.inspect}"
  end
end

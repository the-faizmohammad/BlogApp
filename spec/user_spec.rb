require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name' do
    user = User.new(name: 'John Doe')
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'is valid with a non-negative integer posts counter' do
    user = User.new(name: 'Alice', posts_counter: 0)
    expect(user).to be_valid
  end
end

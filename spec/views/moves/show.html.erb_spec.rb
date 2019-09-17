require 'rails_helper'

RSpec.describe "moves/show", type: :view do
  before(:each) do
    @move = assign(:move, Move.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end

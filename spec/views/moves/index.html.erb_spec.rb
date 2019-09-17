require 'rails_helper'

RSpec.describe "moves/index", type: :view do
  before(:each) do
    assign(:moves, [
      Move.create!(),
      Move.create!()
    ])
  end

  it "renders a list of moves" do
    render
  end
end

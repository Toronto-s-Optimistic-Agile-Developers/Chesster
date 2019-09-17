require 'rails_helper'

RSpec.describe "moves/edit", type: :view do
  before(:each) do
    @move = assign(:move, Move.create!())
  end

  it "renders the edit move form" do
    render

    assert_select "form[action=?][method=?]", move_path(@move), "post" do
    end
  end
end

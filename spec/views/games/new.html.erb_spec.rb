require 'rails_helper'

RSpec.describe 'games/new', type: :view do
  before(:each) do
    assign(:game, Game.new)
  end

  it 'renders new game form' do
    render

    assert_select 'form[action=?][method=?]', games_path, 'post' do
    end
  end
end
>>>>>>> 1284bebaef62edf7c164123120eaba13241d1a65

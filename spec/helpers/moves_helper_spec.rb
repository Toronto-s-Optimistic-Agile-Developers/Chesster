
require 'rails_helper'

# Specs in this file have access to a helper object that includes
 HEAD:spec/helpers/users_helper_spec.rb
# the UsersHelper. For example:
#
# describe UsersHelper do
=======
# the MovesHelper. For example:
#
# describe MovesHelper do

#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
<<<<<<< HEAD:spec/helpers/users_helper_spec.rb
RSpec.describe UsersHelper, type: :helper do
=======
RSpec.describe MovesHelper, type: :helper do
>>>>>>> 6d0cfcb939150325807db57d6c09403f60bc8f89:spec/helpers/moves_helper_spec.rb
  pending "add some examples to (or delete) #{__FILE__}"
end
=======
# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MovesHelper. For example:
#
# describe MovesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MovesHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end
>>>>>>> 1284bebaef62edf7c164123120eaba13241d1a65

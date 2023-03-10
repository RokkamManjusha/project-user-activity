module CapybaraHelper
  # def login_as_admin(user = admin_user)
  #   visit admin_root_path
  #   fill_in 'admin_user[email]', with: user.email
  #   fill_in 'admin_user[password]', with: user.password
  #   click_on('Login')
  # end

end

RSpec.configure do |config|
  config.include CapybaraHelper, type: :feature
end

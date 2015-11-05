# feature "Signing new user" do
#   scenario "User count increases by 1" do
#     visit '/users/new'
#     fill_in :username, with: "Dave"
#     fill_in :password, with: "password"
#     fill_in :email, with: "Dave.Surname@email.com"
#     click_button('Submit')
#     expect(page).to have_content('Welcome, Dave')
#   end
#   scenario 'Password confirmation' do
#     visit '/users/new'
#     fill_in :username, with: "Dave"
#     fill_in :password, with: "password"
#     fill_in :password_conf, with: "anthing"
#     fill_in :email, with: "Dave.Surname@email.com"
#     click_button('Submit')
#     expect(page).not_to have_content('Welcome, Dave')
#   end
# end

feature 'User sign up' do

  scenario 'requires a matching confirmation password' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    expect { sign_up(password_confirmation: '12345678') }.not_to change(User, :count)
  end

  def sign_up(email: 'alice@example.com',
              username: 'Test_Test',
              password: '12345678',
              password_confirmation: '12345678')
    visit '/users/new'
    fill_in :email, with: email
    fill_in :username, with: username
    fill_in :password, with: password
    fill_in :password_conf, with: password_confirmation
    click_button 'Submit'
  end

end

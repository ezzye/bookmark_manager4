
feature 'User sign up' do

  scenario 'requires a matching confirmation password' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    expect { sign_up(password_confirmation: '12345698') }.not_to change(User, :count)
    expect(page.current_path).to eq '/users'
    expect(page).to have_content('Password and confirmation password do not match')
    expect { sign_up(email: nil) }.not_to change(User, :count)
  end
  scenario "I can't sign up with an invalid email address" do
    expect { sign_up(email: "invalid@email") }.not_to change(User, :count)
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

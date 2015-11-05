feature "Signing new user" do
  scenario "User count increases by 1" do
    visit '/users/new'
    fill_in :username, with: "Dave"
    fill_in :password, with: "password"
    fill_in :email, with: "Dave.Surname@email.com"
    click_button('Submit')
    expect(page).to have_content('Welcome Dave')
  end
end

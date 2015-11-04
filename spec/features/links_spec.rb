feature 'list of links on homepage' do
  scenario 'show the link' do
    Link.create(url: 'www.google.com', title: 'google homepage')
    visit '/links'
    expect(page).to have_content('google')
  end
end

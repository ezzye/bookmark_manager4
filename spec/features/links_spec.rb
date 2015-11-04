feature 'list of links on homepage' do
  scenario 'show the link' do
    Link.create(url: 'www.google.com', title: 'google homepage')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('google homepage')
    end
  end
end

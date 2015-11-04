feature 'Tags' do
  scenario 'adding a single tag to link' do
    visit('/links/new')
    fill_in 'title', with: 'Amazon'
    fill_in 'url', with: 'www.amazon.co.uk'
    fill_in 'tag', with: '#books'
    click_button('Submit')
    link=Link.first
    expect(page.status_code).to eq 200
    expect(link.tags.map(&:name)).to include('#books') #|tag| tag.name

  end
end
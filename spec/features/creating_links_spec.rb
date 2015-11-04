require 'database_cleaner'


feature 'Creating new links' do
  scenario 'fill in form' do
    visit('/links/new')
    fill_in 'title', with: 'Amazon'
    fill_in 'url', with: 'www.amazon.co.uk'
    click_button('Submit')
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Amazon')
    end
  end
end

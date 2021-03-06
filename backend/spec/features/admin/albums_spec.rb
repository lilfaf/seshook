require 'rails_helper'

describe 'managing albums' do
  let!(:admin) { create(:admin) }
  let!(:album) { create(:album) }
  let!(:spot)  { create(:spot_with_album) }

  context 'not signed in as admin' do
    it 'cannot view albums' do
      visit admin_albums_path
      expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'signed in as admin' do
    before { login_as admin }

    it 'can view albums' do
      visit admin_dashboard_path
      within '.navmenu' do
        click_link 'Albums'
      end
      expect(page.current_path).to eq(admin_albums_path)
    end

    it 'can paginate albums' do
      a1 = create(:album)
      a2 = create(:album)
      visit admin_albums_path
      expect(page).not_to have_css('.pagination')
      visit admin_albums_path(per_page: 1)
      expect(page).to have_css('.pagination')
      expect(page).to have_content(a2.name)
      click_link('Next')
      expect(page).to have_content(a1.name)
      expect(page.current_url).to eq(admin_albums_url(page: 2, per_page: 1 ))
    end

    it 'can visit parent albumable' do
      spot = create(:spot_with_album)
      visit admin_albums_path
      click_link "##{spot.id}"
      expect(page.current_path).to eq(edit_admin_spot_path(spot))
      expect(page).to have_content("Editing spot ##{spot.id}")
    end

    context 'creating a album' do
      it 'fails with invalid attributes' do
        visit new_admin_album_path
        fill_in 'Name', with: ''
        click_button 'Create Album'
        expect(page).to have_content("can't be blank")
      end

      it 'succeed with valid attributes' do
        visit new_admin_album_path
        fill_in 'Name', with: 'default name'
        fill_in 'Description', with: 'some description'
        attach_file('album_photos', 'spec/fixtures/exif.jpg')
        click_button 'Create Album'
        expect(page).to have_content("Album was successfully created")
      end
    end

    context 'working with a album' do
      it 'does not have photos input on edit' do
        visit edit_admin_album_path(album)
        expect(page).not_to have_field('Photos')
      end

      it 'cannot edit a album to be invalid' do
        visit edit_admin_album_path(album)
        fill_in 'Name', with: ''
        click_button 'Update Album'
        expect(page).to have_content("can't be blank")
      end

      it 'from index redirects to album edit path' do
        visit admin_albums_path
        click_link album.name
        expect(page.current_path).to eq(edit_admin_album_path(album))
      end

      context 'album with albumable' do
        it 'redirects to spot album edit path' do
          visit admin_albums_path
          click_link spot.albums.last.name
          expect(page.current_path).to eq(edit_polymorphic_path([:admin, spot, spot.albums.last]))
        end
      end

      it 'editing an album' do
        visit edit_admin_album_path(album)
        fill_in 'Name', with: 'new name'
        click_button 'Update Album'
        expect(page).to have_content('Album was successfully updated')
      end

      it 'deleting a album' do
        visit admin_albums_path
        click_link('delete', match: :first)
        expect(page).to have_content('Album was successfully destroyed')
      end

      it 'create an associated photo', js: true do
        visit edit_admin_album_path(album)
        attach_file('file', 'spec/fixtures/exif.jpg')
        expect(page).to have_selector('.s3r-progress')
        expect(page).to have_content('exif.jpg')
      end
    end

    context 'searching for albums' do
      it 'can search by name' do
        search_with_term('album', album.name)
        expect(page).to have_content(album.name)
        expect(page).not_to have_content(spot.albums.last.name)
      end

      it 'can search by albumable type' do
        search_with_term('album', 'Spot')
        expect(page).to have_content(spot.albums.last.name)
        expect(page).not_to have_content(album.name)
      end
    end
  end
end

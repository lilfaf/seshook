require 'rails_helper'

describe Photo do
  ## DB schema ----------------------------------------------------------------

  it { is_expected.to have_db_column(:file).with_options(null: false) }
  it { is_expected.to have_db_column(:content_type).with_options(null: false) }
  it { is_expected.to have_db_column(:size).with_options(null: false) }
  it { is_expected.to have_db_column(:key) }
  it { is_expected.to have_db_column(:etag) }
  it { is_expected.to have_db_column(:photoable_id) }
  it { is_expected.to have_db_column(:photoable_type) }
  it { is_expected.to have_db_column(:user_id) }

  it { is_expected.to have_db_index([:photoable_type, :photoable_id]) }
  it { is_expected.to have_db_index(:user_id) }

  ## Validations --------------------------------------------------------------

  it { is_expected.to validate_presence_of(:file) }
  it { is_expected.to validate_presence_of(:content_type) }
  it { is_expected.to validate_presence_of(:size) }

  ## Associations -------------------------------------------------------------

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:photoable) }

  ## Concerns -----------------------------------------------------------------

  it_behaves_like 'temporal scopes'

  ## Callbacks ----------------------------------------------------------------

  it 'updates file size and content_type' do
    subject.file = File.open('spec/fixtures/exif.jpg')
    allow(subject.file.file).to receive(:size).and_return(123456)
    subject.save!
    expect(subject.size).to eq(123456)
    expect(subject.content_type).to eq('image/jpeg')
  end
end

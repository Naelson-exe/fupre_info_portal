require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:admin_user) { AdminUser.create!(name: 'Admin User', email: 'admin@example.com', password: 'password') }

  describe 'validations' do
    it 'is valid with a title, event_date, and details' do
      event = Event.new(
        title: 'Community Meeting',
        event_date: Date.current + 7.days,
        details: 'Annual community meeting to discuss local projects.',
        admin_user: admin_user
      )
      expect(event).to be_valid
    end

    it 'is invalid without a title' do
      event = Event.new(event_date: Date.current, details: 'No title', admin_user: admin_user)
      expect(event).not_to be_valid
      expect(event.errors[:title]).to include("can't be blank")
    end

    it 'is invalid with a title shorter than 3 characters' do
      event = Event.new(title: 'A', event_date: Date.current, details: 'Short title', admin_user: admin_user)
      expect(event).not_to be_valid
      expect(event.errors[:title]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid without an event_date' do
      event = Event.new(title: 'Valid Title', details: 'No date', admin_user: admin_user)
      expect(event).not_to be_valid
      expect(event.errors[:event_date]).to include("can't be blank")
    end

    it 'is invalid without details' do
      event = Event.new(title: 'Valid Title', event_date: Date.current, admin_user: admin_user)
      expect(event).not_to be_valid
      expect(event.errors[:details]).to include("can't be blank")
    end
  end

  describe 'scopes' do
    let!(:upcoming_event) { Event.create!(title: 'Upcoming Event', event_date: Date.current + 10.days, details: 'Details about the future', admin_user: admin_user) }
    let!(:past_event) { Event.create!(title: 'Past Event', event_date: Date.current - 5.days, details: 'Details about the past', admin_user: admin_user) }
    let!(:another_upcoming_event) { Event.create!(title: 'Another Upcoming Event', event_date: Date.current + 20.days, details: 'More future details', admin_user: admin_user) }

    it 'returns upcoming events with the upcoming scope' do
      expect(Event.upcoming).to contain_exactly(upcoming_event, another_upcoming_event)
    end

    it 'returns past events with the past scope' do
      expect(Event.past).to contain_exactly(past_event)
    end

    it 'searches across title and details with the search scope' do
      expect(Event.search('Upcoming')).to contain_exactly(upcoming_event, another_upcoming_event)
      expect(Event.search('past')).to contain_exactly(past_event)
    end
  end

  describe '#formatted_date' do
    it 'returns the event_date formatted as "Month Day, Year"' do
      event_date = Date.new(2024, 8, 15)
      event = Event.new(event_date: event_date)
      expect(event.formatted_date).to eq('August 15, 2024')
    end
  end

  describe '#full_date' do
    it 'includes the time if event_time is present' do
      event_date = Date.new(2024, 8, 15)
      event_time = Time.parse('3:00 PM')
      event = Event.new(event_date: event_date, event_time: event_time)
      expect(event.full_date).to eq('August 15, 2024 at 03:00 PM')
    end

    it 'shows "All day" if event_time is not present' do
      event_date = Date.new(2024, 8, 15)
      event = Event.new(event_date: event_date)
      expect(event.full_date).to eq('August 15, 2024 (All day)')
    end
  end

  describe '#excerpt' do
    it 'returns a truncated details string' do
      event = Event.new(details: 'This is a very long and detailed description of the event that should be truncated.')
      expect(event.excerpt(30)).to eq('This is a very long and...')
    end
  end
end

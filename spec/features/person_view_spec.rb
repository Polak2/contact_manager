require 'rails_helper'

describe 'the person view', type: :feature do
	
	let(:person) do
		Person.create(first_name: 'John', last_name: 'Kowalski')
	end

	before(:each) do
		person.phone_numbers.create(number: "132465879")
		person.phone_numbers.create(number: "678954321")
		visit person_path(person)
	end

	it 'shows the phone numbers' do
		person.phone_numbers.each do |phone|
			expect(page).to have_content(phone.number)
		end
	end

	it 'has a link to add a new phone number' do
		expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
	end

	it 'adds a new phone number' do
		page.click_link('Add phone number')
		page.fill_in('Number', with: '123456789')
		page.click_button('Add phone number')
		expect(current_path).to eq(person_path(person))
		expect(page).to have_content('123456789')
	end

	it 'has links to edit phone numbers' do
		person.phone_numbers.each do |phone|
			expect(page).to have_link('edit', href: edit_phone_number_path(phone))
		end
	end	

	it 'edits a phone number'

end
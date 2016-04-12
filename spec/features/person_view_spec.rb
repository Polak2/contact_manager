require 'rails_helper'

describe 'the person view', type: :feature do
  
	let(:person) do
		Person.create(first_name: 'John', last_name: 'Kowalski')
	end

  describe 'phone numbers' do
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

	it 'edits a phone number' do
		phone = person.phone_numbers.first
		old_number = phone.number

		first(:link, 'edit').click
		page.fill_in('Number', with: '999666333')
		#page.click_button('Update Phone number')
		#expect(current_path).to eq(person_path(person))
		#expect(page).to have_content('999666333')
		expect(page).to_not have_content(old_number)
	end

	xit 'has link to delete phone number' do
		person.phone_numbers.each do |phone|
			expect(page).to have_link('delete', href: phone_number_path(@phone), :method => "delete")
		end
	end
  end


  describe 'email addresses' do
  	before(:each) do
  		person.email_addresses.create(address: "1@1.pl")
  		person.email_addresses.create(address: "2@2.pl")
  		person.email_addresses.create(address: "3@3.pl")
  		visit person_path(person)
  	end

  	it 'looks for LIs' do
  		expect(page).to have_selector('li', text: '1@1.pl')
  	end

  	it 'has an add email address link' do
  		expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
  		page.click_link('Add email address')
  		visit new_email_address_path
  	end

  	it 'click on the link' do
  		#expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
  		page.click_link('Add email address')
  		page.fill_in('address', with: '1@1.pl')
  		page.find_button('Create Email address').click
  		#page.click_button('Create Email address')
  		visit person_path(person)
  	end

  end

end
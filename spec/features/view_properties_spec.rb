feature 'View Properties' do
  let(:user) { User.new(name: 'Tim', user_name: 'timcg', id: 1) }
  scenario 'A user can view a list of listing descriptions alongside their titles' do
    insert_test_properties
    visit('/properties')
    expect(page).to have_content 'Test Property'
    expect(page).to have_content 'Example Property'
    expect(page).to have_content 'Fake Property'
    expect(page).to have_content 'This property is a lovely fake property brought to you by fake property ltd situated in fake, fakeland'
    expect(page).to have_content 'This property is a lovely example property brought to you by example property enterprises situated in example, exampleland'
    expect(page).to have_content 'This property is a lovely test property brought to you by test property co situated in test, testland'
    expect(page).to have_link("New Property Listing", :href => "/properties/add_new")
    p "This test is finished!"
  end


  scenario 'allows a user to choose an available date' do
    property = Property.add("New Property For Date Testing", "This property", "2100-10-15", "2100-10-20", "London Test", "150", user.id)
    visit('/properties')
    select(three_days_from_now, from: "available_dates_#{ property.id }")
    find("##{ property.id }").click
    expect(page).to have_content "Your request has been approved!"
  end

  scenario 'it allows you to navigate to a specific property page' do 
    insert_test_properties
    visit('/properties')
    first('.property').click_button 'View Property'
    # save_and_open_page
    expect(page).to have_content("Fake Property")
    expect(page).to have_content("This property is a lovely fake property brought to you by fake property ltd situated in fake, fakeland")
  end

end
feature 'View Properties' do
  scenario 'A user can view a list of listing descriptions alongside their titles' do
    Property.add("Fake Property", "This property is a lovely fake property brought to you by fake property ltd situated in fake, fakeland", "2020-10-29", "2020-10-30")
    Property.add("Test Property", "This property is a lovely test property brought to you by test property co situated in test, testland", "2020-10-29", "2020-10-30")
    Property.add("Example Property", "This property is a lovely example property brought to you by example property enterprises situated in example, exampleland", "2020-10-29", "2020-10-30")
    visit('/properties')
    expect(page).to have_content 'Test Property'
    expect(page).to have_content 'Example Property'
    expect(page).to have_content 'Fake Property'
    expect(page).to have_content 'This property is a lovely fake property brought to you by fake property ltd situated in fake, fakeland'
    expect(page).to have_content 'This property is a lovely example property brought to you by example property enterprises situated in example, exampleland'
    expect(page).to have_content 'This property is a lovely test property brought to you by test property co situated in test, testland'
    expect(page).to have_link("New Property Listing", :href => "/properties/add_new")
  end

  scenario 'allows a user to choose an available date' do
    insert_test_properties
    property = Property.add("New Property For Date Testing", "This property")
    visit('/properties')
    select(today, from: "available_dates_#{ property.id }")
    find("##{ property.id }").click

    expect(page).to have_content "Your request has been approved!"
  end
end
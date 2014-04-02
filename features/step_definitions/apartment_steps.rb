Given /^apartment created$/ do
  @apartment = Apartment.add(1, "Beautiful Studio", "2451 Le Conte Ave", "200", "Berkeley", "CA", "94709", "Nice place. Come visit.", 800, 2, 1)
  visit "/apartments/" + @apartment.id.to_s
  expect(page).to have_content("Beautiful Studio")
end

Given /^apartment created by different user$/ do
  @apartment = Apartment.add(2, "Best Studio", "2451 Le Conte Ave", "201", "Berkeley", "CA", "94709", "Nice place. Come visit.", 900, 2, 1)
  visit "/apartments/" + @apartment.id.to_s
  expect(page).to have_content("Best Studio")
end
Given /^logged in$/ do
  @user = User.create({
    email: "carinaboo@berkeley.edu",
    username: "Carina Boo",
    password: "1234567890",
    password_confirmation: "1234567890"
  })

  visit "/"
  click_link("Log In")
  fill_in("user_email", :with => "carinaboo@berkeley.edu")
  fill_in("user_password", :with => "1234567890")
  click_button("Sign in")
  expect(page).to have_content("Welcome")
end

Given /^logged out$/ do
  visit "/"
  click_link("Sign out")
  expect(page).to have_content("Signed out successfully")
end
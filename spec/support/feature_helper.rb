module FeatureHelper
  def get_element(element)
    find("[data-test='#{element}']")
  end

  def feature_login(user)
    visit root_path

    click_on 'Login'
    fill_in 'Email', with: 'martin@futureworkz.com'
    fill_in 'Password', with: '123456789'
    click_on 'Sign In'

    expect(page).to have_content 'Signed in successfully'
  end
end

require 'rails_helper'

RSpec.describe 'User show page', type: :feature do
  before(:each) do
    @user = User.create(id: 1, Name: 'Hammas', Photo: 'img.jpg', Bio: 'Developer', email: 'test@email.com',
                        password: 'password', confirmed_at: Time.now)
    @user.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'test@email.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    click_link 'Hammas'
  end

  context 'Testing User Show page' do
    it 'should return user picture' do
      expect(page).to have_css("img[src*='img.jpg']")
    end
    it 'should return username' do
      expect(page).to have_content('Hammas')
    end
    it 'should return user posts' do
      expect(page).to have_content('Number of Posts: 0')
    end
    it 'should return user Bio' do
      expect(page).to have_content('Bio')
    end
    it 'should redirects to all post' do
      expect(page).to have_button('See all posts')
    end
    it 'See all posts button should redirect to posts index' do
      click_link 'See all posts'
      expect(page).to have_button('Pagination')
    end
    # it 'should return individual post' do
    #   @post = Post.create(id: 1, user_id: @user.id, Title: 'Intro to JS',
    #                       Text: 'Full Stack Development', CommentsCounter: 0, LikesCounter: 0)
    #   visit user_post_path(user_id: @user.id, id: @post.id)
    #   expect(page).to have_current_path(user_post_path(@user, @post))
    # end
  end
end

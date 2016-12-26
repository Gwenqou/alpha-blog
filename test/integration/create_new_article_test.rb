require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(username: "john", email: "jogn@example.com", password:"password")
  end 
  
  test "create new article" do 
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article:{ title: "Testing" , description: "Testing Article"}
    end
    assert_template 'articles/show'
  end 
  
end 
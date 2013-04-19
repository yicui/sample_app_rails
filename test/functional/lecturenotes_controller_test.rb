require 'test_helper'

class LecturenotesControllerTest < ActionController::TestCase
  setup do
    @lecturenote = lecturenotes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lecturenotes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lecturenote" do
    assert_difference('Lecturenote.count') do
      post :create, lecturenote: @lecturenote.attributes
    end

    assert_redirected_to lecturenote_path(assigns(:lecturenote))
  end

  test "should show lecturenote" do
    get :show, id: @lecturenote
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lecturenote
    assert_response :success
  end

  test "should update lecturenote" do
    put :update, id: @lecturenote, lecturenote: @lecturenote.attributes
    assert_redirected_to lecturenote_path(assigns(:lecturenote))
  end

  test "should destroy lecturenote" do
    assert_difference('Lecturenote.count', -1) do
      delete :destroy, id: @lecturenote
    end

    assert_redirected_to lecturenotes_path
  end
end

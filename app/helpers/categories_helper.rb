module CategoriesHelper

  def can_delete_category?(category)
    current_user.admin || current_user == category.user
  end
end

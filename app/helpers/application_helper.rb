module ApplicationHelper

  def gulp_asset_path(path)
    path = REV_MANIFEST[path] if defined?(REV_MANIFEST)
    "/assets/#{path}"
  end

  def current_user
    controller.current_user
  end

  def all_users(except: nil)
    UserService.new.all_users(except: except)
  end

end

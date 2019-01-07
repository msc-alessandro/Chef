# ChefSpec matchers for gitlab_ci_runner LWRP
if defined?(ChefSpec)
  def register_gitlab_ci_runner(description)
    ChefSpec::Matchers::ResourceMatcher.new(
      :gitlab_ci_runner,
      :register,
      description
    )
  end

  def unregister_gitlab_ci_runner(description)
    ChefSpec::Matchers::ResourceMatcher.new(
      :gitlab_ci_runner,
      :unregister,
      description
    )
  end
end

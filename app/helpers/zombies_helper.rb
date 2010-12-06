module ZombiesHelper

  def gravatar_for(zombie, options = { :size => 50 })
    gravatar_image_tag(zombie.email.downcase, :alt => zombie.name,
                                              :class => 'gravatar',
                                              :gravatar => options)
  end
end

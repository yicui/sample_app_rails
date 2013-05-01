module TeachersHelper
 def gravatar_for(teacher) 
    gravatar_id = Digest::MD5::hexdigest(teacher.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    link_to(image_tag(gravatar_url+"?s=200", alt: [teacher.first_name, teacher.last_name], class: "gravatar"), gravatar_url+"?s=400", class: "thumbnail span3")
 end 
end

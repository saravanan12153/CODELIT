#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "CODElit"
    xml.author "Sulman Baig"
    xml.description "Ruby On Rails, Gems, How tos"
    xml.link "https://codelit.com/recipes"
    xml.language "en"

    for article in @recipes
      xml.item do
        if article.title
          xml.title article.title
        else
          xml.title ""
        end
        xml.author "Sulman Baig"
        xml.pubDate article.created_at.to_s(:rfc822)
        xml.link "https://codelit.com/recipes/" + article.slug
        xml.guid article.id

        text = article.content
        # if you like, do something with your content text here e.g. insert image tags.
        # Optional. I'm doing this on my website.
        # unless article.meta_image.empty?
        #   image_url = article.meta_image
        #   image_caption = article.title
        #   image_align = ""
        #   image_tag = "
        #         <p><img src='" + image_url +  "' alt='" + image_caption + "' title='" + image_caption + "' align='" + image_align  + "' /></p>
        #       "
        #   text = text.sub('{image}', image_tag)
        # end
        xml.description "<p>" + text + "</p>"

      end
    end
  end
end

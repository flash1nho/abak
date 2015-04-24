module ApplicationHelper
  def form_submit(action_name)
    submit_name = %w(new create).include?(action_name) ? 'Создать' : 'Сохранить'
    %Q{
      <input type = 'submit' value = '#{submit_name}' class = 'btn btn-primary'>
    }.html_safe
  end

  def notice(message)
    if message.present?
      %Q{
        <div class='alert alert-success'>
          #{message}
        </div><br/><br/>
      }.html_safe
    end
  end

  def markdown(text)
    render_options = { 
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow' }
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end

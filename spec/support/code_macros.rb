module CodeMacros
  def codeSave(_code)
    visit new_code_path
    fill_in 'code[title]', with: 'Title'
    fill_in 'code[body_html]', with: 'BodyHtml'
    click_on 'save'
  end
end

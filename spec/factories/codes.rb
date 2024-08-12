FactoryBot.define do
  factory :code do
    title { "MyString" }
    body_html { "MyText" }
    body_css { "MyText" }
    body_js { "MyText" }
    is_public { false }
  end
end

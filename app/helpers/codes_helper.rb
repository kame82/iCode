module CodesHelper
  def private_check(code)
    if code.is_public == "public"
      return false
    else
      return true
    end
  end
end

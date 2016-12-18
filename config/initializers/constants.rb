module Constants
  if Rails.env == "production"
    JAQLIB_DOMAIN = "https://minilib.herokuapp.com"
    PUSH7_APP_NO="e7888985598a4d4783599fe34799ff96"
  else
    JAQLIB_DOMAIN = "https://dev01jaqlib.herokuapp.com"
    PUSH7_APP_NO="6633be7a3c4d46628d47460d401d9737"
  end
end
json.token @command.result
json.user do
  json.partial! 'users/self_user.json.jbuilder', user: @user
end
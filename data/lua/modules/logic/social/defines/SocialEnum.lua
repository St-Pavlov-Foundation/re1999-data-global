module("modules.logic.social.defines.SocialEnum", package.seeall)

local var_0_0 = _M

var_0_0.MaxSaveMessageCount = 200
var_0_0.ChannelType = {
	Friend = 1
}
var_0_0.SelectEnum = {
	Friend = 2,
	Self = 1
}
var_0_0.Type = {
	Search = 2,
	Recommend = 5,
	Request = 4,
	Black = 3,
	Friend = 1
}
var_0_0.TabIndex = {
	Search = 2,
	Friend = 1,
	Black = 4,
	Request = 3
}
var_0_0.SearchFriendCD = 2
var_0_0.FriendChatCD = 2

return var_0_0

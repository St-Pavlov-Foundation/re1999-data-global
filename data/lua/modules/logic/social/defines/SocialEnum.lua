module("modules.logic.social.defines.SocialEnum", package.seeall)

slot0 = _M
slot0.MaxSaveMessageCount = 200
slot0.ChannelType = {
	Friend = 1
}
slot0.Type = {
	Search = 2,
	Recommend = 5,
	Request = 4,
	Black = 3,
	Friend = 1
}
slot0.TabIndex = {
	Search = 2,
	Friend = 1,
	Black = 4,
	Request = 3
}
slot0.SearchFriendCD = 2
slot0.FriendChatCD = 2

return slot0

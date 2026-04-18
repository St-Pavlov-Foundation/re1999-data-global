-- chunkname: @modules/logic/social/defines/SocialEnum.lua

module("modules.logic.social.defines.SocialEnum", package.seeall)

local SocialEnum = _M

SocialEnum.MaxSaveMessageCount = 200
SocialEnum.ChannelType = {
	Friend = 1
}
SocialEnum.SelectEnum = {
	Friend = 2,
	Self = 1
}
SocialEnum.Type = {
	Search = 2,
	Recommend = 5,
	Request = 4,
	Black = 3,
	Friend = 1
}
SocialEnum.TabIndex = {
	Search = 2,
	Friend = 1,
	Black = 4,
	Request = 3
}
SocialEnum.NeedShowTextType2 = {
	[PlayerCardEnum.RightContent.CreatTime] = true,
	[PlayerCardEnum.RightContent.TotalCostPower] = true
}
SocialEnum.SearchFriendCD = 2
SocialEnum.FriendChatCD = 2

return SocialEnum

-- chunkname: @modules/logic/social/model/SocialPlayerMO.lua

module("modules.logic.social.model.SocialPlayerMO", package.seeall)

local SocialPlayerMO = pureTable("SocialPlayerMO")

function SocialPlayerMO:init(info)
	self.id = info.userId
	self.userId = info.userId
	self.name = info.name
	self.level = info.level
	self.portrait = info.portrait
	self.time = info.time
	self.desc = info.desc
	self.infos = info.infos
	self.bg = info.bg or 0
end

function SocialPlayerMO:isSendAddFriend()
	return self._isAdded or false
end

function SocialPlayerMO:setAddedFriend()
	self._isAdded = true
end

function SocialPlayerMO:isMyFriend()
	return SocialModel.instance:isMyFriendByUserId(self.userId)
end

function SocialPlayerMO:isMyBlackList()
	return SocialModel.instance:isMyBlackListByUserId(self.userId)
end

return SocialPlayerMO

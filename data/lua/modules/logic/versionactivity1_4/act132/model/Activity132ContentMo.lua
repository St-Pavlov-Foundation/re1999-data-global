-- chunkname: @modules/logic/versionactivity1_4/act132/model/Activity132ContentMo.lua

module("modules.logic.versionactivity1_4.act132.model.Activity132ContentMo", package.seeall)

local Activity132ContentMo = class("Activity132ContentMo")

function Activity132ContentMo:ctor(cfg)
	self.activityId = cfg.activityId
	self.contentId = cfg.contentId
	self.content = cfg.content
	self.condition = cfg.condition
	self.unlockDesc = cfg.unlockDesc
	self._cfg = cfg
end

function Activity132ContentMo:getUnlockDesc()
	return self._cfg.unlockDesc
end

function Activity132ContentMo:getContent()
	return self._cfg.content
end

return Activity132ContentMo

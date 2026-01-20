-- chunkname: @modules/logic/voyage/config/VoyageConfig.lua

module("modules.logic.voyage.config.VoyageConfig", package.seeall)

local VoyageConfig = class("VoyageConfig", Activity1001Config)

function VoyageConfig:getTaskList()
	return self:_createOrGetShowTaskList()
end

function VoyageConfig:getRewardStrList(id)
	return string.split(self:getRewardStr(id), "|")
end

VoyageConfig.instance = VoyageConfig.New(ActivityEnum.Activity.ActivityGiftForTheVoyage)

return VoyageConfig

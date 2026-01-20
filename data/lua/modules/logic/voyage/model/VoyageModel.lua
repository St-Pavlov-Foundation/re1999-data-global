-- chunkname: @modules/logic/voyage/model/VoyageModel.lua

module("modules.logic.voyage.model.VoyageModel", package.seeall)

local VoyageModel = class("VoyageModel", Activity1001Model)

function VoyageModel:reInit()
	VoyageModel.super.reInit(self)

	local config = VoyageConfig.instance
	local activityId = config:getActivityId()

	self:_internal_set_config(config)
	self:_internal_set_activity(activityId)
end

function VoyageModel:hasAnyRewardAvailable()
	for _, state in pairs(self.__id2StateDict) do
		if state == VoyageEnum.State.Available then
			return true
		end
	end

	return false
end

VoyageModel.instance = VoyageModel.New()

return VoyageModel

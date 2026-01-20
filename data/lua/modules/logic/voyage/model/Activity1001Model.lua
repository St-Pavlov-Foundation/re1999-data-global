-- chunkname: @modules/logic/voyage/model/Activity1001Model.lua

module("modules.logic.voyage.model.Activity1001Model", package.seeall)

local Activity1001Model = class("Activity1001Model", BaseModel)

function Activity1001Model:onInit()
	self:reInit()
end

function Activity1001Model:reInit()
	self.__activityId = false
	self.__config = false
	self.__id2StateDict = {}
end

function Activity1001Model:_internal_set_activity(activityId)
	self.__activityId = activityId
end

function Activity1001Model:_internal_set_config(config)
	assert(isTypeOf(config, Activity1001Config), debug.traceback())

	self.__config = config
end

function Activity1001Model:getConfig()
	return assert(self.__config, "pleaes call self:_internal_set_config(config) first")
end

function Activity1001Model:_updateInfo(info)
	self.__id2StateDict[info.id] = info.state
end

function Activity1001Model:onReceiveAct1001GetInfoReply(msg)
	for _, info in ipairs(msg.act1001Infos) do
		self:_updateInfo(info)
	end
end

function Activity1001Model:onReceiveAct1001UpdatePush(msg)
	self:_updateInfo(msg)
end

function Activity1001Model:getStateById(id)
	return self.__id2StateDict[id] or VoyageEnum.State.None
end

return Activity1001Model

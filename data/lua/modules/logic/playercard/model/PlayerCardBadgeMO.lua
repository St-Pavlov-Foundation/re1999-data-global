-- chunkname: @modules/logic/playercard/model/PlayerCardBadgeMO.lua

module("modules.logic.playercard.model.PlayerCardBadgeMO", package.seeall)

local PlayerCardBadgeMO = class("PlayerCardBadgeMO")

function PlayerCardBadgeMO:initMO(co)
	self.id = co.id
	self.co = co
end

function PlayerCardBadgeMO:getRare(co)
	return co.level
end

function PlayerCardBadgeMO:isGain()
	local taskMo = self:getTaskMo()

	if taskMo and taskMo:isClaimed() then
		local activityId = self:getActivityId()

		if not activityId or ActivityHelper.isOpen(activityId) then
			return true
		end
	end
end

function PlayerCardBadgeMO:getActivityId()
	local taskMo = self:getTaskMo()
	local activityId = taskMo and taskMo.config and taskMo.config.activityId

	return activityId
end

function PlayerCardBadgeMO:getTaskMo()
	local taskId = self.co and self.co.taskId

	if taskId and taskId > 0 then
		local taskMo = TaskModel.instance:getTaskById(taskId)

		return taskMo
	end
end

return PlayerCardBadgeMO

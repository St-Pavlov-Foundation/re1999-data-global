-- chunkname: @modules/logic/commandstation/model/CommandStationTaskMo.lua

module("modules.logic.commandstation.model.CommandStationTaskMo", package.seeall)

local CommandStationTaskMo = pureTable("CommandStationTaskMo")

function CommandStationTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function CommandStationTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function CommandStationTaskMo:isLock()
	return self.taskMO == nil
end

function CommandStationTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function CommandStationTaskMo:getMaxProgress()
	return self.config and self.config.maxProgress or 0
end

function CommandStationTaskMo:getFinishProgress()
	return self.taskMO and self.taskMO.progress or 0
end

function CommandStationTaskMo:alreadyGotReward()
	if self.id == -99999 then
		return true
	end

	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

function CommandStationTaskMo:getActivityStatus()
	local activityId = self.config and self.config.activityid

	if not activityId or activityId <= 0 then
		return nil
	end

	return ActivityHelper.getActivityStatus(activityId)
end

return CommandStationTaskMo

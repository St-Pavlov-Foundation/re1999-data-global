-- chunkname: @modules/logic/versionactivity1_2/jiexika/model/Activity114TaskMo.lua

module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskMo", package.seeall)

local Activity114TaskMo = pureTable("Activity114TaskMo")

function Activity114TaskMo:ctor()
	self.id = 0
	self.config = nil
	self.progress = 0
	self.finishStatus = 0
end

function Activity114TaskMo:update(info)
	if self.id ~= info.taskId or not self.config then
		self.config = Activity114Config.instance:getTaskCoById(Activity114Model.instance.id, info.taskId)
		self.id = info.taskId
	end

	self.progress = info.progress

	if info.progress < self.config.maxProgress then
		self.finishStatus = Activity114Enum.TaskStatu.NoFinish
	elseif info.hasGetBonus then
		self.finishStatus = Activity114Enum.TaskStatu.GetBonus
	else
		self.finishStatus = Activity114Enum.TaskStatu.Finish
	end
end

return Activity114TaskMo

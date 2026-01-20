-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/task/VersionActivity1_5TaskView.lua

module("modules.logic.versionactivity1_5.dungeon.view.task.VersionActivity1_5TaskView", package.seeall)

local VersionActivity1_5TaskView = class("VersionActivity1_5TaskView", BaseView)

function VersionActivity1_5TaskView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5TaskView:addEvents()
	return
end

function VersionActivity1_5TaskView:removeEvents()
	return
end

function VersionActivity1_5TaskView:_editableInitView()
	self._simageFullBG:LoadImage("singlebg/v1a5_taskview_singlebg/v1a5_taskview_fullbg.png")

	self._txtremaintime = gohelper.findChildText(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
end

function VersionActivity1_5TaskView:onUpdateParam()
	return
end

function VersionActivity1_5TaskView:onOpen()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, self._onOpen, self)
end

function VersionActivity1_5TaskView:_onOpen()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshRight, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self.refreshRight, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self.refreshRight, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
	VersionActivity1_5TaskListModel.instance:initTask()
	self:refreshLeft()
	self:refreshRight()
end

function VersionActivity1_5TaskView:refreshLeft()
	self:refreshRemainTime()
end

function VersionActivity1_5TaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity1_5Enum.ActivityId.Dungeon]
	local timeStr = actInfoMo:getRemainTimeStr3()

	self._txtremaintime.text = formatLuaLang("remain", timeStr)
end

function VersionActivity1_5TaskView:refreshRight()
	VersionActivity1_5TaskListModel.instance:sortTaskMoList()
	VersionActivity1_5TaskListModel.instance:refreshList()
end

function VersionActivity1_5TaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function VersionActivity1_5TaskView:onDestroyView()
	self._simageFullBG:UnLoadImage()
end

return VersionActivity1_5TaskView

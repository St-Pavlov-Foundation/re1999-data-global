module("modules.logic.versionactivity2_5.act186.view.Activity186TaskView", package.seeall)

slot0 = class("Activity186TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0.stageList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateInfo, slot0.onUpdateInfo, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.UpdateTask, slot0.refreshTask, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.FinishTask, slot0.onFinishTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SetTaskList, slot0.refreshTask, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateInfo(slot0)
	slot0:refreshView()
end

function slot0.onFinishTask(slot0)
	slot0:refreshTask()
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_details_open)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.actMo = Activity186Model.instance:getById(slot0.actId)

	Activity186TaskListModel.instance:init(slot0.actId)
end

function slot0.refreshView(slot0)
	slot0:refreshTask()
	slot0:refreshStageList()
end

function slot0.refreshTask(slot0)
	Activity186TaskListModel.instance:refresh()
end

function slot0.refreshStageList(slot0)
	for slot4 = 1, 3 do
		if not slot0.stageList[slot4] then
			slot0.stageList[slot4] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(slot0.viewGO, "root/stageList/stage" .. slot4), Activity186StageItem)
		end

		slot5:onUpdateMO({
			id = slot4,
			actMo = slot0.actMo
		})
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

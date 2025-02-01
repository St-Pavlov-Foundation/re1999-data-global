module("modules.logic.investigate.view.InvestigateTaskView", package.seeall)

slot0 = class("InvestigateTaskView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshRight, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshRight, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
	slot0:refreshLeft()
	InvestigateTaskListModel.instance:clear()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Investigate
	}, slot0._oneClaimReward, slot0)
end

function slot0._oneClaimReward(slot0)
	slot0:refreshRight()
end

function slot0.refreshLeft(slot0)
	slot0:refreshRemainTime()
end

function slot0.refreshRemainTime(slot0)
end

function slot0.refreshRight(slot0)
	InvestigateTaskListModel.instance:initTask()
	InvestigateTaskListModel.instance:sortTaskMoList()
	InvestigateTaskListModel.instance:refreshList()
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.InvestigateOpinionTabView then
		slot0:closeThis()
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

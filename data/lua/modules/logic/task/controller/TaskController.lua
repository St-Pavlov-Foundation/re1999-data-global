module("modules.logic.task.controller.TaskController", package.seeall)

slot0 = class("TaskController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
end

function slot0.reInit(slot0)
end

function slot0.enterTaskView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.TaskView, slot1)
end

function slot0.enterTaskViewCheckUnlock(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		uv0.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function slot0._onDailyRefresh(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Daily,
		TaskEnum.TaskType.Weekly,
		TaskEnum.TaskType.Novice
	})
end

function slot0.getRewardByLine(slot0, slot1, slot2, slot3)
	if not slot0._priority then
		slot0._priority = 10000
	end

	slot0._priority = slot0._priority - 1

	PopupController.instance:addPopupView(slot0._priority, slot2, slot3)
end

slot0.instance = slot0.New()

return slot0

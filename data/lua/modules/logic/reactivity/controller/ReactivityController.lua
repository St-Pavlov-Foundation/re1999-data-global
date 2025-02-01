module("modules.logic.reactivity.controller.ReactivityController", package.seeall)

slot0 = class("ReactivityController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.openReactivityTaskView(slot0, slot1)
	slot0:_enterActivityView(ViewName.ReactivityTaskView, slot1, slot0._openTaskView, slot0)
end

function slot0._openTaskView(slot0, slot1, slot2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, function ()
		ViewMgr.instance:openView(uv0, {
			actId = uv1
		})
	end)
end

function slot0.getCurReactivityId(slot0)
	for slot4, slot5 in pairs(ReactivityEnum.ActivityDefine) do
		if ActivityHelper.getActivityStatus(slot4) == ActivityEnum.ActivityStatus.Normal or slot6 == ActivityEnum.ActivityStatus.NotUnlock or ActivityHelper.getActivityStatus(slot5.storeActId) == ActivityEnum.ActivityStatus.Normal then
			return slot4
		end
	end
end

function slot0.openReactivityStoreView(slot0, slot1)
	if not ReactivityEnum.ActivityDefine[slot1] then
		return
	end

	slot0:_enterActivityView(ViewName.ReactivityStoreView, slot2.storeActId, slot0._openStoreView, slot0)
end

function slot0._openStoreView(slot0, slot1, slot2)
	Activity107Rpc.instance:sendGet107GoodsInfoRequest(slot2, function ()
		ViewMgr.instance:openView(uv0, {
			actId = uv1
		})
	end)
end

function slot0._enterActivityView(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6, slot7, slot8 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot6 ~= ActivityEnum.ActivityStatus.Normal then
		if slot7 then
			GameFacade.showToastWithTableParam(slot7, slot8)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2, slot5)

		return
	end

	slot9 = {
		actId = slot2
	}

	if slot5 then
		for slot13, slot14 in pairs(slot5) do
			slot9[slot13] = slot14
		end
	end

	ViewMgr.instance:openView(slot1, slot9)
end

slot0.instance = slot0.New()

return slot0

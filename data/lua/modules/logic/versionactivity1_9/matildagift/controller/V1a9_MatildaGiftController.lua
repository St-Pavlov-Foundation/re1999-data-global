module("modules.logic.versionactivity1_9.matildagift.controller.V1a9_MatildaGiftController", package.seeall)

slot0 = class("V1a9_MatildaGiftController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._checkActivityInfo, slot0)
end

function slot0.reInit(slot0)
end

function slot0._checkActivityInfo(slot0, slot1)
	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.V1a9_Matildagift) == ActivityEnum.ActivityStatus.Normal then
		slot0:sendGet101InfosRequest()
	end
end

function slot0.openMatildaGiftView(slot0)
	if not V1a9_MatildaGiftModel.instance:isMatildaGiftOpen(true) then
		return
	end

	slot0:sendGet101InfosRequest(slot0._realOpenMatildaGiftView)
end

function slot0._realOpenMatildaGiftView(slot0)
	ViewMgr.instance:openView(ViewName.V1a9_MatildagiftView, {
		isDisplayView = not V1a9_MatildaGiftModel.instance:isShowRedDot()
	})
end

function slot0.sendGet101InfosRequest(slot0, slot1)
	Activity101Rpc.instance:sendGet101InfosRequest(V1a9_MatildaGiftModel.instance:getMatildagiftActId(), slot1, slot0)
end

slot0.instance = slot0.New()

return slot0

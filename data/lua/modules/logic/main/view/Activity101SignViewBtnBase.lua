module("modules.logic.main.view.Activity101SignViewBtnBase", package.seeall)

slot0 = class("Activity101SignViewBtnBase", ActCenterItemBase)

function slot0.onAddEvent(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshRedDot, slot0)
end

function slot0.onRemoveEvent(slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshRedDot, slot0)
end

function slot0.onClick(slot0)
	slot1, slot2 = slot0:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(slot1) then
		return
	end

	Activity101Rpc.instance:sendGet101InfosRequest(slot0:onGetActId(), slot0._onReceiveGet101InfosReply, slot0)
end

function slot0._onReceiveGet101InfosReply(slot0, slot1, slot2)
	if slot2 == 0 then
		slot3, slot4 = slot0:onGetViewNameAndParam()

		ViewMgr.instance:openView(slot3, slot4)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function slot0._tryInit(slot0)
	if not ActivityType101Model.instance:isInit(slot0:onGetActId()) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot1)
	end
end

function slot0.onOpen(slot0)
	slot0:_tryInit()
	slot0:_addNotEventRedDot(slot0._checkRed, slot0)
end

function slot0._checkRed(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:onGetActId()) and true or false
end

function slot0.onRefresh(slot0)
	assert(false, "please override this function")
end

function slot0.onGetViewNameAndParam(slot0)
	slot1 = slot0:getCustomData()

	return slot1.viewName, slot1.viewParam
end

function slot0.onGetActId(slot0)
	return slot0:getCustomData().viewParam.actId
end

return slot0

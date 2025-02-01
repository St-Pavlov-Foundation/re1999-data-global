module("modules.logic.versionactivity1_6.v1a6_panelsign.view.V1a6_Role_PanelSignView_ActCenterItemBtn", package.seeall)

slot0 = class("V1a6_Role_PanelSignView_ActCenterItemBtn", ActCenterItemBase)

function slot0.onInit(slot0, slot1)
end

function slot0.onAddEvent(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshRedDot, slot0)
end

function slot0.onRemoveEvent(slot0)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, slot0._refreshRedDot, slot0)
end

function slot0.onClick(slot0)
	if ViewMgr.instance:isOpen(slot0:_viewNameAndParam()) then
		return
	end

	Activity101Rpc.instance:sendGet101InfosRequest(slot0:_actId(), slot0._onReceiveGet101InfosReply, slot0)
end

function slot0._onReceiveGet101InfosReply(slot0, slot1, slot2)
	if slot2 == 0 then
		slot3, slot4 = slot0:_viewNameAndParam()

		ViewMgr.instance:openView(slot3, slot4)
	else
		GameFacade.showToast(ToastEnum.BattlePass)
	end
end

function slot0._viewNameAndParam(slot0)
	slot1 = slot0:getCustomData()

	return slot1.viewName, slot1.viewParam
end

function slot0._actId(slot0)
	return slot0:getCustomData().viewParam.actId
end

function slot0._tryInit(slot0)
	if not ActivityType101Model.instance:isInit(slot0:_actId()) then
		Activity101Rpc.instance:sendGet101InfosRequest(slot1)
	end
end

function slot0.onOpen(slot0)
	slot0:_tryInit()
	slot0:_addNotEventRedDot(slot0._checkRed, slot0)
end

function slot0.onRefresh(slot0)
	slot0:_setMainSprite("v1a6_act_icon3")
end

function slot0._checkRed(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:_actId()) and true or false
end

return slot0

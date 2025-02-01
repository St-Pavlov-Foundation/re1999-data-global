module("modules.logic.versionactivity1_2.trade.controller.Activity117Controller", package.seeall)

slot0 = class("Activity117Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.openView(slot0, slot1, slot2)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot1)

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		return
	end

	slot0:initAct(slot1)
	slot0:openTradeBargainView({
		actId = slot1,
		tabIndex = slot2
	})
end

function slot0.initAct(slot0, slot1)
	Activity117Model.instance:initAct(slot1)
	Activity117Rpc.instance:sendAct117InfoRequest(slot1)
end

function slot0.openTradeBargainView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ActivityTradeBargain, slot1)
end

function slot0.openTradeSuccessView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.ActivityTradeSuccessView, slot1)
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

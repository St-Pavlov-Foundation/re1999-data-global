module("modules.logic.versionactivity1_6.decalogpresent.controller.DecalogPresentController", package.seeall)

slot0 = class("DecalogPresentController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._checkActivityInfo, slot0)
end

function slot0.reInit(slot0)
	TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
end

function slot0._checkActivityInfo(slot0)
	TaskDispatcher.cancelTask(slot0._delayGetInfo, slot0)
	TaskDispatcher.runDelay(slot0._delayGetInfo, slot0, 0.2)
end

function slot0._delayGetInfo(slot0)
	slot0:getDecalogActivityInfo()
end

function slot0.getDecalogActivityInfo(slot0, slot1, slot2)
	if not DecalogPresentModel.instance:isDecalogPresentOpen() then
		return
	end

	Activity101Rpc.instance:sendGet101InfosRequest(DecalogPresentModel.instance:getDecalogPresentActId(), slot1, slot2)
end

function slot0.openDecalogPresentView(slot0, slot1)
	slot0._viewName = slot1

	slot0:getDecalogActivityInfo(slot0._realOpenDecalogPresentView, slot0)
end

function slot0._realOpenDecalogPresentView(slot0)
	ViewMgr.instance:openView(slot0._viewName or ViewName.DecalogPresentView)
end

function slot0.receiveDecalogPresent(slot0, slot1, slot2)
	if not ActivityType101Model.instance:isOpen(DecalogPresentModel.instance:getDecalogPresentActId()) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if not ActivityType101Model.instance:isType101RewardCouldGet(slot3, DecalogPresentModel.REWARD_INDEX) then
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)

		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(slot3, slot5, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0

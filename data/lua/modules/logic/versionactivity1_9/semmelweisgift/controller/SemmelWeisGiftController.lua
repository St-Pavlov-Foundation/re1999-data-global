module("modules.logic.versionactivity1_9.semmelweisgift.controller.SemmelWeisGiftController", package.seeall)

slot0 = class("SemmelWeisGiftController", BaseController)

function slot0.addConstEvents(slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._checkActivityInfo, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._checkActivityInfo, slot0)
end

function slot0._checkActivityInfo(slot0)
	slot0:getSemmelWeisGiftActivityInfo()
end

function slot0.getSemmelWeisGiftActivityInfo(slot0, slot1, slot2)
	if not SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen() then
		return
	end

	Activity101Rpc.instance:sendGet101InfosRequest(SemmelWeisGiftModel.instance:getSemmelWeisGiftActId(), slot1, slot2)
end

function slot0.openSemmelWeisGiftView(slot0)
	slot0:getSemmelWeisGiftActivityInfo(slot0._realOpenSemmelWeisGiftView, slot0)
end

function slot0._realOpenSemmelWeisGiftView(slot0)
	ViewMgr.instance:openView(ViewName.SemmelWeisGiftView)
end

function slot0.receiveSemmelWeisGift(slot0, slot1, slot2)
	if not SemmelWeisGiftModel.instance:isSemmelWeisGiftOpen() then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	if ActivityType101Model.instance:isType101RewardCouldGet(SemmelWeisGiftModel.instance:getSemmelWeisGiftActId(), SemmelWeisGiftModel.REWARD_INDEX) then
		Activity101Rpc.instance:sendGet101BonusRequest(slot4, slot5, slot1, slot2)
	else
		GameFacade.showToast(ToastEnum.ActivityRewardHasReceive)
	end
end

slot0.instance = slot0.New()

return slot0

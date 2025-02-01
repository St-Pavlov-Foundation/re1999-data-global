module("modules.logic.versionactivity1_9.matildagift.model.V1a9_MatildaGiftModel", package.seeall)

slot0 = class("V1a9_MatildaGiftModel", BaseModel)

function slot0.getMatildagiftActId(slot0)
	return ActivityEnum.Activity.V1a9_Matildagift
end

function slot0.isMatildaGiftOpen(slot0, slot1)
	if not ActivityType101Model.instance:isOpen(slot0:getMatildagiftActId()) and slot1 then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return slot3
end

function slot0.isShowRedDot(slot0)
	slot1 = false

	if slot0:isMatildaGiftOpen() then
		slot1 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:getMatildagiftActId())
	end

	return slot1
end

function slot0.couldGet(slot0)
	return ActivityType101Model.instance:isType101RewardCouldGet(slot0:getMatildagiftActId(), 1)
end

function slot0.onGetBonus(slot0)
	if slot0:couldGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0:getMatildagiftActId(), 1)
	end
end

slot0.instance = slot0.New()

return slot0

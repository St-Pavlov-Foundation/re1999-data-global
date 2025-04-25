module("modules.logic.versionactivity1_6.goldenmilletpresent.model.GoldenMilletPresentModel", package.seeall)

slot0 = class("GoldenMilletPresentModel", BaseModel)

function slot0.getGoldenMilletPresentActId(slot0)
	return ActivityEnum.Activity.V2a5_GoldenMilletPresent
end

function slot0.isGoldenMilletPresentOpen(slot0, slot1)
	if not ActivityType101Model.instance:isOpen(slot0:getGoldenMilletPresentActId()) and slot1 then
		GameFacade.showToast(ToastEnum.BattlePass)
	end

	return slot3
end

function slot0.haveReceivedSkin(slot0)
	return not ActivityType101Model.instance:isType101RewardCouldGet(slot0:getGoldenMilletPresentActId(), GoldenMilletEnum.REWARD_INDEX)
end

function slot0.isShowRedDot(slot0)
	slot1 = false

	if slot0:isGoldenMilletPresentOpen() then
		slot1 = ActivityType101Model.instance:isType101RewardCouldGetAnyOne(slot0:getGoldenMilletPresentActId())
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.achievement.rpc.AchievementRpc", package.seeall)

slot0 = class("AchievementRpc", BaseRpc)

function slot0.sendGetAchievementInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(AchievementModule_pb.GetAchievementInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetAchievementInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AchievementModel.instance:initDatas(slot2.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function slot0.onReceiveUpdateAchievementPush(slot0, slot1, slot2)
	if slot1 == 0 then
		AchievementModel.instance:updateDatas(slot2.infos)
		AchievementToastModel.instance:updateNeedPushToast(slot2.infos)
		AchievementController.instance:onUpdateAchievements()
		AchievementToastController.instance:onUpdateAchievements()
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

function slot0.sendShowAchievementRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = AchievementModule_pb.ShowAchievementRequest()

	for slot9, slot10 in ipairs(slot1) do
		slot5.ids:append(slot10)
	end

	slot5.groupId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveShowAchievementReply(slot0, slot1, slot2)
	if slot1 == 0 then
		GameFacade.showToast(ToastEnum.AchievementSaveSucc)
		AchievementController.instance:dispatchEvent(AchievementEvent.AchievementSaveSucc)
		AchievementStatController.instance:onSaveDisplayAchievementsSucc()
	end
end

function slot0.sendReadNewAchievementRequest(slot0, slot1, slot2, slot3)
	slot4 = AchievementModule_pb.ReadNewAchievementRequest()

	for slot8, slot9 in ipairs(slot1) do
		slot4.ids:append(slot9)
	end

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveReadNewAchievementReply(slot0, slot1, slot2)
	if slot1 == 0 and AchievementModel.instance:cleanAchievementNew(slot2.ids) then
		AchievementController.instance:dispatchEvent(AchievementEvent.UpdateAchievements)
	end
end

slot0.instance = slot0.New()

return slot0

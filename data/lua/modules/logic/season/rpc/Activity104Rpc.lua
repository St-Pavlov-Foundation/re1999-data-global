module("modules.logic.season.rpc.Activity104Rpc", package.seeall)

slot0 = class("Activity104Rpc", BaseRpc)

function slot0.sendGet104InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity104Module_pb.Get104InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet104InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:setActivity104Info(slot2)
	Activity104EquipController.instance:checkHeroGroupCardExist(slot2.activityId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104Info)
end

function slot0.sendBeforeStartAct104BattleRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity104Module_pb.BeforeStartAct104BattleRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot3
	slot6.layer = slot2

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveBeforeStartAct104BattleReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.StartAct104BattleReply, slot2)
end

function slot0.sendStartAct104BattleRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Activity104Module_pb.StartAct104BattleRequest()

	slot0:setStartDungeonReq(slot7.startDungeonRequest, slot1)

	slot7.activityId = slot2
	slot7.episodeId = slot4
	slot7.layer = slot3 or 0

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.setStartDungeonReq(slot0, slot1, slot2)
	if not slot2.endAdventure then
		DungeonModel.instance:SetSendChapterEpisodeId(slot2.chapterId, slot2.episodeId)
	end

	slot1.chapterId = slot2.chapterId
	slot1.episodeId = slot2.episodeId

	if slot2.isRestart then
		slot1.isRestart = slot2.isRestart
	end

	if slot2.fightParam then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			slot1.isBalance = true
		end

		slot3:setReqFightGroup(slot1)

		if slot3:getCurEpisodeConfig() and not Activity104Model.instance:isSeasonEpisodeType(slot4.type) then
			for slot8 = #slot1.fightGroup.activity104Equips, 1, -1 do
				table.remove(slot1.fightGroup.activity104Equips, slot8)
			end
		end
	end

	slot1.multiplication = slot2.multiplication or 1

	if slot2.useRecord == true then
		slot1.useRecord = slot2.useRecord
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(slot2.episodeId)
end

function slot0.onReceiveStartAct104BattleReply(slot0, slot1, slot2)
	DungeonRpc.instance:onReceiveStartDungeonReply(slot1, slot2.startDungeonReply)
end

function slot0.onReceiveAct104BattleFinishPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:updateActivity104Info(slot2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104BattleFinish)
end

function slot0.onReceiveActivity104ItemChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:updateItemChange(slot2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.GetAct104ItemChange)
end

function slot0.sendRefreshRetailRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity104Module_pb.RefreshRetailRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRefreshRetailReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:replaceAct104Retails(slot2)
	Activity104Controller.instance:dispatchEvent(Activity104Event.RefreshRetail)
end

function slot0.sendOptionalActivity104EquipRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity104Module_pb.OptionalActivity104EquipRequest()
	slot6.activityId = slot1
	slot6.optionalEquipUid = slot2
	slot6.equipId = slot3

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveOptionalActivity104EquipReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Controller.instance:dispatchEvent(Activity104Event.OptionalEquip)
end

function slot0.sendChangeFightGroupRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity104Module_pb.ChangeFightGroupRequest()
	slot5.activityId = slot1
	slot5.heroGroupSnapshotSubId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveChangeFightGroupReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:setSeasonCurSnapshotSubId(slot2.activityId, slot2.heroGroupSnapshotSubId)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SwitchSnapshotSubId)
end

function slot0.sendComposeActivity104EquipRequest(slot0, slot1, slot2)
	Activity104Module_pb.ComposeActivity104EquipRequest().activityId = slot1

	for slot7, slot8 in ipairs(slot2) do
		slot3.equipIdUids:append(slot8)
	end

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveComposeActivity104EquipReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104EquipController.instance:checkHeroGroupCardExist(slot2.activityId)
	Activity104EquipComposeController.instance:dispatchEvent(Activity104Event.OnComposeSuccess, slot2.activityId)
end

function slot0.sendGetUnlockActivity104EquipIdsRequest(slot0, slot1)
	slot2 = Activity104Module_pb.GetUnlockActivity104EquipIdsRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetUnlockActivity104EquipIdsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:onReceiveGetUnlockActivity104EquipIdsReply(slot2)
end

function slot0.sendMarkActivity104StoryRequest(slot0, slot1)
	slot2 = Activity104Module_pb.MarkActivity104StoryRequest()
	slot2.activityId = slot1

	Activity104Model.instance:markActivityStory(slot1)

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkActivity104StoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:markActivityStory(slot2.activityId)
end

function slot0.sendMarkEpisodeAfterStoryRequest(slot0, slot1, slot2)
	slot3 = Activity104Module_pb.MarkEpisodeAfterStoryRequest()
	slot3.activityId = slot1
	slot3.layer = slot2

	return slot0:sendMsg(slot3)
end

function slot0.onReceiveMarkEpisodeAfterStoryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:markEpisodeAfterStory(slot2.activityId, slot2.layer)
end

function slot0.sendMarkPopSummaryRequest(slot0, slot1)
	slot2 = Activity104Module_pb.MarkPopSummaryRequest()
	slot2.activityId = slot1

	return slot0:sendMsg(slot2)
end

function slot0.onReceiveMarkPopSummaryReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity104Model.instance:MarkPopSummary(slot2.activityId)
end

slot0.instance = slot0.New()

return slot0

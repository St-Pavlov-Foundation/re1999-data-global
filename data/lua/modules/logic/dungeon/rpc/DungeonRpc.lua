module("modules.logic.dungeon.rpc.DungeonRpc", package.seeall)

slot0 = class("DungeonRpc", BaseRpc)

function slot0.sendGetDungeonRequest(slot0, slot1, slot2)
	return slot0:sendMsg(DungeonModule_pb.GetDungeonRequest(), slot1, slot2)
end

function slot0.onReceiveGetDungeonReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.lastHeroGroup
	slot7 = slot2.rewardPoint

	DungeonMapModel.instance:addFinishedElements(slot2.finishElements)
	DungeonMapModel.instance:updateMapIds(slot2.mapIds)
	DungeonMapModel.instance:addElements(slot2.elements)
	DungeonMapModel.instance:initRewardPointInfo(slot2.rewardPointInfo)
	DungeonMapModel.instance:initEquipSpChapters(slot2.equipSpChapters)
	DungeonMapModel.instance:initMapPuzzleStatus(slot2.finishPuzzles)
	DungeonModel.instance:setChapterTypeNums(slot2.chapterTypeNums)

	DungeonModel.instance.dungeonInfoCount = slot2.dungeonInfoSize

	if slot2.dungeonInfoSize <= 0 then
		DungeonModel.instance:initDungeonInfoList({})
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function slot0.onReceiveDungeonInfosPush(slot0, slot1, slot2)
	if #slot2.dungeonInfos <= 0 then
		return
	end

	if DungeonModel.instance:initDungeonInfoList(slot3) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function slot0.onReceiveDungeonUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DungeonController.instance:checkFirstPass(slot2.dungeonInfo)
	DungeonModel.instance:setChapterTypeNums(slot2.chapterTypeNums)

	if DungeonModel.instance.initAllDungeonInfo then
		DungeonController.instance:onStartLevelOrStoryChange()
	end

	DungeonModel.instance:updateDungeonInfo(slot3)
	DungeonController.instance:onEndLevelOrStoryChange()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, slot3)
end

function slot0.packStartDungeonRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot1.chapterId = slot2
	slot1.episodeId = slot3

	if slot8 then
		slot1.isRestart = slot8
	end

	if slot4 then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			slot1.isBalance = true
		end

		slot4:setReqFightGroup(slot1)
		FightModel.instance:recordFightGroup(slot1.fightGroup)

		if slot4:getCurEpisodeConfig() and not Activity104Model.instance:isSeasonEpisodeType(slot9.type) and not Season123Controller.canUse123EquipEpisodeType(slot9.type) then
			for slot13 = #slot1.fightGroup.activity104Equips, 1, -1 do
				table.remove(slot1.fightGroup.activity104Equips, slot13)
			end
		end

		if slot9 and slot9.type == DungeonEnum.EpisodeType.Rouge then
			slot1.params = tostring(RougeConfig1.instance:season())
		end
	end

	slot1.multiplication = slot5 or 1

	if slot7 == true then
		slot1.useRecord = slot7
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(slot3)
end

function slot0.sendStartDungeonRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	if not slot5 then
		DungeonModel.instance:SetSendChapterEpisodeId(slot1, slot2)
	end

	slot0:packStartDungeonRequest(DungeonModule_pb.StartDungeonRequest(), slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	logNormal(string.format("aaaaaaaaaaaaaaaaaaa StartDungeonRequest chapter_%d episode_%d %s", slot1 or "nil", slot2 or "nil", debug.traceback("", 2)))
	slot0:sendMsg(slot8)
end

function slot0.onReceiveStartDungeonReply(slot0, slot1, slot2)
	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and DungeonModel.isBattleEpisode(slot3) then
		DungeonFightController.instance:onReceiveStartDungeonReply(slot1, slot2)
	end
end

function slot0.sendEndDungeonRequest(slot0, slot1)
	slot2 = DungeonModule_pb.EndDungeonRequest()
	slot2.isAbort = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveEndDungeonReply(slot0, slot1, slot2)
	DungeonFightController.instance:onReceiveEndDungeonReply(slot1, slot2)
	DungeonFightController.instance:dispatchEvent(DungeonEvent.OnEndDungeonReply, slot1)
end

function slot0.onReceiveEndDungeonPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	FightResultModel.instance:onEndDungeonPush(slot2)
	DungeonController.instance:onReceiveEndDungeonReply(slot1, slot2)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEndDungeonPush)
end

function slot0.sendMapElementRequest(slot0, slot1, slot2, slot3, slot4)
	DungeonModule_pb.MapElementRequest().elementId = slot1

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			table.insert(slot5.dialogIds, tonumber(slot10))
		end
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveMapElementReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.elementId

	DungeonModel.instance:startCheckUnlockChapter()
	DungeonMapModel.instance:addFinishedElement(slot3)
	DungeonMapModel.instance:removeElement(slot3)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnRemoveElement, slot3)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, lua_chapter_map_element.configDict[slot3].mapId)
end

function slot0.onReceiveChapterMapUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DungeonMapModel.instance:updateMapIds(slot2.mapIds)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChapterMapUpdate)
end

function slot0.onReceiveChapterMapElementUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.elements

	DungeonMapModel.instance:setNewElements(slot3)
	DungeonMapModel.instance:addElements(slot3)

	slot7 = DungeonEvent.OnAddElements
	slot8 = slot3

	DungeonController.instance:dispatchEvent(slot7, slot8)

	for slot7, slot8 in ipairs(slot3) do
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, lua_chapter_map_element.configDict[slot8].mapId)
	end

	if DungeonMapModel.instance.playAfterStory then
		DungeonMapModel.instance.playAfterStory = nil

		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)
	end
end

function slot0.sendGetPointRewardRequest(slot0, slot1)
	slot2 = DungeonModule_pb.GetPointRewardRequest()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.id, slot7)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetPointRewardReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DungeonMapModel.instance:addPointRewardIds(slot2.id)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointReward)
end

function slot0.sendGetEpisodeHeroRecommendRequest(slot0, slot1, slot2, slot3)
	slot4 = DungeonModule_pb.GetEpisodeHeroRecommendRequest()
	slot4.episodeId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetEpisodeHeroRecommendReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.onReceiveEquipSpDungeonUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot3 = slot2.isDelete

	DungeonMapModel.instance:updateEquipSpChapter(slot2.chapterId, slot3)

	if not slot3 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.SpecialEquipOpenTip, ViewName.MessageBoxView, {
			messageBoxId = MessageBoxIdDefine.SpecialEquipOpenTip,
			msgBoxType = MsgBoxEnum.BoxType.Yes_No,
			yesCallback = function ()
				DungeonModel.instance.curSendEpisodeId = DungeonConfig.instance:getChapterEpisodeCOList(uv0)[1].id

				FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
				ViewMgr.instance:closeView(ViewName.FightSuccView)
			end
		})
	end
end

function slot0.onReceiveRewardPointUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DungeonMapModel.instance:updateRewardPoint(slot2.chapterId, slot2.value)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateRewardPoint)
end

function slot0.sendInstructionDungeonInfoRequest(slot0, slot1, slot2)
	slot0:sendMsg(DungeonModule_pb.InstructionDungeonInfoRequest(), slot1, slot2)
end

function slot0.onReceiveInstructionDungeonInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(slot2)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function slot0.sendInstructionDungeonOpenRequest(slot0, slot1)
	slot2 = DungeonModule_pb.InstructionDungeonOpenRequest()

	for slot6, slot7 in ipairs(slot1) do
		table.insert(slot2.openId, slot7)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveInstructionDungeonOpenReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerSetOpenSuccess)
	end
end

function slot0.onReceiveInstructionDungeonInfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(slot2)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function slot0.sendInstructionDungeonRewardRequest(slot0, slot1)
	slot2 = DungeonModule_pb.InstructionDungeonRewardRequest()
	slot2.topicId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveInstructionDungeonRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicReward)
	end
end

function slot0.sendInstructionDungeonFinalRewardRequest(slot0)
	slot0:sendMsg(DungeonModule_pb.InstructionDungeonFinalRewardRequest())
end

function slot0.onReceiveInstructionDungeonFinalRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTeachNoteFinalReward)
	end
end

function slot0.sendCoverDungeonRecordRequest(slot0, slot1)
	slot2 = DungeonModule_pb.CoverDungeonRecordRequest()
	slot2.isCover = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveCoverDungeonRecordReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnCoverDungeonRecordReply, slot2.isCover)
	end
end

function slot0.sendPuzzleFinishRequest(slot0, slot1)
	slot2 = DungeonModule_pb.PuzzleFinishRequest()
	slot2.elementId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceivePuzzleFinishReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DungeonMapModel.instance:setPuzzleStatus(slot2.elementId)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnPuzzleFinish, slot2.elementId)
	end
end

function slot0.sendRefreshAssistRequest(slot0, slot1, slot2, slot3)
	slot4 = DungeonModule_pb.RefreshAssistRequest()
	slot4.assistType = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveRefreshAssistReply(slot0, slot1, slot2)
	if slot1 == 0 then
		DungeonAssistModel.instance:setAssistHeroCareersByServerData(slot2.assistType, slot2.assistHeroCareers)
	end
end

function slot0.sendGetMainDramaRewardRequest(slot0)
	slot0:sendMsg(DungeonModule_pb.GetMainDramaRewardRequest())
end

function slot0.onReceiveGetMainDramaRewardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2.bonus) do
			slot9 = MaterialDataMO.New()

			slot9:initValue(slot8.materilType, slot8.materilId, slot8.quantity)
			table.insert(slot3, slot9)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot3)
		DungeonModel.instance:setCanGetDramaReward(false)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function slot0.onReceiveMainDramaRewardInfo(slot0, slot1, slot2)
	if slot1 == 0 then
		DungeonModel.instance:setCanGetDramaReward(true)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function slot0.sendSavePuzzleProgressRequest(slot0, slot1, slot2)
	slot3 = DungeonModule_pb.SavePuzzleProgressRequest()
	slot3.elementId = slot1
	slot3.progress = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveSavePuzzleProgressReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.sendGetPuzzleProgressRequest(slot0, slot1, slot2, slot3)
	slot4 = DungeonModule_pb.GetPuzzleProgressRequest()
	slot4.elementId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetPuzzleProgressReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	PuzzleMazeDrawController.instance:onGetPuzzleDrawProgress(slot2.elementId, slot2.progress)
end

slot0.instance = slot0.New()

return slot0

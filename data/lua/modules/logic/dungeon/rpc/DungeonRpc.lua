module("modules.logic.dungeon.rpc.DungeonRpc", package.seeall)

local var_0_0 = class("DungeonRpc", BaseRpc)

function var_0_0.sendGetDungeonRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = DungeonModule_pb.GetDungeonRequest()

	return arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetDungeonReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	local var_2_0 = arg_2_2.lastHeroGroup
	local var_2_1 = arg_2_2.mapIds
	local var_2_2 = arg_2_2.elements
	local var_2_3 = arg_2_2.rewardPointInfo
	local var_2_4 = arg_2_2.rewardPoint
	local var_2_5 = arg_2_2.equipSpChapters
	local var_2_6 = arg_2_2.chapterTypeNums
	local var_2_7 = arg_2_2.finishElements

	DungeonMapModel.instance:addFinishedElements(var_2_7)
	DungeonMapModel.instance:updateMapIds(var_2_1)
	DungeonMapModel.instance:addElements(var_2_2)
	DungeonMapModel.instance:initRewardPointInfo(var_2_3)
	DungeonMapModel.instance:initEquipSpChapters(var_2_5)
	DungeonMapModel.instance:initMapPuzzleStatus(arg_2_2.finishPuzzles)
	DungeonModel.instance:setChapterTypeNums(var_2_6)

	DungeonModel.instance.dungeonInfoCount = arg_2_2.dungeonInfoSize

	if arg_2_2.dungeonInfoSize <= 0 then
		DungeonModel.instance:initDungeonInfoList({})
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function var_0_0.onReceiveDungeonInfosPush(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2.dungeonInfos

	if #var_3_0 <= 0 then
		return
	end

	if DungeonModel.instance:initDungeonInfoList(var_3_0) then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function var_0_0.onReceiveDungeonUpdatePush(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.dungeonInfo
	local var_4_1 = arg_4_2.chapterTypeNums

	DungeonController.instance:checkFirstPass(var_4_0)
	DungeonModel.instance:setChapterTypeNums(var_4_1)

	if DungeonModel.instance.initAllDungeonInfo then
		DungeonController.instance:onStartLevelOrStoryChange()
	end

	DungeonModel.instance:updateDungeonInfo(var_4_0)
	DungeonController.instance:onEndLevelOrStoryChange()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, var_4_0)
end

function var_0_0.packStartDungeonRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7, arg_5_8)
	arg_5_1.chapterId = arg_5_2
	arg_5_1.episodeId = arg_5_3

	if arg_5_8 then
		arg_5_1.isRestart = arg_5_8
	end

	if arg_5_4 then
		if HeroGroupBalanceHelper.getIsBalanceMode() then
			arg_5_1.isBalance = true
		end

		arg_5_4:setReqFightGroup(arg_5_1)
		FightModel.instance:recordFightGroup(arg_5_1.fightGroup)

		local var_5_0 = arg_5_4:getCurEpisodeConfig()

		if var_5_0 and not Activity104Model.instance:isSeasonEpisodeType(var_5_0.type) and not Season123Controller.canUse123EquipEpisodeType(var_5_0.type) then
			for iter_5_0 = #arg_5_1.fightGroup.activity104Equips, 1, -1 do
				table.remove(arg_5_1.fightGroup.activity104Equips, iter_5_0)
			end
		end

		if var_5_0 and var_5_0.type == DungeonEnum.EpisodeType.Rouge then
			arg_5_1.params = tostring(RougeConfig1.instance:season())
		elseif var_5_0 and var_5_0.type == DungeonEnum.EpisodeType.WeekWalk_2 then
			arg_5_1.params = WeekWalk_2Model.instance:getFightParam()
		elseif var_5_0 and var_5_0.type == DungeonEnum.EpisodeType.Act183 then
			arg_5_1.params = Act183Helper.generateStartDungeonParams(var_5_0.id)
		end

		DungeonController.instance:dispatchEvent(DungeonEvent.OnStartDungeonExtraParams, arg_5_1, var_5_0)
	end

	arg_5_1.multiplication = arg_5_5 or 1

	if arg_5_7 == true then
		arg_5_1.useRecord = arg_5_7
	end

	VersionActivityDungeonBaseController.instance:resetIsFirstPassEpisode(arg_5_3)
end

function var_0_0.sendStartDungeonRequest(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	if not arg_6_5 then
		DungeonModel.instance:SetSendChapterEpisodeId(arg_6_1, arg_6_2)
	end

	local var_6_0 = DungeonModule_pb.StartDungeonRequest()

	arg_6_0:packStartDungeonRequest(var_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	logNormal(string.format("aaaaaaaaaaaaaaaaaaa StartDungeonRequest chapter_%d episode_%d %s", arg_6_1 or "nil", arg_6_2 or "nil", debug.traceback("", 2)))
	arg_6_0:sendMsg(var_6_0)
end

function var_0_0.onReceiveStartDungeonReply(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId)

	if var_7_0 and DungeonModel.isBattleEpisode(var_7_0) then
		DungeonFightController.instance:onReceiveStartDungeonReply(arg_7_1, arg_7_2)
	end
end

function var_0_0.sendEndDungeonRequest(arg_8_0, arg_8_1)
	local var_8_0 = DungeonModule_pb.EndDungeonRequest()

	var_8_0.isAbort = arg_8_1

	arg_8_0:sendMsg(var_8_0)
end

function var_0_0.onReceiveEndDungeonReply(arg_9_0, arg_9_1, arg_9_2)
	DungeonFightController.instance:onReceiveEndDungeonReply(arg_9_1, arg_9_2)
	DungeonFightController.instance:dispatchEvent(DungeonEvent.OnEndDungeonReply, arg_9_1)
end

function var_0_0.onReceiveEndDungeonPush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	FightResultModel.instance:onEndDungeonPush(arg_10_2)
	DungeonController.instance:onReceiveEndDungeonReply(arg_10_1, arg_10_2)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnEndDungeonPush, arg_10_2)
end

function var_0_0.sendMapElementRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = DungeonModule_pb.MapElementRequest()

	var_11_0.elementId = arg_11_1

	if arg_11_2 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
			table.insert(var_11_0.dialogIds, tonumber(iter_11_1))
		end
	end

	arg_11_0:sendMsg(var_11_0, arg_11_3, arg_11_4)
end

function var_0_0.onReceiveMapElementReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	local var_12_0 = arg_12_2.elementId

	DungeonModel.instance:startCheckUnlockChapter()
	DungeonMapModel.instance:addFinishedElement(var_12_0)
	DungeonMapModel.instance:removeElement(var_12_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnRemoveElement, var_12_0)

	local var_12_1 = lua_chapter_map_element.configDict[var_12_0]

	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, var_12_1.mapId)
end

function var_0_0.onReceiveChapterMapUpdatePush(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 ~= 0 then
		return
	end

	local var_13_0 = arg_13_2.mapIds

	DungeonMapModel.instance:updateMapIds(var_13_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChapterMapUpdate)
end

function var_0_0.onReceiveChapterMapElementUpdatePush(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end

	local var_14_0 = arg_14_2.elements

	DungeonMapModel.instance:setNewElements(var_14_0)
	DungeonMapModel.instance:addElements(var_14_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnAddElements, var_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = lua_chapter_map_element.configDict[iter_14_1]

		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateMapElementState, var_14_1.mapId)
	end

	if DungeonMapModel.instance.playAfterStory then
		DungeonMapModel.instance.playAfterStory = nil

		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo, nil)
	end
end

function var_0_0.sendGetPointRewardRequest(arg_15_0, arg_15_1)
	local var_15_0 = DungeonModule_pb.GetPointRewardRequest()

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		table.insert(var_15_0.id, iter_15_1)
	end

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveGetPointRewardReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end

	local var_16_0 = arg_16_2.id

	DungeonMapModel.instance:addPointRewardIds(var_16_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnGetPointReward)
end

function var_0_0.sendGetEpisodeHeroRecommendRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = DungeonModule_pb.GetEpisodeHeroRecommendRequest()

	var_17_0.episodeId = arg_17_1

	arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveGetEpisodeHeroRecommendReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveEquipSpDungeonUpdatePush(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 ~= 0 then
		return
	end

	local var_19_0 = arg_19_2.isDelete
	local var_19_1 = arg_19_2.chapterId

	DungeonMapModel.instance:updateEquipSpChapter(var_19_1, var_19_0)

	if not var_19_0 then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.SpecialEquipOpenTip, ViewName.MessageBoxView, {
			messageBoxId = MessageBoxIdDefine.SpecialEquipOpenTip,
			msgBoxType = MsgBoxEnum.BoxType.Yes_No,
			yesCallback = function()
				local var_20_0 = DungeonConfig.instance:getChapterEpisodeCOList(var_19_1)

				DungeonModel.instance.curSendEpisodeId = var_20_0[1].id

				FightController.instance:dispatchEvent(FightEvent.OnResultViewClose)
				ViewMgr.instance:closeView(ViewName.FightSuccView)
			end
		})
	end
end

function var_0_0.onReceiveRewardPointUpdatePush(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= 0 then
		return
	end

	local var_21_0 = arg_21_2.chapterId
	local var_21_1 = arg_21_2.value

	DungeonMapModel.instance:updateRewardPoint(var_21_0, var_21_1)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateRewardPoint)
end

function var_0_0.sendInstructionDungeonInfoRequest(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = DungeonModule_pb.InstructionDungeonInfoRequest()

	arg_22_0:sendMsg(var_22_0, arg_22_1, arg_22_2)
end

function var_0_0.onReceiveInstructionDungeonInfoReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(arg_23_2)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function var_0_0.sendInstructionDungeonOpenRequest(arg_24_0, arg_24_1)
	local var_24_0 = DungeonModule_pb.InstructionDungeonOpenRequest()

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		table.insert(var_24_0.openId, iter_24_1)
	end

	arg_24_0:sendMsg(var_24_0)
end

function var_0_0.onReceiveInstructionDungeonOpenReply(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerSetOpenSuccess)
	end
end

function var_0_0.onReceiveInstructionDungeonInfoPush(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		TeachNoteModel.instance:setTeachNoteInfo(arg_26_2)
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicInfo)
	end
end

function var_0_0.sendInstructionDungeonRewardRequest(arg_27_0, arg_27_1)
	local var_27_0 = DungeonModule_pb.InstructionDungeonRewardRequest()

	var_27_0.topicId = arg_27_1

	arg_27_0:sendMsg(var_27_0)
end

function var_0_0.onReceiveInstructionDungeonRewardReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTopicReward)
	end
end

function var_0_0.sendInstructionDungeonFinalRewardRequest(arg_29_0)
	local var_29_0 = DungeonModule_pb.InstructionDungeonFinalRewardRequest()

	arg_29_0:sendMsg(var_29_0)
end

function var_0_0.onReceiveInstructionDungeonFinalRewardReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		TeachNoteController.instance:dispatchEvent(TeachNoteEvent.GetServerTeachNoteFinalReward)
	end
end

function var_0_0.sendCoverDungeonRecordRequest(arg_31_0, arg_31_1)
	local var_31_0 = DungeonModule_pb.CoverDungeonRecordRequest()

	var_31_0.isCover = arg_31_1

	arg_31_0:sendMsg(var_31_0)
end

function var_0_0.onReceiveCoverDungeonRecordReply(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == 0 then
		DungeonController.instance:dispatchEvent(DungeonEvent.OnCoverDungeonRecordReply, arg_32_2.isCover)
	end
end

function var_0_0.sendPuzzleFinishRequest(arg_33_0, arg_33_1)
	local var_33_0 = DungeonModule_pb.PuzzleFinishRequest()

	var_33_0.elementId = arg_33_1

	arg_33_0:sendMsg(var_33_0)
end

function var_0_0.onReceivePuzzleFinishReply(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == 0 then
		DungeonMapModel.instance:setPuzzleStatus(arg_34_2.elementId)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnPuzzleFinish, arg_34_2.elementId)
	end
end

function var_0_0.sendRefreshAssistRequest(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = DungeonModule_pb.RefreshAssistRequest()

	var_35_0.assistType = arg_35_1

	return arg_35_0:sendMsg(var_35_0, arg_35_2, arg_35_3)
end

function var_0_0.onReceiveRefreshAssistReply(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		DungeonAssistModel.instance:setAssistHeroCareersByServerData(arg_36_2.assistType, arg_36_2.assistHeroCareers)
	end
end

function var_0_0.sendGetMainDramaRewardRequest(arg_37_0)
	local var_37_0 = DungeonModule_pb.GetMainDramaRewardRequest()

	arg_37_0:sendMsg(var_37_0)
end

function var_0_0.onReceiveGetMainDramaRewardReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		local var_38_0 = {}

		for iter_38_0, iter_38_1 in ipairs(arg_38_2.bonus) do
			local var_38_1 = MaterialDataMO.New()

			var_38_1:initValue(iter_38_1.materilType, iter_38_1.materilId, iter_38_1.quantity)
			table.insert(var_38_0, var_38_1)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, var_38_0)
		DungeonModel.instance:setCanGetDramaReward(false)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function var_0_0.onReceiveMainDramaRewardInfo(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == 0 then
		DungeonModel.instance:setCanGetDramaReward(true)
		DungeonController.instance:dispatchEvent(DungeonEvent.OnDramaRewardStatusChange)
	end
end

function var_0_0.sendSavePuzzleProgressRequest(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = DungeonModule_pb.SavePuzzleProgressRequest()

	var_40_0.elementId = arg_40_1
	var_40_0.progress = arg_40_2

	arg_40_0:sendMsg(var_40_0)
end

function var_0_0.onReceiveSavePuzzleProgressReply(arg_41_0, arg_41_1, arg_41_2)
	if arg_41_1 ~= 0 then
		return
	end
end

function var_0_0.sendGetPuzzleProgressRequest(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = DungeonModule_pb.GetPuzzleProgressRequest()

	var_42_0.elementId = arg_42_1

	arg_42_0:sendMsg(var_42_0, arg_42_2, arg_42_3)
end

function var_0_0.onReceiveGetPuzzleProgressReply(arg_43_0, arg_43_1, arg_43_2)
	if arg_43_1 ~= 0 then
		return
	end

	local var_43_0 = arg_43_2.elementId
	local var_43_1 = arg_43_2.progress

	PuzzleMazeDrawController.instance:onGetPuzzleDrawProgress(var_43_0, var_43_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0

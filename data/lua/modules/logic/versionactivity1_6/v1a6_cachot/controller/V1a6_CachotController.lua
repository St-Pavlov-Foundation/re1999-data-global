module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotController", package.seeall)

local var_0_0 = class("V1a6_CachotController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.needShowCureEffect = nil
	arg_1_0.heartNum = nil
	arg_1_0.cureAddHp = nil
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0.needShowCureEffect = nil
	arg_4_0.heartNum = nil
	arg_4_0.cureAddHp = nil
end

function var_0_0.enterMap(arg_5_0, arg_5_1)
	if V1a6_CachotModel.instance:isInRogue() then
		local var_5_0 = V1a6_CachotModel.instance:getRogueInfo()

		if not var_5_0 then
			RogueRpc.instance:sendGetRogueInfoRequest(V1a6_CachotEnum.ActivityId)
		else
			local var_5_1 = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

			if var_5_1 and not var_5_1:isBattleSuccess() and var_5_1:getRetries() > 0 then
				local var_5_2 = lua_rogue_event_fight.configDict[var_5_1:getEventCo().eventId]

				DungeonModel.instance:SetSendChapterEpisodeId(nil, var_5_2.episode)
				FightController.instance:setFightParamByEpisodeId(var_5_2.episode, false, 1)
				V1a6_CachotHeroGroupModel.instance:clear()
				V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
				V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
				V1a6_CachotHeroGroupModel.instance:updateGroupIndex()
				arg_5_0:setFightHeroGroup()

				local var_5_3 = FightModel.instance:getFightParam()

				DungeonFightController.instance:sendStartDungeonRequest(var_5_3.chapterId, var_5_3.episodeId, var_5_3, 1)

				return
			end

			if V1a6_CachotRoomModel.instance:getLayerIsChange() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
			elseif not arg_5_1 then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotView)
			end

			local var_5_4 = V1a6_CachotEventConfig.instance:getBgmIdByLayer(var_5_0.layer)

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, var_5_4)
			V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
			GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, V1a6_CachotConfig.instance:getSceneLevelId(var_5_0.sceneId), true, true)
		end
	else
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
	end
end

function var_0_0.abandonGame(arg_6_0)
	V1a6_CachotStatController.instance:statReset()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
end

function var_0_0.checkRogueStateInfo(arg_7_0)
	if V1a6_CachotModel.instance:getRogueStateInfo() then
		return
	end

	RogueRpc.instance:sendGetRogueStateRequest()
end

function var_0_0.openRoom(arg_8_0)
	var_0_0.instance:openV1a6_CachotRoomView()
	arg_8_0:enterMap()
end

function var_0_0.openV1a6_CachotEnterView(arg_9_0, arg_9_1, arg_9_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView, arg_9_1, arg_9_2)
end

function var_0_0.openV1a6_CachotMainView(arg_10_0, arg_10_1, arg_10_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotMainView, arg_10_1, arg_10_2)
end

function var_0_0.openV1a6_CachotRoomView(arg_11_0, arg_11_1, arg_11_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView, arg_11_1, arg_11_2)
end

function var_0_0.openV1a6_CachotCollectionView(arg_12_0, arg_12_1, arg_12_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionView, arg_12_1, arg_12_2)
end

function var_0_0.openV1a6_CachotDifficultyView(arg_13_0, arg_13_1, arg_13_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotDifficultyView, arg_13_1, arg_13_2)
end

function var_0_0.openV1a6_CachotResultView(arg_14_0, arg_14_1, arg_14_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotResultView, arg_14_1, arg_14_2)
end

function var_0_0.openV1a6_CachotFinishView(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = V1a6_CachotModel.instance:getRogueEndingInfo()

	if not var_15_0 or var_15_0:isEnterEndingFlow() then
		return
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotFinishView, arg_15_1, arg_15_2)
end

function var_0_0.openV1a6_CachotProgressView(arg_16_0, arg_16_1, arg_16_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotProgressView, arg_16_1, arg_16_2)
end

function var_0_0.setFightHeroGroup(arg_17_0)
	local var_17_0 = FightModel.instance:getFightParam()

	if not var_17_0 then
		return false
	end

	local var_17_1 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	if not var_17_1 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_17_2, var_17_3 = var_17_1:getMainList()
	local var_17_4, var_17_5 = var_17_1:getSubList()

	if (not var_17_1.aidDict or #var_17_1.aidDict <= 0) and var_17_3 + var_17_5 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	local var_17_6 = var_17_0.battleId
	local var_17_7 = var_17_6 and lua_battle.configDict[var_17_6]
	local var_17_8 = var_17_7 and var_17_7.noClothSkill == 0 and var_17_1.clothId or 0

	var_17_0:setMySide(var_17_8, var_17_2, var_17_1:getSubList(), var_17_1:getAllHeroEquips(), var_17_1:getAllHeroActivity104Equips())

	return true
end

function var_0_0._initHeroSingleGroupModel(arg_18_0)
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:clear()

	local var_18_0 = V1a6_CachotModel.instance:getTeamInfo()

	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(var_18_0.groupInfos)
	V1a6_CachotHeroGroupModel.instance:setCurGroupId(var_18_0.groupIdx)
end

function var_0_0.selectHeroFromEvent(arg_19_0, arg_19_1)
	V1a6_CachotHeroGroupModel.instance:clear()

	local var_19_0 = V1a6_CachotModel.instance:getTeamInfo():getAllHeroUids()
	local var_19_1 = V1a6_CachotHeroGroupMO.New()

	var_19_1:setMaxHeroCount(#var_19_0)

	local var_19_2 = 1

	var_19_1:init({
		groupId = var_19_2,
		heroList = var_19_0
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(#var_19_0)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(var_19_1)

	local var_19_3 = {}

	var_19_3.singleGroupMOId = 1
	var_19_3.originalHeroUid = "0"
	var_19_3.equips = {
		"0"
	}
	var_19_3.hideCancel = true
	var_19_3.selectHeroFromEvent = true
	var_19_3.heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Event
	var_19_3.eventMo = arg_19_1

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, var_19_3)
end

function var_0_0.openV1a6_CachotTeamView(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 and arg_20_1.selectLevel then
		V1a6_CachotTeamModel.instance:setSelectLevel(arg_20_1.selectLevel)
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamView, arg_20_1, arg_20_2)
end

function var_0_0.openV1a6_CachotTeamPreView(arg_21_0, arg_21_1, arg_21_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamPreView, arg_21_1, arg_21_2)
end

function var_0_0.openV1a6_CachotLoadingView(arg_22_0, arg_22_1, arg_22_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotLoadingView, arg_22_1, arg_22_2)
end

function var_0_0.openV1a6_CachotRoleRevivalView(arg_23_0, arg_23_1, arg_23_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalView, arg_23_1, arg_23_2)
end

function var_0_0.openV1a6_CachotRoleRevivalResultView(arg_24_0, arg_24_1, arg_24_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalResultView, arg_24_1, arg_24_2)
end

function var_0_0.openV1a6_CachotRoleRecoverView(arg_25_0, arg_25_1, arg_25_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverView, arg_25_1, arg_25_2)
end

function var_0_0.openV1a6_CachotRoleRecoverResultView(arg_26_0, arg_26_1, arg_26_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverResultView, arg_26_1, arg_26_2)
end

function var_0_0.openV1a6_CachotUpgradeView(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:_initHeroSingleGroupModel()
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeView, arg_27_1, arg_27_2)
end

function var_0_0.openV1a6_CachotUpgradeResultView(arg_28_0, arg_28_1, arg_28_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeResultView, arg_28_1, arg_28_2)
end

function var_0_0.openV1a6_CachotEquipInfoTeamShowView(arg_29_0, arg_29_1, arg_29_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEquipInfoTeamShowView, arg_29_1, arg_29_2)
end

function var_0_0.openV1a6_CachotEndingView(arg_30_0, arg_30_1, arg_30_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEndingView, arg_30_1, arg_30_2)
end

function var_0_0.openV1a6_CachotCollectionBagView(arg_31_0, arg_31_1, arg_31_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionBagView, arg_31_1, arg_31_2)
end

function var_0_0.openV1a6_CachotCollectionUnlockedView(arg_32_0, arg_32_1, arg_32_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionUnlockedView, arg_32_1, arg_32_2)
end

function var_0_0.openV1a6_CachotCollectionOverView(arg_33_0, arg_33_1, arg_33_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionOverView, arg_33_1, arg_33_2)
end

function var_0_0.openV1a6_CachotStoreView(arg_34_0, arg_34_1, arg_34_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotStoreView, arg_34_1, arg_34_2)
end

function var_0_0.openV1a6_CachotTipsView(arg_35_0, arg_35_1, arg_35_2)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTipsView, arg_35_1, arg_35_2)
end

function var_0_0.openV1a6_CachotEpisodeView(arg_36_0, arg_36_1, arg_36_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEpisodeView, arg_36_1, arg_36_2)
end

function var_0_0.openV1a6_CachotCollectionEnchantView(arg_37_0, arg_37_1, arg_37_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionEnchantView, arg_37_1, arg_37_2)
end

function var_0_0.openV1a6_CachotCollectionGetView(arg_38_0, arg_38_1, arg_38_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionGetView, arg_38_1, arg_38_2)
end

function var_0_0.openV1a6_CachotCollectionSelectView(arg_39_0, arg_39_1, arg_39_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionSelectView, arg_39_1, arg_39_2)
end

function var_0_0.openV1a6_CachotRewardView(arg_40_0, arg_40_1, arg_40_2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRewardView, arg_40_1, arg_40_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0

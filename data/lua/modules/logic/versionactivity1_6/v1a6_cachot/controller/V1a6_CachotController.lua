module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotController", package.seeall)

slot0 = class("V1a6_CachotController", BaseController)

function slot0.onInit(slot0)
	slot0.needShowCureEffect = nil
	slot0.heartNum = nil
	slot0.cureAddHp = nil
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0.needShowCureEffect = nil
	slot0.heartNum = nil
	slot0.cureAddHp = nil
end

function slot0.enterMap(slot0, slot1)
	if V1a6_CachotModel.instance:isInRogue() then
		if not V1a6_CachotModel.instance:getRogueInfo() then
			RogueRpc.instance:sendGetRogueInfoRequest(V1a6_CachotEnum.ActivityId)
		else
			if V1a6_CachotRoomModel.instance:getNowBattleEventMo() and not slot3:isBattleSuccess() and slot3:getRetries() > 0 then
				slot4 = lua_rogue_event_fight.configDict[slot3:getEventCo().eventId]

				DungeonModel.instance:SetSendChapterEpisodeId(nil, slot4.episode)
				FightController.instance:setFightParamByEpisodeId(slot4.episode, false, 1)
				V1a6_CachotHeroGroupModel.instance:clear()
				V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
				V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(V1a6_CachotModel.instance:getTeamInfo():getGroupInfos())
				V1a6_CachotHeroGroupModel.instance:updateGroupIndex()
				slot0:setFightHeroGroup()

				slot5 = FightModel.instance:getFightParam()

				DungeonFightController.instance:sendStartDungeonRequest(slot5.chapterId, slot5.episodeId, slot5, 1)

				return
			end

			if V1a6_CachotRoomModel.instance:getLayerIsChange() then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
			elseif not slot1 then
				GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotView)
			end

			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, V1a6_CachotEventConfig.instance:getBgmIdByLayer(slot2.layer))
			V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
			GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, V1a6_CachotConfig.instance:getSceneLevelId(slot2.sceneId), true, true)
		end
	else
		AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
	end
end

function slot0.abandonGame(slot0)
	V1a6_CachotStatController.instance:statReset()
	RogueRpc.instance:sendAbortRogueRequest(V1a6_CachotEnum.ActivityId)
end

function slot0.checkRogueStateInfo(slot0)
	if V1a6_CachotModel.instance:getRogueStateInfo() then
		return
	end

	RogueRpc.instance:sendGetRogueStateRequest()
end

function slot0.openRoom(slot0)
	uv0.instance:openV1a6_CachotRoomView()
	slot0:enterMap()
end

function slot0.openV1a6_CachotEnterView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEnterView, slot1, slot2)
end

function slot0.openV1a6_CachotMainView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotMainView, slot1, slot2)
end

function slot0.openV1a6_CachotRoomView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionView, slot1, slot2)
end

function slot0.openV1a6_CachotDifficultyView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotDifficultyView, slot1, slot2)
end

function slot0.openV1a6_CachotResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotResultView, slot1, slot2)
end

function slot0.openV1a6_CachotFinishView(slot0, slot1, slot2)
	if not V1a6_CachotModel.instance:getRogueEndingInfo() or slot3:isEnterEndingFlow() then
		return
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotFinishView, slot1, slot2)
end

function slot0.openV1a6_CachotProgressView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotProgressView, slot1, slot2)
end

function slot0.setFightHeroGroup(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not V1a6_CachotHeroGroupModel.instance:getCurGroupMO() then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot3, slot4 = slot2:getMainList()
	slot5, slot6 = slot2:getSubList()

	if (not slot2.aidDict or #slot2.aidDict <= 0) and slot4 + slot6 == 0 then
		GameFacade.showToast(ToastEnum.FightNoCurGroupMO)

		return false
	end

	slot8 = slot1.battleId and lua_battle.configDict[slot7]

	slot1:setMySide(slot8 and slot8.noClothSkill == 0 and slot2.clothId or 0, slot3, slot2:getSubList(), slot2:getAllHeroEquips(), slot2:getAllHeroActivity104Equips())

	return true
end

function slot0._initHeroSingleGroupModel(slot0)
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(V1a6_CachotEnum.HeroCountInGroup)
	V1a6_CachotHeroGroupModel.instance:clear()

	slot1 = V1a6_CachotModel.instance:getTeamInfo()

	V1a6_CachotHeroGroupModel.instance:onGetHeroGroupList(slot1.groupInfos)
	V1a6_CachotHeroGroupModel.instance:setCurGroupId(slot1.groupIdx)
end

function slot0.selectHeroFromEvent(slot0, slot1)
	V1a6_CachotHeroGroupModel.instance:clear()

	slot3 = V1a6_CachotModel.instance:getTeamInfo():getAllHeroUids()
	slot4 = V1a6_CachotHeroGroupMO.New()

	slot4:setMaxHeroCount(#slot3)
	slot4:init({
		groupId = 1,
		heroList = slot3
	})
	V1a6_CachotHeroSingleGroupModel.instance:setMaxHeroCount(#slot3)
	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(slot4)
	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, {
		singleGroupMOId = 1,
		originalHeroUid = "0",
		equips = {
			"0"
		},
		hideCancel = true,
		selectHeroFromEvent = true,
		heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Event,
		eventMo = slot1
	})
end

function slot0.openV1a6_CachotTeamView(slot0, slot1, slot2)
	if slot1 and slot1.selectLevel then
		V1a6_CachotTeamModel.instance:setSelectLevel(slot1.selectLevel)
	end

	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamView, slot1, slot2)
end

function slot0.openV1a6_CachotTeamPreView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTeamPreView, slot1, slot2)
end

function slot0.openV1a6_CachotLoadingView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotLoadingView, slot1, slot2)
end

function slot0.openV1a6_CachotRoleRevivalView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalView, slot1, slot2)
end

function slot0.openV1a6_CachotRoleRevivalResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRevivalResultView, slot1, slot2)
end

function slot0.openV1a6_CachotRoleRecoverView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverView, slot1, slot2)
end

function slot0.openV1a6_CachotRoleRecoverResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRoleRecoverResultView, slot1, slot2)
end

function slot0.openV1a6_CachotUpgradeView(slot0, slot1, slot2)
	slot0:_initHeroSingleGroupModel()
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeView, slot1, slot2)
end

function slot0.openV1a6_CachotUpgradeResultView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotUpgradeResultView, slot1, slot2)
end

function slot0.openV1a6_CachotEquipInfoTeamShowView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEquipInfoTeamShowView, slot1, slot2)
end

function slot0.openV1a6_CachotEndingView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEndingView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionBagView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionBagView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionUnlockedView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionUnlockedView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionOverView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionOverView, slot1, slot2)
end

function slot0.openV1a6_CachotStoreView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotStoreView, slot1, slot2)
end

function slot0.openV1a6_CachotTipsView(slot0, slot1, slot2)
	V1a6_CachotEventController.instance:setPause(true, V1a6_CachotEnum.EventPauseType.Tips)
	ViewMgr.instance:openView(ViewName.V1a6_CachotTipsView, slot1, slot2)
end

function slot0.openV1a6_CachotEpisodeView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotEpisodeView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionEnchantView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionEnchantView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionGetView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionGetView, slot1, slot2)
end

function slot0.openV1a6_CachotCollectionSelectView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotCollectionSelectView, slot1, slot2)
end

function slot0.openV1a6_CachotRewardView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.V1a6_CachotRewardView, slot1, slot2)
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.bossrush.controller.BossRushController", package.seeall)

slot0 = class("BossRushController", BaseController)

function slot0.onInit(slot0)
	slot0._model = BossRushModel.instance
	slot0._redModel = BossRushRedModel.instance
end

function slot0.reInit(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshClientCharacterDot, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshClientCharacterDot, slot0)
end

function slot0.addConstEvents(slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	FightController.instance:registerCallback(FightEvent.OnIndicatorChange, slot0._onIndicatorChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, slot0._refreshCurBossHP, slot0)
	FightController.instance:registerCallback(FightEvent.OnHpChange, slot0._onHpChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnMonsterChange, slot0._onMonsterChange, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshClientCharacterDot, slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, slot0._onEndDungeonPush, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, slot0._refreshActivityState, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._updateRelateDotInfo, slot0)
end

function slot0.enterFightScene(slot0, slot1, slot2)
	slot0._model:setBattleStageAndLayer(slot1, slot2)

	slot3 = BossRushConfig.instance:getDungeonEpisodeCO(slot1, slot2)
	slot4 = slot3.id
	slot5 = slot3.chapterId

	if BossRushConfig.instance:isInfinite(slot1, slot2) then
		FightController.instance:setFightParamByBattleId(slot3.battleId).chapterId = DungeonEnum.ChapterType.BossRushInfinite
	else
		slot7.chapterId = DungeonEnum.ChapterType.BossRushNormal
	end

	slot7.episodeId = slot4
	slot7.chapterId = slot5
	FightResultModel.instance.episodeId = slot4

	DungeonModel.instance:SetSendChapterEpisodeId(slot5, slot4)
	slot7:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.openMainView(slot0, slot1, slot2)
	if slot2 then
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, slot1)

		return
	end

	if not slot0._model:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if slot1 then
		slot4 = slot1.layer

		if slot1.stage and not slot0._model:isBossOnline(slot3) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

			return
		end

		if slot4 and not slot0._model:isBossLayerOpen(slot3, slot4) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)
		end
	end

	BossRushRpc.instance:sendGet128InfosRequest(function ()
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, uv0)
	end)
end

function slot0.openLevelDetailView(slot0, slot1, slot2)
	slot4 = slot1.layer

	if not slot0._model:isBossOnline(slot1.stage) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if not slot1.stageCO then
		slot1.stageCO = BossRushConfig.instance:getStageCO(slot3)
	end

	if slot2 then
		slot0:openMainView(nil, true)
	end

	if slot4 then
		slot1.selectedIndex = slot0._model:layer2Index(slot3, slot4)
	end

	ViewMgr.instance:openView(ViewName.V1a4_BossRushLevelDetail, slot1)
end

function slot0.sendGetTaskInfoRequest(slot0, slot1, slot2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity128
	}, slot1, slot2)
end

function slot0._refreshClientCharacterDot(slot0)
	if not slot0._redModel:isInitReady() then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, slot0._refreshClientCharacterDot, slot0)
	slot0._redModel:refreshClientCharacterDot()
end

function slot0._updateRelateDotInfo(slot0, slot1)
	slot0._redModel:updateRelateDotInfo(slot1)
end

function slot0._refreshActivityState(slot0, slot1)
	if slot1 ~= slot0._model:getActivityId() then
		return
	end

	slot0._redModel:setIsOpenActivity(ActivityModel.instance:isActOnLine(slot1))
end

function slot0._onEndDungeonPush(slot0)
	if not FightResultModel.instance.firstPass then
		return
	end

	slot2, slot3 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(FightResultModel.instance.episodeId)

	if not slot2 then
		return
	end

	if not BossRushConfig.instance:tryGetStageNextLayer(slot2, slot3) then
		return
	end

	if not slot0._model:isBossLayerOpen(slot2, slot4) then
		return
	end

	slot0._redModel:setIsNewUnlockStageLayer(slot2, slot4, true)
end

function slot0.openVersionActivityEnterViewIfNotOpened(slot0)
	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_5EnterView) then
		VersionActivity1_5EnterController.instance:directOpenVersionActivityEnterView()
	end
end

function slot0._respBeginFight(slot0)
	if not slot0:isInBossRushFight() then
		return
	end

	if not FightModel.instance:getCurMonsterGroupId() then
		return
	end

	slot0._temp11235 = 0

	slot0._model:setFightScore(0)
	slot0._model:clearStageScore()

	if string.nilorempty(BossRushConfig.instance:getMonsterGroupBossId(slot1)) then
		slot0._model:setBossIdList(nil)
	else
		slot0._model:setBossIdList(string.splitToNumber(slot2, "#"))
		slot0._model:setBossBloodCount(slot0._model:getBossBloodMaxCount())
	end

	slot0:_refreshCurBossHP()
end

function slot0._respBeginRound(slot0)
end

function slot0._onIndicatorChange(slot0, slot1)
	if FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips == slot1 then
		slot0._temp11235 = (slot0._temp11235 or 0) + FightDataHelper.fieldMgr:getIndicatorNum(slot1)

		slot0._model:noticeFightScore(slot0._temp11235)
		slot0._model:setFightScore(slot0._temp11235)
	elseif slot2.BossInfiniteHPCount == slot1 then
		slot0._model:setInfiniteBossDeadSum(FightDataHelper.fieldMgr:getIndicatorNum(slot1))
	end
end

function slot0._refreshCurBossHP(slot0)
	if not slot0._model:getBossEntityMO() then
		return
	end

	slot0._model:setBossCurHP(slot1.currentHp)
end

function slot0._onHpChange(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._model:getBossEntityMO() then
		return
	end

	if slot2.id ~= slot1:getMO().id then
		return
	end

	slot0._model:setBossCurHP(slot2.currentHp)
end

function slot0._onMonsterChange(slot0, slot1, slot2)
	slot0._model:subBossBlood()
end

function slot0.checkBattleChapterType(slot0, slot1, slot2)
	if slot1 and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	if not DungeonModel.instance.curSendChapterId then
		return false
	end

	if not DungeonConfig.instance:getChapterCO(slot3) then
		return false
	end

	return slot4.type == slot2
end

function slot0.isInBossRushInfiniteFight(slot0, slot1)
	return slot0:checkBattleChapterType(slot1, DungeonEnum.ChapterType.BossRushInfinite)
end

function slot0.isInBossRushNormalFight(slot0, slot1)
	return slot0:checkBattleChapterType(slot1, DungeonEnum.ChapterType.BossRushNormal)
end

function slot0.isInBossRushFight(slot0, slot1)
	return slot0:isInBossRushNormalFight(slot1) or slot0:isInBossRushInfiniteFight(slot1)
end

function slot0.isInBossRushDungeon(slot0)
	if not DungeonModel.instance.curSendEpisodeId then
		return false
	end

	if not DungeonConfig.instance:getEpisodeCO(slot1) then
		return false
	end

	if not DungeonConfig.instance:getChapterCO(slot2.chapterId) then
		return false
	end

	if slot4.type == DungeonEnum.ChapterType.BossRushInfinite or slot5 == slot6.BossRushNormal then
		return true
	end

	return false
end

function slot0.openBossRushStoreView(slot0, slot1)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.BossRushStore, function ()
		ViewMgr.instance:openView(ViewName.V1a6_BossRush_StoreView, {
			actId = uv0
		})
	end, slot0)
end

function slot0.openResultPanel(slot0, slot1)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_ResultPanel, slot1)
end

function slot0.openBossRushOfferRoleView(slot0)
	ViewMgr.instance:openView(ViewName.V2a1_BossRush_OfferRoleView, {
		actId = BossRushConfig.instance:getActivityId()
	})
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.bossrush.controller.BossRushController", package.seeall)

local var_0_0 = class("BossRushController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._model = BossRushModel.instance
	arg_1_0._redModel = BossRushRedModel.instance
end

function var_0_0.reInit(arg_2_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, arg_2_0._refreshClientCharacterDot, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, arg_2_0._refreshClientCharacterDot, arg_2_0)
end

function var_0_0.addConstEvents(arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, arg_3_0._respBeginFight, arg_3_0)
	FightController.instance:registerCallback(FightEvent.RespBeginRound, arg_3_0._respBeginRound, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnIndicatorChange, arg_3_0._onIndicatorChange, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnBeginWave, arg_3_0._refreshCurBossHP, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnHpChange, arg_3_0._onHpChange, arg_3_0)
	FightController.instance:registerCallback(FightEvent.OnMonsterChange, arg_3_0._onMonsterChange, arg_3_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_3_0._onGetInfoFinish, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.RefreshClientCharacterDot, arg_3_0._refreshClientCharacterDot, arg_3_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnEndDungeonPush, arg_3_0._onEndDungeonPush, arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0._refreshActivityState, arg_3_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._updateRelateDotInfo, arg_3_0)
end

function var_0_0.enterFightScene(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._model:setBattleStageAndLayer(arg_4_1, arg_4_2)

	local var_4_0 = BossRushConfig.instance:getDungeonEpisodeCO(arg_4_1, arg_4_2)
	local var_4_1 = var_4_0.id
	local var_4_2 = var_4_0.chapterId
	local var_4_3 = var_4_0.battleId
	local var_4_4 = FightController.instance:setFightParamByBattleId(var_4_3)

	if BossRushConfig.instance:isInfinite(arg_4_1, arg_4_2) then
		var_4_4.chapterId = DungeonEnum.ChapterType.BossRushInfinite
	else
		var_4_4.chapterId = DungeonEnum.ChapterType.BossRushNormal
	end

	var_4_4.episodeId = var_4_1
	var_4_4.chapterId = var_4_2
	FightResultModel.instance.episodeId = var_4_1

	DungeonModel.instance:SetSendChapterEpisodeId(var_4_2, var_4_1)
	var_4_4:setPreload()
	FightController.instance:enterFightScene()
end

function var_0_0.openMainView(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, arg_5_1)

		return
	end

	if not arg_5_0._model:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if arg_5_1 then
		local var_5_0 = arg_5_1.stage
		local var_5_1 = arg_5_1.layer

		if var_5_0 and not arg_5_0._model:isBossOnline(var_5_0) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

			return
		end

		if var_5_1 and not arg_5_0._model:isBossLayerOpen(var_5_0, var_5_1) then
			GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)
		end
	end

	BossRushRpc.instance:sendGet128InfosRequest(function()
		ViewMgr.instance:openView(ViewName.V1a4_BossRushMainView, arg_5_1)
	end)
end

function var_0_0.openLevelDetailView(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.stage
	local var_7_1 = arg_7_1.layer

	if not arg_7_0._model:isBossOnline(var_7_0) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if not arg_7_1.stageCO then
		arg_7_1.stageCO = BossRushConfig.instance:getStageCO(var_7_0)
	end

	if arg_7_2 then
		arg_7_0:openMainView(nil, true)
	end

	if var_7_1 then
		arg_7_1.selectedIndex = arg_7_0._model:layer2Index(var_7_0, var_7_1)
	end

	ViewMgr.instance:openView(ViewName.V1a4_BossRushLevelDetail, arg_7_1)
end

function var_0_0.sendGetTaskInfoRequest(arg_8_0, arg_8_1, arg_8_2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity128
	}, arg_8_1, arg_8_2)
end

function var_0_0._refreshClientCharacterDot(arg_9_0)
	if not arg_9_0._redModel:isInitReady() then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.RefreshClientCharacterDot, arg_9_0._refreshClientCharacterDot, arg_9_0)
	arg_9_0._redModel:refreshClientCharacterDot()
end

function var_0_0._updateRelateDotInfo(arg_10_0, arg_10_1)
	arg_10_0._redModel:updateRelateDotInfo(arg_10_1)
end

function var_0_0._refreshActivityState(arg_11_0, arg_11_1)
	if arg_11_1 ~= arg_11_0._model:getActivityId() then
		return
	end

	local var_11_0 = ActivityModel.instance:isActOnLine(arg_11_1)

	arg_11_0._redModel:setIsOpenActivity(var_11_0)
end

function var_0_0._onEndDungeonPush(arg_12_0)
	if not FightResultModel.instance.firstPass then
		return
	end

	local var_12_0 = FightResultModel.instance.episodeId
	local var_12_1, var_12_2 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(var_12_0)

	if not var_12_1 then
		return
	end

	local var_12_3 = BossRushConfig.instance:tryGetStageNextLayer(var_12_1, var_12_2)

	if not var_12_3 then
		return
	end

	if not arg_12_0._model:isBossLayerOpen(var_12_1, var_12_3) then
		return
	end

	arg_12_0._redModel:setIsNewUnlockStageLayer(var_12_1, var_12_3, true)
end

function var_0_0.openVersionActivityEnterViewIfNotOpened(arg_13_0)
	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_5EnterView) then
		VersionActivity1_5EnterController.instance:directOpenVersionActivityEnterView()
	end
end

function var_0_0._respBeginFight(arg_14_0)
	if not arg_14_0:isInBossRushFight() then
		return
	end

	local var_14_0 = FightModel.instance:getCurMonsterGroupId()

	if not var_14_0 then
		return
	end

	local var_14_1 = BossRushConfig.instance:getMonsterGroupBossId(var_14_0)

	arg_14_0._temp11235 = 0

	arg_14_0._model:setFightScore(0)
	arg_14_0._model:clearStageScore()

	if string.nilorempty(var_14_1) then
		arg_14_0._model:setBossIdList(nil)
	else
		local var_14_2 = string.splitToNumber(var_14_1, "#")

		arg_14_0._model:setBossIdList(var_14_2)
		arg_14_0._model:setBossBloodCount(arg_14_0._model:getBossBloodMaxCount())
	end

	arg_14_0:_refreshCurBossHP()
end

function var_0_0._respBeginRound(arg_15_0)
	return
end

function var_0_0._onIndicatorChange(arg_16_0, arg_16_1)
	local var_16_0 = FightEnum.IndicatorId

	if var_16_0.V1a4_BossRush_ig_ScoreTips == arg_16_1 then
		local var_16_1 = FightDataHelper.fieldMgr:getIndicatorNum(arg_16_1)

		arg_16_0._temp11235 = (arg_16_0._temp11235 or 0) + var_16_1

		arg_16_0._model:noticeFightScore(arg_16_0._temp11235)
		arg_16_0._model:setFightScore(arg_16_0._temp11235)
	elseif var_16_0.BossInfiniteHPCount == arg_16_1 then
		local var_16_2 = FightDataHelper.fieldMgr:getIndicatorNum(arg_16_1)

		arg_16_0._model:setInfiniteBossDeadSum(var_16_2)
	end
end

function var_0_0._refreshCurBossHP(arg_17_0)
	local var_17_0 = arg_17_0._model:getBossEntityMO()

	if not var_17_0 then
		return
	end

	arg_17_0._model:setBossCurHP(var_17_0.currentHp)
end

function var_0_0._onHpChange(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	local var_18_0 = arg_18_0._model:getBossEntityMO()

	if not var_18_0 then
		return
	end

	local var_18_1 = arg_18_1:getMO()

	if var_18_0.id ~= var_18_1.id then
		return
	end

	arg_18_0._model:setBossCurHP(var_18_0.currentHp)
end

function var_0_0._onMonsterChange(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0._model:subBossBlood()
end

function var_0_0._onGetInfoFinish(arg_20_0)
	arg_20_0:_recordBossRushCurrencyNum()
end

function var_0_0._recordBossRushCurrencyNum(arg_21_0)
	local var_21_0 = PlayerEnum.SimpleProperty.V2a7_BossRushCurrencyNum

	if not PlayerModel.instance:getSimpleProperty(var_21_0) then
		local var_21_1 = V1a6_BossRush_StoreModel.instance:getCurrencyCount()

		PlayerModel.instance:forceSetSimpleProperty(var_21_0, tostring(var_21_1))
		PlayerRpc.instance:sendSetSimplePropertyRequest(var_21_0, tostring(var_21_1))
	end
end

function var_0_0.checkBattleChapterType(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	local var_22_0 = DungeonModel.instance.curSendChapterId

	if not var_22_0 then
		return false
	end

	local var_22_1 = DungeonConfig.instance:getChapterCO(var_22_0)

	if not var_22_1 then
		return false
	end

	return var_22_1.type == arg_22_2
end

function var_0_0.isInBossRushInfiniteFight(arg_23_0, arg_23_1)
	return arg_23_0:checkBattleChapterType(arg_23_1, DungeonEnum.ChapterType.BossRushInfinite)
end

function var_0_0.isInBossRushNormalFight(arg_24_0, arg_24_1)
	return arg_24_0:checkBattleChapterType(arg_24_1, DungeonEnum.ChapterType.BossRushNormal)
end

function var_0_0.isInBossRushFight(arg_25_0, arg_25_1)
	return arg_25_0:isInBossRushNormalFight(arg_25_1) or arg_25_0:isInBossRushInfiniteFight(arg_25_1)
end

function var_0_0.isInBossRushDungeon(arg_26_0)
	local var_26_0 = DungeonModel.instance.curSendEpisodeId

	if not var_26_0 then
		return false
	end

	local var_26_1 = DungeonConfig.instance:getEpisodeCO(var_26_0)

	if not var_26_1 then
		return false
	end

	local var_26_2 = var_26_1.chapterId
	local var_26_3 = DungeonConfig.instance:getChapterCO(var_26_2)

	if not var_26_3 then
		return false
	end

	local var_26_4 = var_26_3.type
	local var_26_5 = DungeonEnum.ChapterType

	if var_26_4 == var_26_5.BossRushInfinite or var_26_4 == var_26_5.BossRushNormal then
		return true
	end

	return false
end

function var_0_0.openBossRushStoreView(arg_27_0, arg_27_1)
	StoreRpc.instance:sendGetStoreInfosRequest(StoreEnum.BossRushStore, function()
		local var_28_0 = {
			actId = arg_27_1
		}

		ViewMgr.instance:openView(ViewName.V1a6_BossRush_StoreView, var_28_0)
	end, arg_27_0)
end

function var_0_0.openResultPanel(arg_29_0, arg_29_1)
	ViewMgr.instance:openView(ViewName.V1a6_BossRush_ResultPanel, arg_29_1)
end

function var_0_0.openBossRushOfferRoleView(arg_30_0)
	local var_30_0 = {
		actId = BossRushConfig.instance:getActivityId()
	}

	ViewMgr.instance:openView(ViewName.V2a1_BossRush_OfferRoleView, var_30_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0

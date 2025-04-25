module("modules.logic.versionactivity1_6.dungeon.controller.VersionActivity1_6DungeonController", package.seeall)

slot0 = class("VersionActivity1_6DungeonController", BaseController)

function slot0.onInit(slot0)
	slot0._bossModel = VersionActivity1_6DungeonBossModel.instance
end

function slot0.reInit(slot0)
	slot0._bossModel = VersionActivity1_6DungeonBossModel.instance

	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._respBeginRound, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, slot0._onIndicatorChange, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
end

function slot0._respBeginFight(slot0)
	slot0._tempScore = 0

	slot0._bossModel:setFightScore(0)
end

function slot0._respBeginRound(slot0)
	if not FightModel.instance:getCurRoundMO() then
		return
	end

	if not slot1.fightStepMOs or not next(slot2) then
		return
	end

	slot3 = FightWorkIndicatorChange.ConfigEffect.AddIndicator
	slot4 = FightEnum.EffectType.INDICATORCHANGE
	slot5 = FightEnum.IndicatorId.Act1_6DungeonBoss
	slot6 = 0

	for slot10 = #slot2, 1, -1 do
		slot12 = slot2[slot10].actEffectMOs or {}

		for slot16 = #slot12, 1, -1 do
			slot17 = slot12[slot16]

			if slot17.effectType == slot4 and tonumber(slot17.targetId) == slot5 and slot17.configEffect == slot3 then
				slot6 = math.max(slot6, slot17.effectNum)
			end
		end
	end

	if slot6 > 0 then
		slot0._bossModel:setFightScore(slot6)
	end
end

function slot0._onIndicatorChange(slot0, slot1)
	if slot1 == FightEnum.IndicatorId.Act1_6DungeonBoss then
		slot0._tempScore = math.max(slot0._tempScore, FightDataHelper.fieldMgr:getIndicatorNum(slot1))

		slot0._bossModel:noticeFightScore(slot0._tempScore)
	end
end

function slot0._onEndDungeonPush(slot0, slot1)
	if not FightResultModel.instance.firstPass then
		return
	end

	if slot0._bossModel:getMaxOrderMo().cfg.episodeId == FightResultModel.instance.episodeId then
		-- Nothing
	end
end

function slot0.openActivityDungeonMapViewDirectly(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, slot0.openViewParam)
end

function slot0.getEpisodeMapConfig(slot0, slot1)
	return DungeonConfig.instance:getChapterMapCfg(VersionActivity1_6DungeonEnum.DungeonChapterId.Story, slot0:getStoryEpisodeCo(slot1).preEpisode)
end

function slot0.getEpisodeIndex(slot0, slot1)
	slot2 = slot0:getStoryEpisodeCo(slot1)

	return DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot2.chapterId, slot2.id)
end

function slot0.getStoryEpisodeCo(slot0, slot1)
	if DungeonConfig.instance:getEpisodeCO(slot1).chapterId == VersionActivity1_6DungeonEnum.DungeonChapterId.Hard then
		slot2 = DungeonConfig.instance:getEpisodeCO(slot1 - 10000)
	else
		while slot2.chapterId ~= VersionActivity1_6DungeonEnum.DungeonChapterId.Story do
			slot2 = DungeonConfig.instance:getEpisodeCO(slot2.preEpisode)
		end
	end

	return slot2
end

function slot0.enterBossFightScene(slot0, slot1)
	slot2 = Activity149Config.instance:getDungeonEpisodeCfg(slot1)
	slot3 = slot2.id
	slot4 = slot2.chapterId
	slot6 = FightController.instance:setFightParamByBattleId(slot2.battleId)
	slot6.episodeId = slot3
	slot6.chapterId = slot4
	FightResultModel.instance.episodeId = slot3

	DungeonModel.instance:SetSendChapterEpisodeId(slot4, slot3)
	slot6:setPreload()
	FightController.instance:enterFightScene()
end

function slot0.openVersionActivityDungeonMapView(slot0, slot1, slot2, slot3, slot4)
	slot0.openViewParam = {
		chapterId = slot1,
		episodeId = slot2
	}
	slot0.openMapViewCallback = slot3
	slot0.openMapViewCallbackObj = slot4
	slot0.receiveTaskReply = nil
	slot0.waitAct148InfoReply = true

	VersionActivity1_6DungeonModel.instance:init()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.ActivityDungeon
	}, slot0._onReceiveTaskReply, slot0)
	Activity113Rpc.instance:sendGetAct113InfoRequest(VersionActivity1_6Enum.ActivityId.Dungeon)

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60101) then
		VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(slot0._onReceiveAct148InfoReply, slot0)
	else
		slot0.waitAct148InfoReply = false
	end
end

function slot0._onReceiveTaskReply(slot0)
	slot0.receiveTaskReply = true

	slot0:_openVersionActivityDungeonMapView()
end

function slot0._onReceiveAct148InfoReply(slot0)
	slot0.waitAct148InfoReply = false

	slot0:_openVersionActivityDungeonMapView()
end

function slot0._openVersionActivityDungeonMapView(slot0)
	if not slot0.receiveTaskReply or slot0.waitAct148InfoReply then
		return
	end

	slot0.receiveTaskReply = nil

	if slot0.openMapViewCallback then
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapView, slot0.openViewParam)
end

function slot0._onOpenMapViewDone(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_6DungeonMapView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenMapViewDone, slot0)

		if slot0.openMapViewCallback then
			slot0.openMapViewCallback = nil
			slot0.openMapViewCallbackObj = nil

			slot0.openMapViewCallback(slot0.openMapViewCallbackObj)
		end
	end
end

function slot0.openTaskView(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6TaskView)
end

function slot0.openSkillView(slot0)
	VersionActivity1_6DungeonRpc.instance:sendGet148InfoRequest(slot0._openSkillViewImpl, slot0)
end

function slot0._openSkillViewImpl(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillView)
end

function slot0.openSkillLvUpView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6SkillLvUpView, {
		skillType = slot1
	})
end

function slot0.openResultPanel(slot0, slot1)
	ViewMgr.instance:openView(ViewName.VersionActivity1_6BossFightSuccView)
end

function slot0.openDungeonBossView(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102) then
		slot3, slot4 = OpenHelper.getToastIdAndParam(OpenEnum.UnlockFunc.Act_60102)

		GameFacade.showToastWithTableParam(slot3, slot4)

		return
	end

	slot0._openBossViewParam = {
		toPreEpisode = slot1
	}

	VersionActivity1_6DungeonRpc.instance:sendGet149InfoRequest(slot0._onReceiveAct149InfoReply, slot0)
end

function slot0._onReceiveAct149InfoReply(slot0)
	VersionActivity1_6DungeonRpc.instance:sendAct149GainDailyBonusRequest(slot0._afterDailyBonusOpenDungeonBossView, slot0)
end

function slot0._afterDailyBonusOpenDungeonBossView(slot0)
	slot0._openBossViewParam.showDailyBonus = VersionActivity1_6DungeonBossModel.instance:GetOpenBossViewWithDailyBonus()

	ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonBossView, slot0._openBossViewParam)
	VersionActivity1_6DungeonBossModel.instance:SetOpenBossViewWithDailyBonus(false)
end

function slot0._onCurrencyChange(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		if slot6 == CurrencyEnum.CurrencyType.V1a6DungeonSkill then
			-- Nothing
		end
	end
end

slot0.instance = slot0.New()

return slot0

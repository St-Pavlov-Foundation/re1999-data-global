module("modules.logic.fight.FightMgr", package.seeall)

slot0 = class("FightMgr", FightBaseClass)

function slot0.onInitialization(slot0)
end

function slot0.startFight(slot0, slot1, slot2)
	slot0:com_sendFightEvent(FightEvent.BeforeStartFight)
	FightDataHelper.initDataMgr()
	FightDataHelper.initFightData(slot1)
	FightDataHelper.stageMgr:enterStage(FightStageMgr.StageType.Normal)
	FightDataHelper.stageMgr:enterStage(FightStageMgr.StageType.Enter)
end

function slot0.playDouQuQu(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not slot4 then
		logError("斗蛐蛐开始战斗,但是没有传入要播放的场次")

		return
	end

	if tabletool.len(slot4) == 0 then
		logError("斗蛐蛐开始战斗,但是传入的要播放的场次是张空表")

		return
	end

	slot7 = FightDataModel.instance:initDouQuQu()

	slot7:cachePlayIndex(slot4)

	slot7.index = slot4[1]
	slot7.isRecord = slot5
	slot7.param = slot6
	slot8 = FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3)

	slot8:setDungeon(slot1, slot2)

	slot8.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function slot0.playGMDouQuQuStart(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = FightDataModel.instance:initDouQuQu()

	slot6:cachePlayIndex({
		slot4
	})

	slot6.index = slot4
	slot6.isGMStartIndex = slot4
	slot6.isGMStartRound = slot5
	slot7 = FightController.instance:setFightParamByEpisodeAndBattle(slot2, slot3)

	slot7:setDungeon(slot1, slot2)

	slot7.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function slot0.playGMDouQuQu(slot0, slot1)
	slot2 = FightDataModel.instance:initDouQuQu()

	slot2:cacheGMProto(slot1)

	slot2.isGM = true
	slot3 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	slot4 = DungeonConfig.instance:getChapterEpisodeCOList(slot3)
	slot5 = slot4[math.random(1, #slot4)]
	slot6 = slot5.id
	slot8 = FightController.instance:setFightParamByEpisodeAndBattle(slot6, slot5.battleId)

	slot8:setDungeon(slot3, slot6)

	slot8.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function slot0.reconnectFight(slot0)
end

slot0.instance = slot0.New()

return slot0

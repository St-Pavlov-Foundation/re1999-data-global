module("modules.logic.fight.FightMgr", package.seeall)

local var_0_0 = class("FightMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	return
end

function var_0_0.changeCardScript(arg_2_0, arg_2_1)
	return
end

function var_0_0.startFight(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:com_sendFightEvent(FightEvent.BeforeStartFight)
	FightDataHelper.initDataMgr()
	FightDataHelper.initFightData(arg_3_1)
	var_0_0.instance:enterStage(FightStageMgr.StageType.Normal)
	var_0_0.instance:enterStage(FightStageMgr.StageType.Play)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Enter)
end

function var_0_0.enterStage(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = FightDataMgr.instance.stageMgr:getCurStage()

	FightDataMgr.instance:enterStage(arg_4_1, arg_4_2)
	FightLocalDataMgr.instance:enterStage(arg_4_1, arg_4_2)
	arg_4_0:com_sendFightEvent(FightEvent.EnterStage, arg_4_1, arg_4_2)
	arg_4_0:com_sendFightEvent(FightEvent.StageChanged, arg_4_1, var_4_0)
end

function var_0_0.exitStage(arg_5_0, arg_5_1)
	FightDataMgr.instance:exitStage(arg_5_1)
	FightLocalDataMgr.instance:exitStage(arg_5_1)
	arg_5_0:com_sendFightEvent(FightEvent.ExitStage, arg_5_1)
	arg_5_0:com_sendFightEvent(FightEvent.StageChanged, FightDataMgr.instance.stageMgr:getCurStage(), arg_5_1)
end

function var_0_0.cancelOperation(arg_6_0)
	arg_6_0:com_sendFightEvent(FightEvent.BeforeCancelOperation)
	FightDataMgr.instance:cancelOperation()
	FightLocalDataMgr.instance:cancelOperation()
	arg_6_0:com_sendFightEvent(FightEvent.CancelOperation)
end

function var_0_0.playDouQuQu(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6)
	if not arg_7_4 then
		logError("斗蛐蛐开始战斗,但是没有传入要播放的场次")

		return
	end

	if tabletool.len(arg_7_4) == 0 then
		logError("斗蛐蛐开始战斗,但是传入的要播放的场次是张空表")

		return
	end

	local var_7_0 = FightDataModel.instance:initDouQuQu()

	var_7_0:cachePlayIndex(arg_7_4)

	var_7_0.index = arg_7_4[1]
	var_7_0.isRecord = arg_7_5
	var_7_0.param = arg_7_6

	local var_7_1 = FightController.instance:setFightParamByEpisodeAndBattle(arg_7_2, arg_7_3)

	var_7_1:setDungeon(arg_7_1, arg_7_2)

	var_7_1.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function var_0_0.playGMDouQuQuStart(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = FightDataModel.instance:initDouQuQu()

	var_8_0:cachePlayIndex({
		arg_8_4
	})

	var_8_0.index = arg_8_4
	var_8_0.isGMStartIndex = arg_8_4
	var_8_0.isGMStartRound = arg_8_5

	local var_8_1 = FightController.instance:setFightParamByEpisodeAndBattle(arg_8_2, arg_8_3)

	var_8_1:setDungeon(arg_8_1, arg_8_2)

	var_8_1.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function var_0_0.playGMDouQuQu(arg_9_0, arg_9_1)
	local var_9_0 = FightDataModel.instance:initDouQuQu()

	var_9_0:cacheGMProto(arg_9_1)

	var_9_0.isGM = true

	local var_9_1 = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.ChapterId].value)
	local var_9_2 = DungeonConfig.instance:getChapterEpisodeCOList(var_9_1)
	local var_9_3 = var_9_2[math.random(1, #var_9_2)]
	local var_9_4 = var_9_3.id
	local var_9_5 = var_9_3.battleId
	local var_9_6 = FightController.instance:setFightParamByEpisodeAndBattle(var_9_4, var_9_5)

	var_9_6:setDungeon(var_9_1, var_9_4)

	var_9_6.fightActType = FightEnum.FightActType.Act174

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		FightMsgMgr.sendMsg(FightMsgId.PlayDouQuQu, true)

		return
	end

	FightController.instance:enterFightScene()
end

function var_0_0.reconnectFight(arg_10_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0

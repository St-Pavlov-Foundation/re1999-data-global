module("modules.logic.fight.system.work.FightWorkDouQuQuGMEnter", package.seeall)

local var_0_0 = class("FightWorkDouQuQuGMEnter", FightWorkItem)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightData = FightData.New(arg_1_1)
	arg_1_0.startRound = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()
	arg_2_0:_onClearFinish()
end

function var_0_0._onClearFinish(arg_3_0)
	FightMgr.instance:startFight(arg_3_0.fightData, arg_3_0.startRound)
	FightModel.instance:updateFight(arg_3_0.fightData)
	FightModel.instance:refreshBattleId(arg_3_0.fightData)
	FightModel.instance:updateFightRound(arg_3_0.startRound)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DouQuQu)
	arg_3_0:com_registEvent(GameSceneMgr.instance, SceneType.Fight, arg_3_0._onFightSceneStart)
	arg_3_0:com_registFightEvent(FightEvent.OnStartSequenceFinish, arg_3_0._onStartSequenceFinish)
	GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
	FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
end

function var_0_0._onFightSceneStart(arg_4_0)
	FightSystem.instance:startFight()
end

function var_0_0._onStartSequenceFinish(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0

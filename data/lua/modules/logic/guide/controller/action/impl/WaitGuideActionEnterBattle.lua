module("modules.logic.guide.controller.action.impl.WaitGuideActionEnterBattle", package.seeall)

local var_0_0 = class("WaitGuideActionEnterBattle", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._battleId = tonumber(arg_1_0.actionParam)

	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_1_0._checkInBattle, arg_1_0)
	arg_1_0:_checkInBattle(GameSceneMgr.instance:getCurSceneType(), nil)
end

function var_0_0._checkInBattle(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == SceneType.Fight then
		local var_2_0 = FightModel.instance:getFightParam()

		if arg_2_0._battleId and arg_2_0._battleId == var_2_0.battleId then
			GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_2_0._checkInBattle, arg_2_0)
			arg_2_0:onDone(true)
		end
	end
end

function var_0_0.clearWork(arg_3_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, arg_3_0._checkInBattle, arg_3_0)
end

return var_0_0

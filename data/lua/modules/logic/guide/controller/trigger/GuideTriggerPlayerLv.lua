module("modules.logic.guide.controller.trigger.GuideTriggerPlayerLv", package.seeall)

local var_0_0 = class("GuideTriggerPlayerLv", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, arg_1_0._checkStartGuide, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return tonumber(arg_2_2) <= arg_2_0:getParam()
end

function var_0_0.getParam(arg_3_0)
	return PlayerModel.instance:getPlayinfo().level
end

function var_0_0._onMainScene(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 1 then
		arg_4_0:checkStartGuide()
	end
end

function var_0_0._checkStartGuide(arg_5_0)
	arg_5_0:checkStartGuide()
end

return var_0_0

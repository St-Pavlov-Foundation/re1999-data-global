module("modules.logic.guide.controller.action.impl.WaitGuideActionUseActPoint", package.seeall)

local var_0_0 = class("WaitGuideActionUseActPoint", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	FightController.instance:registerCallback(FightEvent.OnMoveHandCard, arg_1_0._OnMoveHandCard, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnPlayHandCard, arg_1_0._OnPlayHandCard, arg_1_0)
end

function var_0_0._OnPlayHandCard(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0._OnMoveHandCard(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnMoveHandCard, arg_4_0._OnMoveHandCard, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnPlayHandCard, arg_4_0._OnPlayHandCard, arg_4_0)
end

return var_0_0

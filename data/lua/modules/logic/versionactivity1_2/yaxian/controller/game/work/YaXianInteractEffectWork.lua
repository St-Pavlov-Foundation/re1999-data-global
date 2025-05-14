module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractEffectWork", package.seeall)

local var_0_0 = class("YaXianInteractEffectWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.interactItem = YaXianGameController.instance:getInteractItem(arg_1_1)
	arg_1_0.effectType = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.interactItem:showEffect(arg_2_0.effectType, arg_2_0.effectDoneCallback, arg_2_0)
end

function var_0_0.effectDoneCallback(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0.interactItem:cancelEffectTask()
end

return var_0_0

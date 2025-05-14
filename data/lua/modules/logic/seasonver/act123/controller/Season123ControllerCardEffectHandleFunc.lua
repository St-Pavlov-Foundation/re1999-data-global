module("modules.logic.seasonver.act123.controller.Season123ControllerCardEffectHandleFunc", package.seeall)

local var_0_0 = Season123Controller

function var_0_0.activeHandleFuncController()
	return
end

function var_0_0.ReduceRoundCount(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = GameUtil.getTabLen(arg_2_1) > 0

	Season123Model.instance:getActInfo(arg_2_2.actId):getStageMO(arg_2_2.stage):updateReduceEpisodeRoundState(arg_2_2.layer, var_2_0)
end

var_0_0.SpecialEffctHandleFunc = {
	[Activity123Enum.EquipCardEffect.ReduceRoundCount] = var_0_0.ReduceRoundCount
}

return var_0_0

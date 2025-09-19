module("modules.logic.survival.controller.work.SurvivalDecreeVoteBuildPlayerWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVoteBuildPlayerWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.mapCo = arg_2_1.mapCo
	arg_2_0.goBubble = arg_2_1.goBubble
end

function var_0_0.onStart(arg_3_0)
	local var_3_0 = string.splitToNumber(arg_3_0.mapCo.orderPosition, ",")
	local var_3_1 = arg_3_0.mapCo.toward
	local var_3_2 = SurvivalMapHelper.instance:getShelterEntity(SurvivalEnum.ShelterUnitType.Player, 0)

	if var_3_2 then
		var_3_2:setPosAndDir(SurvivalHexNode.New(var_3_0[1], var_3_0[2]), var_3_1)
		arg_3_0:buildBubble(var_3_2)
	end

	arg_3_0:onBuildFinish()
end

function var_0_0.buildBubble(arg_4_0, arg_4_1)
	arg_4_0.playerBubble = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0.goBubble, SurvivalDecreeVoteUIItem, arg_4_1.go)
end

function var_0_0.clearBubble(arg_5_0)
	if arg_5_0.playerBubble then
		arg_5_0.playerBubble:dispose()

		arg_5_0.playerBubble = nil
	end
end

function var_0_0.onBuildFinish(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:clearBubble()
	var_0_0.super.onDestroy(arg_7_0)
end

return var_0_0

module("modules.logic.survival.controller.work.SummaryAct.SurvivalSummaryActBuildPlayerWork", package.seeall)

local var_0_0 = class("SurvivalSummaryActBuildPlayerWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.goBubble = arg_2_1.goBubble
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.playerEntity = SurvivalMapHelper.instance:getScene().actProgress.playerEntity

	arg_3_0:buildBubble(arg_3_0.playerEntity)
	arg_3_0:onDone(true)
end

function var_0_0.setPos(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0, var_4_1, var_4_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_4_1, arg_4_2)

	transformhelper.setLocalPos(arg_4_0.playerEntity.trans, var_4_0, var_4_1, var_4_2)
	transformhelper.setLocalRotation(arg_4_0.playerEntity.trans, 0, arg_4_3 * 60, 0)
end

function var_0_0.buildBubble(arg_5_0, arg_5_1)
	arg_5_0.playerBubble = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0.goBubble, SurvivalDecreeVoteUIItem, arg_5_1.go)

	AudioMgr.instance:trigger(AudioEnum3_1.Survival.ui_mingdi_tansuo_talks_eject)
end

function var_0_0.clearBubble(arg_6_0)
	if arg_6_0.playerBubble then
		arg_6_0.playerBubble:dispose()

		arg_6_0.playerBubble = nil
	end
end

function var_0_0.onDestroy(arg_7_0)
	gohelper.destroy(arg_7_0.playerEntity.go)

	arg_7_0.playerEntity = nil

	arg_7_0:clearBubble()
	var_0_0.super.onDestroy(arg_7_0)
end

return var_0_0

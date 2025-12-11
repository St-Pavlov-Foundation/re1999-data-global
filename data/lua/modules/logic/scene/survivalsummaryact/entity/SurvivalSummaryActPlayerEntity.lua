module("modules.logic.scene.survivalsummaryact.entity.SurvivalSummaryActPlayerEntity", package.seeall)

local var_0_0 = class("SurvivalSummaryActPlayerEntity", LuaCompBase)

function var_0_0.Create(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.create3d(arg_1_2, tostring(arg_1_0))
	local var_1_1 = {
		pos = arg_1_0,
		dir = arg_1_1
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0, var_1_1)
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0.pos = arg_2_1.pos
	arg_2_0.dir = arg_2_1.dir
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0.trans = arg_3_1.transform

	local var_3_0 = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.PlayerRes)
	local var_3_1 = SurvivalMapHelper.instance:getScene().preloader:getRes(var_3_0)

	arg_3_0.goModel = gohelper.clone(var_3_1, arg_3_1)

	arg_3_0:_onResLoadEnd()
end

function var_0_0._onResLoadEnd(arg_4_0)
	arg_4_0._anim = gohelper.findChildAnim(arg_4_0.go, "")

	arg_4_0:playAnim("idle")

	local var_4_0, var_4_1, var_4_2 = SurvivalHelper.instance:hexPointToWorldPoint(arg_4_0.pos.q, arg_4_0.pos.r)

	transformhelper.setLocalPos(arg_4_0.trans, var_4_0, var_4_1, var_4_2)
	transformhelper.setLocalRotation(arg_4_0.trans, 0, arg_4_0.dir * 60, 0)
end

function var_0_0.playAnim(arg_5_0, arg_5_1)
	arg_5_0._curAnimName = arg_5_1

	if arg_5_0._anim and arg_5_0._anim.isActiveAndEnabled then
		arg_5_0._anim:Play(arg_5_1, 0, 0)
	end
end

return var_0_0

module("modules.logic.survival.view.map.comp.SurvivalEndPart", package.seeall)

local var_0_0 = class("SurvivalEndPart", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1.view
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goDefaultBg = gohelper.findChild(arg_2_1, "#simage_FullBG")
	arg_2_0.txtDefaultTime = gohelper.findChildTextMesh(arg_2_0.goDefaultBg, "image_LimitTimeBG/#txt_LimitTime")
	arg_2_0.goEndBg = gohelper.findChild(arg_2_1, "#simage_FullBG2")
	arg_2_0.txtEndTime = gohelper.findChildTextMesh(arg_2_0.goEndBg, "image_LimitTimeBG/#txt_LimitTime")
	arg_2_0.goSpecialBg = gohelper.findChild(arg_2_0.goEndBg, "#simage_Character1")
end

function var_0_0.refreshView(arg_3_0)
	local var_3_0 = arg_3_0:isFailEnd()

	gohelper.setActive(arg_3_0.goDefaultBg, var_3_0)
	gohelper.setActive(arg_3_0.goEndBg, not var_3_0)

	if not var_3_0 then
		arg_3_0.view._txtLimitTime = arg_3_0.txtEndTime

		local var_3_1 = arg_3_0:isSpecialEnd()

		gohelper.setActive(arg_3_0.goSpecialBg, var_3_1)
	else
		arg_3_0.view._txtLimitTime = arg_3_0.txtDefaultTime
	end
end

function var_0_0.isFailEnd(arg_4_0)
	local var_4_0 = arg_4_0:getEndConfig()

	return not var_4_0 or var_4_0.type == 1
end

function var_0_0.isSpecialEnd(arg_5_0)
	local var_5_0 = arg_5_0:getEndConfig()

	return var_5_0 and var_5_0.type == 3
end

function var_0_0.getEndConfig(arg_6_0)
	local var_6_0 = SurvivalModel.instance:getOutSideInfo()
	local var_6_1 = var_6_0 and var_6_0:getEndId() or 0

	return lua_survival_end.configDict[var_6_1]
end

function var_0_0.onDestroy(arg_7_0)
	return
end

return var_0_0

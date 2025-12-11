module("modules.logic.versionactivity3_1.gaosiniao.work.view.GaoSiNiaoViewFlowBase", package.seeall)

local var_0_0 = class("GaoSiNiaoViewFlowBase", GaoSiNiaoFlowSequence_Base)

function var_0_0.ctor(arg_1_0, ...)
	var_0_0.super.ctor(arg_1_0, ...)
end

function var_0_0.start(arg_2_0, arg_2_1)
	arg_2_0:reset()
	arg_2_0:setViewObj(arg_2_1)
	var_0_0.super.start(arg_2_0)
end

function var_0_0.setViewObj(arg_3_0, arg_3_1)
	arg_3_0._viewObj = assert(arg_3_1)
end

function var_0_0.viewObj(arg_4_0)
	return arg_4_0._viewObj
end

function var_0_0.baseViewContainer(arg_5_0)
	if type(arg_5_0._viewObj.baseViewContainer) == "function" then
		return arg_5_0._viewObj:baseViewContainer()
	end

	return arg_5_0._viewObj.viewContainer
end

function var_0_0.gameObject(arg_6_0)
	return arg_6_0._viewObj.viewGO
end

function var_0_0.transform(arg_7_0)
	return arg_7_0:gameObject().transform
end

function var_0_0.setActive(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0:gameObject(), arg_8_1)
end

return var_0_0

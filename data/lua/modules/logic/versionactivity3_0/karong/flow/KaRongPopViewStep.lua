module("modules.logic.versionactivity3_0.karong.flow.KaRongPopViewStep", package.seeall)

local var_0_0 = class("KaRongPopViewStep", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	if not string.nilorempty(arg_1_1.param) then
		arg_1_0.viewParam = string.splitToNumber(arg_1_1.param, "#")[1]
	end
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)

	if not arg_2_0.viewParam then
		logError("请检查弹窗效果配置,参数格式错误")
		arg_2_0:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.KaRongRoleTagView, arg_2_0.viewParam)
end

function var_0_0.onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.KaRongRoleTagView then
		arg_3_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0.viewParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0.onCloseViewFinish, arg_4_0)
end

return var_0_0

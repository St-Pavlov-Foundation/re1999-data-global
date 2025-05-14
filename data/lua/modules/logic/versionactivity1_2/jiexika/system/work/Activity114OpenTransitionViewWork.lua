module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114OpenTransitionViewWork", package.seeall)

local var_0_0 = class("Activity114OpenTransitionViewWork", Activity114OpenViewWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._transitionId = arg_1_1
end

function var_0_0.getTransitionId(arg_2_0)
	return arg_2_0._transitionId
end

function var_0_0.onStart(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0:getTransitionId()

	if not var_3_0 then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0.context.transitionId = var_3_0

	local var_3_1, var_3_2 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, arg_3_0.context.transitionId)

	if string.nilorempty(var_3_2) then
		arg_3_0.context.transitionId = nil

		arg_3_0:onDone(true)

		return
	end

	arg_3_0._viewName = ViewName.Activity114TransitionView

	var_0_0.super.onStart(arg_3_0, arg_3_1)
end

return var_0_0

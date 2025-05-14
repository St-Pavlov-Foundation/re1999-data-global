module("modules.logic.main.controller.work.MainPatFaceWork", package.seeall)

local var_0_0 = class("MainPatFaceWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	PatFaceController.instance:registerCallback(PatFaceEvent.FinishAllPatFace, arg_1_0._onFinishAllPatFace, arg_1_0)

	local var_1_0 = PatFaceEnum.patFaceType.Login

	if arg_1_1 and arg_1_1.dailyRefresh then
		var_1_0 = PatFaceEnum.patFaceType.NewDay
	end

	if not PatFaceController.instance:startPatFace(var_1_0) then
		arg_1_0:onDone(true)
	end
end

function var_0_0._onFinishAllPatFace(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	PatFaceController.instance:unregisterCallback(PatFaceEvent.FinishAllPatFace, arg_3_0._onFinishAllPatFace, arg_3_0)
end

return var_0_0

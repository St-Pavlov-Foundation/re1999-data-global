module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseSubView", package.seeall)

local var_0_0 = class("VersionActivityEnterBaseSubView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0._editableInitView(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	local var_3_0 = arg_3_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if var_3_0 then
		var_3_0:Play(UIAnimationName.Open, 0, 0)
	end

	arg_3_0:everySecondCall()
	arg_3_0:beginPerSecondRefresh()
end

function var_0_0.onOpenFinish(arg_4_0)
	return
end

function var_0_0.onEnterVideoFinished(arg_5_0)
	arg_5_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play(UIAnimationName.Open, 0, 0)
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.everySecondCall, arg_6_0)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:everySecondCall()
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

function var_0_0.beginPerSecondRefresh(arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0.everySecondCall, arg_9_0, 1)
end

function var_0_0.everySecondCall(arg_10_0)
	return
end

return var_0_0

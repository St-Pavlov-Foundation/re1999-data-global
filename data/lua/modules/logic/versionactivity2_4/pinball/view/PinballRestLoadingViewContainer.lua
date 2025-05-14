module("modules.logic.versionactivity2_4.pinball.view.PinballRestLoadingViewContainer", package.seeall)

local var_0_0 = class("PinballRestLoadingViewContainer", PinballLoadingViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {}
end

function var_0_0.onContainerOpen(arg_2_0, ...)
	var_0_0.super.onContainerOpen(arg_2_0, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio10)

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "bg/#txt_dec")
	local var_2_1 = gohelper.findChild(arg_2_0.viewGO, "bg/#txt_dec2")

	gohelper.setActive(var_2_0, PinballModel.instance.restCdDay <= 0)
	gohelper.setActive(var_2_1, PinballModel.instance.restCdDay > 0)

	arg_2_0._openDt = UnityEngine.Time.realtimeSinceStartup
end

function var_0_0.onContainerClickModalMask(arg_3_0)
	if not arg_3_0._openDt or UnityEngine.Time.realtimeSinceStartup - arg_3_0._openDt > 1 then
		arg_3_0:closeThis()
	end
end

function var_0_0.onContainerClose(arg_4_0, ...)
	var_0_0.super.onContainerClose(arg_4_0, ...)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio11)
end

return var_0_0

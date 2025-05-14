module("modules.logic.versionactivity1_7.v1a7_warmup.view.VersionActivity1_7WarmUpViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_7WarmUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_7WarmUpView.New(),
		VersionActivity1_7WarmUpMapView.New()
	}
end

function var_0_0.isPlayingDesc(arg_2_0)
	return arg_2_0._isPlayingDesc
end

function var_0_0.setIsPlayingDesc(arg_3_0, arg_3_1)
	arg_3_0._isPlayingDesc = arg_3_1
end

return var_0_0

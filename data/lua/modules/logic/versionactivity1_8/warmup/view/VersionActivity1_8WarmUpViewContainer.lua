module("modules.logic.versionactivity1_8.warmup.view.VersionActivity1_8WarmUpViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8WarmUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_8WarmUpView.New(),
		Act1_8WarmUpLeftView.New()
	}
end

function var_0_0.isPlayingDesc(arg_2_0)
	return arg_2_0._isPlayingDesc
end

function var_0_0.setIsPlayingDesc(arg_3_0, arg_3_1)
	arg_3_0._isPlayingDesc = arg_3_1
end

return var_0_0

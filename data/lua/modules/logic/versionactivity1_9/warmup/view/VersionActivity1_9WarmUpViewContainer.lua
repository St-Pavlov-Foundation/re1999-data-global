module("modules.logic.versionactivity1_9.warmup.view.VersionActivity1_9WarmUpViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_9WarmUpViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, VersionActivity1_9WarmUpView.New())

	return var_1_0
end

function var_0_0.isPlayingDesc(arg_2_0)
	return arg_2_0._isPlayingDesc
end

function var_0_0.setIsPlayingDesc(arg_3_0, arg_3_1)
	arg_3_0._isPlayingDesc = arg_3_1
end

return var_0_0

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffTipViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffTipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.buffTipView = VersionActivity1_3BuffTipView.New()

	return {
		arg_1_0.buffTipView
	}
end

return var_0_0

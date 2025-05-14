module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3FairyLandViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_3FairyLandViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0.buffView = VersionActivity1_3FairyLandView.New()

	return {
		arg_1_0.buffView
	}
end

return var_0_0

module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterViewContainer", package.seeall)

local var_0_0 = class("BGMSwitchMusicFilterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BGMSwitchMusicFilterView.New()
	}
end

return var_0_0

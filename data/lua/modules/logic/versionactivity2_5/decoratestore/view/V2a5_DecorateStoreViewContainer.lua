module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreViewContainer", package.seeall)

local var_0_0 = class("V2a5_DecorateStoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a5_DecorateStoreView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return var_0_0

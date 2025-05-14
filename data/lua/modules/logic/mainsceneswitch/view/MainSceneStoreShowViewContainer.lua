module("modules.logic.mainsceneswitch.view.MainSceneStoreShowViewContainer", package.seeall)

local var_0_0 = class("MainSceneStoreShowViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, MainSceneStoreShowView.New())

	return var_1_0
end

return var_0_0

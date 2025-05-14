module("modules.logic.gm.view.GMPostProcessViewContainer", package.seeall)

local var_0_0 = class("GMPostProcessViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "scroll/item"
	var_1_1.cellClass = GMPostProcessItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV

	table.insert(var_1_0, LuaMixScrollView.New(GMPostProcessModel.instance, var_1_1))
	table.insert(var_1_0, GMPostProcessView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0

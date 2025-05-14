module("modules.logic.effect.view.EffectStatViewContainer", package.seeall)

local var_0_0 = class("EffectStatViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "view/scroll"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "view/scroll/item"
	var_1_1.cellClass = EffectStatItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.cellWidth = 744
	var_1_1.cellHeight = 45
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0

	table.insert(var_1_0, LuaListScrollView.New(EffectStatModel.instance, var_1_1))
	table.insert(var_1_0, EffectStatView.New())
	table.insert(var_1_0, ToggleListView.New(1, "view/toggles"))

	return var_1_0
end

function var_0_0.onContainerInit(arg_2_0)
	arg_2_0:registerCallback(ViewEvent.ToSwitchTab, arg_2_0._toSwitchTab, arg_2_0)
end

function var_0_0.onContainerDestroy(arg_3_0)
	arg_3_0:unregisterCallback(ViewEvent.ToSwitchTab, arg_3_0._toSwitchTab, arg_3_0)
end

function var_0_0._toSwitchTab(arg_4_0, arg_4_1, arg_4_2)
	EffectStatModel.instance:switchTab(arg_4_2)
end

return var_0_0

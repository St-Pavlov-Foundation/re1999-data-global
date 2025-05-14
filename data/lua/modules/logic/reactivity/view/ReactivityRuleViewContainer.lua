module("modules.logic.reactivity.view.ReactivityRuleViewContainer", package.seeall)

local var_0_0 = class("ReactivityRuleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = ListScrollParam.New()

	var_1_1.scrollGOPath = "object/#scroll_rule"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromView
	var_1_1.prefabUrl = "object/#scroll_rule/Viewport/Content/#ruleitem"
	var_1_1.cellClass = ReactivityRuleItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 3
	var_1_1.cellWidth = 490
	var_1_1.cellHeight = 172
	var_1_1.cellSpaceH = 0
	var_1_1.cellSpaceV = 0
	var_1_1.startSpace = 10

	table.insert(var_1_0, LuaListScrollView.New(ReactivityRuleModel.instance, var_1_1))
	table.insert(var_1_0, ReactivityRuleView.New())

	return var_1_0
end

function var_0_0.onContainerClickModalMask(arg_2_0)
	arg_2_0:closeThis()
end

return var_0_0

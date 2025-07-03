module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceViewContainer", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_rule"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = V2a7_SelfSelectSix_PickChoiceItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.startSpace = 0
	var_1_1.endSpace = 30
	arg_1_0._csScrollView = LuaMixScrollView.New(V2a7_SelfSelectSix_PickChoiceListModel.instance, var_1_1)

	table.insert(var_1_0, V2a7_SelfSelectSix_PickChoiceView.New())
	table.insert(var_1_0, arg_1_0._csScrollView)

	return var_1_0
end

return var_0_0

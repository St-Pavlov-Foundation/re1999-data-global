module("modules.logic.versionactivity2_8.act199.view.V2a8_SelfSelectSix_PickChoiceViewContainer", package.seeall)

local var_0_0 = class("V2a8_SelfSelectSix_PickChoiceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = MixScrollParam.New()

	var_1_1.scrollGOPath = "#scroll_rule"
	var_1_1.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_1.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_1.cellClass = V2a8_SelfSelectSix_PickChoiceItem
	var_1_1.scrollDir = ScrollEnum.ScrollDirV
	var_1_1.lineCount = 1
	var_1_1.startSpace = 0
	var_1_1.endSpace = 30
	arg_1_0._csScrollView = LuaMixScrollView.New(V2a8_SelfSelectSix_PickChoiceListModel.instance, var_1_1)

	table.insert(var_1_0, V2a8_SelfSelectSix_PickChoiceView.New())
	table.insert(var_1_0, arg_1_0._csScrollView)

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0

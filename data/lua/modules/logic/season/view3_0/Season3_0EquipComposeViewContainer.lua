module("modules.logic.season.view3_0.Season3_0EquipComposeViewContainer", package.seeall)

local var_0_0 = class("Season3_0EquipComposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:createEquipItemsParam()
	local var_1_1 = Season3_0EquipTagSelect2.New()

	var_1_1:init(Activity104EquipComposeController.instance, "left/#drop_filter", "left/#drop_filter2")

	return {
		Season3_0EquipComposeView.New(),
		var_1_1,
		LuaListScrollView.New(Activity104EquipItemComposeModel.instance, var_1_0),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "left/mask/#scroll_cardlist"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season3_0EquipComposeItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = Season3_0EquipComposeItem.ColumnCount
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 8.48
	var_2_0.cellSpaceV = 1
	var_2_0.frameUpdateMs = 100
	var_2_0.minUpdateCountInFrame = Season3_0EquipComposeItem.ColumnCount

	return var_2_0
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0._navigateButtonView
		}
	end
end

function var_0_0.playCloseTransition(arg_4_0)
	arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_4_0.delayOnPlayCloseAnim, arg_4_0, 0.2)
end

function var_0_0.delayOnPlayCloseAnim(arg_5_0)
	arg_5_0:onPlayCloseTransitionFinish()
end

return var_0_0

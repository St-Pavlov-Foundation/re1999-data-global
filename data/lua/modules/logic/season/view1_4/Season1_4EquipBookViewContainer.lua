module("modules.logic.season.view1_4.Season1_4EquipBookViewContainer", package.seeall)

local var_0_0 = class("Season1_4EquipBookViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = arg_1_0:createEquipItemsParam()
	local var_1_1 = Season1_4EquipFloatTouch.New()

	var_1_1:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	local var_1_2 = Season1_4EquipTagSelect.New()

	var_1_2:init(Activity104EquipBookController.instance, "right/#drop_filter")

	return {
		Season1_4EquipBookView.New(),
		var_1_1,
		var_1_2,
		LuaListScrollView.New(Activity104EquipItemBookModel.instance, var_1_0),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "right/mask/#scroll_cardlist"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season1_4EquipBookItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = Season1_4EquipBookItem.ColumnCount
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 8.2
	var_2_0.cellSpaceV = 1.74
	var_2_0.frameUpdateMs = 100
	var_2_0.minUpdateCountInFrame = Season1_4EquipBookItem.ColumnCount

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

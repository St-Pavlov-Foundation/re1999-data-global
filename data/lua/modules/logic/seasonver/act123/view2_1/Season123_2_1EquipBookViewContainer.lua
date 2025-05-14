module("modules.logic.seasonver.act123.view2_1.Season123_2_1EquipBookViewContainer", package.seeall)

local var_0_0 = class("Season123_2_1EquipBookViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0:createEquipItemsParam()

	local var_1_0 = Season123_2_1EquipFloatTouch.New()

	var_1_0:init("left/#go_target/#go_ctrl", "left/#go_target/#go_touch")

	local var_1_1 = Season123_2_1EquipTagSelect.New()

	var_1_1:init(Season123EquipBookController.instance, "right/#drop_filter")

	return {
		Season123_2_1EquipBookView.New(),
		var_1_0,
		var_1_1,
		arg_1_0.scrollView,
		TabViewGroup.New(1, "#go_btns"),
		TabViewGroup.New(2, "right/#go_righttop")
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "right/mask/#scroll_cardlist"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season123_2_1EquipBookItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = Season123_2_1EquipBookItem.ColumnCount
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 8.2
	var_2_0.cellSpaceV = 1.74
	var_2_0.frameUpdateMs = 100
	var_2_0.minUpdateCountInFrame = Season123_2_1EquipBookItem.ColumnCount
	arg_2_0.scrollView = LuaListScrollView.New(Season123EquipBookModel.instance, var_2_0)
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

	if arg_3_1 == 2 then
		local var_3_0 = Season123Model.instance:getCurSeasonId()
		local var_3_1 = CurrencyView.New({
			Season123Config.instance:getEquipItemCoin(var_3_0, Activity123Enum.Const.EquipItemCoin)
		})

		var_3_1.foreHideBtn = true

		return {
			var_3_1
		}
	end
end

function var_0_0.playCloseTransition(arg_4_0)
	ZProj.ProjAnimatorPlayer.Get(arg_4_0.viewGO):Play(UIAnimationName.Close, arg_4_0.onCloseAnimDone, arg_4_0)
end

function var_0_0.onCloseAnimDone(arg_5_0)
	arg_5_0:onPlayCloseTransitionFinish()
end

return var_0_0

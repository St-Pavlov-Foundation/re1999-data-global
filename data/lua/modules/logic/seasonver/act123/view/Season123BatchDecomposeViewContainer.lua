module("modules.logic.seasonver.act123.view.Season123BatchDecomposeViewContainer", package.seeall)

local var_0_0 = class("Season123BatchDecomposeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	arg_1_0:createEquipItemsParam()

	return {
		Season123BatchDecomposeView.New(),
		arg_1_0.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns"),
		TabViewGroup.New(2, "#go_righttop")
	}
end

function var_0_0.createEquipItemsParam(arg_2_0)
	local var_2_0 = ListScrollParam.New()

	var_2_0.scrollGOPath = "left_container/#go_scrollcontainer/#scroll_equip"
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[1]
	var_2_0.cellClass = Season123DecomposeItem
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = arg_2_0:getLineCount()
	var_2_0.cellWidth = 170
	var_2_0.cellHeight = 235
	var_2_0.cellSpaceH = 8.48
	var_2_0.cellSpaceV = 1
	var_2_0.frameUpdateMs = 100
	var_2_0.minUpdateCountInFrame = SeasonEquipComposeItem.ColumnCount
	arg_2_0.scrollView = LuaListScrollView.New(Season123DecomposeModel.instance, var_2_0)
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

function var_0_0.getLineCount(arg_4_0)
	local var_4_0 = gohelper.findChildComponent(arg_4_0.viewGO, "left_container/#go_scrollcontainer", gohelper.Type_Transform)
	local var_4_1 = recthelper.getWidth(var_4_0)

	return math.floor(var_4_1 / 178.48)
end

function var_0_0.playCloseTransition(arg_5_0)
	ZProj.ProjAnimatorPlayer.Get(arg_5_0.viewGO):Play(UIAnimationName.Close, arg_5_0.onCloseAnimDone, arg_5_0)
end

function var_0_0.onCloseAnimDone(arg_6_0)
	arg_6_0:onPlayCloseTransitionFinish()
end

return var_0_0

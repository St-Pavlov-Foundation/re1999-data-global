module("modules.logic.bossrush.view.v1a6.taskachievement.V1a6_BossRush_BonusViewContainer", package.seeall)

local var_0_0 = class("V1a6_BossRush_BonusViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, V1a6_BossRush_TabViewGroup.New(2, "#go_bonus"))
	table.insert(var_1_0, V1a6_BossRush_BonusView.New())

	return var_1_0
end

function var_0_0._getTabView(arg_2_0, arg_2_1)
	local var_2_0 = ListScrollParam.New()

	var_2_0.cellClass = arg_2_1.CellClass
	var_2_0.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_2_0.prefabUrl = arg_2_0._viewSetting.otherRes[arg_2_1.ResIndex]
	var_2_0.scrollGOPath = "Right/#scroll_ScoreList"
	var_2_0.scrollDir = ScrollEnum.ScrollDirV
	var_2_0.lineCount = 1
	var_2_0.cellWidth = 964
	var_2_0.cellHeight = 162
	var_2_0.cellSpaceH = 0
	var_2_0.cellSpaceV = 0
	var_2_0.startSpace = 0
	var_2_0.sortMode = ScrollEnum.ScrollSortDown

	local var_2_1 = LuaListScrollViewWithAnimator.New(arg_2_1.ListModel, var_2_0, arg_2_0.delayTimes)
	local var_2_2 = arg_2_1.ViewClass.New()
	local var_2_3 = MultiView.New({
		var_2_2,
		var_2_1
	})

	return {
		viewClass = var_2_2,
		scrollView = var_2_1,
		multiView = var_2_3
	}
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		arg_3_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_3_0.navigationView
		}
	elseif arg_3_1 == 2 then
		arg_3_0.delayTimes = {}

		for iter_3_0 = 1, 10 do
			local var_3_0 = (iter_3_0 - 1) * 0.07

			arg_3_0.delayTimes[iter_3_0] = var_3_0
		end

		arg_3_0._tabView = {}

		local var_3_1 = BossRushModel.instance:getActivityBonus()
		local var_3_2 = {}

		for iter_3_1, iter_3_2 in pairs(var_3_1) do
			local var_3_3 = arg_3_0:_getTabView(iter_3_2)

			arg_3_0._tabView[iter_3_1] = var_3_3

			table.insert(var_3_2, var_3_3.multiView)
		end

		return var_3_2
	end
end

function var_0_0.getScrollAnimRemoveItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._tabView[arg_4_1]

	if var_4_0 and var_4_0.scrollView and not gohelper.isNil(var_4_0.scrollView._csListScroll) then
		return ListScrollAnimRemoveItem.Get(var_4_0.scrollView)
	end
end

function var_0_0.getTabView(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._tabView[arg_5_1]

	return var_5_0 and var_5_0.viewClass
end

function var_0_0.selectTabView(arg_6_0, arg_6_1)
	V1a6_BossRush_BonusModel.instance:setTab(arg_6_1)
	arg_6_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_6_1)
end

return var_0_0

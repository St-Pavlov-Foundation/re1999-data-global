module("modules.logic.dungeon.view.DungeonViewContainer", package.seeall)

local var_0_0 = class("DungeonViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = TabViewGroupDynamic.New(2)

	var_1_1:stopOpenDefaultTab(true)
	var_1_1:setDynamicNodeContainers({
		"#go_weekwalk",
		"#go_explore",
		"#go_permanent"
	})
	var_1_1:setDynamicNodeResHandlers({
		[2] = var_0_0._getExploreRes
	})
	table.insert(var_1_0, var_1_1)

	arg_1_0._dungeonViewAudio = DungeonViewAudio.New()

	table.insert(var_1_0, arg_1_0._dungeonViewAudio)
	table.insert(var_1_0, DungeonView.New())

	local var_1_2 = MixScrollParam.New()

	var_1_2.scrollGOPath = "#go_story/chapterlist/#scroll_chapter"
	var_1_2.prefabType = ScrollEnum.ScrollPrefabFromRes
	var_1_2.prefabUrl = arg_1_0._viewSetting.otherRes[1]
	var_1_2.cellClass = DungeonChapterItem
	var_1_2.scrollDir = ScrollEnum.ScrollDirH
	var_1_2.startSpace = 147.5
	var_1_2.endSpace = 0
	arg_1_0._scrollParam = var_1_2
	arg_1_0._scrollView = LuaMixScrollView.New(DungeonChapterListModel.instance, var_1_2)

	arg_1_0._scrollView:setDynamicGetItem(arg_1_0._dynamicGetItem, arg_1_0)
	table.insert(var_1_0, arg_1_0._scrollView)
	table.insert(var_1_0, TabViewGroup.New(1, "top_left"))
	table.insert(var_1_0, DungeonResourceView.New())
	table.insert(var_1_0, DungeonViewEffect.New())
	table.insert(var_1_0, DungeonViewPointReward.New())

	return var_1_0
end

function var_0_0._getExploreRes()
	local var_2_0, var_2_1, var_2_2 = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())
	local var_2_3 = ExploreSimpleModel.instance:isChapterFinish(var_2_2) and "level/levelbg" .. var_2_0 .. "_1" or "level/levelbg" .. var_2_0

	return {
		ResUrl.getExploreBg(var_2_3)
	}
end

function var_0_0._dynamicGetItem(arg_3_0, arg_3_1)
	if arg_3_1 and DungeonModel.instance:isSpecialMainPlot(arg_3_1.id) then
		return "mini_item", DungeonChapterMiniItem, arg_3_0._viewSetting.otherRes.mini_item
	end
end

function var_0_0.onContainerOpen(arg_4_0)
	return
end

function var_0_0.getScrollView(arg_5_0)
	return arg_5_0._scrollView
end

function var_0_0.getScrollParam(arg_6_0)
	return arg_6_0._scrollParam
end

function var_0_0.getItemSpace(arg_7_0)
	local var_7_0 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")
	local var_7_1 = recthelper.getWidth(var_7_0.transform) / recthelper.getHeight(var_7_0.transform)

	if var_7_1 >= 2.2 then
		return 16
	elseif var_7_1 >= 2 then
		return 8
	else
		return 0
	end
end

function var_0_0.buildTabViews(arg_8_0, arg_8_1)
	if arg_8_1 == 1 then
		arg_8_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, arg_8_0._closeCallback, nil, nil, arg_8_0)

		return {
			arg_8_0._navigateButtonView
		}
	elseif arg_8_1 == 2 then
		arg_8_0._exploreView = DungeonExploreView.New()

		return {
			DungeonWeekWalkView.New(),
			arg_8_0._exploreView,
			PermanentMainView.New()
		}
	end
end

function var_0_0.getExploreView(arg_9_0)
	return arg_9_0._exploreView
end

function var_0_0.switchTab(arg_10_0, arg_10_1)
	arg_10_0:dispatchEvent(ViewEvent.ToSwitchTab, 2, arg_10_1)
end

function var_0_0.onContainerOpenFinish(arg_11_0)
	arg_11_0._navigateButtonView:resetOnCloseViewAudio()
end

function var_0_0.setOverrideClose(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._navigateButtonView:setOverrideClose(arg_12_1, arg_12_2)
end

function var_0_0._closeCallback(arg_13_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		if ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	elseif not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function var_0_0.setNavigateButtonViewLight(arg_14_0, arg_14_1)
	if arg_14_0._navigateButtonView then
		arg_14_0._navigateButtonView:setLight(arg_14_1)
	end
end

function var_0_0.setNavigateButtonViewHelpId(arg_15_0)
	if arg_15_0._navigateButtonView then
		arg_15_0._navigateButtonView:setHelpId(HelpEnum.HelpId.WeekWalk)
	end
end

function var_0_0.resetNavigateButtonViewHelpId(arg_16_0)
	if arg_16_0._navigateButtonView then
		arg_16_0._navigateButtonView:hideHelpIcon()
	end
end

return var_0_0

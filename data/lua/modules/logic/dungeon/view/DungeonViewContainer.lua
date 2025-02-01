module("modules.logic.dungeon.view.DungeonViewContainer", package.seeall)

slot0 = class("DungeonViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = TabViewGroupDynamic.New(2)

	slot2:stopOpenDefaultTab(true)
	slot2:setDynamicNodeContainers({
		"#go_weekwalk",
		"#go_explore",
		"#go_permanent"
	})
	slot2:setDynamicNodeResHandlers({
		[2] = uv0._getExploreRes
	})
	table.insert(slot1, slot2)

	slot0._dungeonViewAudio = DungeonViewAudio.New()

	table.insert(slot1, slot0._dungeonViewAudio)
	table.insert(slot1, DungeonView.New())

	slot3 = MixScrollParam.New()
	slot3.scrollGOPath = "#go_story/chapterlist/#scroll_chapter"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot3.prefabUrl = slot0._viewSetting.otherRes[1]
	slot3.cellClass = DungeonChapterItem
	slot3.scrollDir = ScrollEnum.ScrollDirH
	slot3.startSpace = 147.5
	slot3.endSpace = 0
	slot0._scrollParam = slot3
	slot0._scrollView = LuaMixScrollView.New(DungeonChapterListModel.instance, slot3)

	slot0._scrollView:setDynamicGetItem(slot0._dynamicGetItem, slot0)
	table.insert(slot1, slot0._scrollView)
	table.insert(slot1, TabViewGroup.New(1, "top_left"))
	table.insert(slot1, DungeonResourceView.New())
	table.insert(slot1, DungeonViewEffect.New())
	table.insert(slot1, DungeonViewPointReward.New())

	return slot1
end

function slot0._getExploreRes()
	slot0, slot1, slot2 = ExploreSimpleModel.instance:getChapterIndex(ExploreSimpleModel.instance:getLastSelectMap())

	return {
		ResUrl.getExploreBg(ExploreSimpleModel.instance:isChapterFinish(slot2) and "level/levelbg" .. slot0 .. "_1" or "level/levelbg" .. slot0)
	}
end

function slot0._dynamicGetItem(slot0, slot1)
	if slot1 and DungeonModel.instance:isSpecialMainPlot(slot1.id) then
		return "mini_item", DungeonChapterMiniItem, slot0._viewSetting.otherRes.mini_item
	end
end

function slot0.onContainerOpen(slot0)
end

function slot0.getScrollView(slot0)
	return slot0._scrollView
end

function slot0.getScrollParam(slot0)
	return slot0._scrollParam
end

function slot0.getItemSpace(slot0)
	slot1 = gohelper.findChild(ViewMgr.instance:getTopUIRoot(), "POPUP_TOP")

	if recthelper.getWidth(slot1.transform) / recthelper.getHeight(slot1.transform) >= 2.2 then
		return 16
	elseif slot4 >= 2 then
		return 8
	else
		return 0
	end
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, 100, slot0._closeCallback, nil, , slot0)

		return {
			slot0._navigateButtonView
		}
	elseif slot1 == 2 then
		slot0._exploreView = DungeonExploreView.New()

		return {
			DungeonWeekWalkView.New(),
			slot0._exploreView,
			PermanentMainView.New()
		}
	end
end

function slot0.getExploreView(slot0)
	return slot0._exploreView
end

function slot0.switchTab(slot0, slot1)
	slot0:dispatchEvent(ViewEvent.ToSwitchTab, 2, slot1)
end

function slot0.onContainerOpenFinish(slot0)
	slot0._navigateButtonView:resetOnCloseViewAudio()
end

function slot0.setOverrideClose(slot0, slot1, slot2)
	slot0._navigateButtonView:setOverrideClose(slot1, slot2)
end

function slot0._closeCallback(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DontOpenMain) then
		if ViewMgr.instance:isOpen(ViewName.MainView) then
			ViewMgr.instance:closeView(ViewName.MainView)
		end
	elseif not ViewMgr.instance:isOpen(ViewName.MainView) then
		ViewMgr.instance:openView(ViewName.MainView)
	end
end

function slot0.setNavigateButtonViewLight(slot0, slot1)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setLight(slot1)
	end
end

function slot0.setNavigateButtonViewHelpId(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:setHelpId(HelpEnum.HelpId.WeekWalk)
	end
end

function slot0.resetNavigateButtonViewHelpId(slot0)
	if slot0._navigateButtonView then
		slot0._navigateButtonView:hideHelpIcon()
	end
end

return slot0

module("modules.logic.activity.view.ActivityBeginnerViewContainer", package.seeall)

slot0 = class("ActivityBeginnerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_category/#scroll_categoryitem"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = ActivityCategoryItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 405
	slot2.cellHeight = 125
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 9.8
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(ActivityBeginnerCategoryListModel.instance, slot2))
	table.insert(slot1, ActivityBeginnerView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		slot0.navigationView
	}
end

slot1 = {
	[ActivityEnum.ActivityTypeID.OpenTestWarmUp] = HelpEnum.HelpId.ActivityWarmUp
}

function slot0.refreshHelp(slot0, slot1)
	if slot0.navigationView then
		if uv0[slot1] then
			slot0.navigationView:setHelpId(slot2)
		else
			slot0.navigationView:hideHelpIcon()
		end
	end
end

function slot0.hideHelp(slot0)
	if slot0.navigationView then
		slot0.navigationView:hideHelpIcon()
	end
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_common_pause)
end

return slot0

module("modules.logic.weekwalk.view.WeekWalkBuffBindingViewContainer", package.seeall)

slot0 = class("WeekWalkBuffBindingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = WeekWalkBuffBindingHeroItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 211
	slot1.cellHeight = 450
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 30

	for slot6 = 1, 15 do
	end

	return {
		LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, slot1, {
			[slot6] = math.ceil((slot6 - 1) % 5) * 0.06
		}),
		WeekWalkBuffBindingView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	slot0.navigationView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		slot0.navigationView
	}
end

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

return slot0

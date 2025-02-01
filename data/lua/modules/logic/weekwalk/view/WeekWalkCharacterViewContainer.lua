module("modules.logic.weekwalk.view.WeekWalkCharacterViewContainer", package.seeall)

slot0 = class("WeekWalkCharacterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_card"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = WeekWalkCharacterItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 300
	slot1.cellHeight = 600
	slot1.cellSpaceH = 35
	slot1.cellSpaceV = -30

	for slot6 = 1, 10 do
	end

	slot0._cardScrollView = LuaListScrollViewWithAnimator.New(WeekWalkCardListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.06
	})

	return {
		slot0._cardScrollView,
		WeekWalkCharacterView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
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

function slot0.onContainerOpenFinish(slot0)
	slot0.navigationView:resetOnCloseViewAudio(AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.playCardOpenAnimation(slot0)
	if slot0._cardScrollView then
		slot0._cardScrollView:playOpenAnimation()
	end
end

return slot0

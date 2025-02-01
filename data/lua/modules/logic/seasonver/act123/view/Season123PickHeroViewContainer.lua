module("modules.logic.seasonver.act123.view.Season123PickHeroViewContainer", package.seeall)

slot0 = class("Season123PickHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CheckCloseView.New(),
		Season123PickHeroView.New(),
		slot0:getScrollView(),
		Season123PickHeroDetailView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.getScrollView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_rolecontainer/#scroll_quickedit"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123PickHeroItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 5
	slot1.cellWidth = 200
	slot1.cellHeight = 440
	slot1.cellSpaceH = 12
	slot1.cellSpaceV = 10
	slot1.startSpace = 37

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(Season123PickHeroModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 5) * 0.03
	})
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0

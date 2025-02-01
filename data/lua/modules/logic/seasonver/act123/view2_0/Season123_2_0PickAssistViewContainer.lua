module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickAssistViewContainer", package.seeall)

slot0 = class("Season123_2_0PickAssistViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0.viewOpenAnimTime = 0.4
	slot0.scrollView = slot0:instantiateListScrollView()

	return {
		Season123_2_0PickAssistView.New(),
		slot0.scrollView,
		TabViewGroup.New(1, "#go_lefttopbtns")
	}
end

function slot0.instantiateListScrollView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_selection"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_2_0PickAssistItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 6
	slot1.cellWidth = 296
	slot1.cellHeight = 636

	for slot6 = 1, 15 do
	end

	return LuaListScrollViewWithAnimator.New(Season123PickAssistListModel.instance, slot1, {
		[slot6] = math.ceil((slot6 - 1) % 6) * 0.03 + slot0.viewOpenAnimTime
	})
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0._navigateButtonView
		}
	end
end

return slot0

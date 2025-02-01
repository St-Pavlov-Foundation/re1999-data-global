module("modules.logic.rouge.view.RougeIllustrationListViewContainer", package.seeall)

slot0 = class("RougeIllustrationListViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeIllustrationListView.New())
	table.insert(slot1, RougeScrollAudioView.New("#scroll_view"))
	table.insert(slot1, TabViewGroup.New(1, "#go_LeftTop"))

	slot2 = MixScrollParam.New()
	slot2.scrollGOPath = "#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RougeIllustrationListPage
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.endSpace = 120
	slot0._scrollView = LuaMixScrollView.New(RougeIllustrationListModel.instance, slot2)

	table.insert(slot1, slot0._scrollView)

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

return slot0

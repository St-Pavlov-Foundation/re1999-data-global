module("modules.logic.rouge.view.RougeResultReportViewContainer", package.seeall)

slot0 = class("RougeResultReportViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeResultReportView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_recordlist"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RougeResultReportItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1480
	slot2.cellHeight = 254
	slot2.cellSpaceH = 8
	slot2.cellSpaceV = 0
	slot2.startSpace = 10
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(RougeResultReportListModel.instance, slot2))

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

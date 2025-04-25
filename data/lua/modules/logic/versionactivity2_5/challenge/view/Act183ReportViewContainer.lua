module("modules.logic.versionactivity2_5.challenge.view.Act183ReportViewContainer", package.seeall)

slot0 = class("Act183ReportViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(slot1, Act183ReportView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "root/#scroll_report"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Act183ReportListItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1636
	slot2.cellHeight = 248
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 20
	slot2.startSpace = 0
	slot2.endSpace = 0

	for slot7 = 1, 4 do
	end

	table.insert(slot1, LuaListScrollViewWithAnimator.New(Act183ReportListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.03
	}))

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

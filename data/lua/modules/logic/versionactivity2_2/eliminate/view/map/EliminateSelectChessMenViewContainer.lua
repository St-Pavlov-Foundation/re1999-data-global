module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenViewContainer", package.seeall)

slot0 = class("EliminateSelectChessMenViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, EliminateSelectChessMenView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Left/#scroll_ChessList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = EliminateSelectChessMenItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 5
	slot2.cellWidth = 220
	slot2.cellHeight = 272
	slot2.startSpace = 20

	table.insert(slot1, LuaListScrollView.New(EliminateSelectChessMenListModel.instance, slot2))

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

module("modules.logic.turnback.view.TurnbackSignInViewContainer", package.seeall)

slot0 = class("TurnbackSignInViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_daylist"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = TurnbackSignInItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.lineCount = 1
	slot1.cellWidth = 200
	slot1.cellHeight = 600
	slot1.cellSpaceH = 5
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(TurnbackSignInModel.instance, slot1)
	slot0._scrollParam = slot1

	return {
		slot0._scrollView,
		TurnbackSignInView.New()
	}
end

return slot0

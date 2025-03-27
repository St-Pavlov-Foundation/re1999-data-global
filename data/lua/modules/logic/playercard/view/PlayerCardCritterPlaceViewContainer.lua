module("modules.logic.playercard.view.PlayerCardCritterPlaceViewContainer", package.seeall)

slot0 = class("PlayerCardCritterPlaceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerCardCritterPlaceView.New())
	table.insert(slot1, LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, slot0:getScrollParam1()))
	table.insert(slot1, LuaListScrollView.New(PlayerCardCritterPlaceListModel.instance, slot0:getScrollParam2()))
	table.insert(slot1, TabViewGroup.New(1, "#go_topright"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		slot0.navigateView:setOverrideClose(slot0._overrideClose, slot0)

		return {
			slot0.navigateView
		}
	end
end

function slot0.getScrollParam1(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#go_critterview1/critterscroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_critterview1/critterscroll/Viewport/#go_critterContent1/#go_critterItem"
	slot1.cellClass = PlayerCardCritterPlaceItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.cellWidth = 150
	slot1.cellHeight = 200
	slot1.cellSpaceH = 30
	slot1.startSpace = 30

	return slot1
end

function slot0.getScrollParam2(slot0)
	slot1 = "#go_critterview2/critterscroll"
	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = slot1
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "#go_critterview2/critterscroll/Viewport/#go_critterContent2/#go_critterItem"
	slot3.cellClass = PlayerCardCritterPlaceItem
	slot3.scrollDir = ScrollEnum.ScrollDirV
	slot3.cellWidth = 180
	slot3.cellHeight = 150
	slot3.lineCount = slot0:_getLineCount(slot0:_getScrollWidth(slot1), slot3.cellWidth)
	slot3.cellSpaceV = 20
	slot3.startSpace = 10

	return slot3
end

function slot0._getScrollWidth(slot0, slot1)
	if gohelper.findChildComponent(slot0.viewGO, slot1, gohelper.Type_Transform) then
		return recthelper.getWidth(slot2)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

function slot0._getLineCount(slot0, slot1, slot2)
	return math.max(math.floor(slot1 / slot2), 1)
end

return slot0

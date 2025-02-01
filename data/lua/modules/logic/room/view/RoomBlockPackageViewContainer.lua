module("modules.logic.room.view.RoomBlockPackageViewContainer", package.seeall)

slot0 = class("RoomBlockPackageViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomBlockPackageView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "middle/#scroll_detailed"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "middle/cloneItem/#go_detailedItem"
	slot2.cellClass = RoomBlockPackageDetailedItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 298
	slot2.cellHeight = 360
	slot2.cellSpaceH = 70
	slot2.cellSpaceV = 0
	slot2.startSpace = 26

	table.insert(slot1, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, slot2))

	slot7 = 0

	if math.max(math.floor((slot0:getUIScreenWidth() - 182 - 46 - 10 - 10) / 380), 1) > 1 then
		slot7 = math.max(0, (slot4 - slot5 * slot6) / slot6)
	end

	slot8 = ListScrollParam.New()
	slot8.scrollGOPath = "middle/#scroll_simple"
	slot8.prefabType = ScrollEnum.ScrollPrefabFromView
	slot8.prefabUrl = "middle/cloneItem/#go_simpleItem"
	slot8.cellClass = RoomBlockPackageSimpleItem
	slot8.scrollDir = ScrollEnum.ScrollDirV
	slot8.lineCount = slot6
	slot8.cellWidth = slot5
	slot8.cellHeight = 105
	slot8.cellSpaceH = slot7
	slot8.cellSpaceV = 10
	slot8.startSpace = 10

	table.insert(slot1, LuaListScrollView.New(RoomShowBlockPackageListModel.instance, slot8))

	return slot1
end

function slot0.getUIScreenWidth(slot0)
	if UnityEngine.GameObject.Find("UIRoot/POPUP_TOP") then
		return recthelper.getWidth(slot1.transform)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return slot0

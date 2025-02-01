module("modules.logic.room.view.RoomCharacterPlaceViewContainer", package.seeall)

slot0 = class("RoomCharacterPlaceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomCharacterPlaceView.New())
	table.insert(slot1, RoomViewTopRight.New("#go_topright", slot0._viewSetting.otherRes[2], {
		{
			classDefine = RoomViewTopRightCharacterItem
		}
	}))
	slot0:_buildCharacterPlaceListView1(slot1)
	slot0:_buildCharacterPlaceListView2(slot1)

	return slot1
end

function slot0._buildCharacterPlaceListView1(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_roleview1/rolescroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RoomCharacterPlaceItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.cellWidth = 200
	slot2.lineCount = 1
	slot2.cellHeight = 225
	slot2.cellSpaceH = slot0:_getCellSpace(slot0:_getUIScreenWidth() - 44.22 - 39.48 - 20, slot2.lineCount, slot2.cellWidth)
	slot2.cellSpaceV = 0
	slot2.startSpace = 10
	slot0._characterPlaceScrollView1 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, slot2)

	table.insert(slot1, slot0._characterPlaceScrollView1)
end

function slot0._buildCharacterPlaceListView2(slot0, slot1)
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_roleview2/rolescroll"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = RoomCharacterPlaceItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.cellWidth = 200
	slot4 = slot0:_getUIScreenWidth() - 44.22 - 39.48 - 20
	slot2.lineCount = slot0:_getLineCount(slot4, slot2.cellWidth)
	slot2.cellHeight = 205
	slot2.cellSpaceH = slot0:_getCellSpace(slot4, slot2.lineCount, slot2.cellWidth)
	slot2.cellSpaceV = 4.6
	slot2.startSpace = 10
	slot0._characterPlaceScrollView2 = LuaListScrollView.New(RoomCharacterPlaceListModel.instance, slot2)

	table.insert(slot1, slot0._characterPlaceScrollView2)
end

function slot0._getLineCount(slot0, slot1, slot2)
	return math.max(math.floor(slot1 / slot2), 1)
end

function slot0._getCellSpace(slot0, slot1, slot2, slot3)
	slot4 = 7

	if slot2 > 1 then
		slot4 = math.max(0, (slot1 - slot3 * slot2 + 48) / slot2)
	end

	return slot4
end

function slot0._getUIScreenWidth(slot0)
	if UnityEngine.GameObject.Find("UIRoot/POPUP_TOP") then
		return recthelper.getWidth(slot1.transform)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

return slot0

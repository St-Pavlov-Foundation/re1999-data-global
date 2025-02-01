module("modules.logic.room.view.common.RoomThemeFilterViewContainer", package.seeall)

slot0 = class("RoomThemeFilterViewContainer", BaseViewContainer)
slot1 = 386
slot2 = 80
slot3 = 3

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomThemeFilterView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_content/#scroll_theme"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_content/#go_themeitem"
	slot2.cellClass = RoomThemeFilterItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = uv0
	slot2.cellWidth = uv1
	slot2.cellHeight = uv2
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomThemeFilterListModel.instance, slot2))

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.getUIScreenWidth(slot0)
	if UnityEngine.GameObject.Find("UIRoot/POPUP_TOP") then
		return recthelper.getWidth(slot1.transform)
	end

	return math.floor(UnityEngine.Screen.width * 1080 / UnityEngine.Screen.height + 0.5)
end

function slot0.layoutContentTrs(slot0, slot1, slot2)
	slot3 = 1220
	slot6 = math.floor((RoomThemeFilterListModel.instance:getCount() + uv0 - 1) / uv0) * uv1 + 130 + 26

	if slot2 then
		recthelper.setAnchorX(slot1, -(slot0:getUIScreenWidth() * 0.5) + 173)
	else
		recthelper.setHeight(slot1, math.min(slot6, 605))
		recthelper.setAnchor(slot1, math.min(-slot4 + 668, slot4 - slot3 - 46), 85)
	end
end

return slot0

module("modules.logic.room.view.common.RoomThemeFilterItem", package.seeall)

slot0 = class("RoomThemeFilterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._onBtnclick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._goselect = gohelper.findChild(slot0.viewGO, "beselected")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "unselected")
	slot0._txtselectName = gohelper.findChildText(slot0.viewGO, "beselected/name")
	slot0._txtunselectName = gohelper.findChildText(slot0.viewGO, "unselected/name")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
end

function slot0._onBtnclick(slot0)
	if not slot0._themeItemMO then
		return
	end

	if RoomThemeFilterListModel.instance:isSelectById(slot0._themeItemMO.id) then
		RoomThemeFilterListModel.instance:setSelectById(slot1, false)
	else
		RoomThemeFilterListModel.instance:setSelectById(slot1, true)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function slot0._refreshUI(slot0)
	if not slot0._themeItemMO then
		return
	end

	if slot0._lastId ~= slot0._themeItemMO.id then
		slot0._lastId = slot0._themeItemMO.id
		slot0._txtselectName.text = slot0._themeItemMO.config.name
		slot0._txtunselectName.text = slot0._themeItemMO.config.name
	end

	if slot0._lastSelect ~= RoomThemeFilterListModel.instance:isSelectById(slot0._themeItemMO.id) then
		slot0._lastSelect = slot1

		gohelper.setActive(slot0._goselect, slot1)
		gohelper.setActive(slot0._gounselect, not slot1)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._themeItemMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0

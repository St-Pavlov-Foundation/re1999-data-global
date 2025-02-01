module("modules.logic.room.view.common.RoomThemeFilterView", package.seeall)

slot0 = class("RoomThemeFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._gobuildingArrow = gohelper.findChild(slot0.viewGO, "#go_content/bg/#go_buildingArrow")
	slot0._goblockpackageArrow = gohelper.findChild(slot0.viewGO, "#go_content/bg/#go_blockpackageArrow")
	slot0._goall = gohelper.findChild(slot0.viewGO, "#go_content/#go_all")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_content/#go_all/#go_selected")
	slot0._gounselected = gohelper.findChild(slot0.viewGO, "#go_content/#go_all/#go_unselected")
	slot0._btnall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#go_all/#btn_all")
	slot0._scrolltheme = gohelper.findChildScrollRect(slot0.viewGO, "#go_content/#scroll_theme")
	slot0._gothemeitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_themeitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnall:AddClickListener(slot0._btnallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnall:RemoveClickListener()
end

function slot0._btnallOnClick(slot0)
	if RoomThemeFilterListModel.instance:getIsAll() then
		RoomThemeFilterListModel.instance:clearFilterData()
	else
		RoomThemeFilterListModel.instance:selectAll()
	end

	RoomThemeFilterListModel.instance:onModelUpdate()
	RoomMapController.instance:dispatchEvent(RoomEvent.UIRoomThemeFilterChanged)
end

function slot0._editableInitView(slot0)
end

function slot0._onThemeFilterChanged(slot0)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if slot0._lastSelect ~= RoomThemeFilterListModel.instance:getIsAll() then
		slot0._lastSelect = slot1

		gohelper.setActive(slot0._goselected, slot1)
		gohelper.setActive(slot0._gounselected, not slot1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UIRoomThemeFilterChanged, slot0._onThemeFilterChanged, slot0)
	slot0:_refreshUI()

	slot1 = false

	if slot0.viewParam then
		slot1 = slot0.viewParam.isBottom
	end

	gohelper.setActive(slot0._gobuildingArrow, slot1)
	gohelper.setActive(slot0._goblockpackageArrow, not slot1)
	slot0.viewContainer:layoutContentTrs(slot0._gocontent.transform, slot1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.room.view.RoomBuildingFilterView", package.seeall)

slot0 = class("RoomBuildingFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._goraredownselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/rare/go_raredown/beselected")
	slot0._goraredownunselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/rare/go_raredown/unselected")
	slot0._gorareupselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/rare/go_rareup/beselected")
	slot0._gorareupunselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/rare/go_rareup/unselected")
	slot0._goplacedselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/beselected")
	slot0._goplacedunselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/unselected")
	slot0._gonotplacedselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/beselected")
	slot0._gonotplacedunselect = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/unselected")
	slot0._gorange = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/go_range")
	slot0._gorangeitem = gohelper.findChild(slot0.viewGO, "#scrollview/viewport/content/go_range/go_rangeitem")
	slot0._btnraredown = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scrollview/viewport/content/rare/go_raredown/click")
	slot0._btnrareup = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scrollview/viewport/content/rare/go_rareup/click")
	slot0._btnplaced = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_placed/click")
	slot0._btnnotplaced = gohelper.findChildButtonWithAudio(slot0.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnraredown:AddClickListener(slot0._btnraredownOnClick, slot0)
	slot0._btnrareup:AddClickListener(slot0._btnrareupOnClick, slot0)
	slot0._btnplaced:AddClickListener(slot0._btnplacedOnClick, slot0)
	slot0._btnnotplaced:AddClickListener(slot0._btnnotplacedOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnraredown:RemoveClickListener()
	slot0._btnrareup:RemoveClickListener()
	slot0._btnplaced:RemoveClickListener()
	slot0._btnnotplaced:RemoveClickListener()
end

function slot0._btnraredownOnClick(slot0)
	if not RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(true)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	slot0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function slot0._btnrareupOnClick(slot0)
	if RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(false)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	slot0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function slot0._btnnotplacedOnClick(slot0)
	slot0:_setFilterUse(0)
end

function slot0._btnplacedOnClick(slot0)
	slot0:_setFilterUse(1)
end

function slot0._setFilterUse(slot0, slot1)
	if RoomShowBuildingListModel.instance:isFilterUse(slot1) then
		RoomShowBuildingListModel.instance:removeFilterUse(slot1)
	else
		RoomShowBuildingListModel.instance:addFilterUse(slot1)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	slot0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function slot0._btnrangeOnClick(slot0, slot1)
	if RoomShowBuildingListModel.instance:isFilterOccupy(slot1) then
		RoomShowBuildingListModel.instance:removeFilterOccupy(slot1)
	else
		RoomShowBuildingListModel.instance:addFilterOccupy(slot1)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	slot0:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorangeitem, false)

	slot0._rangeItemList = {}

	for slot5, slot6 in ipairs(RoomConfig.instance:getBuildingOccupyList()) do
		slot7 = slot0:_createTbItem(slot0._gorange, "rangeitem" .. slot6)
		slot7.occupyId = slot6
		slot7.txtnum.text = RoomConfig.instance:getBuildingOccupyNum(slot6)

		UISpriteSetMgr.instance:setRoomSprite(slot7.imageicon, RoomConfig.instance:getBuildingOccupyIcon(slot6))
		slot7.btnclick:AddClickListener(slot0._btnrangeOnClick, slot0, slot7.occupyId)
		table.insert(slot0._rangeItemList, slot7)
	end
end

function slot0._createTbItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = gohelper.clone(slot0._gorangeitem, slot1, slot2)
	slot3.goselect = gohelper.findChild(slot3.go, "beselected")
	slot3.gounselect = gohelper.findChild(slot3.go, "unselected")
	slot3.imageicon = gohelper.findChildImage(slot3.go, "layout/num/icon")
	slot3.txtnum = gohelper.findChildText(slot3.go, "layout/num")
	slot3.btnclick = gohelper.findChildButtonWithAudio(slot3.go, "click")

	gohelper.addUIClickAudio(slot3.btnclick.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.setActive(slot3.go, true)

	return slot3
end

function slot0._refreshFilter(slot0)
	gohelper.setActive(slot0._goraredownselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(slot0._goraredownunselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(slot0._gorareupselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(slot0._gorareupunselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(slot0._goplacedselect, RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(slot0._goplacedunselect, not RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(slot0._gonotplacedselect, RoomShowBuildingListModel.instance:isFilterUse(0))

	slot3 = RoomShowBuildingListModel.instance
	slot4 = slot3
	slot5 = 0

	gohelper.setActive(slot0._gonotplacedunselect, not slot3.isFilterUse(slot4, slot5))

	for slot4, slot5 in ipairs(slot0._rangeItemList) do
		SLFramework.UGUI.GuiHelper.SetColor(slot5.imageicon, RoomShowBuildingListModel.instance:isFilterOccupy(slot5.occupyId) and "#EC7E4B" or "#E5E5E5")
		SLFramework.UGUI.GuiHelper.SetColor(slot5.txtnum, slot6 and "#EC7E4B" or "#E5E5E5")
		gohelper.setActive(slot5.goselect, slot6)
		gohelper.setActive(slot5.gounselect, not slot6)
	end
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnraredown.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(slot0._btnrareup.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(slot0._btnplaced.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(slot0._btnnotplaced.gameObject, AudioEnum.UI.play_ui_role_open)
end

function slot0.onOpen(slot0)
	slot0:_addBtnAudio()
	slot0:_refreshFilter()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._rangeItemList) do
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0

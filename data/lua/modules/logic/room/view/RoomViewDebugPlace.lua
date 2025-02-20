module("modules.logic.room.view.RoomViewDebugPlace", package.seeall)

slot0 = class("RoomViewDebugPlace", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btncloseOnClick(slot0)
	RoomDebugController.instance:setDebugPlaceListShow(false)
end

function slot0._btncategoryOnClick(slot0, slot1)
	if slot0._categoryItemList[slot1].category == "未分类" or string.nilorempty(slot3) then
		RoomDebugPlaceListModel.instance:setFilterCategory(nil)
	else
		RoomDebugPlaceListModel.instance:setFilterCategory(slot3)
	end

	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	slot0:_refreshCategory()

	slot0._scrolldebugplace.horizontalNormalizedPosition = 0
end

function slot0._editableInitView(slot0)
	slot0._godebugplace = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugplace")
	slot0._gocategoryitem = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugplace/filtercategory/viewport/content/go_categoryitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugplace/btn_close")
	slot0._scrolldebugplace = gohelper.findChildScrollRect(slot0.viewGO, "go_normalroot/go_debugplace/scroll_debugplace")
	slot0._gopackageiditem = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugplace/filterpackageid/viewport/content/go_packageiditem")

	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)

	slot0._isShowDebugPlace = false

	gohelper.setActive(slot0._godebugplace, false)

	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._categoryItemList = {}

	gohelper.setActive(slot0._gocategoryitem, false)

	slot0._packageIdItemList = {}

	gohelper.setActive(slot0._gopackageiditem, false)
	slot0:_initCategory()
	slot0:_initPackageId()
	OrthCameraRTMgr.instance:initRT()
	CameraMgr.instance:setOrthCameraActive(true)
end

function slot0._initPackageId(slot0)
	slot1 = lua_block_package.configList

	function slot5(slot0, slot1)
		return slot0.id < slot1.id
	end

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0:getUserDataTb_()
		slot7.index = slot5
		slot7.go = gohelper.cloneInPlace(slot0._gopackageiditem, "item" .. slot5)
		slot7.gobeselect = gohelper.findChild(slot7.go, "go_beselect")
		slot7.gounselect = gohelper.findChild(slot7.go, "go_unselect")
		slot7.txtbeselectname = gohelper.findChildText(slot7.go, "go_beselect/txt_name")
		slot7.txtunselectname = gohelper.findChildText(slot7.go, "go_unselect/txt_name")
		slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

		slot7.btnclick:AddClickListener(slot0._btnpackageidOnClick, slot0, slot7.index)

		slot7.packageId = slot6.id
		slot7.txtbeselectname.text = slot6.name
		slot7.txtunselectname.text = slot6.name

		table.insert(slot0._packageIdItemList, slot7)
		gohelper.setActive(slot7.go, true)
	end

	slot0:_refreshPackageId()
end

function slot0._initCategory(slot0)
	slot2 = {}
	slot3 = {}

	for slot7, slot8 in pairs(RoomConfig.instance:getBlockDefineConfigDict()) do
		if string.nilorempty(slot8.category) then
			slot9 = "未分类"
		end

		if not slot3[slot9] then
			slot3[slot9] = {}

			table.insert(slot2, slot9)
		end
	end

	for slot7, slot8 in ipairs(slot2) do
		if not slot0._categoryItemList[slot7] then
			slot9 = slot0:getUserDataTb_()
			slot9.index = slot7
			slot9.go = gohelper.cloneInPlace(slot0._gocategoryitem, "item" .. slot7)
			slot9.gobeselect = gohelper.findChild(slot9.go, "go_beselect")
			slot9.gounselect = gohelper.findChild(slot9.go, "go_unselect")
			slot9.txtbeselectname = gohelper.findChildText(slot9.go, "go_beselect/txt_name")
			slot9.txtunselectname = gohelper.findChildText(slot9.go, "go_unselect/txt_name")
			slot9.btnclick = gohelper.findChildButtonWithAudio(slot9.go, "btn_click")

			slot9.btnclick:AddClickListener(slot0._btncategoryOnClick, slot0, slot9.index)
			table.insert(slot0._categoryItemList, slot9)
		end

		slot9.category = slot8
		slot9.txtbeselectname.text = slot9.category
		slot9.txtunselectname.text = slot9.category

		gohelper.setActive(slot9.go, true)
	end

	for slot7 = #slot2 + 1, #slot0._categoryItemList do
		gohelper.setActive(slot0._categoryItemList[slot7].go, false)
	end

	slot0:_refreshCategory()
end

function slot0._refreshCategory(slot0)
	slot1 = RoomDebugPlaceListModel.instance:getFilterCategory()

	for slot5, slot6 in ipairs(slot0._categoryItemList) do
		slot7 = slot1 == slot6.category

		if string.nilorempty(slot1) and slot6.category == "未分类" then
			slot7 = true
		end

		gohelper.setActive(slot6.gobeselect, slot7)
		gohelper.setActive(slot6.gounselect, not slot7)
	end
end

function slot0._refreshUI(slot0)
	slot0:_refreshPackageId()
end

function slot0._btnpackageidOnClick(slot0, slot1)
	RoomDebugPlaceListModel.instance:setFilterPackageId(slot0._packageIdItemList[slot1].packageId)
	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	slot0:_refreshPackageId()
end

function slot0._refreshPackageId(slot0)
	for slot4, slot5 in ipairs(slot0._packageIdItemList) do
		gohelper.setActive(slot5.gobeselect, RoomDebugPlaceListModel.instance:isFilterPackageId(slot5.packageId))
		gohelper.setActive(slot5.gounselect, not RoomDebugPlaceListModel.instance:isFilterPackageId(slot5.packageId))
	end
end

function slot0._debugPlaceListViewShowChanged(slot0, slot1)
	slot2 = slot0._isShowDebugPlace ~= slot1
	slot0._isShowDebugPlace = slot1

	RoomDebugPlaceListModel.instance:clearSelect()
	gohelper.setActive(slot0._godebugplace, slot1)

	if slot1 then
		RoomDebugPlaceListModel.instance:setDebugPlaceList()

		slot0._scrolldebugplace.horizontalNormalizedPosition = 0
	end
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._debugPlaceListViewShowChanged, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._categoryItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	slot0._btnclose:RemoveClickListener()
	slot0._scrolldebugplace:RemoveOnValueChanged()
	OrthCameraRTMgr.instance:destroyRT()
	CameraMgr.instance:setOrthCameraActive(false)
end

return slot0

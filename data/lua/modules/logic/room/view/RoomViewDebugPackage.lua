module("modules.logic.room.view.RoomViewDebugPackage", package.seeall)

slot0 = class("RoomViewDebugPackage", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnpackageidOnClick(slot0, slot1)
	RoomDebugPackageListModel.instance:setFilterPackageId(slot0._packageIdItemList[slot1].packageId)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	slot0:_refreshPackageId()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	slot0._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function slot0._btnmainresOnClick(slot0, slot1)
	RoomDebugPackageListModel.instance:setFilterMainRes(slot0._mainResItemList[slot1].resourceId >= 0 and slot2.resourceId or nil)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	slot0:_refreshMainRes()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	slot0._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function slot0._editableInitView(slot0)
	slot0._godebugpackage = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugpackage/btn_close")
	slot0._gopackageiditem = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage/filterpackageid/viewport/content/go_packageiditem")
	slot0._gomainresitem = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage/filtermainres/go_mainresitem")
	slot0._scrolldebugpackage = gohelper.findChildScrollRect(slot0.viewGO, "go_normalroot/go_debugpackage/scroll_debugpackage")
	slot0._btnpackageidmode = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode")
	slot0._goselectpackageidmode = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode/go_selectpackageidmode")
	slot0._btnpackageordermode = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode")
	slot0._goselectpackageordermode = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode/go_selectpackageordermode")
	slot0._btnthemfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/go_debugpackage/btn_themfilter")
	slot0._goselectthemfilter = gohelper.findChild(slot0.viewGO, "go_normalroot/go_debugpackage/btn_themfilter/go_selectthemfilter")

	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnpackageidmode:AddClickListener(slot0._btnpackageidmodeOnClick, slot0)
	slot0._btnpackageordermode:AddClickListener(slot0._btnpackageordermodeOnClick, slot0)
	slot0._btnthemfilter:AddClickListener(slot0._btnthemfilterOnClick, slot0)

	slot0._isShowDebugPackage = false

	gohelper.setActive(slot0._godebugpackage, false)

	slot0._packageIdItemList = {}
	slot0._mainResItemList = {}

	gohelper.setActive(slot0._gopackageiditem, false)
	gohelper.setActive(slot0._gomainresitem, false)
	gohelper.setActive(slot0._goselectthemfilter, false)
	slot0:_initPackageId()
	slot0:_initMainRes()

	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0._btncloseOnClick(slot0)
	RoomDebugController.instance:setDebugPackageListShow(false)
end

function slot0._btnpackageidmodeOnClick(slot0)
	RoomDebugController.instance:setEditPackageOrder(false)
	slot0:_refreshPackageMode()
end

function slot0._btnpackageordermodeOnClick(slot0)
	RoomDebugController.instance:setEditPackageOrder(true)
	slot0:_refreshPackageMode()
end

function slot0._btnthemfilterOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoomDebugThemeFilterView)
end

function slot0._refreshPackageMode(slot0)
	slot1 = RoomDebugController.instance:isEditPackageOrder()

	gohelper.setActive(slot0._goselectpackageidmode, not slot1)
	gohelper.setActive(slot0._goselectpackageordermode, slot1)
end

function slot0._refreshUI(slot0)
	slot0:_refreshPackageId()
	slot0:_refreshMainRes()
	slot0:_refreshPackageMode()
end

function slot0._initPackageId(slot0)
	slot1 = lua_block_package.configList

	function slot5(slot0, slot1)
		return slot0.id < slot1.id
	end

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._packageIdItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._gopackageiditem, "item" .. slot5)
			slot7.gobeselect = gohelper.findChild(slot7.go, "go_beselect")
			slot7.gounselect = gohelper.findChild(slot7.go, "go_unselect")
			slot7.txtbeselectname = gohelper.findChildText(slot7.go, "go_beselect/txt_name")
			slot7.txtunselectname = gohelper.findChildText(slot7.go, "go_unselect/txt_name")
			slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

			slot7.btnclick:AddClickListener(slot0._btnpackageidOnClick, slot0, slot7.index)
			table.insert(slot0._packageIdItemList, slot7)
		end

		slot7.packageId = slot6.id
		slot7.txtbeselectname.text = slot6.name
		slot7.txtunselectname.text = slot6.name

		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._packageIdItemList do
		gohelper.setActive(slot0._packageIdItemList[slot5].go, false)
	end

	slot0:_refreshPackageId()
end

function slot0._refreshPackageId(slot0)
	for slot4, slot5 in ipairs(slot0._packageIdItemList) do
		gohelper.setActive(slot5.gobeselect, RoomDebugPackageListModel.instance:isFilterPackageId(slot5.packageId))
		gohelper.setActive(slot5.gounselect, not RoomDebugPackageListModel.instance:isFilterPackageId(slot5.packageId))
	end
end

function slot0._initMainRes(slot0)
	slot5 = -1

	table.insert({}, slot5)

	for slot5, slot6 in pairs(RoomResourceEnum.ResourceId) do
		if slot6 >= 0 then
			table.insert(slot1, slot6)
		end
	end

	function slot5(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot1, slot5)

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._mainResItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._gomainresitem, "item" .. slot5)
			slot7.gobeselect = gohelper.findChild(slot7.go, "go_beselect")
			slot7.gounselect = gohelper.findChild(slot7.go, "go_unselect")
			slot7.txtbeselectname = gohelper.findChildText(slot7.go, "go_beselect/txt_name")
			slot7.txtunselectname = gohelper.findChildText(slot7.go, "go_unselect/txt_name")
			slot7.txtcount = gohelper.findChildText(slot7.go, "txt_count")
			slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "btn_click")

			slot7.btnclick:AddClickListener(slot0._btnmainresOnClick, slot0, slot7.index)
			table.insert(slot0._mainResItemList, slot7)
		end

		slot7.resourceId = slot6
		slot8 = "空"

		if slot6 > 0 then
			if RoomConfig.instance:getResourceConfig(slot6) then
				slot8 = slot9.name
			else
				logError(string.format("[X小屋地块包表.xlsx] [export_地块资源] 找不到资源id:[%s]", slot6))

				slot8 = "未知:" .. slot6
			end
		elseif slot6 < 0 then
			slot8 = "未分类"
		end

		slot7.txtbeselectname.text = slot8
		slot7.txtunselectname.text = slot8

		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._mainResItemList do
		gohelper.setActive(slot0._mainResItemList[slot5].go, false)
	end

	slot0:_refreshMainRes()
end

function slot0._refreshMainRes(slot0)
	slot1 = RoomDebugPackageListModel.instance:getFilterMainRes()

	for slot5, slot6 in ipairs(slot0._mainResItemList) do
		slot7 = slot1 == slot6.resourceId or slot6.resourceId < 0 and not slot1

		gohelper.setActive(slot6.gobeselect, slot7)
		gohelper.setActive(slot6.gounselect, not slot7)

		slot6.txtcount.text = RoomDebugPackageListModel.instance:getCountByMainRes(slot6.resourceId)
	end
end

function slot0._themeFilterChanged(slot0)
	slot1 = RoomDebugThemeFilterListModel.instance

	for slot6 = 1, #slot0._packageIdItemList do
		slot7 = slot0._packageIdItemList[slot6]

		gohelper.setActive(slot7.go, slot1:checkSelectByItem(slot7.packageId, MaterialEnum.MaterialType.BlockPackage))
	end

	gohelper.setActive(slot0._goselectthemfilter, slot1:getIsAll() or slot1:getSelectCount() > 0)
end

function slot0._debugPackageListViewShowChanged(slot0, slot1)
	slot2 = slot0._isShowDebugPackage ~= slot1
	slot0._isShowDebugPackage = slot1

	RoomDebugPackageListModel.instance:clearSelect()
	gohelper.setActive(slot0._godebugpackage, slot1)

	if slot1 then
		RoomDebugPackageListModel.instance:setDebugPackageList()

		slot0._scrolldebugpackage.horizontalNormalizedPosition = 0
	end
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, slot0._debugPackageListViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugSetPackage, slot0._refreshMainRes, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._refreshMainRes, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageOrderChanged, slot0._refreshMainRes, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageFilterChanged, slot0._refreshMainRes, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.UIRoomThemeFilterChanged, slot0._themeFilterChanged, slot0)
	RoomDebugThemeFilterListModel.instance:init()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._packageIdItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._mainResItemList) do
		slot5.btnclick:RemoveClickListener()
	end

	slot0._btnclose:RemoveClickListener()
	slot0._scrolldebugpackage:RemoveOnValueChanged()
	slot0._btnpackageidmode:RemoveClickListener()
	slot0._btnpackageordermode:RemoveClickListener()
	slot0._btnthemfilter:RemoveClickListener()
end

return slot0

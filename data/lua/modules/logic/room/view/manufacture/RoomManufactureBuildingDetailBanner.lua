module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailBanner", package.seeall)

local var_0_0 = class("RoomManufactureBuildingDetailBanner", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_detail")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_content/#scroll_base")
	arg_1_0._gobaseLayer = gohelper.findChild(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	arg_1_0._goitemLayer = gohelper.findChild(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer")
	arg_1_0._txtadd = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#txt_add")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
end

function var_0_0._btndetailOnClick(arg_4_0)
	local var_4_0 = ManufactureController.instance:openRoomManufactureBuildingDetailView(arg_4_0._buildingUid)

	arg_4_0:_setDetailSelect(var_4_0)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._gounselectdetail = gohelper.findChild(arg_5_0.viewGO, "#go_content/#btn_detail/unselect")
	arg_5_0._goselectdetail = gohelper.findChild(arg_5_0.viewGO, "#go_content/#btn_detail/select")
	arg_5_0._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	arg_5_0._attrItemCompList = {}
	arg_5_0._itemTbList = {}

	gohelper.setActive(arg_5_0._gobaseitem, false)
	gohelper.setActive(arg_5_0._goitem, false)
	arg_5_0:_setDetailSelect(false)
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:_startRefreshTask()
	arg_6_0:_refreshUI()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_7_0._startRefreshTask, arg_7_0)
	arg_7_0:addEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, arg_7_0._onCloseDetatilView, arg_7_0)
	arg_7_0:_startRefreshTask()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:_stopRefreshTask()
end

function var_0_0._startRefreshTask(arg_10_0)
	if not arg_10_0._hasWaitRefreshTask then
		arg_10_0._hasWaitRefreshTask = true

		TaskDispatcher.runDelay(arg_10_0._onRunRefreshTask, arg_10_0, 0.1)
	end
end

function var_0_0._stopRefreshTask(arg_11_0)
	arg_11_0._hasWaitRefreshTask = false

	TaskDispatcher.cancelTask(arg_11_0._onRunRefreshTask, arg_11_0)
end

function var_0_0._onRunRefreshTask(arg_12_0)
	arg_12_0:_updateParam()
	arg_12_0:_refreshAttr()
	arg_12_0:_refreshItem()

	if not arg_12_0._isSendCritterRequest and arg_12_0._buildingType then
		arg_12_0._isSendCritterRequest = true

		CritterController.instance:sendBuildManufacturAttrByBtype(arg_12_0._buildingType)
	end

	arg_12_0._hasWaitRefreshTask = false
end

function var_0_0._onCloseDetatilView(arg_13_0)
	arg_13_0:_setDetailSelect(false)
end

function var_0_0.getViewBuilding(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0.viewContainer:getContainerViewBuilding()

	return var_14_0, var_14_1
end

function var_0_0._updateParam(arg_15_0)
	arg_15_0._buildingUid, arg_15_0._buildingMO = arg_15_0:getViewBuilding()
	arg_15_0._buildingType = arg_15_0.viewParam.buildingType
	arg_15_0._builidngCfg = arg_15_0._buildingMO and arg_15_0._buildingMO.config
	arg_15_0._buildingType = arg_15_0._builidngCfg and arg_15_0._builidngCfg.buildingType
	arg_15_0._buildingId = arg_15_0._builidngCfg and arg_15_0._builidngCfg.buildingId
	arg_15_0._attrInfoMOList = {}
	arg_15_0._critterMOList = CritterHelper.getWorkCritterMOListByBuid(arg_15_0._buildingUid)
	arg_15_0._critterUidList = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._critterMOList) do
		table.insert(arg_15_0._critterUidList, iter_15_1.id)
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._baseAttrTypeList) do
		table.insert(arg_15_0._attrInfoMOList, CritterHelper.sumArrtInfoMOByAttrId(iter_15_3, arg_15_0._critterMOList))
	end

	arg_15_0._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(arg_15_0._buildingUid)

	gohelper.setActive(arg_15_0._btndetail, #arg_15_0._critterUidList > 0)
end

function var_0_0._refreshUI(arg_16_0)
	arg_16_0:_refreshAttr()
	arg_16_0:_refreshItem()
end

function var_0_0._setDetailSelect(arg_17_0, arg_17_1)
	gohelper.setActive(arg_17_0._goselectdetail, arg_17_1)
	gohelper.setActive(arg_17_0._gounselectdetail, not arg_17_1)
end

function var_0_0._refreshAttr(arg_18_0)
	local var_18_0 = arg_18_0._attrInfoMOList

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_1 = arg_18_0._attrItemCompList[iter_18_0]

		if not var_18_1 then
			local var_18_2 = gohelper.clone(arg_18_0._gobaseitem, arg_18_0._gobaseLayer)

			var_18_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_18_2, RoomCritterDetailAttrItem)

			table.insert(arg_18_0._attrItemCompList, var_18_1)
		end

		local var_18_3 = CritterHelper.sumPreViewAttrValue(iter_18_1.attributeId, arg_18_0._critterUidList, arg_18_0._buildingId, false)
		local var_18_4 = CritterHelper.formatAttrValue(iter_18_1.attributeId, var_18_3)

		var_18_1:onRefreshMo(iter_18_1, iter_18_0, var_18_4, var_18_4, iter_18_1:getName())
	end

	local var_18_5 = #var_18_0

	for iter_18_2 = 1, #arg_18_0._attrItemCompList do
		gohelper.setActive(arg_18_0._attrItemCompList[iter_18_2].viewGO, iter_18_2 <= var_18_5)
	end
end

function var_0_0._refreshItem(arg_19_0)
	local var_19_0 = CritterHelper.sumPreViewAttrValue(CritterEnum.AttributeType.Efficiency, arg_19_0._critterUidList, arg_19_0._buildingId, false) > 100

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._manufactureItemIdList) do
		local var_19_1 = arg_19_0._itemTbList[iter_19_0]

		if not var_19_1 then
			var_19_1 = arg_19_0:getUserDataTb_()

			table.insert(arg_19_0._itemTbList, var_19_1)

			local var_19_2 = gohelper.cloneInPlace(arg_19_0._goitem)

			var_19_1.go = var_19_2
			var_19_1.image_quality = gohelper.findChildImage(var_19_2, "image_quality")
			var_19_1.go_icon = gohelper.findChild(var_19_2, "go_icon")
			var_19_1.go_up = gohelper.findChild(var_19_2, "go_up")
			var_19_1.itemIcon = IconMgr.instance:getCommonItemIcon(var_19_1.go_icon)

			var_19_1.itemIcon:isShowQuality(false)
		end

		var_19_1.itemIcon:setMOValue(MaterialEnum.MaterialType.Item, iter_19_1, nil, nil, nil)

		local var_19_3 = var_19_1.itemIcon:getRare()
		local var_19_4 = RoomManufactureEnum.RareImageMap[var_19_3]

		UISpriteSetMgr.instance:setCritterSprite(var_19_1.image_quality, var_19_4)
		gohelper.setActive(var_19_1.go_up, var_19_0)
	end

	local var_19_5 = #arg_19_0._manufactureItemIdList

	for iter_19_2 = 1, #arg_19_0._itemTbList do
		gohelper.setActive(arg_19_0._itemTbList[iter_19_2].go, iter_19_2 <= var_19_5)
	end

	arg_19_0._txtadd.text = luaLang(var_19_5 < 1 and "room_manufacture_detail_no_item" or "room_manufacture_detail_item_title")
end

var_0_0.prefabPath = "ui/viewres/room/manufacture/roommanufacturebuildingdetailbanner.prefab"

return var_0_0

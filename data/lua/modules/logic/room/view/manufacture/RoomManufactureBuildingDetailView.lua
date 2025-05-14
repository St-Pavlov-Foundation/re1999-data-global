module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailView", package.seeall)

local var_0_0 = class("RoomManufactureBuildingDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclosFull = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closFull")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "root/#go_content")
	arg_1_0._imagebuildingIcon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_content/#image_buildingIcon")
	arg_1_0._txtbuildingName = gohelper.findChildText(arg_1_0.viewGO, "root/#go_content/#txt_buildingName")
	arg_1_0._scrollbase = gohelper.findChildScrollRect(arg_1_0.viewGO, "root/#go_content/#scroll_base")
	arg_1_0._gobaseLayer = gohelper.findChild(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer")
	arg_1_0._gobaseitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	arg_1_0._txtratio = gohelper.findChildText(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	arg_1_0._goitemLayer = gohelper.findChild(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")
	arg_1_0._gocritterLayer = gohelper.findChild(arg_1_0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_critterLayer")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_content/#btn_close")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclosFull:AddClickListener(arg_2_0._btnclosFullOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclosFull:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnclosFullOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	arg_6_0._attrItemCompList = {}
	arg_6_0._critterDetailCompList = {}
	arg_6_0._itemTbList = {}

	gohelper.setActive(arg_6_0._gobaseitem, false)
	gohelper.setActive(arg_6_0._goitem, false)

	arg_6_0._animator = arg_6_0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	arg_6_0._goroot = gohelper.findChild(arg_6_0.viewGO, "root")
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:_updateParam()
	arg_7_0:_refreshUI()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam and arg_8_0.viewParam.showIsRight

	arg_8_0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, arg_8_0._onAttrPreviewUpdate, arg_8_0)
	arg_8_0:_updateParam()
	arg_8_0:_refreshUI()

	if arg_8_0._builidngCfg and arg_8_0._critterUidList and #arg_8_0._critterUidList > 0 then
		CritterRpc.instance:sendGetRealCritterAttributeRequest(arg_8_0._builidngCfg.id, arg_8_0._critterUidList, false)
	end

	if arg_8_0._animator then
		arg_8_0._animator:Play(var_8_0 and "open_right" or "open_left")
	end

	if ViewMgr.instance:isOpen(ViewName.RoomOverView) then
		local var_8_1 = arg_8_0._goroot.transform
		local var_8_2 = recthelper.getHeight(arg_8_0.viewGO.transform)

		recthelper.setHeight(var_8_1, var_8_2)
		recthelper.setAnchor(var_8_1, 0, 0)
	end
end

function var_0_0.onClose(arg_9_0)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnCloseManufactureBuildingDetailView)
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0 = 1, #arg_10_0._attrItemCompList do
		arg_10_0._attrItemCompList[iter_10_0]:onDestroy()
	end

	for iter_10_1 = 1, #arg_10_0._critterDetailCompList do
		arg_10_0._critterDetailCompList[iter_10_1]:onDestroy()
	end
end

function var_0_0._onAttrPreviewUpdate(arg_11_0, arg_11_1)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._critterMOList) do
		local var_11_1 = iter_11_1.id

		if var_11_1 and arg_11_1[var_11_1] then
			var_11_0 = true

			break
		end
	end

	if var_11_0 then
		arg_11_0:_updateParam()
		arg_11_0:_refreshUI()
	end
end

function var_0_0._updateParam(arg_12_0)
	arg_12_0._buildingType = arg_12_0.viewParam.buildingType
	arg_12_0._buildingUid = arg_12_0.viewParam.buildingUid
	arg_12_0._buildingMO = arg_12_0.viewParam.buildingMO
	arg_12_0._builidngCfg = arg_12_0._buildingMO and arg_12_0._buildingMO.config
	arg_12_0._buildingId = arg_12_0._builidngCfg and arg_12_0._builidngCfg.buildingId
	arg_12_0._attrInfoMOList = {}
	arg_12_0._critterMOList = CritterHelper.getWorkCritterMOListByBuid(arg_12_0._buildingUid)
	arg_12_0._critterUidList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._critterMOList) do
		table.insert(arg_12_0._critterUidList, iter_12_1.id)
	end

	for iter_12_2, iter_12_3 in ipairs(arg_12_0._baseAttrTypeList) do
		table.insert(arg_12_0._attrInfoMOList, arg_12_0:_getArrtInfoMOByType(iter_12_3))
	end

	arg_12_0._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(arg_12_0._buildingUid)
end

function var_0_0._getArrtInfoMOByType(arg_13_0, arg_13_1)
	return CritterHelper.sumArrtInfoMOByAttrId(arg_13_1, arg_13_0._critterMOList)
end

function var_0_0._refreshUI(arg_14_0)
	arg_14_0._txtbuildingName.text = arg_14_0._builidngCfg and arg_14_0._builidngCfg.name or ""

	if arg_14_0._builidngCfg then
		local var_14_0 = arg_14_0._builidngCfg.buildingType
		local var_14_1 = arg_14_0._builidngCfg.id
		local var_14_2

		if RoomBuildingEnum.BuildingArea[var_14_0] then
			var_14_2 = ManufactureConfig.instance:getManufactureBuildingIcon(var_14_1)
		else
			var_14_2 = RoomConfig.instance:getBuildingTypeIcon(var_14_0)
		end

		UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imagebuildingIcon, var_14_2)
	end

	arg_14_0:_refreshAttr()
	arg_14_0:_refreshCritter()
	arg_14_0:_refreshItem()
end

function var_0_0._refreshAttr(arg_15_0)
	local var_15_0 = arg_15_0._attrInfoMOList

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0._attrItemCompList[iter_15_0]

		if not var_15_1 then
			local var_15_2 = gohelper.clone(arg_15_0._gobaseitem, arg_15_0._gobaseLayer)

			var_15_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, RoomCritterDetailAttrItem)

			table.insert(arg_15_0._attrItemCompList, var_15_1)
		end

		local var_15_3 = CritterHelper.sumPreViewAttrValue(iter_15_1.attributeId, arg_15_0._critterUidList, arg_15_0._buildingId, false)
		local var_15_4 = CritterHelper.formatAttrValue(iter_15_1.attributeId, var_15_3)

		var_15_1:onRefreshMo(iter_15_1, iter_15_0, var_15_4, var_15_4, iter_15_1:getName())
	end

	local var_15_5 = #var_15_0

	for iter_15_2 = 1, #arg_15_0._attrItemCompList do
		gohelper.setActive(arg_15_0._attrItemCompList[iter_15_2].viewGO, iter_15_2 <= var_15_5)
	end
end

function var_0_0._refreshCritter(arg_16_0)
	local var_16_0 = arg_16_0._critterMOList

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = arg_16_0._critterDetailCompList[iter_16_0]

		if not var_16_1 then
			local var_16_2 = arg_16_0.viewContainer:getResInst(RoomManufactureCritterDetail.prefabPath, arg_16_0._gocritterLayer)

			var_16_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_2, RoomManufactureCritterDetail)

			table.insert(arg_16_0._critterDetailCompList, var_16_1)
		end

		var_16_1:onUpdateMO(iter_16_1)
	end

	local var_16_3 = #var_16_0

	for iter_16_2 = 1, #arg_16_0._critterDetailCompList do
		gohelper.setActive(arg_16_0._critterDetailCompList[iter_16_2].viewGO, iter_16_2 <= var_16_3)
	end
end

function var_0_0._refreshItem(arg_17_0)
	local var_17_0 = CritterHelper.sumPreViewAttrValue(CritterEnum.AttributeType.Efficiency, arg_17_0._critterUidList, arg_17_0._buildingId, false) > 100

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._manufactureItemIdList) do
		local var_17_1 = arg_17_0._itemTbList[iter_17_0]

		if not var_17_1 then
			var_17_1 = arg_17_0:getUserDataTb_()

			table.insert(arg_17_0._itemTbList, var_17_1)

			local var_17_2 = gohelper.cloneInPlace(arg_17_0._goitem)

			var_17_1.go = var_17_2
			var_17_1.image_quality = gohelper.findChildImage(var_17_2, "image_quality")
			var_17_1.go_icon = gohelper.findChild(var_17_2, "go_icon")
			var_17_1.go_up = gohelper.findChild(var_17_2, "go_up")
			var_17_1.itemIcon = IconMgr.instance:getCommonItemIcon(var_17_1.go_icon)

			var_17_1.itemIcon:isShowQuality(false)
		end

		var_17_1.itemIcon:setMOValue(MaterialEnum.MaterialType.Item, iter_17_1, nil, nil, nil)

		local var_17_3 = var_17_1.itemIcon:getRare()
		local var_17_4 = RoomManufactureEnum.RareImageMap[var_17_3]

		UISpriteSetMgr.instance:setCritterSprite(var_17_1.image_quality, var_17_4)
		gohelper.setActive(var_17_1.go_up, var_17_0)
	end

	local var_17_5 = #arg_17_0._manufactureItemIdList

	for iter_17_2 = 1, #arg_17_0._itemTbList do
		gohelper.setActive(arg_17_0._itemTbList[iter_17_2].go, iter_17_2 <= var_17_5)
	end
end

return var_0_0

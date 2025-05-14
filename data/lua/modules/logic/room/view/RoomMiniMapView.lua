module("modules.logic.room.view.RoomMiniMapView", package.seeall)

local var_0_0 = class("RoomMiniMapView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_lefticon")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_righticon")
	arg_1_0._simagerighticon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_righticon2")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line")
	arg_1_0._simageline2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line2")
	arg_1_0._simagecontour = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mapbg/#simage_contour")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._goblockcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_blockcontainer")
	arg_1_0._gounititem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_blockcontainer/unitcontainer/#go_unititem")
	arg_1_0._gobuildingitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_blockcontainer/buildingcontainer/#go_buildingitem")
	arg_1_0._goredpointitem = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_blockcontainer/redpointcontainer/#go_redpointitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()

	arg_4_0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	arg_4_0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	arg_4_0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	arg_4_0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	arg_4_0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	arg_4_0._simageline:LoadImage(ResUrl.getRoomImage("quanlanditu_line_002"))
	arg_4_0._simageline2:LoadImage(ResUrl.getRoomTexture("bgline.jpg"))
	arg_4_0._simagecontour:LoadImage(ResUrl.getRoomImage("quanlanditukuai_012"))

	arg_4_0._unitItemList = {}
	arg_4_0._buildingItemList = {}
	arg_4_0._redpointItemDict = {}
	arg_4_0._countItemList = {}

	gohelper.setActive(arg_4_0._gounititem, false)
	gohelper.setActive(arg_4_0._gobuildingitem, false)
	gohelper.setActive(arg_4_0._goredpointitem, false)

	arg_4_0._left = 0
	arg_4_0._right = 0
	arg_4_0._bottom = 0
	arg_4_0._top = 0
	arg_4_0._width = recthelper.getWidth(arg_4_0._gocontainer.transform)
	arg_4_0._height = recthelper.getHeight(arg_4_0._gocontainer.transform)
	arg_4_0._touchMgr = TouchEventMgrHepler.getTouchEventMgr(arg_4_0._gocontainer)

	arg_4_0._touchMgr:SetIgnoreUI(true)
	arg_4_0._touchMgr:SetOnlyTouch(true)
	arg_4_0._touchMgr:SetOnDragBeginCb(arg_4_0._onDragBegin, arg_4_0)
	arg_4_0._touchMgr:SetOnDragCb(arg_4_0._onDrag, arg_4_0)
	arg_4_0._touchMgr:SetOnDragEndCb(arg_4_0._onDragEnd, arg_4_0)

	arg_4_0._lastPos = nil

	arg_4_0:_setScale(0.5)
end

function var_0_0._onDragBegin(arg_5_0, arg_5_1)
	arg_5_0._isDraging = true
	arg_5_0._lastPos = recthelper.screenPosToAnchorPos(arg_5_1, arg_5_0._gocontainer.transform)

	if math.abs(arg_5_0._lastPos.x) > arg_5_0._width / 2 or math.abs(arg_5_0._lastPos.y) > arg_5_0._height / 2 then
		arg_5_0._lastPos = nil
	end
end

function var_0_0._onDrag(arg_6_0, arg_6_1)
	arg_6_0._isDraging = true

	if not arg_6_0._lastPos then
		return
	end

	local var_6_0 = recthelper.screenPosToAnchorPos(arg_6_1, arg_6_0._gocontainer.transform)

	arg_6_0:_moveMap(var_6_0 - arg_6_0._lastPos)

	arg_6_0._lastPos = var_6_0
end

function var_0_0._onDragEnd(arg_7_0, arg_7_1)
	arg_7_0._isDraging = false
	arg_7_0._lastPos = nil
end

function var_0_0._moveMap(arg_8_0, arg_8_1)
	local var_8_0, var_8_1 = transformhelper.getLocalPos(arg_8_0._goblockcontainer.transform)
	local var_8_2 = var_8_0 + arg_8_1.x
	local var_8_3 = var_8_1 + arg_8_1.y

	arg_8_0:_setMapPos(Vector2(var_8_2, var_8_3))
end

function var_0_0._setMapPos(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.x
	local var_9_1 = arg_9_1.y
	local var_9_2 = Mathf.Clamp(var_9_0, -arg_9_0._right * arg_9_0._scale, -arg_9_0._left * arg_9_0._scale)
	local var_9_3 = Mathf.Clamp(var_9_1, -arg_9_0._top * arg_9_0._scale, -arg_9_0._bottom * arg_9_0._scale)

	transformhelper.setLocalPos(arg_9_0._goblockcontainer.transform, var_9_2, var_9_3, 0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshFixed()
	arg_10_0:_refreshDynamic()
	arg_10_0:_resetScale()

	local var_10_0 = arg_10_0._scene.camera:getCameraFocus()
	local var_10_1 = HexMath.positionToHex(var_10_0, RoomBlockEnum.BlockSize)

	arg_10_0._focusMapPos = -arg_10_0:_getMapPos(var_10_1)

	arg_10_0:_setMapPos(arg_10_0._focusMapPos)
end

function var_0_0._resetScale(arg_11_0)
	arg_11_0:_setScale(0.5)
end

function var_0_0._setScale(arg_12_0, arg_12_1)
	arg_12_0._scale = arg_12_1

	transformhelper.setLocalScale(arg_12_0._goblockcontainer.transform, arg_12_1, arg_12_1, 1)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0._refreshFixed(arg_14_0)
	arg_14_0:_refreshUnitItems()
	arg_14_0:_refreshBuildingItems()
	arg_14_0:_refreshInitBuildingItems()
end

function var_0_0._refreshDynamic(arg_15_0)
	if RoomController.instance:isObMode() then
		arg_15_0:_refreshRedpointItems()
	end
end

function var_0_0._refreshUnitItems(arg_16_0)
	local var_16_0 = RoomMapBlockModel.instance:getBlockMOList()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if iter_16_1.blockState == RoomBlockEnum.BlockState.Map then
			local var_16_1 = iter_16_1.hexPoint
			local var_16_2 = arg_16_0:getUserDataTb_()

			var_16_2.go = gohelper.cloneInPlace(arg_16_0._gounititem, string.format("%s_%s", var_16_1.x, var_16_1.y))
			var_16_2.imageunit = gohelper.findChildImage(var_16_2.go, "image_unit")

			table.insert(arg_16_0._unitItemList, var_16_2)

			local var_16_3 = RoomBlockHelper.getMapResourceId(iter_16_1)

			UISpriteSetMgr.instance:setRoomSprite(var_16_2.imageunit, "mapunit" .. var_16_3)
			arg_16_0:_setCommonPosition(var_16_2.go.transform, var_16_1)
			gohelper.setActive(var_16_2.go, true)
		end
	end
end

function var_0_0._refreshBuildingItems(arg_17_0)
	local var_17_0 = RoomMapBlockModel.instance:getBlockMOList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.blockState == RoomBlockEnum.BlockState.Map then
			local var_17_1 = iter_17_1.hexPoint
			local var_17_2 = RoomBuildingHelper.getOccupyBuildingParam(var_17_1)
			local var_17_3 = var_17_2 and var_17_2.buildingUid
			local var_17_4 = var_17_3 and RoomMapBuildingModel.instance:getBuildingMOById(var_17_3)
			local var_17_5 = var_17_4 and var_17_4.config.buildingType
			local var_17_6 = var_17_4 and var_17_4.config.buildingShowType

			if var_17_5 and var_17_5 ~= RoomBuildingEnum.BuildingType.Decoration then
				local var_17_7 = arg_17_0:getUserDataTb_()

				var_17_7.id = var_17_4.id
				var_17_7.go = gohelper.cloneInPlace(arg_17_0._gobuildingitem, string.format("%s_%s", var_17_1.x, var_17_1.y))
				var_17_7.imagebuilding = gohelper.findChildImage(var_17_7.go, "image_building")

				table.insert(arg_17_0._buildingItemList, var_17_7)
				UISpriteSetMgr.instance:setRoomSprite(var_17_7.imagebuilding, "buildingtype" .. var_17_6)
				arg_17_0:_setCommonPosition(var_17_7.go.transform, var_17_1)
				gohelper.setActive(var_17_7.go, true)
			end
		end
	end
end

function var_0_0._refreshInitBuildingItems(arg_18_0)
	local var_18_0 = RoomConfig.instance:getInitBuildingOccupyDict()

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1) do
			local var_18_1 = HexPoint(iter_18_0, iter_18_2)
			local var_18_2 = arg_18_0:getUserDataTb_()

			var_18_2.id = 0
			var_18_2.go = gohelper.cloneInPlace(arg_18_0._gobuildingitem, string.format("%s_%s", var_18_1.x, var_18_1.y))
			var_18_2.imagebuilding = gohelper.findChildImage(var_18_2.go, "image_building")
			var_18_2.btnbuilding = gohelper.findChildButtonWithAudio(var_18_2.go, "btn_building")

			table.insert(arg_18_0._buildingItemList, var_18_2)
			gohelper.setActive(var_18_2.btnbuilding.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(var_18_2.imagebuilding, "#A29E88")
			UISpriteSetMgr.instance:setRoomSprite(var_18_2.imagebuilding, "buildingtype0")
			recthelper.setWidth(var_18_2.imagebuilding.gameObject.transform, 38)
			recthelper.setHeight(var_18_2.imagebuilding.gameObject.transform, 31)
			arg_18_0:_setCommonPosition(var_18_2.go.transform, var_18_1)
			gohelper.setActive(var_18_2.go, true)
		end
	end
end

function var_0_0._refreshRedpointItems(arg_19_0)
	local var_19_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_19_0, iter_19_1 in pairs(arg_19_0._redpointItemDict) do
		gohelper.setActive(iter_19_1.go, false)
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_0) do
		local var_19_1 = RoomBuildingHelper.getTopRightHexPoint(iter_19_3.buildingId, iter_19_3.hexPoint, iter_19_3.rotate)

		if iter_19_3.config.buildingType ~= RoomBuildingEnum.BuildingType.Decoration and var_19_1 and iter_19_3.buildingState == RoomBuildingEnum.BuildingState.Map then
			local var_19_2 = arg_19_0._redpointItemDict[iter_19_3.id]

			if not var_19_2 then
				var_19_2 = arg_19_0:getUserDataTb_()
				var_19_2.go = gohelper.cloneInPlace(arg_19_0._goredpointitem, string.format("%s_%s", var_19_1.x, var_19_1.y))
				var_19_2.goreddot = gohelper.findChild(var_19_2.go, "go_buildingreddot")

				if RoomController.instance:isObMode() then
					RedDotController.instance:addMultiRedDot(var_19_2.goreddot, {
						{
							id = RedDotEnum.DotNode.RoomBuildingFull,
							uid = tonumber(iter_19_3.id)
						},
						{
							id = RedDotEnum.DotNode.RoomBuildingGet,
							uid = tonumber(iter_19_3.id)
						}
					})
				end

				arg_19_0._redpointItemDict[iter_19_3.id] = var_19_2

				arg_19_0:_setCommonPosition(var_19_2.go.transform, var_19_1)
			end

			gohelper.setActive(var_19_2.go, true)
		end
	end
end

function var_0_0._setCommonPosition(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = HexMath.hexToPosition(arg_20_2, 43.78481 / math.sqrt(3) * 2)
	local var_20_1 = 30 * Mathf.Deg2Rad
	local var_20_2 = Vector2(var_20_0.x * Mathf.Cos(var_20_1) - var_20_0.y * Mathf.Sin(var_20_1), var_20_0.x * Mathf.Sin(var_20_1) + var_20_0.y * Mathf.Cos(var_20_1))

	arg_20_0._left = math.min(var_20_2.x, arg_20_0._left)
	arg_20_0._right = math.max(var_20_2.x, arg_20_0._right)
	arg_20_0._bottom = math.min(var_20_2.y, arg_20_0._bottom)
	arg_20_0._top = math.max(var_20_2.y, arg_20_0._top)

	recthelper.setAnchor(arg_20_1, var_20_0.x, var_20_0.y)
end

function var_0_0._getMapPos(arg_21_0, arg_21_1)
	local var_21_0 = HexMath.hexToPosition(arg_21_1, 43.78481 / math.sqrt(3) * 2)
	local var_21_1 = 30 * Mathf.Deg2Rad
	local var_21_2 = Vector2(var_21_0.x * Mathf.Cos(var_21_1) - var_21_0.y * Mathf.Sin(var_21_1), var_21_0.x * Mathf.Sin(var_21_1) + var_21_0.y * Mathf.Cos(var_21_1))

	return Vector2(var_21_2.x * arg_21_0._scale, var_21_2.y * arg_21_0._scale)
end

function var_0_0.onDestroyView(arg_22_0)
	if arg_22_0._touchMgr then
		TouchEventMgrHepler.remove(arg_22_0._touchMgr)

		arg_22_0._touchMgr = nil
	end

	arg_22_0._simagebg:UnLoadImage()
	arg_22_0._simagelefticon:UnLoadImage()
	arg_22_0._simagerighticon:UnLoadImage()
	arg_22_0._simagerighticon2:UnLoadImage()
	arg_22_0._simagemask:UnLoadImage()
	arg_22_0._simageline:UnLoadImage()
	arg_22_0._simageline2:UnLoadImage()
	arg_22_0._simagecontour:UnLoadImage()
end

return var_0_0

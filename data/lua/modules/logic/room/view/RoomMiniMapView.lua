module("modules.logic.room.view.RoomMiniMapView", package.seeall)

slot0 = class("RoomMiniMapView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_lefticon")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon")
	slot0._simagerighticon2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_righticon2")
	slot0._simagemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mask")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line")
	slot0._simageline2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line2")
	slot0._simagecontour = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mapbg/#simage_contour")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._goblockcontainer = gohelper.findChild(slot0.viewGO, "#go_container/#go_blockcontainer")
	slot0._gounititem = gohelper.findChild(slot0.viewGO, "#go_container/#go_blockcontainer/unitcontainer/#go_unititem")
	slot0._gobuildingitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_blockcontainer/buildingcontainer/#go_buildingitem")
	slot0._goredpointitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_blockcontainer/redpointcontainer/#go_redpointitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	slot0._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	slot0._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	slot0._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	slot0._simageline:LoadImage(ResUrl.getRoomImage("quanlanditu_line_002"))
	slot0._simageline2:LoadImage(ResUrl.getRoomTexture("bgline.jpg"))
	slot0._simagecontour:LoadImage(ResUrl.getRoomImage("quanlanditukuai_012"))

	slot0._unitItemList = {}
	slot0._buildingItemList = {}
	slot0._redpointItemDict = {}
	slot0._countItemList = {}

	gohelper.setActive(slot0._gounititem, false)
	gohelper.setActive(slot0._gobuildingitem, false)
	gohelper.setActive(slot0._goredpointitem, false)

	slot0._left = 0
	slot0._right = 0
	slot0._bottom = 0
	slot0._top = 0
	slot0._width = recthelper.getWidth(slot0._gocontainer.transform)
	slot0._height = recthelper.getHeight(slot0._gocontainer.transform)
	slot0._touchMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._gocontainer)

	slot0._touchMgr:SetIgnoreUI(true)
	slot0._touchMgr:SetOnlyTouch(true)
	slot0._touchMgr:SetOnDragBeginCb(slot0._onDragBegin, slot0)
	slot0._touchMgr:SetOnDragCb(slot0._onDrag, slot0)
	slot0._touchMgr:SetOnDragEndCb(slot0._onDragEnd, slot0)

	slot0._lastPos = nil

	slot0:_setScale(0.5)
end

function slot0._onDragBegin(slot0, slot1)
	slot0._isDraging = true
	slot0._lastPos = recthelper.screenPosToAnchorPos(slot1, slot0._gocontainer.transform)

	if math.abs(slot0._lastPos.x) > slot0._width / 2 or math.abs(slot0._lastPos.y) > slot0._height / 2 then
		slot0._lastPos = nil
	end
end

function slot0._onDrag(slot0, slot1)
	slot0._isDraging = true

	if not slot0._lastPos then
		return
	end

	slot2 = recthelper.screenPosToAnchorPos(slot1, slot0._gocontainer.transform)

	slot0:_moveMap(slot2 - slot0._lastPos)

	slot0._lastPos = slot2
end

function slot0._onDragEnd(slot0, slot1)
	slot0._isDraging = false
	slot0._lastPos = nil
end

function slot0._moveMap(slot0, slot1)
	slot2, slot3 = transformhelper.getLocalPos(slot0._goblockcontainer.transform)

	slot0:_setMapPos(Vector2(slot2 + slot1.x, slot3 + slot1.y))
end

function slot0._setMapPos(slot0, slot1)
	transformhelper.setLocalPos(slot0._goblockcontainer.transform, Mathf.Clamp(slot1.x, -slot0._right * slot0._scale, -slot0._left * slot0._scale), Mathf.Clamp(slot1.y, -slot0._top * slot0._scale, -slot0._bottom * slot0._scale), 0)
end

function slot0.onOpen(slot0)
	slot0:_refreshFixed()
	slot0:_refreshDynamic()
	slot0:_resetScale()

	slot0._focusMapPos = -slot0:_getMapPos(HexMath.positionToHex(slot0._scene.camera:getCameraFocus(), RoomBlockEnum.BlockSize))

	slot0:_setMapPos(slot0._focusMapPos)
end

function slot0._resetScale(slot0)
	slot0:_setScale(0.5)
end

function slot0._setScale(slot0, slot1)
	slot0._scale = slot1

	transformhelper.setLocalScale(slot0._goblockcontainer.transform, slot1, slot1, 1)
end

function slot0.onClose(slot0)
end

function slot0._refreshFixed(slot0)
	slot0:_refreshUnitItems()
	slot0:_refreshBuildingItems()
	slot0:_refreshInitBuildingItems()
end

function slot0._refreshDynamic(slot0)
	if RoomController.instance:isObMode() then
		slot0:_refreshRedpointItems()
	end
end

function slot0._refreshUnitItems(slot0)
	for slot5, slot6 in ipairs(RoomMapBlockModel.instance:getBlockMOList()) do
		if slot6.blockState == RoomBlockEnum.BlockState.Map then
			slot7 = slot6.hexPoint
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._gounititem, string.format("%s_%s", slot7.x, slot7.y))
			slot8.imageunit = gohelper.findChildImage(slot8.go, "image_unit")

			table.insert(slot0._unitItemList, slot8)
			UISpriteSetMgr.instance:setRoomSprite(slot8.imageunit, "mapunit" .. RoomBlockHelper.getMapResourceId(slot6))
			slot0:_setCommonPosition(slot8.go.transform, slot7)
			gohelper.setActive(slot8.go, true)
		end
	end
end

function slot0._refreshBuildingItems(slot0)
	for slot5, slot6 in ipairs(RoomMapBlockModel.instance:getBlockMOList()) do
		if slot6.blockState == RoomBlockEnum.BlockState.Map then
			slot9 = RoomBuildingHelper.getOccupyBuildingParam(slot6.hexPoint) and slot8.buildingUid
			slot10 = slot9 and RoomMapBuildingModel.instance:getBuildingMOById(slot9)

			if slot10 and slot10.config.buildingType and slot11 ~= RoomBuildingEnum.BuildingType.Decoration then
				slot13 = slot0:getUserDataTb_()
				slot13.id = slot10.id
				slot13.go = gohelper.cloneInPlace(slot0._gobuildingitem, string.format("%s_%s", slot7.x, slot7.y))
				slot13.imagebuilding = gohelper.findChildImage(slot13.go, "image_building")

				table.insert(slot0._buildingItemList, slot13)
				UISpriteSetMgr.instance:setRoomSprite(slot13.imagebuilding, "buildingtype" .. (slot10 and slot10.config.buildingShowType))
				slot0:_setCommonPosition(slot13.go.transform, slot7)
				gohelper.setActive(slot13.go, true)
			end
		end
	end
end

function slot0._refreshInitBuildingItems(slot0)
	for slot5, slot6 in pairs(RoomConfig.instance:getInitBuildingOccupyDict()) do
		for slot10, slot11 in pairs(slot6) do
			slot12 = HexPoint(slot5, slot10)
			slot13 = slot0:getUserDataTb_()
			slot13.id = 0
			slot13.go = gohelper.cloneInPlace(slot0._gobuildingitem, string.format("%s_%s", slot12.x, slot12.y))
			slot13.imagebuilding = gohelper.findChildImage(slot13.go, "image_building")
			slot13.btnbuilding = gohelper.findChildButtonWithAudio(slot13.go, "btn_building")

			table.insert(slot0._buildingItemList, slot13)
			gohelper.setActive(slot13.btnbuilding.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(slot13.imagebuilding, "#A29E88")
			UISpriteSetMgr.instance:setRoomSprite(slot13.imagebuilding, "buildingtype0")
			recthelper.setWidth(slot13.imagebuilding.gameObject.transform, 38)
			recthelper.setHeight(slot13.imagebuilding.gameObject.transform, 31)
			slot0:_setCommonPosition(slot13.go.transform, slot12)
			gohelper.setActive(slot13.go, true)
		end
	end
end

function slot0._refreshRedpointItems(slot0)
	slot1 = RoomMapBuildingModel.instance:getBuildingMOList()

	for slot5, slot6 in pairs(slot0._redpointItemDict) do
		gohelper.setActive(slot6.go, false)
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RoomBuildingHelper.getTopRightHexPoint(slot6.buildingId, slot6.hexPoint, slot6.rotate)

		if slot6.config.buildingType ~= RoomBuildingEnum.BuildingType.Decoration and slot7 and slot6.buildingState == RoomBuildingEnum.BuildingState.Map then
			if not slot0._redpointItemDict[slot6.id] then
				slot9 = slot0:getUserDataTb_()
				slot9.go = gohelper.cloneInPlace(slot0._goredpointitem, string.format("%s_%s", slot7.x, slot7.y))
				slot9.goreddot = gohelper.findChild(slot9.go, "go_buildingreddot")

				if RoomController.instance:isObMode() then
					RedDotController.instance:addMultiRedDot(slot9.goreddot, {
						{
							id = RedDotEnum.DotNode.RoomBuildingFull,
							uid = tonumber(slot6.id)
						},
						{
							id = RedDotEnum.DotNode.RoomBuildingGet,
							uid = tonumber(slot6.id)
						}
					})
				end

				slot0._redpointItemDict[slot6.id] = slot9

				slot0:_setCommonPosition(slot9.go.transform, slot7)
			end

			gohelper.setActive(slot9.go, true)
		end
	end
end

function slot0._setCommonPosition(slot0, slot1, slot2)
	slot3 = HexMath.hexToPosition(slot2, 43.78481 / math.sqrt(3) * 2)
	slot4 = 30 * Mathf.Deg2Rad
	slot5 = Vector2(slot3.x * Mathf.Cos(slot4) - slot3.y * Mathf.Sin(slot4), slot3.x * Mathf.Sin(slot4) + slot3.y * Mathf.Cos(slot4))
	slot0._left = math.min(slot5.x, slot0._left)
	slot0._right = math.max(slot5.x, slot0._right)
	slot0._bottom = math.min(slot5.y, slot0._bottom)
	slot0._top = math.max(slot5.y, slot0._top)

	recthelper.setAnchor(slot1, slot3.x, slot3.y)
end

function slot0._getMapPos(slot0, slot1)
	slot2 = HexMath.hexToPosition(slot1, 43.78481 / math.sqrt(3) * 2)
	slot3 = 30 * Mathf.Deg2Rad
	slot4 = Vector2(slot2.x * Mathf.Cos(slot3) - slot2.y * Mathf.Sin(slot3), slot2.x * Mathf.Sin(slot3) + slot2.y * Mathf.Cos(slot3))

	return Vector2(slot4.x * slot0._scale, slot4.y * slot0._scale)
end

function slot0.onDestroyView(slot0)
	if slot0._touchMgr then
		TouchEventMgrHepler.remove(slot0._touchMgr)

		slot0._touchMgr = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerighticon2:UnLoadImage()
	slot0._simagemask:UnLoadImage()
	slot0._simageline:UnLoadImage()
	slot0._simageline2:UnLoadImage()
	slot0._simagecontour:UnLoadImage()
end

return slot0

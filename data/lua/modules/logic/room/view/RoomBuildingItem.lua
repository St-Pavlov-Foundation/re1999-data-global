module("modules.logic.room.view.RoomBuildingItem", package.seeall)

slot0 = class("RoomBuildingItem", ListScrollCellExtend)
slot0.DRAG_RADIUS = 15

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_content/#simage_icon")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_count")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_buildingname")
	slot0._imagearea = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_area")
	slot0._gogroupres = gohelper.findChild(slot0.viewGO, "#go_content/#go_groupres")
	slot0._imageres = gohelper.findChildImage(slot0.viewGO, "#go_content/#go_groupres/#image_res")
	slot0._txtaddvalue = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_addvalue")
	slot0._txtcostres = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_costres")
	slot0._imagecostresicon = gohelper.findChildImage(slot0.viewGO, "#go_content/#txt_costres/#image_costresicon")
	slot0._buildingusedesc = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_buildingusedesc")
	slot0._imagebuildingtype = gohelper.findChildImage(slot0.viewGO, "#go_content/#image_buildingtype")
	slot0._txtcritternum = gohelper.findChildText(slot0.viewGO, "#go_content/#txt_critternum")
	slot0._simagebuilddegree = gohelper.findChildImage(slot0.viewGO, "#go_content/#txt_addvalue/#simage_builddegree")
	slot0._gobeplaced = gohelper.findChild(slot0.viewGO, "#go_content/#go_beplaced")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_content/#go_select")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_click")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#go_content/#go_reddot")
	slot0._govehicle = gohelper.findChild(slot0.viewGO, "#go_content/#go_vehicle")
	slot0._goneed2buy = gohelper.findChild(slot0.viewGO, "#go_content/#go_need2buy")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "#go_content/#go_need2buy/go_costcontent/#go_costitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.addEventListeners(slot0)
	slot0._btnUIlongPrees:SetLongPressTime(slot0._longPressArr)
	slot0._btnUIlongPrees:AddLongPressListener(slot0._onbtnlongPrees, slot0)
	slot0._btnUIclick:AddClickListener(slot0._btnclickOnClick, slot0)

	if slot0._btnUIdrag then
		slot0._btnUIdrag:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._btnUIdrag:AddDragListener(slot0._onDragIng, slot0)
		slot0._btnUIdrag:AddDragEndListener(slot0._onDragEnd, slot0)
	end
end

function slot0.removeEventListeners(slot0)
	slot0._btnUIlongPrees:RemoveLongPressListener()
	slot0._btnUIclick:RemoveClickListener()

	if slot0._btnUIdrag then
		slot0._btnUIdrag:RemoveDragBeginListener()
		slot0._btnUIdrag:RemoveDragListener()
		slot0._btnUIdrag:RemoveDragEndListener()
	end
end

function slot0._btnclickOnClick(slot0)
	if slot0._scene.camera:isTweening() or slot0:_cancelTouch() then
		return
	end

	slot0:_hideReddot()

	slot1 = slot0._mo.uids[1]

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		if RoomMapBuildingModel.instance:getTempBuildingMO() and slot2.id == slot1 then
			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				focus = true,
				buildingUid = slot1
			})

			return
		end

		if slot0._mo.use then
			slot3 = slot1 and RoomMapBuildingModel.instance:getBuildingMOById(slot1)

			slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				buildingUid = slot1,
				hexPoint = slot3.hexPoint,
				rotate = slot3.rotate
			})
			slot0:_playPlaceAudio(slot3)
		else
			slot5 = slot1 and RoomInventoryBuildingModel.instance:getBuildingMOById(slot1)

			if not slot7 then
				slot10, slot11 = RoomBuildingAreaHelper.checkBuildingArea(slot5.buildingId, slot0:_getRecommendHexPoint(slot5, RoomRotateHelper.getCameraNearRotate(slot0._scene.camera:getCameraRotate() * Mathf.Rad2Deg) + RoomConfig.instance:getBuildingConfig(slot5.buildingId).rotate) and slot7.hexPoint or slot0:_findNearHexPoint(), slot7 and slot7.rotate or slot3)

				if slot11 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
					GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
				elseif slot11 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
					GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
				else
					GameFacade.showToast(ToastEnum.RoomBuilding)
				end
			end

			slot10 = {
				buildingUid = slot1,
				hexPoint = slot8,
				rotate = slot9
			}

			TaskDispatcher.runDelay(function ()
				GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, uv0)
			end, slot0, 0.05)
			slot0:_playPlaceAudio(slot5)
		end
	end

	RoomShowBuildingListModel.instance:setSelect(slot0._mo.id)
end

function slot0._playPlaceAudio(slot0, slot1)
	if slot1 and slot1:getPlaceAudioId(true) ~= 0 then
		AudioMgr.instance:trigger(slot2)
	end
end

function slot0._findNearHexPoint(slot0)
	return RoomBuildingHelper.findNearBlockHexPoint(HexMath.positionToRoundHex(slot0._scene.camera:getCameraFocus(), RoomBlockEnum.BlockSize), slot0._mo.id) or slot2
end

function slot0._getRecommendHexPoint(slot0, slot1, slot2)
	slot4 = nil

	if slot1.config.vehicleType ~= 0 then
		slot4 = slot0:_getVehicleHexPoint(slot1, slot2)
	end

	return slot4 or RoomBuildingHelper.getRecommendHexPoint(slot1.buildingId, nil, , slot1.levels, slot2)
end

function slot0._getVehicleHexPoint(slot0, slot1, slot2)
	if not RoomConfig.instance:getVehicleConfig(slot1.config.vehicleId) then
		return nil
	end

	slot6 = RoomConfig.instance:getResourceConfig(slot4.resId) and slot5.numLimit or 2

	if not RoomResourceHelper.getResourcePointAreaMODict(nil, {
		slot4.resId
	})[slot4.resId] then
		return nil
	end

	slot10 = {}

	for slot14, slot15 in ipairs(slot8:findeArea()) do
		if slot6 <= slot0:_getNumByResourcePointList(slot15) then
			tabletool.addValues(slot10, slot15)
		end
	end

	if #slot10 > 0 then
		return slot0:_getHexPointByResourcePoint(slot1, slot2, slot10)
	end
end

function slot0._getNumByResourcePointList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in ipairs(slot1) do
		if not slot2[RoomResourceModel.instance:getIndexByXY(slot9.x, slot9.y)] then
			slot3 = 0 + 1
			slot2[slot10] = true
		end
	end

	return slot3
end

function slot0._getHexPointByResourcePoint(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = RoomMapBlockModel.instance:getBlockMODict()

	for slot9, slot10 in ipairs(slot3) do
		slot12 = slot10.y

		if not slot4[slot10.x] then
			slot4[slot11] = {}
		end

		slot4[slot11][slot12] = slot5[slot11][slot12]
	end

	return RoomBuildingHelper.getRecommendHexPoint(slot1.buildingId, slot4, nil, slot1.levels, slot2)
end

function slot0._starDragBuilding(slot0)
	slot0._isStarDrag = true

	slot0._scene.touch:setUIDragScreenScroll(true)

	slot2 = RoomMapBuildingModel.instance:getBuildingMOById(slot0._mo.uids[1]) or RoomInventoryBuildingModel.instance:getBuildingMOById(slot1)

	slot0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
		press = true,
		buildingUid = slot1,
		hexPoint = RoomBendingHelper.screenPosToHex(GamepadController.instance:getMousePosition()),
		rotate = slot2 and slot2.rotate or 0
	})
	RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, GamepadController.instance:getMousePosition(), slot1)
	slot0:_hideReddot()
end

function slot0._onbtnlongPrees(slot0)
	if slot0._scene.camera:isTweening() or not slot0._mo or slot0._mo.use then
		return
	end

	if slot0:_cancelTouch() then
		return
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isDragBeginOp = true
	slot0._dragBginePosition = slot2.position

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragBeginListener, slot2)
end

function slot0._onDragIng(slot0, slot1, slot2)
	if not slot0._isDragBeginOp then
		return
	end

	if not slot0._isStarDrag and slot2.position.y - slot0._dragBginePosition.y > 50 and slot0._buildingDragStarY < slot3 then
		slot0:_starDragBuilding()
	end

	if slot0._isStarDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, slot2.position)
	else
		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragListener, slot2)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._isDragBeginOp = false
	slot0._dragBginePosition = nil

	if slot0._isStarDrag then
		slot0._isStarDrag = false

		slot0._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, slot2.position)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragEndListener, slot2)
end

function slot0._cancelTouch(slot0)
	if slot0._dragBginePosition then
		if GamepadController.instance:isOpen() then
			return uv0.DRAG_RADIUS < Vector2.Distance(slot0._dragBginePosition, GamepadController.instance:getScreenPos())
		else
			return uv0.DRAG_RADIUS < Vector2.Distance(slot0._dragBginePosition, GamepadController.instance:getMousePosition())
		end
	end

	return false
end

function slot0._editableInitView(slot0)
	slot0._longPressArr = {
		0.2,
		99999
	}
	slot0._buildingDragStarY = 350 * UnityEngine.Screen.height / 1080
	slot0._scene = GameSceneMgr.instance:getCurScene()

	UISpriteSetMgr.instance:setRoomSprite(slot0._simagebuilddegree, "jianshezhi")

	slot0._isSelect = false
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot1 = slot0._btnclick.gameObject

	gohelper.addUIClickAudio(slot1, AudioEnum.UI.UI_Common_Click)

	slot0._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot1)
	slot0._btnUIclick = SLFramework.UGUI.UIClickListener.Get(slot1)
	slot0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(slot1)

	gohelper.setActive(slot0._gocostitem, false)

	slot0._buildingTypeDefindeColor = "#FFFFFF"
	slot0._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#6E9FB1",
		[RoomBuildingEnum.BuildingType.Process] = "#C6BA7B",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#7BB19A"
	}
end

function slot0._refreshUI(slot0)
	slot0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. slot0._mo:getIcon()))
	gohelper.setActive(slot0._gobeplaced, slot0._mo.use)

	slot0._txtcount.text = string.format("<size=24>%s  </size>%d", luaLang("multiple"), #slot0._mo.uids)
	slot0._txtaddvalue.text = slot0._mo.config.buildDegree
	slot0._txtbuildingname.text = slot0._mo.config.name

	gohelper.setActive(slot0._txtcostres.gameObject, false)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagearea, "xiaowuliubianxing_" .. RoomConfig.instance:getBuildingAreaConfig(slot0._mo.config.areaId).icon)
	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, RoomBuildingEnum.RareIcon[slot0._mo.config.rare] or RoomBuildingEnum.RareIcon[1])
	gohelper.setActive(slot0._goreddot, not slot0._mo.use)

	if not slot0._mo.use then
		RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, slot0._mo.buildingId)
	end

	if slot0._refresCostBuilding ~= slot0._mo.buildingId then
		slot0._refresCostBuilding = slot0._mo.buildingId

		slot0:_refreshCostResList(slot0._mo.buildingId)
	end

	gohelper.setActive(slot0._govehicle, slot0._mo.config.vehicleType ~= 0)
	gohelper.setActive(slot0._goneed2buy, slot0._mo.isNeedToBuy == true and slot0._mo.isBuyNoCost ~= true)

	if slot0._mo.isNeedToBuy == true and slot0._mo.isBuyNoCost ~= true then
		slot0:_refreshPlaceCost(slot0._mo.buildingId)
	end

	slot3 = true

	if slot0._mo.config.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
		slot3 = false
	end

	gohelper.setActive(slot0._txtcount, slot3)
	gohelper.setActive(slot0._txtaddvalue, slot3)
	gohelper.setActive(slot0._buildingusedesc, not slot3)
	gohelper.setActive(slot0._imagebuildingtype, not slot3)

	if slot3 then
		gohelper.setActive(slot0._txtcritternum, false)
	else
		slot0:_refreshBuildingTypeIcon(slot0._mo.config)
	end
end

function slot0._refreshCostResList(slot0, slot1)
	slot0._imageResList = slot0._imageResList or {
		slot0._imageres
	}
	slot3 = RoomBuildingHelper.getCostResource(slot1) and #slot2 or 0

	for slot7 = 1, slot3 do
		if not slot0._imageResList[slot7] then
			table.insert(slot0._imageResList, gohelper.onceAddComponent(gohelper.clone(slot0._imageres.gameObject, slot0._gogroupres, "imageres" .. slot7), gohelper.Type_Image))
		end

		gohelper.setActive(slot8.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(slot8, string.format("fanzhi_icon_%s", slot2[slot7]))
	end

	for slot7 = slot3 + 1, #slot0._imageResList do
		gohelper.setActive(slot0._imageResList[slot7].gameObject, false)
	end
end

function slot0._refreshPlaceCost(slot0, slot1)
	if slot0._lastCostPlaceId == slot1 then
		return
	end

	slot0._lastCostPlaceId = slot1

	if ManufactureConfig.instance:getManufactureBuildingCfg(slot1) then
		slot0._costDataList = ItemModel.instance:getItemDataListByConfigStr(slot2.placeCost)
	end

	slot0._costDataList = slot0._costDataList or {}
	slot0._costItemList = slot0._costItemList or {}

	for slot6, slot7 in ipairs(slot0._costDataList) do
		if not slot0._costItemList[slot6] then
			slot8 = {}

			table.insert(slot0._costItemList, slot8)

			slot9 = gohelper.cloneInPlace(slot0._gocostitem, "gocostitem_" .. slot6)

			gohelper.setActive(slot9, true)

			slot8.go = slot9
			slot8.txtnum = gohelper.findChildText(slot9, "txt_num")
			slot8.imageicon = gohelper.findChildImage(slot9, "image_icon")
		else
			gohelper.setActive(slot8.go, true)
		end

		slot8.txtnum.text = slot7.quantity

		if slot7.materilType == MaterialEnum.MaterialType.Currency and CurrencyConfig.instance:getCurrencyCo(slot7.materilId) then
			slot9 = slot10.icon
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot8.imageicon, slot9 .. "_1")
	end

	for slot6 = #slot0._costDataList + 1, #slot0._costItemList do
		gohelper.setActive(slot0._costItemList[slot6].go, true)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot0._isSelect)

	slot0._mo = slot1
	slot2 = slot1 and slot1.config

	gohelper.setActive(slot0._gocontent, slot2)

	if slot2 then
		slot0:_refreshUI()
		slot0:_updateAnchorX()
	end
end

function slot0._updateAnchorX(slot0)
	recthelper.setAnchorX(slot0._gocontent.transform, RoomShowBuildingListModel.instance:getItemAnchorX() or 0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onSelect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)

	slot0._isSelect = slot1

	slot0:_updateAnchorX()
end

function slot0.onDestroy(slot0)
	slot0._simageicon:UnLoadImage()

	if slot0._costItemList and #slot0._costItemList > 0 then
		slot0._costItemList = nil

		for slot5 = 1, #slot0._costItemList do
			for slot10 in pairs(slot1[slot5]) do
				rawset(slot6, slot10, nil)
			end
		end
	end
end

function slot0._refreshBuildingTypeIcon(slot0, slot1)
	slot4 = slot0._buildingTypeIconColor[slot1.buildingType] or slot0._buildingTypeDefindeColor

	SLFramework.UGUI.GuiHelper.SetColor(slot0._buildingusedesc, slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagebuildingtype, slot4)

	slot5 = nil
	slot0._buildingusedesc.text = slot1.useDesc

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingtype, (not RoomBuildingEnum.BuildingArea[slot2] or ManufactureConfig.instance:getManufactureBuildingIcon(slot1.id)) and RoomConfig.instance:getBuildingTypeIcon(slot2))

	slot6 = 0

	if RoomBuildingEnum.BuildingArea[slot2] or slot2 == RoomBuildingEnum.BuildingType.Rest then
		slot6 = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(slot3, ManufactureModel.instance:getTradeLevel())
	end

	gohelper.setActive(slot0._txtcritternum, slot6 > 0)

	if slot6 > 0 then
		slot0._txtcritternum.text = slot6
	end
end

function slot0._hideReddot(slot0)
	if slot0._mo.use then
		return
	end

	if not RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace) or not slot1.infos then
		return
	end

	if not slot1.infos[slot0._mo.buildingId] then
		return
	end

	if slot2.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(slot0._mo.buildingId)
	end
end

return slot0

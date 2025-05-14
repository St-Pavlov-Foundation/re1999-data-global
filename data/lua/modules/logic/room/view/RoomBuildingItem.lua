module("modules.logic.room.view.RoomBuildingItem", package.seeall)

local var_0_0 = class("RoomBuildingItem", ListScrollCellExtend)

var_0_0.DRAG_RADIUS = 15

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_content/#simage_icon")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_count")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingname")
	arg_1_0._imagearea = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_area")
	arg_1_0._gogroupres = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_groupres")
	arg_1_0._imageres = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#go_groupres/#image_res")
	arg_1_0._txtaddvalue = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_addvalue")
	arg_1_0._txtcostres = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_costres")
	arg_1_0._imagecostresicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#txt_costres/#image_costresicon")
	arg_1_0._buildingusedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_buildingusedesc")
	arg_1_0._imagebuildingtype = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#image_buildingtype")
	arg_1_0._txtcritternum = gohelper.findChildText(arg_1_0.viewGO, "#go_content/#txt_critternum")
	arg_1_0._simagebuilddegree = gohelper.findChildImage(arg_1_0.viewGO, "#go_content/#txt_addvalue/#simage_builddegree")
	arg_1_0._gobeplaced = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_beplaced")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_click")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_reddot")
	arg_1_0._govehicle = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_vehicle")
	arg_1_0._goneed2buy = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_need2buy")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_need2buy/go_costcontent/#go_costitem")

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

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0._btnUIlongPrees:SetLongPressTime(arg_4_0._longPressArr)
	arg_4_0._btnUIlongPrees:AddLongPressListener(arg_4_0._onbtnlongPrees, arg_4_0)
	arg_4_0._btnUIclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)

	if arg_4_0._btnUIdrag then
		arg_4_0._btnUIdrag:AddDragBeginListener(arg_4_0._onDragBegin, arg_4_0)
		arg_4_0._btnUIdrag:AddDragListener(arg_4_0._onDragIng, arg_4_0)
		arg_4_0._btnUIdrag:AddDragEndListener(arg_4_0._onDragEnd, arg_4_0)
	end
end

function var_0_0.removeEventListeners(arg_5_0)
	arg_5_0._btnUIlongPrees:RemoveLongPressListener()
	arg_5_0._btnUIclick:RemoveClickListener()

	if arg_5_0._btnUIdrag then
		arg_5_0._btnUIdrag:RemoveDragBeginListener()
		arg_5_0._btnUIdrag:RemoveDragListener()
		arg_5_0._btnUIdrag:RemoveDragEndListener()
	end
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0._scene.camera:isTweening() or arg_6_0:_cancelTouch() then
		return
	end

	arg_6_0:_hideReddot()

	local var_6_0 = arg_6_0._mo.uids[1]

	if RoomHelper.isFSMState(RoomEnum.FSMObState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMObState.PlaceBuildingConfirm) or RoomHelper.isFSMState(RoomEnum.FSMEditState.Idle) or RoomHelper.isFSMState(RoomEnum.FSMEditState.PlaceBuildingConfirm) then
		local var_6_1 = RoomMapBuildingModel.instance:getTempBuildingMO()

		if var_6_1 and var_6_1.id == var_6_0 then
			arg_6_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				focus = true,
				buildingUid = var_6_0
			})

			return
		end

		if arg_6_0._mo.use then
			local var_6_2 = var_6_0 and RoomMapBuildingModel.instance:getBuildingMOById(var_6_0)

			arg_6_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
				buildingUid = var_6_0,
				hexPoint = var_6_2.hexPoint,
				rotate = var_6_2.rotate
			})
			arg_6_0:_playPlaceAudio(var_6_2)
		else
			local var_6_3 = arg_6_0._scene.camera:getCameraRotate() * Mathf.Rad2Deg
			local var_6_4 = RoomRotateHelper.getCameraNearRotate(var_6_3)
			local var_6_5 = var_6_0 and RoomInventoryBuildingModel.instance:getBuildingMOById(var_6_0)
			local var_6_6 = var_6_4 + RoomConfig.instance:getBuildingConfig(var_6_5.buildingId).rotate
			local var_6_7 = arg_6_0:_getRecommendHexPoint(var_6_5, var_6_6)
			local var_6_8 = var_6_7 and var_6_7.hexPoint or arg_6_0:_findNearHexPoint()
			local var_6_9 = var_6_7 and var_6_7.rotate or var_6_6

			if not var_6_7 then
				local var_6_10, var_6_11 = RoomBuildingAreaHelper.checkBuildingArea(var_6_5.buildingId, var_6_8, var_6_9)

				if var_6_11 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding then
					GameFacade.showToast(ToastEnum.NoAreaMainBuilding)
				elseif var_6_11 == RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding then
					GameFacade.showToast(ToastEnum.OutSizeAreaBuilding)
				else
					GameFacade.showToast(ToastEnum.RoomBuilding)
				end
			end

			local var_6_12 = {
				buildingUid = var_6_0,
				hexPoint = var_6_8,
				rotate = var_6_9
			}

			TaskDispatcher.runDelay(function()
				GameSceneMgr.instance:getCurScene().fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, var_6_12)
			end, arg_6_0, 0.05)
			arg_6_0:_playPlaceAudio(var_6_5)
		end
	end

	RoomShowBuildingListModel.instance:setSelect(arg_6_0._mo.id)
end

function var_0_0._playPlaceAudio(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_1:getPlaceAudioId(true)

		if var_8_0 ~= 0 then
			AudioMgr.instance:trigger(var_8_0)
		end
	end
end

function var_0_0._findNearHexPoint(arg_9_0)
	local var_9_0 = arg_9_0._scene.camera:getCameraFocus()
	local var_9_1 = HexMath.positionToRoundHex(var_9_0, RoomBlockEnum.BlockSize)

	return RoomBuildingHelper.findNearBlockHexPoint(var_9_1, arg_9_0._mo.id) or var_9_1
end

function var_0_0._getRecommendHexPoint(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1.config
	local var_10_1

	if var_10_0.vehicleType ~= 0 then
		var_10_1 = arg_10_0:_getVehicleHexPoint(arg_10_1, arg_10_2)
	end

	return var_10_1 or RoomBuildingHelper.getRecommendHexPoint(arg_10_1.buildingId, nil, nil, arg_10_1.levels, arg_10_2)
end

function var_0_0._getVehicleHexPoint(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_1.config
	local var_11_1 = RoomConfig.instance:getVehicleConfig(var_11_0.vehicleId)

	if not var_11_1 then
		return nil
	end

	local var_11_2 = RoomConfig.instance:getResourceConfig(var_11_1.resId)
	local var_11_3 = var_11_2 and var_11_2.numLimit or 2
	local var_11_4 = RoomResourceHelper.getResourcePointAreaMODict(nil, {
		var_11_1.resId
	})[var_11_1.resId]

	if not var_11_4 then
		return nil
	end

	local var_11_5 = var_11_4:findeArea()
	local var_11_6 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_5) do
		if var_11_3 <= arg_11_0:_getNumByResourcePointList(iter_11_1) then
			tabletool.addValues(var_11_6, iter_11_1)
		end
	end

	if #var_11_6 > 0 then
		return arg_11_0:_getHexPointByResourcePoint(arg_11_1, arg_11_2, var_11_6)
	end
end

function var_0_0._getNumByResourcePointList(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = 0
	local var_12_2 = RoomResourceModel.instance

	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_3 = var_12_2:getIndexByXY(iter_12_1.x, iter_12_1.y)

		if not var_12_0[var_12_3] then
			var_12_1 = var_12_1 + 1
			var_12_0[var_12_3] = true
		end
	end

	return var_12_1
end

function var_0_0._getHexPointByResourcePoint(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}
	local var_13_1 = RoomMapBlockModel.instance:getBlockMODict()

	for iter_13_0, iter_13_1 in ipairs(arg_13_3) do
		local var_13_2 = iter_13_1.x
		local var_13_3 = iter_13_1.y

		if not var_13_0[var_13_2] then
			var_13_0[var_13_2] = {}
		end

		var_13_0[var_13_2][var_13_3] = var_13_1[var_13_2][var_13_3]
	end

	return RoomBuildingHelper.getRecommendHexPoint(arg_13_1.buildingId, var_13_0, nil, arg_13_1.levels, arg_13_2)
end

function var_0_0._starDragBuilding(arg_14_0)
	arg_14_0._isStarDrag = true

	arg_14_0._scene.touch:setUIDragScreenScroll(true)

	local var_14_0 = arg_14_0._mo.uids[1]
	local var_14_1 = RoomMapBuildingModel.instance:getBuildingMOById(var_14_0) or RoomInventoryBuildingModel.instance:getBuildingMOById(var_14_0)

	arg_14_0._scene.fsm:triggerEvent(RoomSceneEvent.TryPlaceBuilding, {
		press = true,
		buildingUid = var_14_0,
		hexPoint = RoomBendingHelper.screenPosToHex(GamepadController.instance:getMousePosition()),
		rotate = var_14_1 and var_14_1.rotate or 0
	})
	RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, GamepadController.instance:getMousePosition(), var_14_0)
	arg_14_0:_hideReddot()
end

function var_0_0._onbtnlongPrees(arg_15_0)
	if arg_15_0._scene.camera:isTweening() or not arg_15_0._mo or arg_15_0._mo.use then
		return
	end

	if arg_15_0:_cancelTouch() then
		return
	end
end

function var_0_0._onDragBegin(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._isDragBeginOp = true
	arg_16_0._dragBginePosition = arg_16_2.position

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragBeginListener, arg_16_2)
end

function var_0_0._onDragIng(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._isDragBeginOp then
		return
	end

	if not arg_17_0._isStarDrag then
		local var_17_0 = arg_17_2.position.y

		if var_17_0 - arg_17_0._dragBginePosition.y > 50 and var_17_0 > arg_17_0._buildingDragStarY then
			arg_17_0:_starDragBuilding()
		end
	end

	if arg_17_0._isStarDrag then
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchPressBuilding, arg_17_2.position)
	else
		RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragListener, arg_17_2)
	end
end

function var_0_0._onDragEnd(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._isDragBeginOp = false
	arg_18_0._dragBginePosition = nil

	if arg_18_0._isStarDrag then
		arg_18_0._isStarDrag = false

		arg_18_0._scene.touch:setUIDragScreenScroll(false)
		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDropBuilding, arg_18_2.position)
	end

	RoomBuildingController.instance:dispatchEvent(RoomEvent.BuildingListOnDragEndListener, arg_18_2)
end

function var_0_0._cancelTouch(arg_19_0)
	if arg_19_0._dragBginePosition then
		if GamepadController.instance:isOpen() then
			return Vector2.Distance(arg_19_0._dragBginePosition, GamepadController.instance:getScreenPos()) > var_0_0.DRAG_RADIUS
		else
			return Vector2.Distance(arg_19_0._dragBginePosition, GamepadController.instance:getMousePosition()) > var_0_0.DRAG_RADIUS
		end
	end

	return false
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0._longPressArr = {
		0.2,
		99999
	}
	arg_20_0._buildingDragStarY = 350 * UnityEngine.Screen.height / 1080
	arg_20_0._scene = GameSceneMgr.instance:getCurScene()

	UISpriteSetMgr.instance:setRoomSprite(arg_20_0._simagebuilddegree, "jianshezhi")

	arg_20_0._isSelect = false
	arg_20_0._animator = arg_20_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_20_0 = arg_20_0._btnclick.gameObject

	gohelper.addUIClickAudio(var_20_0, AudioEnum.UI.UI_Common_Click)

	arg_20_0._btnUIlongPrees = SLFramework.UGUI.UILongPressListener.Get(var_20_0)
	arg_20_0._btnUIclick = SLFramework.UGUI.UIClickListener.Get(var_20_0)
	arg_20_0._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(var_20_0)

	gohelper.setActive(arg_20_0._gocostitem, false)

	arg_20_0._buildingTypeDefindeColor = "#FFFFFF"
	arg_20_0._buildingTypeIconColor = {
		[RoomBuildingEnum.BuildingType.Collect] = "#6E9FB1",
		[RoomBuildingEnum.BuildingType.Process] = "#C6BA7B",
		[RoomBuildingEnum.BuildingType.Manufacture] = "#7BB19A"
	}
end

function var_0_0._refreshUI(arg_21_0)
	arg_21_0._simageicon:LoadImage(ResUrl.getRoomImage("building/" .. arg_21_0._mo:getIcon()))
	gohelper.setActive(arg_21_0._gobeplaced, arg_21_0._mo.use)

	arg_21_0._txtcount.text = string.format("<size=24>%s  </size>%d", luaLang("multiple"), #arg_21_0._mo.uids)
	arg_21_0._txtaddvalue.text = arg_21_0._mo.config.buildDegree
	arg_21_0._txtbuildingname.text = arg_21_0._mo.config.name

	gohelper.setActive(arg_21_0._txtcostres.gameObject, false)

	local var_21_0 = RoomConfig.instance:getBuildingAreaConfig(arg_21_0._mo.config.areaId)

	UISpriteSetMgr.instance:setRoomSprite(arg_21_0._imagearea, "xiaowuliubianxing_" .. var_21_0.icon)

	local var_21_1 = RoomBuildingEnum.RareIcon[arg_21_0._mo.config.rare] or RoomBuildingEnum.RareIcon[1]

	UISpriteSetMgr.instance:setRoomSprite(arg_21_0._imagerare, var_21_1)
	gohelper.setActive(arg_21_0._goreddot, not arg_21_0._mo.use)

	if not arg_21_0._mo.use then
		RedDotController.instance:addRedDot(arg_21_0._goreddot, RedDotEnum.DotNode.RoomBuildingPlace, arg_21_0._mo.buildingId)
	end

	if arg_21_0._refresCostBuilding ~= arg_21_0._mo.buildingId then
		arg_21_0._refresCostBuilding = arg_21_0._mo.buildingId

		arg_21_0:_refreshCostResList(arg_21_0._mo.buildingId)
	end

	gohelper.setActive(arg_21_0._govehicle, arg_21_0._mo.config.vehicleType ~= 0)
	gohelper.setActive(arg_21_0._goneed2buy, arg_21_0._mo.isNeedToBuy == true and arg_21_0._mo.isBuyNoCost ~= true)

	if arg_21_0._mo.isNeedToBuy == true and arg_21_0._mo.isBuyNoCost ~= true then
		arg_21_0:_refreshPlaceCost(arg_21_0._mo.buildingId)
	end

	local var_21_2 = true

	if arg_21_0._mo.config.buildingType ~= RoomBuildingEnum.BuildingType.Decoration then
		var_21_2 = false
	end

	gohelper.setActive(arg_21_0._txtcount, var_21_2)
	gohelper.setActive(arg_21_0._txtaddvalue, var_21_2)
	gohelper.setActive(arg_21_0._buildingusedesc, not var_21_2)
	gohelper.setActive(arg_21_0._imagebuildingtype, not var_21_2)

	if var_21_2 then
		gohelper.setActive(arg_21_0._txtcritternum, false)
	else
		arg_21_0:_refreshBuildingTypeIcon(arg_21_0._mo.config)
	end
end

function var_0_0._refreshCostResList(arg_22_0, arg_22_1)
	arg_22_0._imageResList = arg_22_0._imageResList or {
		arg_22_0._imageres
	}

	local var_22_0 = RoomBuildingHelper.getCostResource(arg_22_1)
	local var_22_1 = var_22_0 and #var_22_0 or 0

	for iter_22_0 = 1, var_22_1 do
		local var_22_2 = arg_22_0._imageResList[iter_22_0]

		if not var_22_2 then
			local var_22_3 = gohelper.clone(arg_22_0._imageres.gameObject, arg_22_0._gogroupres, "imageres" .. iter_22_0)

			var_22_2 = gohelper.onceAddComponent(var_22_3, gohelper.Type_Image)

			table.insert(arg_22_0._imageResList, var_22_2)
		end

		gohelper.setActive(var_22_2.gameObject, true)
		UISpriteSetMgr.instance:setRoomSprite(var_22_2, string.format("fanzhi_icon_%s", var_22_0[iter_22_0]))
	end

	for iter_22_1 = var_22_1 + 1, #arg_22_0._imageResList do
		local var_22_4 = arg_22_0._imageResList[iter_22_1]

		gohelper.setActive(var_22_4.gameObject, false)
	end
end

function var_0_0._refreshPlaceCost(arg_23_0, arg_23_1)
	if arg_23_0._lastCostPlaceId == arg_23_1 then
		return
	end

	arg_23_0._lastCostPlaceId = arg_23_1

	local var_23_0 = ManufactureConfig.instance:getManufactureBuildingCfg(arg_23_1)

	if var_23_0 then
		arg_23_0._costDataList = ItemModel.instance:getItemDataListByConfigStr(var_23_0.placeCost)
	end

	arg_23_0._costDataList = arg_23_0._costDataList or {}
	arg_23_0._costItemList = arg_23_0._costItemList or {}

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._costDataList) do
		local var_23_1 = arg_23_0._costItemList[iter_23_0]

		if not var_23_1 then
			var_23_1 = {}

			table.insert(arg_23_0._costItemList, var_23_1)

			local var_23_2 = gohelper.cloneInPlace(arg_23_0._gocostitem, "gocostitem_" .. iter_23_0)

			gohelper.setActive(var_23_2, true)

			var_23_1.go = var_23_2
			var_23_1.txtnum = gohelper.findChildText(var_23_2, "txt_num")
			var_23_1.imageicon = gohelper.findChildImage(var_23_2, "image_icon")
		else
			gohelper.setActive(var_23_1.go, true)
		end

		var_23_1.txtnum.text = iter_23_1.quantity

		local var_23_3 = iter_23_1.materilId

		if iter_23_1.materilType == MaterialEnum.MaterialType.Currency then
			local var_23_4 = CurrencyConfig.instance:getCurrencyCo(var_23_3)

			if var_23_4 then
				var_23_3 = var_23_4.icon
			end
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(var_23_1.imageicon, var_23_3 .. "_1")
	end

	for iter_23_2 = #arg_23_0._costDataList + 1, #arg_23_0._costItemList do
		gohelper.setActive(arg_23_0._costItemList[iter_23_2].go, true)
	end
end

function var_0_0.onUpdateMO(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._goselect, arg_24_0._isSelect)

	arg_24_0._mo = arg_24_1

	local var_24_0 = arg_24_1 and arg_24_1.config

	gohelper.setActive(arg_24_0._gocontent, var_24_0)

	if var_24_0 then
		arg_24_0:_refreshUI()
		arg_24_0:_updateAnchorX()
	end
end

function var_0_0._updateAnchorX(arg_25_0)
	local var_25_0 = RoomShowBuildingListModel.instance:getItemAnchorX()

	recthelper.setAnchorX(arg_25_0._gocontent.transform, var_25_0 or 0)
end

function var_0_0.getAnimator(arg_26_0)
	return arg_26_0._animator
end

function var_0_0.onSelect(arg_27_0, arg_27_1)
	gohelper.setActive(arg_27_0._goselect, arg_27_1)

	arg_27_0._isSelect = arg_27_1

	arg_27_0:_updateAnchorX()
end

function var_0_0.onDestroy(arg_28_0)
	arg_28_0._simageicon:UnLoadImage()

	if arg_28_0._costItemList and #arg_28_0._costItemList > 0 then
		local var_28_0 = arg_28_0._costItemList

		arg_28_0._costItemList = nil

		for iter_28_0 = 1, #var_28_0 do
			local var_28_1 = var_28_0[iter_28_0]

			for iter_28_1 in pairs(var_28_1) do
				rawset(var_28_1, iter_28_1, nil)
			end
		end
	end
end

function var_0_0._refreshBuildingTypeIcon(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.buildingType
	local var_29_1 = arg_29_1.id
	local var_29_2 = arg_29_0._buildingTypeIconColor[var_29_0] or arg_29_0._buildingTypeDefindeColor

	SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._buildingusedesc, var_29_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._imagebuildingtype, var_29_2)

	local var_29_3

	if RoomBuildingEnum.BuildingArea[var_29_0] then
		var_29_3 = ManufactureConfig.instance:getManufactureBuildingIcon(var_29_1)
	else
		var_29_3 = RoomConfig.instance:getBuildingTypeIcon(var_29_0)
	end

	arg_29_0._buildingusedesc.text = arg_29_1.useDesc

	UISpriteSetMgr.instance:setRoomSprite(arg_29_0._imagebuildingtype, var_29_3)

	local var_29_4 = 0

	if RoomBuildingEnum.BuildingArea[var_29_0] or var_29_0 == RoomBuildingEnum.BuildingType.Rest then
		local var_29_5 = ManufactureModel.instance:getTradeLevel()

		var_29_4 = ManufactureConfig.instance:getBuildingCanPlaceCritterCount(var_29_1, var_29_5)
	end

	gohelper.setActive(arg_29_0._txtcritternum, var_29_4 > 0)

	if var_29_4 > 0 then
		arg_29_0._txtcritternum.text = var_29_4
	end
end

function var_0_0._hideReddot(arg_30_0)
	if arg_30_0._mo.use then
		return
	end

	local var_30_0 = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.RoomBuildingPlace)

	if not var_30_0 or not var_30_0.infos then
		return
	end

	local var_30_1 = var_30_0.infos[arg_30_0._mo.buildingId]

	if not var_30_1 then
		return
	end

	if var_30_1.value > 0 then
		RoomRpc.instance:sendHideBuildingReddotRequset(arg_30_0._mo.buildingId)
	end
end

return var_0_0

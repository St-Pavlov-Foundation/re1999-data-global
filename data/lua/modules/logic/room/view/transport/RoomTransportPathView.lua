module("modules.logic.room.view.transport.RoomTransportPathView", package.seeall)

local var_0_0 = class("RoomTransportPathView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._godragmap = gohelper.findChild(arg_1_0.viewGO, "#go_dragmap")
	arg_1_0._gonavigatebuttonscontainer = gohelper.findChild(arg_1_0.viewGO, "#go_navigatebuttonscontainer")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_left")
	arg_1_0._btnsave = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_save")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_reset")
	arg_1_0._btnquick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_left/#btn_quick")
	arg_1_0._btnremoveBuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_bottom/#btn_removeBuilding")
	arg_1_0._goselectRemove = gohelper.findChild(arg_1_0.viewGO, "go_bottom/#btn_removeBuilding/#go_selectRemove")
	arg_1_0._btnremoveLand = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_bottom/#btn_removeLand")
	arg_1_0._goselectRemoveLand = gohelper.findChild(arg_1_0.viewGO, "go_bottom/#btn_removeLand/#go_selectRemoveLand")
	arg_1_0._gotransportgroup = gohelper.findChild(arg_1_0.viewGO, "#go_transportgroup")
	arg_1_0._gotypeitem = gohelper.findChild(arg_1_0.viewGO, "#go_transportgroup/go_pathlinegroup/#go_typeitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnsave:AddClickListener(arg_2_0._btnsaveOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnquick:AddClickListener(arg_2_0._btnquickOnClick, arg_2_0)
	arg_2_0._btnremoveBuilding:AddClickListener(arg_2_0._btnremoveBuildingOnClick, arg_2_0)
	arg_2_0._btnremoveLand:AddClickListener(arg_2_0._btnbtnremoveLandOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnsave:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnquick:RemoveClickListener()
	arg_3_0._btnremoveBuilding:RemoveClickListener()
	arg_3_0._btnremoveLand:RemoveClickListener()
end

function var_0_0._btnquickOnClick(arg_4_0)
	if not arg_4_0._lineDataMO then
		return
	end

	local var_4_0 = arg_4_0._lineDataMO.fromType
	local var_4_1 = arg_4_0._lineDataMO.toType
	local var_4_2 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_4_0, var_4_1)

	if var_4_2 and var_4_2:isLinkFinish() then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFinish)

		return
	end

	if not arg_4_0._quickLinkMO then
		arg_4_0._quickLinkMO = RoomTransportQuickLinkMO.New()

		arg_4_0._quickLinkMO:init()
	end

	local var_4_3 = false
	local var_4_4 = arg_4_0._quickLinkMO:findPath(arg_4_0._lineDataMO.fromType, arg_4_0._lineDataMO.toType, var_4_3)

	if not var_4_4 or #var_4_4 < 2 and arg_4_0._isRemoveBuilding then
		var_4_3 = true
		var_4_4 = arg_4_0._quickLinkMO:findPath(arg_4_0._lineDataMO.fromType, arg_4_0._lineDataMO.toType, arg_4_0._isRemoveBuilding, var_4_3)
	end

	if not var_4_4 or #var_4_4 < 2 then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)

		return
	end

	local var_4_5 = RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(var_4_4[1].hexPoint, var_4_0, var_4_1)

	if var_4_5 then
		var_4_5:clear()

		var_4_5.blockCleanType = arg_4_0:_getBlockCleanType()

		var_4_5:setIsEdit(true)
		var_4_5:setIsQuickLink(true)

		var_4_5.fromType = var_4_0
		var_4_5.toType = var_4_1

		local var_4_6 = var_4_5:getHexPointList()

		for iter_4_0, iter_4_1 in ipairs(var_4_4) do
			table.insert(var_4_6, iter_4_1.hexPoint)
		end

		if var_4_3 then
			for iter_4_2, iter_4_3 in ipairs(var_4_4) do
				arg_4_0:_unUseBuildingByHexXy(iter_4_3.hexPoint.x, iter_4_3.hexPoint.y)
			end
		end

		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		arg_4_0:_clearLinkFailPathMO()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkSuccess)
	else
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)
	end
end

function var_0_0._btnremoveBuildingOnClick(arg_5_0)
	arg_5_0:_setIsRemoveBuiling(arg_5_0._isRemoveBuilding ~= true)
end

function var_0_0._btnbtnremoveLandOnClick(arg_6_0)
	arg_6_0:_setIsRemoveLand(arg_6_0._isRemoveLand ~= true)
	arg_6_0:_updateAllPathBlockState()
end

function var_0_0._btnsaveOnClick(arg_7_0)
	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomTransportController.instance:saveEditPath()
	else
		arg_7_0:closeThis()
	end

	RoomStatController.instance:roomRoadEditClose()
end

function var_0_0._btnresetOnClick(arg_8_0)
	if RoomMapTransportPathModel.instance:isHasEdit() or RoomMapTransportPathModel.instance:getTempTransportPathMO() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportPathResetConfirm, MsgBoxEnum.BoxType.Yes_No, arg_8_0._clearPath, nil, nil, arg_8_0, nil, nil)
	end
end

function var_0_0._onEscape(arg_9_0)
	arg_9_0:_btnsaveOnClick()
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._gopathlinegroup = gohelper.findChild(arg_10_0.viewGO, "#go_transportgroup/go_pathlinegroup")
	arg_10_0._godragmapTrs = arg_10_0._godragmap.transform
	arg_10_0._dragMap = SLFramework.UGUI.UIDragListener.Get(arg_10_0._godragmap)
	arg_10_0._isRemoveBuilding = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
	arg_10_0._screenScaleX = 0
	arg_10_0._screenScaleY = 0
	arg_10_0._waitingBlockIdList = {}
	arg_10_0._unUseBuilingUidList = {}

	arg_10_0:_setIsRemoveBuiling(arg_10_0._isRemoveBuilding)
	arg_10_0:_setIsRemoveLand(true)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathLineChanged, arg_12_0._refreshLineLinkUI, arg_12_0)

	if arg_12_0.viewContainer then
		arg_12_0:addEventCb(arg_12_0.viewContainer, RoomEvent.TransportPathDeleteLineItem, arg_12_0._onDeleteLineItem, arg_12_0)
		arg_12_0:addEventCb(arg_12_0.viewContainer, RoomEvent.TransportPathSelectLineItem, arg_12_0._onSelectLineItem, arg_12_0)
	end

	if arg_12_0._dragMap then
		arg_12_0._dragMap:AddDragListener(arg_12_0._onDragIng, arg_12_0)
		arg_12_0._dragMap:AddDragBeginListener(arg_12_0._onDragBegin, arg_12_0)
		arg_12_0._dragMap:AddDragEndListener(arg_12_0._onDragEnd, arg_12_0)
	end

	NavigateMgr.instance:addEscape(arg_12_0.viewName, arg_12_0._onEscape, arg_12_0)
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	arg_12_0:refreshUI()
	RoomStatController.instance:roomRoadEditView()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)

	if arg_12_0._dataList and #arg_12_0._dataList > 0 then
		local var_12_0

		for iter_12_0 = 1, #arg_12_0._dataList do
			local var_12_1 = arg_12_0._dataList[iter_12_0]

			if not RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_12_1.fromType, var_12_1.toType) then
				var_12_0 = var_12_1

				break
			end
		end

		arg_12_0:_onSelectLineItem(var_12_0 or arg_12_0._dataList[1])
	end
end

function var_0_0.onClose(arg_13_0)
	if arg_13_0._dragMap then
		arg_13_0._dragMap:RemoveDragBeginListener()
		arg_13_0._dragMap:RemoveDragListener()
		arg_13_0._dragMap:RemoveDragEndListener()
	end

	arg_13_0:_clearPath()
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
end

function var_0_0._setIsRemoveBuiling(arg_14_0, arg_14_1)
	arg_14_0._isRemoveBuilding = arg_14_1

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(arg_14_1)
	gohelper.setActive(arg_14_0._goselectRemove, arg_14_0._isRemoveBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathConfirmChange)
end

function var_0_0._setIsRemoveLand(arg_15_0, arg_15_1)
	arg_15_0._isRemoveLand = arg_15_1

	gohelper.setActive(arg_15_0._goselectRemoveLand, arg_15_0._isRemoveLand)
end

function var_0_0._getBlockCleanType(arg_16_0)
	if arg_16_0._isRemoveLand then
		return RoomBlockEnum.CleanType.CleanLand
	end

	return RoomBlockEnum.CleanType.Normal
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

function var_0_0._onDragBegin(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0._isStarDragPath = false
	arg_18_0._canTouchDrag = true
	arg_18_0._isChangeSiteHexPoint = false
	arg_18_0._changeSiteBuildingType = nil
	arg_18_0._startDragSiteHexPoint = nil
	arg_18_0._canDelectfinishPathMOList = nil
	arg_18_0._pathMO = nil
	arg_18_0._lastMousePosition = arg_18_2.position
	arg_18_0._screenScaleX = 1920 / UnityEngine.Screen.width
	arg_18_0._screenScaleY = 1080 / UnityEngine.Screen.height

	if not arg_18_0._lineDataMO then
		return
	end

	local var_18_0 = arg_18_0:_findeBlockMO(arg_18_0._lastMousePosition)

	if not var_18_0 then
		return
	end

	if not RoomTransportHelper.canPathByBlockMO(var_18_0, arg_18_0._isRemoveBuilding) then
		return
	end

	local var_18_1 = RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(var_18_0.hexPoint, arg_18_0._lineDataMO.fromType, arg_18_0._lineDataMO.toType)

	if not var_18_1 then
		return
	end

	if var_18_0.hexPoint == var_18_1:getLastHexPoint() then
		arg_18_0._isStarDragPath = true
		arg_18_0._canTouchDrag = false
	elseif var_18_0.hexPoint == var_18_1:getFirstHexPoint() then
		var_18_1:changeBenEnd()

		arg_18_0._isStarDragPath = true
		arg_18_0._canTouchDrag = false
	end

	if not arg_18_0._isStarDragPath then
		return
	end

	var_18_1.blockCleanType = arg_18_0:_getBlockCleanType()

	if var_18_1:isLinkFinish() then
		if not var_18_1:checkSameType(arg_18_0._lineDataMO.fromType, arg_18_0._lineDataMO.toType) then
			return
		end

		arg_18_0._isChangeSiteHexPoint = true
		arg_18_0._changeSiteBuildingType = var_18_1.toType

		local var_18_2 = RoomMapTransportPathModel.instance:getTransportPathMOListByHexPoint(var_18_0.hexPoint, true)

		if var_18_2 and #var_18_2 > 1 then
			tabletool.removeValue(var_18_2, var_18_1)

			arg_18_0._canDelectfinishPathMOList = var_18_2
			arg_18_0._startDragSiteHexPoint = var_18_0.hexPoint
		end
	end

	arg_18_0._pathMO = var_18_1

	RoomMapTransportPathModel.instance:setOpParam(arg_18_0._isStarDragPath, arg_18_0._changeSiteBuildingType)
	var_18_1:checkTempTypes(arg_18_0._lineDataMO.typeList)

	if var_18_1:getHexPointCount() == 1 then
		var_18_1.fromType = arg_18_0:_getTempSiteTypeByHexPoint(arg_18_0._pathMO:getLastHexPoint(), arg_18_0._lineDataMO and arg_18_0._lineDataMO.typeList)
		var_18_1.toType = 0
	end

	if var_18_1:checkHexPoint(var_18_0.hexPoint) and var_18_0:getUseState() ~= RoomBlockEnum.UseState.TransportPath then
		var_18_0:setUseState(RoomBlockEnum.UseState.TransportPath)
		var_18_0:setCleanType(arg_18_0._pathMO.blockCleanType)
		arg_18_0:_addRefreshBlockId(var_18_0.blockId)
	end
end

function var_0_0._onDragIng(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_0._isStarDragPath then
		arg_19_0:_addPathByScreenPos(arg_19_2.position)
	else
		arg_19_0:_touchDrag(arg_19_2.position)
	end
end

function var_0_0._onDragEnd(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._isStarDragPath

	arg_20_0._canTouchDrag = false
	arg_20_0._isStarDragPath = false

	RoomMapTransportPathModel.instance:setOpParam(false, nil)

	if var_20_0 then
		local var_20_1 = arg_20_0._pathMO

		arg_20_0:_dragPathFinishByPathMO(var_20_1)
	end
end

function var_0_0._touchDrag(arg_21_0, arg_21_1)
	if arg_21_0._canTouchDrag then
		local var_21_0 = arg_21_1 - arg_21_0._lastMousePosition

		arg_21_0._lastMousePosition = arg_21_1

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(var_21_0.x * arg_21_0._screenScaleX, var_21_0.y * arg_21_0._screenScaleY))
	end
end

function var_0_0._findeBlockMO(arg_22_0, arg_22_1)
	local var_22_0 = RoomBendingHelper.screenToWorld(arg_22_1)

	if var_22_0 then
		local var_22_1, var_22_2 = HexMath.posXYToRoundHexYX(var_22_0.x, var_22_0.y, RoomBlockEnum.BlockSize)
		local var_22_3 = RoomMapBlockModel.instance:getBlockMO(var_22_1, var_22_2)

		if var_22_3 and var_22_3:isInMapBlock() then
			return var_22_3
		end
	end
end

function var_0_0._addPathByScreenPos(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_findeBlockMO(arg_23_1)

	if not var_23_0 or not var_23_0:isInMapBlock() then
		return
	end

	local var_23_1 = var_23_0.hexPoint
	local var_23_2, var_23_3 = arg_23_0._pathMO:checkHexPoint(var_23_1)
	local var_23_4 = false

	if var_23_2 then
		if var_23_3 >= 1 and var_23_3 + 1 == arg_23_0._pathMO:getHexPointCount() then
			local var_23_5 = arg_23_0._pathMO:getLastHexPoint()
			local var_23_6 = RoomMapBlockModel.instance:getBlockMO(var_23_5.x, var_23_5.y)

			if var_23_6 and var_23_6:isInMapBlock() then
				arg_23_0._pathMO:removeLastHexPoint()
				arg_23_0._pathMO:setIsEdit(true)
				arg_23_0._pathMO:setIsQuickLink(false)
				arg_23_0:_changeSiteHexPoint(arg_23_0._pathMO:getLastHexPoint())
				arg_23_0._pathMO:checkTempTypes(arg_23_0._lineDataMO.typeList)

				local var_23_7 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(var_23_5)

				if not var_23_7 or var_23_7 == 0 then
					var_23_6:setUseState(nil)
					var_23_6:setCleanType(nil)
				end

				arg_23_0:_addRefreshBlockId(var_23_6.id)
			end
		else
			var_23_4 = true
		end
	elseif HexPoint.Distance(arg_23_0._pathMO:getLastHexPoint(), var_23_1) == 1 then
		local var_23_8, var_23_9 = arg_23_0:_canPathByBlockMO(var_23_0)

		if var_23_9 then
			var_23_4 = true
		end

		if var_23_8 and arg_23_0._pathMO:addHexPoint(var_23_1) then
			var_23_0:setUseState(RoomBlockEnum.UseState.TransportPath)
			var_23_0:setCleanType(arg_23_0._pathMO.blockCleanType)
			arg_23_0._pathMO:setIsEdit(true)
			arg_23_0._pathMO:setIsQuickLink(false)
			arg_23_0:_changeSiteHexPoint(var_23_1)
			arg_23_0._pathMO:checkTempTypes(arg_23_0._lineDataMO.typeList)
			arg_23_0:_addRefreshBlockId(var_23_0.id)
			arg_23_0:_unUseBuildingByHexXy(var_23_1.x, var_23_1.y)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_luxian)
		end
	end

	if var_23_4 and arg_23_0._isLastCrossBlockId ~= var_23_0.id and arg_23_0._pathMO:getHexPointCount() > 0 and HexPoint.Distance(arg_23_0._pathMO:getLastHexPoint(), var_23_1) == 1 then
		arg_23_0._isLastCrossBlockId = var_23_0.id

		GameFacade.showToast(ToastEnum.RoomTransportPathCross)
	end
end

function var_0_0._canPathByBlockMO(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:_findLinkFinishPathMO(arg_24_1.hexPoint)

	if var_24_0 and var_24_0:getLastHexPoint() ~= arg_24_1.hexPoint and var_24_0:getFirstHexPoint() ~= arg_24_1.hexPoint then
		return false, true
	end

	if not arg_24_0._isChangeSiteHexPoint then
		if arg_24_0._pathMO:getHexPointCount() > 1 then
			local var_24_1 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(arg_24_0._pathMO:getLastHexPoint())

			if var_24_1 and var_24_1 ~= 0 and arg_24_0._lineDataMO and (arg_24_0._lineDataMO.fromType == var_24_1 or arg_24_0._lineDataMO.toType == var_24_1) then
				return false, true
			end
		end

		local var_24_2 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(arg_24_1.hexPoint)

		if var_24_2 and var_24_2 ~= 0 then
			if arg_24_0._lineDataMO and (arg_24_0._lineDataMO.fromType == var_24_2 or arg_24_0._lineDataMO.toType == var_24_2) then
				return true
			end

			return false, true
		end

		if arg_24_0:_findLinkFinishPathMO(arg_24_1.hexPoint) then
			return false, true
		end
	else
		local var_24_3 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(arg_24_1.hexPoint)

		if var_24_3 and var_24_3 ~= 0 and var_24_3 ~= arg_24_0._changeSiteBuildingType then
			return false, true
		end
	end

	return RoomTransportHelper.canPathByBlockMO(arg_24_1, arg_24_0._isRemoveBuilding)
end

function var_0_0._findLinkFinishPathMO(arg_25_0, arg_25_1)
	local var_25_0 = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local var_25_1 = arg_25_0._canDelectfinishPathMOList

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1:isLinkFinish() and iter_25_1:checkHexPoint(arg_25_1) and (not var_25_1 or not tabletool.indexOf(var_25_1, iter_25_1)) then
			return iter_25_1
		end
	end
end

function var_0_0._changeSiteHexPoint(arg_26_0, arg_26_1)
	if arg_26_0._isChangeSiteHexPoint and arg_26_0._changeSiteBuildingType then
		local var_26_0

		if RoomTransportHelper.canSiteByHexPoint(arg_26_1, arg_26_0._changeSiteBuildingType) then
			var_26_0 = arg_26_1
		end

		RoomMapTransportPathModel.instance:setSiteHexPointByType(arg_26_0._changeSiteBuildingType, var_26_0)
		arg_26_0:_changeAllPathLineSite()
	elseif arg_26_0._pathMO then
		arg_26_0._pathMO.toType = arg_26_0:_getTempSiteTypeByHexPoint(arg_26_0._pathMO:getLastHexPoint(), arg_26_0._lineDataMO and arg_26_0._lineDataMO.typeList)
	end
end

function var_0_0._dragPathFinishByPathMO(arg_27_0, arg_27_1)
	if arg_27_1:getHexPointCount() == 1 then
		arg_27_1:clear()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:waitRefreshPathLineChanged()
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
	elseif arg_27_1:isLinkFinish() then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		RoomMapTransportPathModel.instance:setSiteHexPointByType(arg_27_1.fromType, arg_27_1:getFirstHexPoint())
		RoomMapTransportPathModel.instance:setSiteHexPointByType(arg_27_1.toType, arg_27_1:getLastHexPoint())
	end

	arg_27_0:_changeAllPathLineSite()
	arg_27_0:_clearLinkFailPathMO()
end

function var_0_0._clearLinkFailPathMO(arg_28_0)
	local var_28_0 = RoomMapTransportPathModel.instance:getTransportPathMOList()
	local var_28_1 = RoomMapTransportPathModel.instance:getTempTransportPathMO()
	local var_28_2 = false

	for iter_28_0, iter_28_1 in ipairs(var_28_0) do
		if not iter_28_1:isLinkFinish() and iter_28_1 ~= var_28_1 then
			iter_28_1:clear()

			var_28_2 = true
		end
	end

	if var_28_2 then
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function var_0_0._changeAllPathLineSite(arg_29_0)
	local var_29_0 = RoomMapTransportPathModel.instance
	local var_29_1 = var_29_0:getTransportPathMOList()

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		iter_29_1.toType = var_29_0:getSiteTypeByHexPoint(iter_29_1:getLastHexPoint())
		iter_29_1.fromType = var_29_0:getSiteTypeByHexPoint(iter_29_1:getFirstHexPoint())
	end

	if arg_29_0._canDelectfinishPathMOList and arg_29_0._pathMO then
		for iter_29_2, iter_29_3 in ipairs(arg_29_0._canDelectfinishPathMOList) do
			if iter_29_3:isLinkFinish() and arg_29_0:_isHasIntersection(iter_29_3, arg_29_0._pathMO) then
				iter_29_3.toType = 0
				iter_29_3.fromType = 0
			end
		end
	end
end

function var_0_0._isHasIntersection(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_1:getHexPointCount()
	local var_30_1 = arg_30_2:getHexPointCount()

	if var_30_0 < 1 or var_30_1 < 1 then
		return false
	end

	local var_30_2 = arg_30_1:getHexPointList()

	for iter_30_0, iter_30_1 in ipairs(var_30_2) do
		local var_30_3, var_30_4 = arg_30_2:checkHexPoint(iter_30_1)

		if var_30_3 and (iter_30_0 ~= 1 and var_30_4 ~= 1 and var_30_4 ~= var_30_1 or iter_30_0 ~= var_30_0 and var_30_4 ~= 1 and var_30_4 ~= var_30_1) then
			return true
		end
	end

	return false
end

function var_0_0._getTempSiteTypeByHexPoint(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_0._pathMO then
		local var_31_0 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(arg_31_1)

		if var_31_0 == 0 then
			var_31_0 = RoomTransportHelper.getBuildingTypeByHexPoint(arg_31_1, arg_31_2)
		end

		return var_31_0
	end

	return 0
end

function var_0_0._unUseBuildingByHexXy(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = RoomMapBuildingModel.instance:getBuildingParam(arg_32_1, arg_32_2)
	local var_32_1 = var_32_0 and var_32_0.buildingUid

	if var_32_0 and not tabletool.indexOf(arg_32_0._unUseBuilingUidList, var_32_1) then
		local var_32_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_32_1)
		local var_32_3 = var_32_2 and var_32_2.config

		if var_32_3 and RoomBuildingEnum.CanDateleBuildingType[var_32_3.buildingType] then
			table.insert(arg_32_0._unUseBuilingUidList, var_32_1)
			RoomMapController.instance:unUseBuildingRequest(var_32_1)
			GameFacade.showToast(ToastEnum.RoomTransportRemoveBuilding, var_32_3.name)
		end
	end
end

function var_0_0._checkCanBlockMO(arg_33_0, arg_33_1)
	if not arg_33_1 or arg_33_1.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
		return false
	end

	local var_33_0 = arg_33_1.hexPoint
	local var_33_1 = RoomMapBuildingModel.instance:getBuildingParam(var_33_0.x, var_33_0.y)

	if var_33_1 then
		if var_33_1:isAreaMainBuilding() then
			return false
		end

		if arg_33_0._isRemoveBuilding ~= true then
			return false
		end
	end
end

function var_0_0._onDeleteLineItem(arg_34_0, arg_34_1)
	return
end

function var_0_0._onSelectLineItem(arg_35_0, arg_35_1)
	if arg_35_0._canTouchDrag or arg_35_0._isStarDragPath then
		return
	end

	local var_35_0 = arg_35_0._lineDataMO

	arg_35_0._lineDataMO = arg_35_1

	RoomMapTransportPathModel.instance:setSelectBuildingType(arg_35_1 and arg_35_1.fromType)

	if not var_35_0 or arg_35_1 and arg_35_1.fromType ~= var_35_0.fromType then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		arg_35_0:_clearLinkFailPathMO()
	end

	arg_35_0:_refreshLineLinkUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
	arg_35_0:_initSelectLineRemoveLand()
	arg_35_0:_updateAllPathBlockState()
end

function var_0_0._initSelectLineRemoveLand(arg_36_0)
	if arg_36_0._lineDataMO then
		local var_36_0 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_36_0._lineDataMO.fromType, arg_36_0._lineDataMO.toType)

		if var_36_0 then
			arg_36_0:_setIsRemoveLand(var_36_0.blockCleanType == RoomBlockEnum.CleanType.CleanLand)
		end
	end
end

function var_0_0.refreshUI(arg_37_0)
	arg_37_0._dataList = arg_37_0:getLineDataList()
	arg_37_0._lineItemCompList = {}

	local var_37_0 = arg_37_0._gopathlinegroup
	local var_37_1 = arg_37_0._gotypeitem

	gohelper.CreateObjList(arg_37_0, arg_37_0._lineItemShow, arg_37_0._dataList, var_37_0, var_37_1, RoomTransportLineItem)
end

function var_0_0._refreshLineLinkUI(arg_38_0)
	local var_38_0 = false

	if arg_38_0._lineItemCompList then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0._lineItemCompList) do
			iter_38_1:refreshLinkUI()

			local var_38_1 = iter_38_1:getDataMO()

			if arg_38_0._lineDataMO and var_38_1 and arg_38_0._lineDataMO.buildingType == var_38_1.buildingType then
				var_38_0 = true

				iter_38_1:onSelect(true)
			else
				iter_38_1:onSelect(false)
			end
		end
	end

	if not var_38_0 then
		arg_38_0._lineDataMO = nil

		RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	end
end

function var_0_0.getLineDataList(arg_39_0)
	local var_39_0 = RoomTransportHelper.getPathBuildingTypesList()
	local var_39_1 = {}
	local var_39_2 = RoomMapBuildingAreaModel.instance

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		local var_39_3 = iter_39_1[1]
		local var_39_4 = iter_39_1[2]

		if var_39_2:getAreaMOByBType(var_39_3) and var_39_2:getAreaMOByBType(var_39_4) then
			local var_39_5 = {}
			local var_39_6 = {
				buildingType = var_39_3,
				fromType = var_39_3,
				toType = var_39_4,
				typeList = var_39_5
			}

			tabletool.addValues(var_39_5, iter_39_1)
			table.insert(var_39_1, var_39_6)
		end
	end

	return var_39_1
end

function var_0_0._lineItemShow(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_1:onUpdateMO(arg_40_2)

	if not arg_40_1._view then
		arg_40_1._view = arg_40_0
	end

	table.insert(arg_40_0._lineItemCompList, arg_40_1)
end

function var_0_0._clearPath(arg_41_0)
	RoomMapTransportPathModel.instance:placeTempTransportPathMO()

	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomMapTransportPathModel.instance:resetByTransportPathMOList(RoomTransportPathModel.instance:getList())
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		arg_41_0:_initSelectLineRemoveLand()
	end
end

function var_0_0._updateAllPathBlockState(arg_42_0)
	local var_42_0 = arg_42_0:_getBlockCleanType()
	local var_42_1 = false
	local var_42_2 = RoomMapTransportPathModel.instance:getTempTransportPathMO()

	if var_42_2 and var_42_2:getHexPointCount() > 0 and var_42_2.blockCleanType ~= var_42_0 then
		var_42_2.blockCleanType = var_42_0
		var_42_1 = true
	end

	if arg_42_0._lineDataMO then
		local var_42_3 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_42_0._lineDataMO.fromType, arg_42_0._lineDataMO.toType)

		if var_42_3 and var_42_3:getHexPointCount() > 0 and var_42_3.blockCleanType ~= var_42_0 then
			var_42_3.blockCleanType = var_42_0
			var_42_1 = true

			var_42_3:setIsEdit(true)
		end
	end

	if var_42_1 then
		RoomTransportController.instance:updateBlockUseState()
	end
end

function var_0_0._addRefreshBlockId(arg_43_0, arg_43_1)
	RoomTransportController.instance:waitRefreshBlockById(arg_43_1)
	RoomTransportController.instance:waitRefreshPathLineChanged()
end

return var_0_0

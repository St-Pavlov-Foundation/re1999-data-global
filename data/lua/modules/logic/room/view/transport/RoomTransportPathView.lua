module("modules.logic.room.view.transport.RoomTransportPathView", package.seeall)

slot0 = class("RoomTransportPathView", BaseView)

function slot0.onInitView(slot0)
	slot0._godragmap = gohelper.findChild(slot0.viewGO, "#go_dragmap")
	slot0._gonavigatebuttonscontainer = gohelper.findChild(slot0.viewGO, "#go_navigatebuttonscontainer")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_left")
	slot0._btnsave = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_save")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_reset")
	slot0._btnquick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/#btn_quick")
	slot0._btnremoveBuilding = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_bottom/#btn_removeBuilding")
	slot0._goselectRemove = gohelper.findChild(slot0.viewGO, "go_bottom/#btn_removeBuilding/#go_selectRemove")
	slot0._btnremoveLand = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_bottom/#btn_removeLand")
	slot0._goselectRemoveLand = gohelper.findChild(slot0.viewGO, "go_bottom/#btn_removeLand/#go_selectRemoveLand")
	slot0._gotransportgroup = gohelper.findChild(slot0.viewGO, "#go_transportgroup")
	slot0._gotypeitem = gohelper.findChild(slot0.viewGO, "#go_transportgroup/go_pathlinegroup/#go_typeitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsave:AddClickListener(slot0._btnsaveOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnquick:AddClickListener(slot0._btnquickOnClick, slot0)
	slot0._btnremoveBuilding:AddClickListener(slot0._btnremoveBuildingOnClick, slot0)
	slot0._btnremoveLand:AddClickListener(slot0._btnbtnremoveLandOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsave:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnquick:RemoveClickListener()
	slot0._btnremoveBuilding:RemoveClickListener()
	slot0._btnremoveLand:RemoveClickListener()
end

function slot0._btnquickOnClick(slot0)
	if not slot0._lineDataMO then
		return
	end

	if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._lineDataMO.fromType, slot0._lineDataMO.toType) and slot3:isLinkFinish() then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFinish)

		return
	end

	if not slot0._quickLinkMO then
		slot0._quickLinkMO = RoomTransportQuickLinkMO.New()

		slot0._quickLinkMO:init()
	end

	if not slot0._quickLinkMO:findPath(slot0._lineDataMO.fromType, slot0._lineDataMO.toType, false) or #slot5 < 2 and slot0._isRemoveBuilding then
		slot5 = slot0._quickLinkMO:findPath(slot0._lineDataMO.fromType, slot0._lineDataMO.toType, slot0._isRemoveBuilding, true)
	end

	if not slot5 or #slot5 < 2 then
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)

		return
	end

	if RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(slot5[1].hexPoint, slot1, slot2) then
		slot6:clear()

		slot6.blockCleanType = slot0:_getBlockCleanType()

		slot6:setIsEdit(true)
		slot6:setIsQuickLink(true)

		slot6.fromType = slot1
		slot6.toType = slot2

		for slot11, slot12 in ipairs(slot5) do
			table.insert(slot6:getHexPointList(), slot12.hexPoint)
		end

		if slot4 then
			for slot11, slot12 in ipairs(slot5) do
				slot0:_unUseBuildingByHexXy(slot12.hexPoint.x, slot12.hexPoint.y)
			end
		end

		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		slot0:_clearLinkFailPathMO()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkSuccess)
	else
		GameFacade.showToast(ToastEnum.RoomTransportQuickLinkFail)
	end
end

function slot0._btnremoveBuildingOnClick(slot0)
	slot0:_setIsRemoveBuiling(slot0._isRemoveBuilding ~= true)
end

function slot0._btnbtnremoveLandOnClick(slot0)
	slot0:_setIsRemoveLand(slot0._isRemoveLand ~= true)
	slot0:_updateAllPathBlockState()
end

function slot0._btnsaveOnClick(slot0)
	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomTransportController.instance:saveEditPath()
	else
		slot0:closeThis()
	end

	RoomStatController.instance:roomRoadEditClose()
end

function slot0._btnresetOnClick(slot0)
	if RoomMapTransportPathModel.instance:isHasEdit() or RoomMapTransportPathModel.instance:getTempTransportPathMO() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportPathResetConfirm, MsgBoxEnum.BoxType.Yes_No, slot0._clearPath, nil, , slot0, nil, )
	end
end

function slot0._onEscape(slot0)
	slot0:_btnsaveOnClick()
end

function slot0._editableInitView(slot0)
	slot0._gopathlinegroup = gohelper.findChild(slot0.viewGO, "#go_transportgroup/go_pathlinegroup")
	slot0._godragmapTrs = slot0._godragmap.transform
	slot0._dragMap = SLFramework.UGUI.UIDragListener.Get(slot0._godragmap)
	slot0._isRemoveBuilding = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
	slot0._screenScaleX = 0
	slot0._screenScaleY = 0
	slot0._waitingBlockIdList = {}
	slot0._unUseBuilingUidList = {}

	slot0:_setIsRemoveBuiling(slot0._isRemoveBuilding)
	slot0:_setIsRemoveLand(true)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathLineChanged, slot0._refreshLineLinkUI, slot0)

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportPathDeleteLineItem, slot0._onDeleteLineItem, slot0)
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportPathSelectLineItem, slot0._onSelectLineItem, slot0)
	end

	if slot0._dragMap then
		slot0._dragMap:AddDragListener(slot0._onDragIng, slot0)
		slot0._dragMap:AddDragBeginListener(slot0._onDragBegin, slot0)
		slot0._dragMap:AddDragEndListener(slot0._onDragEnd, slot0)
	end

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscape, slot0)
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	slot0:refreshUI()
	RoomStatController.instance:roomRoadEditView()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)

	if slot0._dataList and #slot0._dataList > 0 then
		slot1 = nil

		for slot5 = 1, #slot0._dataList do
			slot6 = slot0._dataList[slot5]

			if not RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot6.fromType, slot6.toType) then
				slot1 = slot6

				break
			end
		end

		slot0:_onSelectLineItem(slot1 or slot0._dataList[1])
	end
end

function slot0.onClose(slot0)
	if slot0._dragMap then
		slot0._dragMap:RemoveDragBeginListener()
		slot0._dragMap:RemoveDragListener()
		slot0._dragMap:RemoveDragEndListener()
	end

	slot0:_clearPath()
	RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
end

function slot0._setIsRemoveBuiling(slot0, slot1)
	slot0._isRemoveBuilding = slot1

	RoomMapTransportPathModel.instance:setIsRemoveBuilding(slot1)
	gohelper.setActive(slot0._goselectRemove, slot0._isRemoveBuilding)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathConfirmChange)
end

function slot0._setIsRemoveLand(slot0, slot1)
	slot0._isRemoveLand = slot1

	gohelper.setActive(slot0._goselectRemoveLand, slot0._isRemoveLand)
end

function slot0._getBlockCleanType(slot0)
	if slot0._isRemoveLand then
		return RoomBlockEnum.CleanType.CleanLand
	end

	return RoomBlockEnum.CleanType.Normal
end

function slot0.onDestroyView(slot0)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._isStarDragPath = false
	slot0._canTouchDrag = true
	slot0._isChangeSiteHexPoint = false
	slot0._changeSiteBuildingType = nil
	slot0._startDragSiteHexPoint = nil
	slot0._canDelectfinishPathMOList = nil
	slot0._pathMO = nil
	slot0._lastMousePosition = slot2.position
	slot0._screenScaleX = 1920 / UnityEngine.Screen.width
	slot0._screenScaleY = 1080 / UnityEngine.Screen.height

	if not slot0._lineDataMO then
		return
	end

	if not slot0:_findeBlockMO(slot0._lastMousePosition) then
		return
	end

	if not RoomTransportHelper.canPathByBlockMO(slot3, slot0._isRemoveBuilding) then
		return
	end

	if not (RoomMapTransportPathModel.instance:getTempTransportPathMO() or RoomMapTransportPathModel.instance:addTempTransportPathMO(slot3.hexPoint, slot0._lineDataMO.fromType, slot0._lineDataMO.toType)) then
		return
	end

	if slot3.hexPoint == slot4:getLastHexPoint() then
		slot0._isStarDragPath = true
		slot0._canTouchDrag = false
	elseif slot3.hexPoint == slot4:getFirstHexPoint() then
		slot4:changeBenEnd()

		slot0._isStarDragPath = true
		slot0._canTouchDrag = false
	end

	if not slot0._isStarDragPath then
		return
	end

	slot4.blockCleanType = slot0:_getBlockCleanType()

	if slot4:isLinkFinish() then
		if not slot4:checkSameType(slot0._lineDataMO.fromType, slot0._lineDataMO.toType) then
			return
		end

		slot0._isChangeSiteHexPoint = true
		slot0._changeSiteBuildingType = slot4.toType

		if RoomMapTransportPathModel.instance:getTransportPathMOListByHexPoint(slot3.hexPoint, true) and #slot5 > 1 then
			tabletool.removeValue(slot5, slot4)

			slot0._canDelectfinishPathMOList = slot5
			slot0._startDragSiteHexPoint = slot3.hexPoint
		end
	end

	slot0._pathMO = slot4

	RoomMapTransportPathModel.instance:setOpParam(slot0._isStarDragPath, slot0._changeSiteBuildingType)
	slot4:checkTempTypes(slot0._lineDataMO.typeList)

	if slot4:getHexPointCount() == 1 then
		slot4.fromType = slot0:_getTempSiteTypeByHexPoint(slot0._pathMO:getLastHexPoint(), slot0._lineDataMO and slot0._lineDataMO.typeList)
		slot4.toType = 0
	end

	if slot4:checkHexPoint(slot3.hexPoint) and slot3:getUseState() ~= RoomBlockEnum.UseState.TransportPath then
		slot3:setUseState(RoomBlockEnum.UseState.TransportPath)
		slot3:setCleanType(slot0._pathMO.blockCleanType)
		slot0:_addRefreshBlockId(slot3.blockId)
	end
end

function slot0._onDragIng(slot0, slot1, slot2)
	if slot0._isStarDragPath then
		slot0:_addPathByScreenPos(slot2.position)
	else
		slot0:_touchDrag(slot2.position)
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._canTouchDrag = false
	slot0._isStarDragPath = false

	RoomMapTransportPathModel.instance:setOpParam(false, nil)

	if slot0._isStarDragPath then
		slot0:_dragPathFinishByPathMO(slot0._pathMO)
	end
end

function slot0._touchDrag(slot0, slot1)
	if slot0._canTouchDrag then
		slot2 = slot1 - slot0._lastMousePosition
		slot0._lastMousePosition = slot1

		RoomMapController.instance:dispatchEvent(RoomEvent.TouchDrag, Vector2(slot2.x * slot0._screenScaleX, slot2.y * slot0._screenScaleY))
	end
end

function slot0._findeBlockMO(slot0, slot1)
	if RoomBendingHelper.screenToWorld(slot1) then
		slot3, slot4 = HexMath.posXYToRoundHexYX(slot2.x, slot2.y, RoomBlockEnum.BlockSize)

		if RoomMapBlockModel.instance:getBlockMO(slot3, slot4) and slot5:isInMapBlock() then
			return slot5
		end
	end
end

function slot0._addPathByScreenPos(slot0, slot1)
	if not slot0:_findeBlockMO(slot1) or not slot2:isInMapBlock() then
		return
	end

	slot4, slot5 = slot0._pathMO:checkHexPoint(slot2.hexPoint)
	slot6 = false

	if slot4 then
		if slot5 >= 1 and slot5 + 1 == slot0._pathMO:getHexPointCount() then
			slot7 = slot0._pathMO:getLastHexPoint()

			if RoomMapBlockModel.instance:getBlockMO(slot7.x, slot7.y) and slot8:isInMapBlock() then
				slot0._pathMO:removeLastHexPoint()
				slot0._pathMO:setIsEdit(true)
				slot0._pathMO:setIsQuickLink(false)
				slot0:_changeSiteHexPoint(slot0._pathMO:getLastHexPoint())
				slot0._pathMO:checkTempTypes(slot0._lineDataMO.typeList)

				if not RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot7) or slot9 == 0 then
					slot8:setUseState(nil)
					slot8:setCleanType(nil)
				end

				slot0:_addRefreshBlockId(slot8.id)
			end
		else
			slot6 = true
		end
	elseif HexPoint.Distance(slot0._pathMO:getLastHexPoint(), slot3) == 1 then
		slot7, slot8 = slot0:_canPathByBlockMO(slot2)

		if slot8 then
			slot6 = true
		end

		if slot7 and slot0._pathMO:addHexPoint(slot3) then
			slot2:setUseState(RoomBlockEnum.UseState.TransportPath)
			slot2:setCleanType(slot0._pathMO.blockCleanType)
			slot0._pathMO:setIsEdit(true)
			slot0._pathMO:setIsQuickLink(false)
			slot0:_changeSiteHexPoint(slot3)
			slot0._pathMO:checkTempTypes(slot0._lineDataMO.typeList)
			slot0:_addRefreshBlockId(slot2.id)
			slot0:_unUseBuildingByHexXy(slot3.x, slot3.y)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_luxian)
		end
	end

	if slot6 and slot0._isLastCrossBlockId ~= slot2.id and slot0._pathMO:getHexPointCount() > 0 and HexPoint.Distance(slot0._pathMO:getLastHexPoint(), slot3) == 1 then
		slot0._isLastCrossBlockId = slot2.id

		GameFacade.showToast(ToastEnum.RoomTransportPathCross)
	end
end

function slot0._canPathByBlockMO(slot0, slot1)
	if slot0:_findLinkFinishPathMO(slot1.hexPoint) and slot2:getLastHexPoint() ~= slot1.hexPoint and slot2:getFirstHexPoint() ~= slot1.hexPoint then
		return false, true
	end

	if not slot0._isChangeSiteHexPoint then
		if slot0._pathMO:getHexPointCount() > 1 and RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot0._pathMO:getLastHexPoint()) and slot3 ~= 0 and slot0._lineDataMO and (slot0._lineDataMO.fromType == slot3 or slot0._lineDataMO.toType == slot3) then
			return false, true
		end

		if RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot1.hexPoint) and slot3 ~= 0 then
			if slot0._lineDataMO and (slot0._lineDataMO.fromType == slot3 or slot0._lineDataMO.toType == slot3) then
				return true
			end

			return false, true
		end

		if slot0:_findLinkFinishPathMO(slot1.hexPoint) then
			return false, true
		end
	elseif RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot1.hexPoint) and slot3 ~= 0 and slot3 ~= slot0._changeSiteBuildingType then
		return false, true
	end

	return RoomTransportHelper.canPathByBlockMO(slot1, slot0._isRemoveBuilding)
end

function slot0._findLinkFinishPathMO(slot0, slot1)
	slot3 = slot0._canDelectfinishPathMOList

	for slot7, slot8 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		if slot8:isLinkFinish() and slot8:checkHexPoint(slot1) and (not slot3 or not tabletool.indexOf(slot3, slot8)) then
			return slot8
		end
	end
end

function slot0._changeSiteHexPoint(slot0, slot1)
	if slot0._isChangeSiteHexPoint and slot0._changeSiteBuildingType then
		slot2 = nil

		if RoomTransportHelper.canSiteByHexPoint(slot1, slot0._changeSiteBuildingType) then
			slot2 = slot1
		end

		RoomMapTransportPathModel.instance:setSiteHexPointByType(slot0._changeSiteBuildingType, slot2)
		slot0:_changeAllPathLineSite()
	elseif slot0._pathMO then
		slot0._pathMO.toType = slot0:_getTempSiteTypeByHexPoint(slot0._pathMO:getLastHexPoint(), slot0._lineDataMO and slot0._lineDataMO.typeList)
	end
end

function slot0._dragPathFinishByPathMO(slot0, slot1)
	if slot1:getHexPointCount() == 1 then
		slot1:clear()
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:waitRefreshPathLineChanged()
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
	elseif slot1:isLinkFinish() then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		RoomMapTransportPathModel.instance:setSiteHexPointByType(slot1.fromType, slot1:getFirstHexPoint())
		RoomMapTransportPathModel.instance:setSiteHexPointByType(slot1.toType, slot1:getLastHexPoint())
	end

	slot0:_changeAllPathLineSite()
	slot0:_clearLinkFailPathMO()
end

function slot0._clearLinkFailPathMO(slot0)
	slot3 = false

	for slot7, slot8 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		if not slot8:isLinkFinish() and slot8 ~= RoomMapTransportPathModel.instance:getTempTransportPathMO() then
			slot8:clear()

			slot3 = true
		end
	end

	if slot3 then
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
	end
end

function slot0._changeAllPathLineSite(slot0)
	for slot6, slot7 in ipairs(RoomMapTransportPathModel.instance:getTransportPathMOList()) do
		slot7.toType = slot1:getSiteTypeByHexPoint(slot7:getLastHexPoint())
		slot7.fromType = slot1:getSiteTypeByHexPoint(slot7:getFirstHexPoint())
	end

	if slot0._canDelectfinishPathMOList and slot0._pathMO then
		for slot6, slot7 in ipairs(slot0._canDelectfinishPathMOList) do
			if slot7:isLinkFinish() and slot0:_isHasIntersection(slot7, slot0._pathMO) then
				slot7.toType = 0
				slot7.fromType = 0
			end
		end
	end
end

function slot0._isHasIntersection(slot0, slot1, slot2)
	if slot1:getHexPointCount() < 1 or slot2:getHexPointCount() < 1 then
		return false
	end

	for slot9, slot10 in ipairs(slot1:getHexPointList()) do
		slot11, slot12 = slot2:checkHexPoint(slot10)

		if slot11 and (slot9 ~= 1 and slot12 ~= 1 and slot12 ~= slot4 or slot9 ~= slot3 and slot12 ~= 1 and slot12 ~= slot4) then
			return true
		end
	end

	return false
end

function slot0._getTempSiteTypeByHexPoint(slot0, slot1, slot2)
	if slot0._pathMO then
		if RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(slot1) == 0 then
			slot3 = RoomTransportHelper.getBuildingTypeByHexPoint(slot1, slot2)
		end

		return slot3
	end

	return 0
end

function slot0._unUseBuildingByHexXy(slot0, slot1, slot2)
	slot4 = RoomMapBuildingModel.instance:getBuildingParam(slot1, slot2) and slot3.buildingUid

	if slot3 and not tabletool.indexOf(slot0._unUseBuilingUidList, slot4) and RoomMapBuildingModel.instance:getBuildingMOById(slot4) and slot5.config and RoomBuildingEnum.CanDateleBuildingType[slot6.buildingType] then
		table.insert(slot0._unUseBuilingUidList, slot4)
		RoomMapController.instance:unUseBuildingRequest(slot4)
		GameFacade.showToast(ToastEnum.RoomTransportRemoveBuilding, slot6.name)
	end
end

function slot0._checkCanBlockMO(slot0, slot1)
	if not slot1 or slot1.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
		return false
	end

	slot2 = slot1.hexPoint

	if RoomMapBuildingModel.instance:getBuildingParam(slot2.x, slot2.y) then
		if slot3:isAreaMainBuilding() then
			return false
		end

		if slot0._isRemoveBuilding ~= true then
			return false
		end
	end
end

function slot0._onDeleteLineItem(slot0, slot1)
end

function slot0._onSelectLineItem(slot0, slot1)
	if slot0._canTouchDrag or slot0._isStarDragPath then
		return
	end

	slot0._lineDataMO = slot1

	RoomMapTransportPathModel.instance:setSelectBuildingType(slot1 and slot1.fromType)

	if not slot0._lineDataMO or slot1 and slot1.fromType ~= slot2.fromType then
		RoomMapTransportPathModel.instance:placeTempTransportPathMO()
		slot0:_clearLinkFailPathMO()
	end

	slot0:_refreshLineLinkUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportPathViewShowChanged)
	slot0:_initSelectLineRemoveLand()
	slot0:_updateAllPathBlockState()
end

function slot0._initSelectLineRemoveLand(slot0)
	if slot0._lineDataMO and RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._lineDataMO.fromType, slot0._lineDataMO.toType) then
		slot0:_setIsRemoveLand(slot1.blockCleanType == RoomBlockEnum.CleanType.CleanLand)
	end
end

function slot0.refreshUI(slot0)
	slot0._dataList = slot0:getLineDataList()
	slot0._lineItemCompList = {}

	gohelper.CreateObjList(slot0, slot0._lineItemShow, slot0._dataList, slot0._gopathlinegroup, slot0._gotypeitem, RoomTransportLineItem)
end

function slot0._refreshLineLinkUI(slot0)
	slot1 = false

	if slot0._lineItemCompList then
		for slot5, slot6 in ipairs(slot0._lineItemCompList) do
			slot6:refreshLinkUI()

			slot7 = slot6:getDataMO()

			if slot0._lineDataMO and slot7 and slot0._lineDataMO.buildingType == slot7.buildingType then
				slot1 = true

				slot6:onSelect(true)
			else
				slot6:onSelect(false)
			end
		end
	end

	if not slot1 then
		slot0._lineDataMO = nil

		RoomMapTransportPathModel.instance:setSelectBuildingType(nil)
	end
end

function slot0.getLineDataList(slot0)
	slot2 = {}
	slot3 = RoomMapBuildingAreaModel.instance

	for slot7, slot8 in ipairs(RoomTransportHelper.getPathBuildingTypesList()) do
		slot10 = slot8[2]

		if slot3:getAreaMOByBType(slot8[1]) and slot3:getAreaMOByBType(slot10) then
			slot11 = {}

			tabletool.addValues(slot11, slot8)
			table.insert(slot2, {
				buildingType = slot9,
				fromType = slot9,
				toType = slot10,
				typeList = slot11
			})
		end
	end

	return slot2
end

function slot0._lineItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	if not slot1._view then
		slot1._view = slot0
	end

	table.insert(slot0._lineItemCompList, slot1)
end

function slot0._clearPath(slot0)
	RoomMapTransportPathModel.instance:placeTempTransportPathMO()

	if RoomMapTransportPathModel.instance:isHasEdit() then
		RoomMapTransportPathModel.instance:resetByTransportPathMOList(RoomTransportPathModel.instance:getList())
		RoomMapTransportPathModel.instance:updateSiteHexPoint()
		RoomTransportController.instance:updateBlockUseState()
		slot0:_initSelectLineRemoveLand()
	end
end

function slot0._updateAllPathBlockState(slot0)
	slot1 = slot0:_getBlockCleanType()
	slot2 = false

	if RoomMapTransportPathModel.instance:getTempTransportPathMO() and slot3:getHexPointCount() > 0 and slot3.blockCleanType ~= slot1 then
		slot3.blockCleanType = slot1
		slot2 = true
	end

	if slot0._lineDataMO and RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._lineDataMO.fromType, slot0._lineDataMO.toType) and slot4:getHexPointCount() > 0 and slot4.blockCleanType ~= slot1 then
		slot4.blockCleanType = slot1
		slot2 = true

		slot4:setIsEdit(true)
	end

	if slot2 then
		RoomTransportController.instance:updateBlockUseState()
	end
end

function slot0._addRefreshBlockId(slot0, slot1)
	RoomTransportController.instance:waitRefreshBlockById(slot1)
	RoomTransportController.instance:waitRefreshPathLineChanged()
end

return slot0

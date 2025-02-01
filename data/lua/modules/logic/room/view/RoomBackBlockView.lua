module("modules.logic.room.view.RoomBackBlockView", package.seeall)

slot0 = class("RoomBackBlockView", BaseView)

function slot0.onInitView(slot0)
	slot0._goviewcontent = gohelper.findChild(slot0.viewGO, "#go_viewContent")
	slot0._gobackOne = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_backOne")
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_viewContent/#go_backOne/#btn_back")
	slot0._gobackState = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_backState")
	slot0._gonotbackState = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_notbackState")
	slot0._gobackMore = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_backMore")
	slot0._btnmoreConfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_viewContent/#go_backMore/#btn_moreConfirm")
	slot0._btnmoreCancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_viewContent/#go_backMore/#btn_moreCancel")
	slot0._gonoSelect = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_backMore/#go_noSelect")
	slot0._gonumber = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_number")
	slot0._gonumberItem = gohelper.findChild(slot0.viewGO, "#go_viewContent/#go_number/#go_numberItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
	slot0._btnmoreConfirm:AddClickListener(slot0._btnmoreConfirmOnClick, slot0)
	slot0._btnmoreCancel:AddClickListener(slot0._btnmoreCancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnback:RemoveClickListener()
	slot0._btnmoreConfirm:RemoveClickListener()
	slot0._btnmoreCancel:RemoveClickListener()
end

function slot0._btnmoreConfirmOnClick(slot0)
	if RoomMapBlockModel.instance:getBackBlockModel():getCount() < 1 then
		GameFacade.showToast(RoomEnum.Toast.InventoryConfirmNoBackBlock)

		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMoreUnBack)

		return
	end

	slot3, slot4 = slot0:_isHasBuilding()

	GameFacade.showMessageBox(slot4 or MessageBoxIdDefine.RoomInventoryBlockMoreBack, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_sendRequest()
	end)
end

function slot0._isHasBuilding(slot0)
	slot3 = RoomMapBuildingModel.instance
	slot4 = ManufactureModel.instance
	slot5 = false
	slot6 = false

	for slot10 = 1, #RoomMapBlockModel.instance:getBackBlockModel():getList() do
		if slot2[slot10].hexPoint and slot3:getBuildingParam(slot11.x, slot11.y) then
			slot5 = true

			if slot3:isHasCritterByBuid(slot12.buildingUid) then
				return true, MessageBoxIdDefine.RoomBackBlockCritterBuilding
			end
		end

		if not slot6 and RoomTransportHelper.checkInLoadHexXY(slot11.x, slot11.y) then
			slot6 = true
		end
	end

	if slot6 then
		return true, MessageBoxIdDefine.RoomBackBlockHasTransportPath
	end

	if slot5 then
		return true, MessageBoxIdDefine.RoomInventoryBlockBuildingBack
	end

	return false
end

function slot0._btnmoreCancelOnClick(slot0)
	slot0:cancelBack()
end

function slot0.cancelBack(slot0)
	RoomMapController.instance:switchBackBlock(false)
end

function slot0._btnbackOnClick(slot0)
	if RoomMapBlockModel.instance:getBackBlockModel():getCount() < 1 then
		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast(RoomBackBlockHelper.isHasInitBlock(slot1:getList()) and RoomEnum.Toast.InventoryCannotBackInitBlock or RoomEnum.Toast.InventoryBlockUnBack)

		return
	end

	slot2, slot3 = slot0:_isHasBuilding()

	if slot2 then
		GameFacade.showMessageBox(slot3, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:_sendRequest()
		end)
	else
		slot0:_sendRequest()
	end
end

function slot0._editableInitView(slot0)
	slot0._animator = ZProj.ProjAnimatorPlayer.Get(slot0.viewGO)
	slot0._gonumberTrs = slot0._gonumber.transform
	slot0._gobackOneTrs = slot0._gobackOne.transform
	slot0._btnbackTrs = slot0._btnback.transform
	slot0._gobackOneTrs = slot0._gobackOne.transform
	slot0._btnmoreConfirmGO = slot0._btnmoreConfirm.gameObject
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._isOneCanBack = true
	slot0._blockNumberItemList = {}
	slot0._confirmCanvasGroup = slot0._gobackOne:GetComponent(typeof(UnityEngine.CanvasGroup))

	table.insert(slot0._blockNumberItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot0._gonumberItem, RoomBackBlockNumberItem, slot0))
	gohelper.setActive(slot0._gonumberItem, false)
end

function slot0._sendRequest(slot0)
	if RoomMapBlockModel.instance:getBackBlockModel():getCount() < 1 then
		return
	end

	slot3 = {}

	for slot7 = 1, #slot1:getList() do
		table.insert(slot3, slot2[slot7].id)
	end

	RoomMapController.instance:unUseBlockListRequest(slot3)
end

function slot0._sceneEvent(slot0, slot1, slot2)
	slot0._scene.fsm:triggerEvent(slot1, slot2 or {})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, slot0._onTryBackBlock, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, slot0._onBackBlockEventHandler, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, slot0._onBackBlockEventHandler, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._onBuildViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0._backBlockShowChanged, slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0._backBlockShowChanged(slot0)
	if not RoomMapBlockModel.instance:isBackMore() then
		slot0._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	if RoomMapBlockModel.instance:isBackMore() or slot0._isLastPlayAnimClose then
		slot0._isLastPlayAnimClose = false

		slot0._animator:Play(UIAnimationName.Open)
		slot0:_refreshUI()
		TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
	elseif not slot1 and not slot0._isLastPlayAnimClose then
		slot0._isLastPlayAnimClose = true

		slot0._animator:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(slot0._refreshUI, slot0, 0.3)
	end
end

function slot0._onTryBackBlock(slot0)
	if not RoomMapBlockModel.instance:isBackMore() then
		slot0._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	slot0:_refreshUI()
end

function slot0._onBuildViewShowChanged(slot0, slot1)
	gohelper.setActive(slot0._goviewcontent, not slot1)
end

function slot0._onBackBlockEventHandler(slot0)
	slot0:_refreshUI()
end

function slot0._cameraTransformUpdate(slot0)
	slot0:_refreshUI()
end

function slot0._getBackBlockModel(slot0)
	return RoomMapBlockModel.instance:getBackBlockModel()
end

function slot0._refreshUI(slot0)
	slot2 = slot0:_getBackBlockModel():getCount()

	gohelper.setActive(slot0._gobackMore, RoomMapBlockModel.instance:isBackMore() == true)
	gohelper.setActive(slot0._btnmoreConfirmGO, slot2 > 0)
	gohelper.setActive(slot0._gonoSelect, slot2 <= 0)

	if slot2 < 1 then
		gohelper.setActive(slot0._gobackOne, false)
		gohelper.setActive(slot0._gonumber, false)

		return
	end

	gohelper.setActive(slot0._gobackOne, slot3 == false)
	gohelper.setActive(slot0._gonumber, slot3 == true)

	if slot3 == false and slot1:getByIndex(1) and slot0._scene.mapmgr:getBlockEntity(slot4.id, SceneTag.RoomMapBlock) then
		slot0:_setUIPos(Vector3(transformhelper.getPos(slot5.goTrs)), slot0._btnbackTrs, slot0._gobackOneTrs, nil, true)
		gohelper.setActive(slot0._gobackState, slot0._isOneCanBack == true)
		gohelper.setActive(slot0._gonotbackState, slot0._isOneCanBack == false)
	end

	slot0:_refreshItemUI()
	slot0:_refreshItemUIPos()
end

function slot0._refreshItemUI(slot0)
	for slot6 = 1, #RoomMapBlockModel.instance:getBackBlockModel():getList() do
		if not slot0._blockNumberItemList[slot6] then
			table.insert(slot0._blockNumberItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gonumberItem, slot0._gonumber, "numberitem" .. slot6), RoomBackBlockNumberItem, slot0))
		end

		slot7:setNumber(slot6)
		slot7:setBlockMO(slot2[slot6])
	end

	for slot6 = #slot2 + 1, #slot0._blockNumberItemList do
		slot0._blockNumberItemList[slot6]:setBlockMO(nil)
	end
end

function slot0._refreshItemUIPos(slot0)
	for slot4 = 1, #slot0._blockNumberItemList do
		if slot0._blockNumberItemList[slot4]:getBlockMO() and slot0._scene.mapmgr:getBlockEntity(slot6.id, SceneTag.RoomMapBlock) then
			slot0:_setUIPos(Vector3(transformhelper.getPos(slot7.goTrs)), slot5:getGOTrs(), slot0._gonumberTrs)
		end
	end
end

function slot0._setUIPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = RoomBendingHelper.worldToBendingSimple(slot1)
	slot9 = Vector2.Distance(slot0._scene.camera:getCameraFocus(), Vector2(slot1.x, slot1.z))

	if slot5 then
		slot10 = 1
		slot10 = slot9 <= 2.5 and 1 or slot9 >= 3.5 and 0 or 3.5 - slot9

		if slot0._lastAlpha == nil or math.abs(slot0._lastAlpha - slot10) >= 0.02 then
			slot0._lastAlpha = slot10
			slot0._confirmCanvasGroup.alpha = slot10
			slot0._confirmCanvasGroup.blocksRaycasts = slot10 > 0.25
		end
	end

	slot10 = 1

	transformhelper.setLocalScale(slot2, slot10, slot10, slot10)

	slot11 = slot0._scene.camera:getCameraRotate()
	slot12 = slot7.x
	slot13 = slot7.z
	slot4 = slot4 or 0.12

	if slot6 then
		slot12 = slot7.x - (0.9 - slot10 * 0.5) * Mathf.Sin(slot11)
		slot13 = slot7.z - (0.9 - slot10 * 0.5) * Mathf.Cos(slot11)
	end

	slot15 = recthelper.worldPosToAnchorPos(Vector3(slot12, slot7.y + slot4, slot13), slot3)

	recthelper.setAnchor(slot2, slot15.x, slot15.y)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._refreshUI, slot0)
end

return slot0

module("modules.logic.room.view.RoomBackBlockView", package.seeall)

local var_0_0 = class("RoomBackBlockView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goviewcontent = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent")
	arg_1_0._gobackOne = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_backOne")
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_viewContent/#go_backOne/#btn_back")
	arg_1_0._gobackState = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_backState")
	arg_1_0._gonotbackState = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_backOne/#btn_back/#go_notbackState")
	arg_1_0._gobackMore = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_backMore")
	arg_1_0._btnmoreConfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_viewContent/#go_backMore/#btn_moreConfirm")
	arg_1_0._btnmoreCancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_viewContent/#go_backMore/#btn_moreCancel")
	arg_1_0._gonoSelect = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_backMore/#go_noSelect")
	arg_1_0._gonumber = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_number")
	arg_1_0._gonumberItem = gohelper.findChild(arg_1_0.viewGO, "#go_viewContent/#go_number/#go_numberItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
	arg_2_0._btnmoreConfirm:AddClickListener(arg_2_0._btnmoreConfirmOnClick, arg_2_0)
	arg_2_0._btnmoreCancel:AddClickListener(arg_2_0._btnmoreCancelOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnback:RemoveClickListener()
	arg_3_0._btnmoreConfirm:RemoveClickListener()
	arg_3_0._btnmoreCancel:RemoveClickListener()
end

function var_0_0._btnmoreConfirmOnClick(arg_4_0)
	if RoomMapBlockModel.instance:getBackBlockModel():getCount() < 1 then
		GameFacade.showToast(RoomEnum.Toast.InventoryConfirmNoBackBlock)

		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast(RoomEnum.Toast.InventoryBlockMoreUnBack)

		return
	end

	local var_4_0, var_4_1 = arg_4_0:_isHasBuilding()

	var_4_1 = var_4_1 or MessageBoxIdDefine.RoomInventoryBlockMoreBack

	GameFacade.showMessageBox(var_4_1, MsgBoxEnum.BoxType.Yes_No, function()
		arg_4_0:_sendRequest()
	end)
end

function var_0_0._isHasBuilding(arg_6_0)
	local var_6_0 = RoomMapBlockModel.instance:getBackBlockModel():getList()
	local var_6_1 = RoomMapBuildingModel.instance
	local var_6_2 = ManufactureModel.instance
	local var_6_3 = false
	local var_6_4 = false

	for iter_6_0 = 1, #var_6_0 do
		local var_6_5 = var_6_0[iter_6_0].hexPoint
		local var_6_6 = var_6_5 and var_6_1:getBuildingParam(var_6_5.x, var_6_5.y)

		if var_6_6 then
			var_6_3 = true

			if var_6_1:isHasCritterByBuid(var_6_6.buildingUid) then
				return true, MessageBoxIdDefine.RoomBackBlockCritterBuilding
			end
		end

		if not var_6_4 and RoomTransportHelper.checkInLoadHexXY(var_6_5.x, var_6_5.y) then
			var_6_4 = true
		end
	end

	if var_6_4 then
		return true, MessageBoxIdDefine.RoomBackBlockHasTransportPath
	end

	if var_6_3 then
		return true, MessageBoxIdDefine.RoomInventoryBlockBuildingBack
	end

	return false
end

function var_0_0._btnmoreCancelOnClick(arg_7_0)
	arg_7_0:cancelBack()
end

function var_0_0.cancelBack(arg_8_0)
	RoomMapController.instance:switchBackBlock(false)
end

function var_0_0._btnbackOnClick(arg_9_0)
	local var_9_0 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_9_0:getCount() < 1 then
		return
	end

	if not RoomMapBlockModel.instance:isCanBackBlock() then
		GameFacade.showToast(RoomBackBlockHelper.isHasInitBlock(var_9_0:getList()) and RoomEnum.Toast.InventoryCannotBackInitBlock or RoomEnum.Toast.InventoryBlockUnBack)

		return
	end

	local var_9_1, var_9_2 = arg_9_0:_isHasBuilding()

	if var_9_1 then
		GameFacade.showMessageBox(var_9_2, MsgBoxEnum.BoxType.Yes_No, function()
			arg_9_0:_sendRequest()
		end)
	else
		arg_9_0:_sendRequest()
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._animator = ZProj.ProjAnimatorPlayer.Get(arg_11_0.viewGO)
	arg_11_0._gonumberTrs = arg_11_0._gonumber.transform
	arg_11_0._gobackOneTrs = arg_11_0._gobackOne.transform
	arg_11_0._btnbackTrs = arg_11_0._btnback.transform
	arg_11_0._gobackOneTrs = arg_11_0._gobackOne.transform
	arg_11_0._btnmoreConfirmGO = arg_11_0._btnmoreConfirm.gameObject
	arg_11_0._scene = GameSceneMgr.instance:getCurScene()
	arg_11_0._isOneCanBack = true
	arg_11_0._blockNumberItemList = {}
	arg_11_0._confirmCanvasGroup = arg_11_0._gobackOne:GetComponent(typeof(UnityEngine.CanvasGroup))

	table.insert(arg_11_0._blockNumberItemList, MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._gonumberItem, RoomBackBlockNumberItem, arg_11_0))
	gohelper.setActive(arg_11_0._gonumberItem, false)
end

function var_0_0._sendRequest(arg_12_0)
	local var_12_0 = RoomMapBlockModel.instance:getBackBlockModel()

	if var_12_0:getCount() < 1 then
		return
	end

	local var_12_1 = var_12_0:getList()
	local var_12_2 = {}

	for iter_12_0 = 1, #var_12_1 do
		table.insert(var_12_2, var_12_1[iter_12_0].id)
	end

	RoomMapController.instance:unUseBlockListRequest(var_12_2)
end

function var_0_0._sceneEvent(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._scene.fsm:triggerEvent(arg_13_1, arg_13_2 or {})
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_15_0._cameraTransformUpdate, arg_15_0)
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.ClientTryBackBlock, arg_15_0._onTryBackBlock, arg_15_0)
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.ClientCancelBackBlock, arg_15_0._onBackBlockEventHandler, arg_15_0)
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.ConfirmBackBlock, arg_15_0._onBackBlockEventHandler, arg_15_0)
	arg_15_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_15_0._onBuildViewShowChanged, arg_15_0)
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_15_0._backBlockShowChanged, arg_15_0)
	arg_15_0:_refreshUI()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0._backBlockShowChanged(arg_17_0)
	if not RoomMapBlockModel.instance:isBackMore() then
		arg_17_0._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	local var_17_0 = RoomMapBlockModel.instance:isBackMore()

	if var_17_0 or arg_17_0._isLastPlayAnimClose then
		arg_17_0._isLastPlayAnimClose = false

		arg_17_0._animator:Play(UIAnimationName.Open)
		arg_17_0:_refreshUI()
		TaskDispatcher.cancelTask(arg_17_0._refreshUI, arg_17_0)
	elseif not var_17_0 and not arg_17_0._isLastPlayAnimClose then
		arg_17_0._isLastPlayAnimClose = true

		arg_17_0._animator:Play(UIAnimationName.Close)
		TaskDispatcher.runDelay(arg_17_0._refreshUI, arg_17_0, 0.3)
	end
end

function var_0_0._onTryBackBlock(arg_18_0)
	if not RoomMapBlockModel.instance:isBackMore() then
		arg_18_0._isOneCanBack = RoomMapBlockModel.instance:isCanBackBlock()
	end

	arg_18_0:_refreshUI()
end

function var_0_0._onBuildViewShowChanged(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._goviewcontent, not arg_19_1)
end

function var_0_0._onBackBlockEventHandler(arg_20_0)
	arg_20_0:_refreshUI()
end

function var_0_0._cameraTransformUpdate(arg_21_0)
	arg_21_0:_refreshUI()
end

function var_0_0._getBackBlockModel(arg_22_0)
	return RoomMapBlockModel.instance:getBackBlockModel()
end

function var_0_0._refreshUI(arg_23_0)
	local var_23_0 = arg_23_0:_getBackBlockModel()
	local var_23_1 = var_23_0:getCount()
	local var_23_2 = RoomMapBlockModel.instance:isBackMore()

	gohelper.setActive(arg_23_0._gobackMore, var_23_2 == true)
	gohelper.setActive(arg_23_0._btnmoreConfirmGO, var_23_1 > 0)
	gohelper.setActive(arg_23_0._gonoSelect, var_23_1 <= 0)

	if var_23_1 < 1 then
		gohelper.setActive(arg_23_0._gobackOne, false)
		gohelper.setActive(arg_23_0._gonumber, false)

		return
	end

	gohelper.setActive(arg_23_0._gobackOne, var_23_2 == false)
	gohelper.setActive(arg_23_0._gonumber, var_23_2 == true)

	if var_23_2 == false then
		local var_23_3 = var_23_0:getByIndex(1)
		local var_23_4 = var_23_3 and arg_23_0._scene.mapmgr:getBlockEntity(var_23_3.id, SceneTag.RoomMapBlock)

		if var_23_4 then
			local var_23_5 = Vector3(transformhelper.getPos(var_23_4.goTrs))

			arg_23_0:_setUIPos(var_23_5, arg_23_0._btnbackTrs, arg_23_0._gobackOneTrs, nil, true)
			gohelper.setActive(arg_23_0._gobackState, arg_23_0._isOneCanBack == true)
			gohelper.setActive(arg_23_0._gonotbackState, arg_23_0._isOneCanBack == false)
		end
	end

	arg_23_0:_refreshItemUI()
	arg_23_0:_refreshItemUIPos()
end

function var_0_0._refreshItemUI(arg_24_0)
	local var_24_0 = RoomMapBlockModel.instance:getBackBlockModel():getList()

	for iter_24_0 = 1, #var_24_0 do
		local var_24_1 = arg_24_0._blockNumberItemList[iter_24_0]

		if not var_24_1 then
			local var_24_2 = gohelper.clone(arg_24_0._gonumberItem, arg_24_0._gonumber, "numberitem" .. iter_24_0)

			var_24_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_2, RoomBackBlockNumberItem, arg_24_0)

			table.insert(arg_24_0._blockNumberItemList, var_24_1)
		end

		var_24_1:setNumber(iter_24_0)
		var_24_1:setBlockMO(var_24_0[iter_24_0])
	end

	for iter_24_1 = #var_24_0 + 1, #arg_24_0._blockNumberItemList do
		arg_24_0._blockNumberItemList[iter_24_1]:setBlockMO(nil)
	end
end

function var_0_0._refreshItemUIPos(arg_25_0)
	for iter_25_0 = 1, #arg_25_0._blockNumberItemList do
		local var_25_0 = arg_25_0._blockNumberItemList[iter_25_0]
		local var_25_1 = var_25_0:getBlockMO()
		local var_25_2 = var_25_1 and arg_25_0._scene.mapmgr:getBlockEntity(var_25_1.id, SceneTag.RoomMapBlock)

		if var_25_2 then
			local var_25_3 = Vector3(transformhelper.getPos(var_25_2.goTrs))

			arg_25_0:_setUIPos(var_25_3, var_25_0:getGOTrs(), arg_25_0._gonumberTrs)
		end
	end
end

function var_0_0._setUIPos(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0 = RoomBendingHelper.worldToBendingSimple(arg_26_1)
	local var_26_1 = arg_26_0._scene.camera:getCameraFocus()
	local var_26_2 = Vector2.Distance(var_26_1, Vector2(arg_26_1.x, arg_26_1.z))

	if arg_26_5 then
		local var_26_3 = 1
		local var_26_4 = var_26_2 <= 2.5 and 1 or var_26_2 >= 3.5 and 0 or 3.5 - var_26_2

		if arg_26_0._lastAlpha == nil or math.abs(arg_26_0._lastAlpha - var_26_4) >= 0.02 then
			arg_26_0._lastAlpha = var_26_4
			arg_26_0._confirmCanvasGroup.alpha = var_26_4
			arg_26_0._confirmCanvasGroup.blocksRaycasts = var_26_4 > 0.25
		end
	end

	local var_26_5 = 1

	transformhelper.setLocalScale(arg_26_2, var_26_5, var_26_5, var_26_5)

	local var_26_6 = arg_26_0._scene.camera:getCameraRotate()
	local var_26_7 = var_26_0.x
	local var_26_8 = var_26_0.z

	arg_26_4 = arg_26_4 or 0.12

	if arg_26_6 then
		var_26_7 = var_26_0.x - (0.9 - var_26_5 * 0.5) * Mathf.Sin(var_26_6)
		var_26_8 = var_26_0.z - (0.9 - var_26_5 * 0.5) * Mathf.Cos(var_26_6)
	end

	local var_26_9 = Vector3(var_26_7, var_26_0.y + arg_26_4, var_26_8)
	local var_26_10 = recthelper.worldPosToAnchorPos(var_26_9, arg_26_3)

	recthelper.setAnchor(arg_26_2, var_26_10.x, var_26_10.y)
end

function var_0_0.onDestroyView(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._refreshUI, arg_27_0)
end

return var_0_0

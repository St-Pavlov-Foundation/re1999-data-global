module("modules.logic.room.view.debug.RoomDebugBuildingAreaView", package.seeall)

local var_0_0 = class("RoomDebugBuildingAreaView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_content/#btn_close")
	arg_1_0._goarearoot = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_arearoot")
	arg_1_0._goareaitem = gohelper.findChild(arg_1_0.viewGO, "#go_content/#go_arearoot/#go_areaitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goarearootTrs = arg_5_0._goarearoot.transform
	arg_5_0._itemTbList = {}
	arg_5_0._lastIndex = 1

	table.insert(arg_5_0._itemTbList, arg_5_0:_createTbByGO(arg_5_0._goareaitem))
end

function var_0_0._createTbByGO(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getUserDataTb_()

	var_6_0.go = arg_6_1
	var_6_0.goTrs = arg_6_1.transform
	var_6_0.txtname = gohelper.findChildText(arg_6_1, "txt_name")
	var_6_0._canvasGroup = arg_6_1:GetComponent(typeof(UnityEngine.CanvasGroup))

	return var_6_0
end

function var_0_0.onOpen(arg_7_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Room then
		arg_7_0:closeThis()

		return
	end

	arg_7_0:addEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_7_0._refreshUI, arg_7_0)

	arg_7_0._scene = GameSceneMgr.instance:getCurScene()

	arg_7_0:_refreshUI()
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(RoomMapController.instance, RoomEvent.CameraTransformUpdate, arg_8_0._refreshUI, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0._refreshUI(arg_10_0)
	arg_10_0._focusPos = arg_10_0._scene.camera:getCameraFocus()

	local var_10_0 = RoomMapBuildingModel.instance:getAllOccupyDict()
	local var_10_1 = 1

	for iter_10_0, iter_10_1 in pairs(var_10_0) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			if var_10_1 > #arg_10_0._itemTbList then
				local var_10_2 = gohelper.cloneInPlace(arg_10_0._goareaitem)

				table.insert(arg_10_0._itemTbList, arg_10_0:_createTbByGO(var_10_2))
			end

			local var_10_3 = arg_10_0._itemTbList[var_10_1]

			var_10_1 = var_10_1 + 1

			arg_10_0:_setTbItemAvtive(var_10_3, true)
			arg_10_0:_refreshByParam(var_10_3, iter_10_3)
		end
	end

	for iter_10_4 = var_10_1, #arg_10_0._itemTbList do
		arg_10_0:_setTbItemAvtive(arg_10_0._itemTbList[iter_10_4], false)
	end
end

function var_0_0._setTbItemAvtive(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1.isActive ~= arg_11_2 then
		arg_11_1.isActive = arg_11_2

		gohelper.setActive(arg_11_1.go, arg_11_2)
	end
end

function var_0_0._refreshByParam(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1.buildingId ~= arg_12_2.buildingId or arg_12_1.posindex ~= arg_12_2.index then
		arg_12_1.buildingId = arg_12_2.buildingId
		arg_12_1.posindex = arg_12_2.index

		local var_12_0 = RoomMapModel.instance:getBuildingConfigParam(arg_12_2.buildingId).pointList[arg_12_2.index]

		arg_12_1.txtname.text = var_12_0.x .. "#" .. var_12_0.y
	end

	local var_12_1 = HexMath.hexToPosition(arg_12_2.hexPoint, RoomBlockEnum.BlockSize)

	arg_12_0:_setTbItemPos(var_12_1, arg_12_1, arg_12_0._goarearootTrs)
end

function var_0_0._setTbItemPos(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Vector3(arg_13_1.x, 0.12, arg_13_1.y)
	local var_13_1 = recthelper.worldPosToAnchorPos(var_13_0, arg_13_3)
	local var_13_2 = Vector2.Distance(arg_13_0._focusPos, arg_13_1)
	local var_13_3 = 1
	local var_13_4 = var_13_2 <= 2.5 and 1 or var_13_2 >= 3.5 and 0 or 3.5 - var_13_2

	arg_13_2._canvasGroup.alpha = var_13_4

	recthelper.setAnchor(arg_13_2.goTrs, var_13_1.x, var_13_1.y)
end

return var_0_0

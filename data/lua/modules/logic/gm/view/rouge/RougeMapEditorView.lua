module("modules.logic.gm.view.rouge.RougeMapEditorView", package.seeall)

local var_0_0 = class("RougeMapEditorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnExit = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_exit")
	arg_1_0.btnGenerateNode = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_generatenode")
	arg_1_0.btnGeneratePathNode = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_generatepathnode")
	arg_1_0.btnGenerateLeaveNode = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_generateleavenode")
	arg_1_0.btnGeneratePath = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_generatepath")
	arg_1_0.dropMap = gohelper.findChildDropdown(arg_1_0.viewGO, "left_tool/#drop_map")
	arg_1_0.goStartTextContainer = gohelper.findChild(arg_1_0.viewGO, "textcontainer")
	arg_1_0.goStartText = gohelper.findChild(arg_1_0.viewGO, "textcontainer/startText")
	arg_1_0.btnShowPath = gohelper.findChildButton(arg_1_0.viewGO, "left_tool/#btn_showpath")
	arg_1_0.inputStart = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "left_tool/inputpathpoint/#input_start")
	arg_1_0.inputEnd = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "left_tool/inputpathpoint/#input_end")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnExit:AddClickListener(arg_2_0.onClickExit, arg_2_0)
	arg_2_0.btnGenerateNode:AddClickListener(arg_2_0.onClickGenerateNode, arg_2_0)
	arg_2_0.btnGeneratePathNode:AddClickListener(arg_2_0.onClickGeneratePathNode, arg_2_0)
	arg_2_0.btnGenerateLeaveNode:AddClickListener(arg_2_0.onClickGenerateLeaveNode, arg_2_0)
	arg_2_0.btnGeneratePath:AddClickListener(arg_2_0.onClickGeneratePath, arg_2_0)
	arg_2_0.btnShowPath:AddClickListener(arg_2_0.onClickShowPath, arg_2_0)
	arg_2_0.dropMap:AddOnValueChanged(arg_2_0.onDropMapValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnExit:RemoveClickListener()
	arg_3_0.btnGenerateNode:RemoveClickListener()
	arg_3_0.btnGeneratePathNode:RemoveClickListener()
	arg_3_0.btnGenerateLeaveNode:RemoveClickListener()
	arg_3_0.btnGeneratePath:RemoveClickListener()
	arg_3_0.btnShowPath:RemoveClickListener()
	arg_3_0.dropMap:RemoveOnValueChanged()
end

function var_0_0.onClickShowPath(arg_4_0)
	local var_4_0 = tonumber(arg_4_0.inputStart:GetText())
	local var_4_1 = tonumber(arg_4_0.inputEnd:GetText())

	if not var_4_0 or not var_4_1 then
		return
	end

	local var_4_2 = {}
	local var_4_3 = RougeMapEditModel.instance:getLineDict()

	RougeMapConfig.instance:getPathIndexList(var_4_3, var_4_0, var_4_1, var_4_2)

	if GameUtil.tabletool_dictIsEmpty(var_4_2) then
		GameFacade.showToastString("没找到路径")

		return
	end

	local var_4_4 = table.concat(var_4_2, " -> ")

	logError(var_4_4)
	GameFacade.showToastString(var_4_4)
end

function var_0_0.onDropMapValueChanged(arg_5_0, arg_5_1)
	if arg_5_0.switchLayering then
		arg_5_0.dropMap:SetValue(arg_5_0.layerIndex - 1)

		return
	end

	local var_5_0 = arg_5_0.layerIdList[arg_5_1 + 1]

	if var_5_0 == arg_5_0.layerId then
		return
	end

	arg_5_0.switchLayering = true
	arg_5_0.layerIndex = arg_5_1 + 1
	arg_5_0.layerId = var_5_0

	arg_5_0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, arg_5_0.onSwitchDone, arg_5_0)

	local var_5_1 = GameSceneMgr.instance:getCurScene().map

	RougeMapEditModel.instance:init(var_5_0)
	var_5_1:switchMap()
end

function var_0_0.onSwitchDone(arg_6_0)
	arg_6_0.switchLayering = false

	ViewMgr.instance:openView(arg_6_0.viewName)
end

function var_0_0.onClickExit(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClickGenerateNode(arg_8_0)
	if arg_8_0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodeConfig()
end

function var_0_0.onClickGeneratePathNode(arg_9_0)
	if arg_9_0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generatePathNodeConfig()
end

function var_0_0.onClickGenerateLeaveNode(arg_10_0)
	if arg_10_0.switchLayering then
		return
	end

	if not RougeMapEditModel.instance:getLeavePos() then
		GameFacade.showToastString("未生成离开点。")

		return
	end

	RougeMapEditModel.instance:generateLeaveNodeConfig()
end

function var_0_0.onClickGeneratePath(arg_11_0)
	if arg_11_0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodePath()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.camera = CameraMgr.instance:getMainCamera()
	arg_12_0.offsetZ = RougeMapEnum.OffsetZ.NodeContainer
	arg_12_0.map = RougeMapController.instance:getMapComp()
	arg_12_0.frameHandle = UpdateBeat:CreateListener(arg_12_0.onFrame, arg_12_0)

	UpdateBeat:AddListener(arg_12_0.frameHandle)
	gohelper.setActive(arg_12_0.goStartText, false)

	arg_12_0.rectTrView = arg_12_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_12_0.textGoList = arg_12_0:getUserDataTb_()

	arg_12_0:initDrop()
end

function var_0_0.initDrop(arg_13_0)
	arg_13_0.layerIdList = {}
	arg_13_0.layerStrList = {}

	for iter_13_0, iter_13_1 in ipairs(lua_rouge_middle_layer.configList) do
		table.insert(arg_13_0.layerIdList, iter_13_1.id)
		table.insert(arg_13_0.layerStrList, tostring(iter_13_1.id))
	end

	arg_13_0.dropMap:ClearOptions()
	arg_13_0.dropMap:AddOptions(arg_13_0.layerStrList)

	arg_13_0.layerId = RougeMapEditModel.instance:getMiddleLayerId()

	for iter_13_2, iter_13_3 in ipairs(arg_13_0.layerIdList) do
		if iter_13_3 == arg_13_0.layerId then
			arg_13_0.dropMap:SetValue(iter_13_2 - 1)
		end
	end
end

function var_0_0.onUpdateParam(arg_14_0)
	arg_14_0.map = RougeMapController.instance:getMapComp()

	arg_14_0:refreshAllText()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:refreshAllText()
end

function var_0_0.refreshAllText(arg_16_0)
	local var_16_0 = RougeMapEditModel.instance:getPointsDict()
	local var_16_1 = RougeMapEditModel.instance:getPathPointsDict()

	if GameUtil.tabletool_dictIsEmpty(var_16_0) and GameUtil.tabletool_dictIsEmpty(var_16_1) then
		gohelper.setActive(arg_16_0.goStartTextContainer, false)

		return
	end

	gohelper.setActive(arg_16_0.goStartTextContainer, true)

	local var_16_2 = 0
	local var_16_3 = arg_16_0:refreshPointDictText(var_16_0, "坐标点id : ", var_16_2)

	for iter_16_0 = arg_16_0:refreshPointDictText(var_16_1, "路径点id : ", var_16_3) + 1, #arg_16_0.textGoList do
		gohelper.setActive(arg_16_0.textGoList[iter_16_0], false)
	end
end

function var_0_0.refreshPointDictText(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		arg_17_3 = arg_17_3 + 1

		local var_17_0 = arg_17_0.textGoList[arg_17_3]

		if not var_17_0 then
			var_17_0 = gohelper.cloneInPlace(arg_17_0.goStartText)

			table.insert(arg_17_0.textGoList, var_17_0)
		end

		gohelper.setActive(var_17_0, true)

		local var_17_1 = var_17_0:GetComponent(gohelper.Type_RectTransform)
		local var_17_2, var_17_3 = recthelper.worldPosToAnchorPos2(iter_17_1, arg_17_0.rectTrView)

		var_17_3 = var_17_3 > 0 and var_17_3 + 60 or var_17_3 - 60

		recthelper.setAnchor(var_17_1, var_17_2, var_17_3)

		gohelper.findChildText(var_17_0, "text").text = arg_17_2 .. iter_17_0
	end

	return arg_17_3
end

function var_0_0.onFrame(arg_18_0)
	if arg_18_0.switchLayering then
		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		arg_18_0:createPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		arg_18_0:createPathPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.R) then
		arg_18_0:createLeavePoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.E) then
		arg_18_0:deletePoint()

		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		if UnityEngine.Input.GetMouseButtonDown(0) then
			arg_18_0:startDrag()
		elseif UnityEngine.Input.GetMouseButton(0) then
			arg_18_0:dragPoint()
		end

		return
	end

	if UnityEngine.Input.GetMouseButtonUp(0) then
		if arg_18_0.draggingId then
			arg_18_0.draggingId = nil
		else
			arg_18_0:startEditLine()
		end

		return
	end

	if UnityEngine.Input.GetMouseButton(1) then
		arg_18_0:exitEditLine()

		return
	end

	arg_18_0:drawEditingLine()
end

function var_0_0.createPoint(arg_19_0)
	if arg_19_0.editLining then
		return
	end

	local var_19_0 = RougeMapHelper.getScenePos(arg_19_0.camera, UnityEngine.Input.mousePosition, arg_19_0.offsetZ)

	if RougeMapEditModel.instance:getPointByPos(var_19_0) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	arg_19_0.map:addPoint(var_19_0)
	arg_19_0:refreshAllText()
end

function var_0_0.createPathPoint(arg_20_0)
	if arg_20_0.editLining then
		return
	end

	local var_20_0 = RougeMapHelper.getScenePos(arg_20_0.camera, UnityEngine.Input.mousePosition, arg_20_0.offsetZ)

	if RougeMapEditModel.instance:getPointByPos(var_20_0) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	arg_20_0.map:addPathPoint(var_20_0)
	arg_20_0:refreshAllText()
end

function var_0_0.createLeavePoint(arg_21_0)
	if arg_21_0.editLining then
		return
	end

	local var_21_0 = RougeMapHelper.getScenePos(arg_21_0.camera, UnityEngine.Input.mousePosition, arg_21_0.offsetZ)

	if RougeMapEditModel.instance:getPointByPos(var_21_0) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	arg_21_0.map:addLeavePoint(var_21_0)
end

function var_0_0.deletePoint(arg_22_0)
	if arg_22_0.editLining then
		return
	end

	local var_22_0 = RougeMapHelper.getScenePos(arg_22_0.camera, UnityEngine.Input.mousePosition, arg_22_0.offsetZ)
	local var_22_1, var_22_2 = RougeMapEditModel.instance:getPointByPos(var_22_0)

	if var_22_1 then
		arg_22_0.map:deletePoint(var_22_2, var_22_1)
		arg_22_0:refreshAllText()
	end
end

function var_0_0.startDrag(arg_23_0)
	if not arg_23_0.draggingId then
		local var_23_0 = RougeMapHelper.getScenePos(arg_23_0.camera, UnityEngine.Input.mousePosition, arg_23_0.offsetZ)
		local var_23_1, var_23_2 = RougeMapEditModel.instance:getPointByPos(var_23_0)

		if not var_23_1 then
			return
		end

		arg_23_0.draggingId = var_23_1
		arg_23_0.draggingType = var_23_2
	end
end

function var_0_0.dragPoint(arg_24_0)
	if not arg_24_0.draggingId then
		return
	end

	local var_24_0 = RougeMapHelper.getScenePos(arg_24_0.camera, UnityEngine.Input.mousePosition, arg_24_0.offsetZ)

	arg_24_0.map:setPointPos(arg_24_0.draggingId, arg_24_0.draggingType, var_24_0.x, var_24_0.y)
	arg_24_0:refreshAllText()
end

function var_0_0.startEditLine(arg_25_0)
	local var_25_0 = RougeMapHelper.getScenePos(arg_25_0.camera, UnityEngine.Input.mousePosition, arg_25_0.offsetZ)
	local var_25_1, var_25_2 = RougeMapEditModel.instance:getPointByPos(var_25_0)

	if not var_25_1 then
		return
	end

	if arg_25_0.editLining then
		if arg_25_0.startType == var_25_2 and arg_25_0.startPointId == var_25_1 then
			return
		end

		if not RougeMapEditModel.instance:checkCanAddLine(arg_25_0.startType, arg_25_0.startPointId, var_25_2, var_25_1) then
			return
		end

		arg_25_0.map:addLine(arg_25_0.startType, arg_25_0.startPointId, var_25_2, var_25_1)

		arg_25_0.editLineGo = nil
		arg_25_0.editLining = false
		arg_25_0.startPointId = nil

		return
	end

	arg_25_0.editLining = true
	arg_25_0.startPointId = var_25_1
	arg_25_0.startType = var_25_2

	arg_25_0.map:createEditingLine(var_25_1, var_25_2)
end

function var_0_0.exitEditLine(arg_26_0)
	arg_26_0.map:exitEditLine()

	arg_26_0.editLining = false
	arg_26_0.startPointId = nil
end

function var_0_0.drawEditingLine(arg_27_0)
	if not arg_27_0.editLining then
		return
	end

	local var_27_0 = RougeMapHelper.getScenePos(arg_27_0.camera, UnityEngine.Input.mousePosition, arg_27_0.offsetZ)

	arg_27_0.map:updateDrawingLine(var_27_0)
end

function var_0_0.onClose(arg_28_0)
	if arg_28_0.frameHandle then
		UpdateBeat:RemoveListener(arg_28_0.frameHandle)

		arg_28_0.frameHandle = nil
	end
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0

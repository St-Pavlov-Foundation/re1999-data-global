module("modules.logic.gm.view.rouge.RougeMapEditorView", package.seeall)

slot0 = class("RougeMapEditorView", BaseView)

function slot0.onInitView(slot0)
	slot0.btnExit = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_exit")
	slot0.btnGenerateNode = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_generatenode")
	slot0.btnGeneratePathNode = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_generatepathnode")
	slot0.btnGenerateLeaveNode = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_generateleavenode")
	slot0.btnGeneratePath = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_generatepath")
	slot0.dropMap = gohelper.findChildDropdown(slot0.viewGO, "left_tool/#drop_map")
	slot0.goStartTextContainer = gohelper.findChild(slot0.viewGO, "textcontainer")
	slot0.goStartText = gohelper.findChild(slot0.viewGO, "textcontainer/startText")
	slot0.btnShowPath = gohelper.findChildButton(slot0.viewGO, "left_tool/#btn_showpath")
	slot0.inputStart = gohelper.findChildTextMeshInputField(slot0.viewGO, "left_tool/inputpathpoint/#input_start")
	slot0.inputEnd = gohelper.findChildTextMeshInputField(slot0.viewGO, "left_tool/inputpathpoint/#input_end")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnExit:AddClickListener(slot0.onClickExit, slot0)
	slot0.btnGenerateNode:AddClickListener(slot0.onClickGenerateNode, slot0)
	slot0.btnGeneratePathNode:AddClickListener(slot0.onClickGeneratePathNode, slot0)
	slot0.btnGenerateLeaveNode:AddClickListener(slot0.onClickGenerateLeaveNode, slot0)
	slot0.btnGeneratePath:AddClickListener(slot0.onClickGeneratePath, slot0)
	slot0.btnShowPath:AddClickListener(slot0.onClickShowPath, slot0)
	slot0.dropMap:AddOnValueChanged(slot0.onDropMapValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnExit:RemoveClickListener()
	slot0.btnGenerateNode:RemoveClickListener()
	slot0.btnGeneratePathNode:RemoveClickListener()
	slot0.btnGenerateLeaveNode:RemoveClickListener()
	slot0.btnGeneratePath:RemoveClickListener()
	slot0.btnShowPath:RemoveClickListener()
	slot0.dropMap:RemoveOnValueChanged()
end

function slot0.onClickShowPath(slot0)
	slot2 = tonumber(slot0.inputEnd:GetText())

	if not tonumber(slot0.inputStart:GetText()) or not slot2 then
		return
	end

	slot3 = {}

	RougeMapConfig.instance:getPathIndexList(RougeMapEditModel.instance:getLineDict(), slot1, slot2, slot3)

	if GameUtil.tabletool_dictIsEmpty(slot3) then
		GameFacade.showToastString("没找到路径")

		return
	end

	slot5 = table.concat(slot3, " -> ")

	logError(slot5)
	GameFacade.showToastString(slot5)
end

function slot0.onDropMapValueChanged(slot0, slot1)
	if slot0.switchLayering then
		slot0.dropMap:SetValue(slot0.layerIndex - 1)

		return
	end

	if slot0.layerIdList[slot1 + 1] == slot0.layerId then
		return
	end

	slot0.switchLayering = true
	slot0.layerIndex = slot1 + 1
	slot0.layerId = slot2

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, slot0.onSwitchDone, slot0)
	RougeMapEditModel.instance:init(slot2)
	GameSceneMgr.instance:getCurScene().map:switchMap()
end

function slot0.onSwitchDone(slot0)
	slot0.switchLayering = false

	ViewMgr.instance:openView(slot0.viewName)
end

function slot0.onClickExit(slot0)
	slot0:closeThis()
end

function slot0.onClickGenerateNode(slot0)
	if slot0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodeConfig()
end

function slot0.onClickGeneratePathNode(slot0)
	if slot0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generatePathNodeConfig()
end

function slot0.onClickGenerateLeaveNode(slot0)
	if slot0.switchLayering then
		return
	end

	if not RougeMapEditModel.instance:getLeavePos() then
		GameFacade.showToastString("未生成离开点。")

		return
	end

	RougeMapEditModel.instance:generateLeaveNodeConfig()
end

function slot0.onClickGeneratePath(slot0)
	if slot0.switchLayering then
		return
	end

	RougeMapEditModel.instance:generateNodePath()
end

function slot0._editableInitView(slot0)
	slot0.camera = CameraMgr.instance:getMainCamera()
	slot0.offsetZ = RougeMapEnum.OffsetZ.NodeContainer
	slot0.map = RougeMapController.instance:getMapComp()
	slot0.frameHandle = UpdateBeat:CreateListener(slot0.onFrame, slot0)

	UpdateBeat:AddListener(slot0.frameHandle)
	gohelper.setActive(slot0.goStartText, false)

	slot0.rectTrView = slot0.viewGO:GetComponent(gohelper.Type_RectTransform)
	slot0.textGoList = slot0:getUserDataTb_()

	slot0:initDrop()
end

function slot0.initDrop(slot0)
	slot0.layerIdList = {}
	slot0.layerStrList = {}

	for slot4, slot5 in ipairs(lua_rouge_middle_layer.configList) do
		table.insert(slot0.layerIdList, slot5.id)
		table.insert(slot0.layerStrList, tostring(slot5.id))
	end

	slot0.dropMap:ClearOptions()
	slot0.dropMap:AddOptions(slot0.layerStrList)

	slot0.layerId = RougeMapEditModel.instance:getMiddleLayerId()

	for slot4, slot5 in ipairs(slot0.layerIdList) do
		if slot5 == slot0.layerId then
			slot0.dropMap:SetValue(slot4 - 1)
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0.map = RougeMapController.instance:getMapComp()

	slot0:refreshAllText()
end

function slot0.onOpen(slot0)
	slot0:refreshAllText()
end

function slot0.refreshAllText(slot0)
	if GameUtil.tabletool_dictIsEmpty(RougeMapEditModel.instance:getPointsDict()) and GameUtil.tabletool_dictIsEmpty(RougeMapEditModel.instance:getPathPointsDict()) then
		gohelper.setActive(slot0.goStartTextContainer, false)

		return
	end

	gohelper.setActive(slot0.goStartTextContainer, true)

	slot8 = "路径点id : "

	for slot8 = slot0:refreshPointDictText(slot2, slot8, slot0:refreshPointDictText(slot1, "坐标点id : ", 0)) + 1, #slot0.textGoList do
		gohelper.setActive(slot0.textGoList[slot8], false)
	end
end

function slot0.refreshPointDictText(slot0, slot1, slot2, slot3)
	for slot7, slot8 in pairs(slot1) do
		if not slot0.textGoList[slot3 + 1] then
			table.insert(slot0.textGoList, gohelper.cloneInPlace(slot0.goStartText))
		end

		gohelper.setActive(slot9, true)

		slot11, slot12 = recthelper.worldPosToAnchorPos2(slot8, slot0.rectTrView)

		recthelper.setAnchor(slot9:GetComponent(gohelper.Type_RectTransform), slot11, slot12 > 0 and slot12 + 60 or slot12 - 60)

		gohelper.findChildText(slot9, "text").text = slot2 .. slot7
	end

	return slot3
end

function slot0.onFrame(slot0)
	if slot0.switchLayering then
		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Q) then
		slot0:createPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.W) then
		slot0:createPathPoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.R) then
		slot0:createLeavePoint()

		return
	end

	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.E) then
		slot0:deletePoint()

		return
	end

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		if UnityEngine.Input.GetMouseButtonDown(0) then
			slot0:startDrag()
		elseif UnityEngine.Input.GetMouseButton(0) then
			slot0:dragPoint()
		end

		return
	end

	if UnityEngine.Input.GetMouseButtonUp(0) then
		if slot0.draggingId then
			slot0.draggingId = nil
		else
			slot0:startEditLine()
		end

		return
	end

	if UnityEngine.Input.GetMouseButton(1) then
		slot0:exitEditLine()

		return
	end

	slot0:drawEditingLine()
end

function slot0.createPoint(slot0)
	if slot0.editLining then
		return
	end

	if RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ)) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	slot0.map:addPoint(slot1)
	slot0:refreshAllText()
end

function slot0.createPathPoint(slot0)
	if slot0.editLining then
		return
	end

	if RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ)) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	slot0.map:addPathPoint(slot1)
	slot0:refreshAllText()
end

function slot0.createLeavePoint(slot0)
	if slot0.editLining then
		return
	end

	if RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ)) then
		GameFacade.showToastString("此处已添加点位。")

		return
	end

	slot0.map:addLeavePoint(slot1)
end

function slot0.deletePoint(slot0)
	if slot0.editLining then
		return
	end

	slot2, slot3 = RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ))

	if slot2 then
		slot0.map:deletePoint(slot3, slot2)
		slot0:refreshAllText()
	end
end

function slot0.startDrag(slot0)
	if not slot0.draggingId then
		slot2, slot3 = RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ))

		if not slot2 then
			return
		end

		slot0.draggingId = slot2
		slot0.draggingType = slot3
	end
end

function slot0.dragPoint(slot0)
	if not slot0.draggingId then
		return
	end

	slot1 = RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ)

	slot0.map:setPointPos(slot0.draggingId, slot0.draggingType, slot1.x, slot1.y)
	slot0:refreshAllText()
end

function slot0.startEditLine(slot0)
	slot2, slot3 = RougeMapEditModel.instance:getPointByPos(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ))

	if not slot2 then
		return
	end

	if slot0.editLining then
		if slot0.startType == slot3 and slot0.startPointId == slot2 then
			return
		end

		if not RougeMapEditModel.instance:checkCanAddLine(slot0.startType, slot0.startPointId, slot3, slot2) then
			return
		end

		slot0.map:addLine(slot0.startType, slot0.startPointId, slot3, slot2)

		slot0.editLineGo = nil
		slot0.editLining = false
		slot0.startPointId = nil

		return
	end

	slot0.editLining = true
	slot0.startPointId = slot2
	slot0.startType = slot3

	slot0.map:createEditingLine(slot2, slot3)
end

function slot0.exitEditLine(slot0)
	slot0.map:exitEditLine()

	slot0.editLining = false
	slot0.startPointId = nil
end

function slot0.drawEditingLine(slot0)
	if not slot0.editLining then
		return
	end

	slot0.map:updateDrawingLine(RougeMapHelper.getScenePos(slot0.camera, UnityEngine.Input.mousePosition, slot0.offsetZ))
end

function slot0.onClose(slot0)
	if slot0.frameHandle then
		UpdateBeat:RemoveListener(slot0.frameHandle)

		slot0.frameHandle = nil
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

module("modules.logic.gm.view.rouge.RougePathSelectMapEditorView", package.seeall)

slot0 = class("RougePathSelectMapEditorView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotop = gohelper.findChild(slot0.viewGO, "#go_top")
	slot0._gocamera = gohelper.findChild(slot0.viewGO, "#go_top/#go_camera")
	slot0._btncamerareduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_camera/#btn_reduce")
	slot0._inputcamera = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top/#go_camera/#input_camera")
	slot0._btncameraadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_camera/#btn_add")
	slot0._btnFocusPosXReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_focusposX/#btn_reduce")
	slot0._inputFocusPosX = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top/#go_focusposX/#input_posX")
	slot0._btnFocusPosXAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_focusposX/#btn_add")
	slot0._btnFocusPosYReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_focusposY/#btn_reduce")
	slot0._inputFocusPosY = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top/#go_focusposY/#input_posY")
	slot0._btnFocusPosYAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top/#go_focusposY/#btn_add")
	slot0._btnStartPosXReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_startposX/#btn_reduce")
	slot0._inputStartPosX = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top1/#go_startposX/#input_posX")
	slot0._btnStartPosXAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_startposX/#btn_add")
	slot0._btnStartPosYReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_startposY/#btn_reduce")
	slot0._inputStartPosY = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top1/#go_startposY/#input_posY")
	slot0._btnStartPosYAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_startposY/#btn_add")
	slot0._btnEndPosXReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_endposX/#btn_reduce")
	slot0._inputEndPosX = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top1/#go_endposX/#input_posX")
	slot0._btnEndPosXAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_endposX/#btn_add")
	slot0._btnEndPosYReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_endposY/#btn_reduce")
	slot0._inputEndPosY = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top1/#go_endposY/#input_posY")
	slot0._btnEndPosYAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top1/#go_endposY/#btn_add")
	slot0._btnSelectLinePosXReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineposX/#btn_reduce")
	slot0._inputSelectLinePosX = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top2/#go_lineposX/#input_posX")
	slot0._btnSelectLinePosXAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineposX/#btn_add")
	slot0._btnSelectLinePosYReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineposY/#btn_reduce")
	slot0._inputSelectLinePosY = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top2/#go_lineposY/#input_posY")
	slot0._btnSelectLinePosYAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineposY/#btn_add")
	slot0._btnLineIconPosXReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineiconposX/#btn_reduce")
	slot0._inputLineIconPosX = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top2/#go_lineiconposX/#input_posX")
	slot0._btnLineIconPosXAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineiconposX/#btn_add")
	slot0._btnLineIconPosYReduce = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineiconposY/#btn_reduce")
	slot0._inputLineIconPosY = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_top2/#go_lineiconposY/#input_posY")
	slot0._btnLineIconPosYAdd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_top2/#go_lineiconposY/#btn_add")
	slot0.dropMap = gohelper.findChildDropdown(slot0.viewGO, "#go_top/#go_dropmap/#drop_map")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncamerareduce:AddClickListener(slot0.onClickCameraReduceBtn, slot0)
	slot0._btncameraadd:AddClickListener(slot0.onClickCameraAddBtn, slot0)
	slot0._inputcamera:AddOnValueChanged(slot0.onCameraValueChange, slot0)
	slot0._btnFocusPosXReduce:AddClickListener(slot0.onClickFocusPosXReduceBtn, slot0)
	slot0._btnFocusPosXAdd:AddClickListener(slot0.onClickFocusPosXAddBtn, slot0)
	slot0._inputFocusPosX:AddOnValueChanged(slot0.onInputFocusPosXChange, slot0)
	slot0._btnFocusPosYReduce:AddClickListener(slot0.onClickFocusPosYReduceBtn, slot0)
	slot0._btnFocusPosYAdd:AddClickListener(slot0.onClickFocusPosYAddBtn, slot0)
	slot0._inputFocusPosY:AddOnValueChanged(slot0.onInputFocusPosYChange, slot0)
	slot0._btnStartPosXReduce:AddClickListener(slot0.onClickStartPosXReduceBtn, slot0)
	slot0._btnStartPosXAdd:AddClickListener(slot0.onClickStartPosXAddBtn, slot0)
	slot0._inputStartPosX:AddOnValueChanged(slot0.onInputStartPosXChange, slot0)
	slot0._btnStartPosYReduce:AddClickListener(slot0.onClickStartPosYReduceBtn, slot0)
	slot0._btnStartPosYAdd:AddClickListener(slot0.onClickStartPosYAddBtn, slot0)
	slot0._inputStartPosY:AddOnValueChanged(slot0.onInputStartPosYChange, slot0)
	slot0._btnEndPosXReduce:AddClickListener(slot0.onClickEndPosXReduceBtn, slot0)
	slot0._btnEndPosXAdd:AddClickListener(slot0.onClickEndPosXAddBtn, slot0)
	slot0._inputEndPosX:AddOnValueChanged(slot0.onInputEndPosXChange, slot0)
	slot0._btnEndPosYReduce:AddClickListener(slot0.onClickEndPosYReduceBtn, slot0)
	slot0._btnEndPosYAdd:AddClickListener(slot0.onClickEndPosYAddBtn, slot0)
	slot0._inputEndPosY:AddOnValueChanged(slot0.onInputEndPosYChange, slot0)
	slot0._btnSelectLinePosXReduce:AddClickListener(slot0.onClickLinePosXReduceBtn, slot0)
	slot0._btnSelectLinePosXAdd:AddClickListener(slot0.onClickLinePosXAddBtn, slot0)
	slot0._inputSelectLinePosX:AddOnValueChanged(slot0.onInputSelectLinePosXChange, slot0)
	slot0._btnSelectLinePosYReduce:AddClickListener(slot0.onClickLinePosYReduceBtn, slot0)
	slot0._btnSelectLinePosYAdd:AddClickListener(slot0.onClickLinePosYAddBtn, slot0)
	slot0._inputSelectLinePosY:AddOnValueChanged(slot0.onInputSelectLinePosYChange, slot0)
	slot0._btnLineIconPosXReduce:AddClickListener(slot0.onClickLineIconXReduceBtn, slot0)
	slot0._btnLineIconPosXAdd:AddClickListener(slot0.onClickLineIconXAddBtn, slot0)
	slot0._inputLineIconPosX:AddOnValueChanged(slot0.onInputLineIconPosXChange, slot0)
	slot0._btnLineIconPosYReduce:AddClickListener(slot0.onClickLineIconYReduceBtn, slot0)
	slot0._btnLineIconPosYAdd:AddClickListener(slot0.onClickLineIconYAddBtn, slot0)
	slot0._inputLineIconPosY:AddOnValueChanged(slot0.onInputLineIconPosYChange, slot0)
	slot0.dropMap:AddOnValueChanged(slot0.onDropMapValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncamerareduce:RemoveClickListener()
	slot0._btncameraadd:RemoveClickListener()
	slot0._inputcamera:RemoveOnValueChanged()
	slot0._btnFocusPosXReduce:RemoveClickListener()
	slot0._btnFocusPosXAdd:RemoveClickListener()
	slot0._btnFocusPosYReduce:RemoveClickListener()
	slot0._btnFocusPosYAdd:RemoveClickListener()
	slot0._inputFocusPosX:RemoveOnValueChanged()
	slot0._inputFocusPosY:RemoveOnValueChanged()
	slot0._btnStartPosXReduce:RemoveClickListener()
	slot0._btnStartPosXAdd:RemoveClickListener()
	slot0._btnStartPosYReduce:RemoveClickListener()
	slot0._btnStartPosYAdd:RemoveClickListener()
	slot0._inputStartPosX:RemoveOnValueChanged()
	slot0._inputStartPosY:RemoveOnValueChanged()
	slot0._btnEndPosXReduce:RemoveClickListener()
	slot0._btnEndPosXAdd:RemoveClickListener()
	slot0._btnEndPosYReduce:RemoveClickListener()
	slot0._btnEndPosYAdd:RemoveClickListener()
	slot0._inputEndPosX:RemoveOnValueChanged()
	slot0._inputEndPosY:RemoveOnValueChanged()
	slot0._btnSelectLinePosXReduce:RemoveClickListener()
	slot0._btnSelectLinePosXAdd:RemoveClickListener()
	slot0._btnSelectLinePosYReduce:RemoveClickListener()
	slot0._btnSelectLinePosYAdd:RemoveClickListener()
	slot0._inputSelectLinePosX:RemoveOnValueChanged()
	slot0._inputSelectLinePosY:RemoveOnValueChanged()
	slot0._btnLineIconPosXReduce:RemoveClickListener()
	slot0._btnLineIconPosXAdd:RemoveClickListener()
	slot0._btnLineIconPosYReduce:RemoveClickListener()
	slot0._btnLineIconPosYAdd:RemoveClickListener()
	slot0._inputLineIconPosX:RemoveOnValueChanged()
	slot0._inputLineIconPosY:RemoveOnValueChanged()
	slot0.dropMap:RemoveOnValueChanged()
end

function slot0.onDropMapValueChanged(slot0, slot1)
	if slot0.switchLayering then
		slot0.dropMap:SetValue(slot0.curLayerIndex - 1)

		return
	end

	if slot0.layerIdList[slot1 + 1] == slot0.curLayerId then
		return
	end

	if not RougeMapConfig.instance:getNextLayerList(slot2) then
		slot0.dropMap:SetValue(slot0.curLayerIndex - 1)
		GameFacade.showToastString(slot2 .. " 层 没有下一层 ")

		return
	end

	slot0.switchLayering = true
	slot0.curLayerIndex = slot1 + 1
	slot0.curLayerId = slot2

	RougeMapModel.instance:updateMapInfo({
		mapType = RougeMapEnum.MapType.Middle,
		middleLayerInfo = {
			layerId = 101,
			positionIndex = RougeMapEnum.PathSelectIndex,
			middleLayerId = slot2
		},
		HasField = function ()
			return false
		end
	})
end

function slot0.onPathSelectMapFocusDone(slot0)
	slot0.switchLayering = false

	ViewMgr.instance:openView(slot0.viewName, nil, true)

	slot0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	slot0.map = RougeMapController.instance:getMapComp()
	slot0.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	slot0:initPos()
end

function slot0.onClickCameraReduceBtn(slot0)
	slot0.cameraSize = slot0.cameraSize - uv0.Interval

	slot0:onCameraSizeChange()
end

function slot0.onClickCameraAddBtn(slot0)
	slot0.cameraSize = slot0.cameraSize + uv0.Interval

	slot0:onCameraSizeChange()
end

function slot0.onCameraValueChange(slot0, slot1)
	slot0.cameraSize = slot1

	slot0:onCameraSizeChange()
end

function slot0.onClickFocusPosXReduceBtn(slot0)
	slot0.focusPosX = slot0.focusPosX + uv0.Interval

	slot0:onFocusPosChange()
end

function slot0.onClickFocusPosXAddBtn(slot0)
	slot0.focusPosX = slot0.focusPosX - uv0.Interval

	slot0:onFocusPosChange()
end

function slot0.onClickFocusPosYReduceBtn(slot0)
	slot0.focusPosY = slot0.focusPosY + uv0.Interval

	slot0:onFocusPosChange()
end

function slot0.onClickFocusPosYAddBtn(slot0)
	slot0.focusPosY = slot0.focusPosY - uv0.Interval

	slot0:onFocusPosChange()
end

function slot0.onInputFocusPosXChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.focusPosX = slot1

	slot0:onFocusPosChange()
end

function slot0.onInputFocusPosYChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.focusPosY = slot1

	slot0:onFocusPosChange()
end

function slot0.onClickStartPosXReduceBtn(slot0)
	slot0.startPosX = slot0.startPosX + uv0.Interval

	slot0:onStartPosChange()
end

function slot0.onClickStartPosXAddBtn(slot0)
	slot0.startPosX = slot0.startPosX - uv0.Interval

	slot0:onStartPosChange()
end

function slot0.onClickStartPosYReduceBtn(slot0)
	slot0.startPosY = slot0.startPosY + uv0.Interval

	slot0:onStartPosChange()
end

function slot0.onClickStartPosYAddBtn(slot0)
	slot0.startPosY = slot0.startPosY - uv0.Interval

	slot0:onStartPosChange()
end

function slot0.onInputStartPosXChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.startPosX = slot1

	slot0:onStartPosChange()
end

function slot0.onInputStartPosYChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.startPosY = slot1

	slot0:onStartPosChange()
end

function slot0.onClickEndPosXReduceBtn(slot0)
	slot0.endPosX = slot0.endPosX + uv0.Interval

	slot0:onEndPosChange()
end

function slot0.onClickEndPosXAddBtn(slot0)
	slot0.endPosX = slot0.endPosX - uv0.Interval

	slot0:onEndPosChange()
end

function slot0.onClickEndPosYReduceBtn(slot0)
	slot0.endPosY = slot0.endPosY + uv0.Interval

	slot0:onEndPosChange()
end

function slot0.onClickEndPosYAddBtn(slot0)
	slot0.endPosY = slot0.endPosY - uv0.Interval

	slot0:onEndPosChange()
end

function slot0.onInputEndPosXChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.endPosX = slot1

	slot0:onEndPosChange()
end

function slot0.onInputEndPosYChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.endPosY = slot1

	slot0:onEndPosChange()
end

function slot0.onClickLinePosXReduceBtn(slot0)
	slot0.linePosX = slot0.linePosX + uv0.Interval

	slot0:onSelectLinePosChange()
end

function slot0.onClickLinePosXAddBtn(slot0)
	slot0.linePosX = slot0.linePosX - uv0.Interval

	slot0:onSelectLinePosChange()
end

function slot0.onClickLinePosYReduceBtn(slot0)
	slot0.linePosY = slot0.linePosY + uv0.Interval

	slot0:onSelectLinePosChange()
end

function slot0.onClickLinePosYAddBtn(slot0)
	slot0.linePosY = slot0.linePosY - uv0.Interval

	slot0:onSelectLinePosChange()
end

function slot0.onInputSelectLinePosXChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.linePosX = slot1

	slot0:onSelectLinePosChange()
end

function slot0.onInputSelectLinePosYChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.linePosY = slot1

	slot0:onSelectLinePosChange()
end

function slot0.onClickLineIconXReduceBtn(slot0)
	slot0.lineIconPosX = slot0.lineIconPosX + uv0.Interval

	slot0:onLineIconPosChange()
end

function slot0.onClickLineIconXAddBtn(slot0)
	slot0.lineIconPosX = slot0.lineIconPosX - uv0.Interval

	slot0:onLineIconPosChange()
end

function slot0.onClickLineIconYReduceBtn(slot0)
	slot0.lineIconPosY = slot0.lineIconPosY + uv0.Interval

	slot0:onLineIconPosChange()
end

function slot0.onClickLineIconYAddBtn(slot0)
	slot0.lineIconPosY = slot0.lineIconPosY - uv0.Interval

	slot0:onLineIconPosChange()
end

function slot0.onInputLineIconPosXChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.lineIconPosX = slot1

	slot0:onLineIconPosChange()
end

function slot0.onInputLineIconPosYChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	slot0.lineIconPosY = slot1

	slot0:onLineIconPosChange()
end

slot0.Interval = 0.01

function slot0.onOpen(slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, slot0.onPathSelectMapFocusDone, slot0, LuaEventSystem.Low)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, slot0.onSelectLayerChange, slot0, LuaEventSystem.Low)

	slot0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	slot0.map = RougeMapController.instance:getMapComp()
	slot0.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	slot0:initPos()
	slot0:initLayerDrop()
end

function slot0.initPos(slot0)
	slot0:initCamera()
	slot0:initFocusPos()
	slot0:initStartPos()
	slot0:initEndPos()
	slot0:initSelectLinePos()
	slot0:initLineIconPos()
end

function slot0.onSelectLayerChange(slot0, slot1)
	slot0:initSelectLinePos()
	slot0:initLineIconPos()
end

function slot0.initCamera(slot0)
	slot0.cameraSize = slot0.pathSelectCo.focusCameraSize
	slot0.camera = CameraMgr.instance:getMainCamera()

	slot0:onCameraSizeChange()
end

function slot0.onCameraSizeChange(slot0)
	slot0.camera.orthographicSize = slot0.cameraSize

	slot0._inputcamera:SetText(slot0.cameraSize)
end

function slot0.initFocusPos(slot0)
	slot0.focusPosX, slot0.focusPosY = RougeMapHelper.getPos(slot0.pathSelectCo.focusMapPos)
	slot0.mapTransform = slot0.map.mapTransform

	slot0:onFocusPosChange()
end

function slot0.onFocusPosChange(slot0)
	transformhelper.setLocalPos(slot0.mapTransform, slot0.focusPosX, slot0.focusPosY, RougeMapEnum.OffsetZ.Map)
	slot0._inputFocusPosX:SetText(slot0.focusPosX)
	slot0._inputFocusPosY:SetText(slot0.focusPosY)
end

function slot0.initStartPos(slot0)
	slot0.startPosX, slot0.startPosY = RougeMapHelper.getPos(slot0.pathSelectCo.startPos)
	slot0.rectTrStart = gohelper.findChild(slot0.mapViewGo, "#go_linecontainer/#go_start"):GetComponent(gohelper.Type_RectTransform)

	slot0:onStartPosChange()
end

function slot0.onStartPosChange(slot0)
	recthelper.setAnchor(slot0.rectTrStart, slot0.startPosX, slot0.startPosY)
	slot0._inputStartPosX:SetText(slot0.startPosX)
	slot0._inputStartPosY:SetText(slot0.startPosY)
end

function slot0.initEndPos(slot0)
	slot0.endPosX, slot0.endPosY = RougeMapHelper.getPos(slot0.pathSelectCo.endPos)
	slot0.rectTrEnd = gohelper.findChild(slot0.mapViewGo, "#go_linecontainer/#go_end"):GetComponent(gohelper.Type_RectTransform)

	slot0:onEndPosChange()
end

function slot0.onEndPosChange(slot0)
	recthelper.setAnchor(slot0.rectTrEnd, slot0.endPosX, slot0.endPosY)
	slot0._inputEndPosX:SetText(slot0.endPosX)
	slot0._inputEndPosY:SetText(slot0.endPosY)
end

function slot0.initSelectLinePos(slot0)
	slot2 = lua_rouge_layer.configDict[RougeMapModel.instance:getSelectLayerId()]
	slot0.linePosX, slot0.linePosY = RougeMapHelper.getPos(slot2.pathPos)

	if not gohelper.findChild(slot0.mapViewGo, string.format("#go_linecontainer/%s/line", slot2.id)) then
		return
	end

	slot0.rectTrLine = slot4:GetComponent(gohelper.Type_RectTransform)

	slot0:onSelectLinePosChange()
end

function slot0.onSelectLinePosChange(slot0)
	slot0._inputSelectLinePosX:SetText(slot0.linePosX)
	slot0._inputSelectLinePosY:SetText(slot0.linePosY)
	recthelper.setAnchor(slot0.rectTrLine, slot0.linePosX, slot0.linePosY)
end

function slot0.initLineIconPos(slot0)
	slot2 = lua_rouge_layer.configDict[RougeMapModel.instance:getSelectLayerId()]
	slot0.lineIconPosX, slot0.lineIconPosY = RougeMapHelper.getPos(slot2.iconPos)

	if not gohelper.findChild(slot0.mapViewGo, string.format("#go_linecontainer/%s/lineIcon", slot2.id)) then
		return
	end

	slot0.rectTrLineIcon = slot4:GetComponent(gohelper.Type_RectTransform)

	slot0:onLineIconPosChange()
end

function slot0.onLineIconPosChange(slot0)
	slot0._inputLineIconPosX:SetText(slot0.lineIconPosX)
	slot0._inputLineIconPosY:SetText(slot0.lineIconPosY)
	recthelper.setAnchor(slot0.rectTrLineIcon, slot0.lineIconPosX, slot0.lineIconPosY)
end

function slot0.initLayerDrop(slot0)
	slot0.curLayerId = RougeMapModel.instance:getMiddleLayerId()
	slot0.curLayerIndex = 1
	slot0.layerIdList = {}
	slot0.layerStrList = {}

	for slot4, slot5 in ipairs(lua_rouge_middle_layer.configList) do
		slot6 = slot5.id

		table.insert(slot0.layerIdList, slot6)
		table.insert(slot0.layerStrList, tostring(slot6))

		if slot6 == slot0.curLayerId then
			slot0.curLayerIndex = slot4
		end
	end

	slot0.dropMap:ClearOptions()
	slot0.dropMap:AddOptions(slot0.layerStrList)
	slot0.dropMap:SetValue(slot0.curLayerIndex - 1)
end

return slot0

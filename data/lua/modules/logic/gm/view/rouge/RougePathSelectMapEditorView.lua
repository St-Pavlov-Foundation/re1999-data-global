module("modules.logic.gm.view.rouge.RougePathSelectMapEditorView", package.seeall)

local var_0_0 = class("RougePathSelectMapEditorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._gocamera = gohelper.findChild(arg_1_0.viewGO, "#go_top/#go_camera")
	arg_1_0._btncamerareduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_camera/#btn_reduce")
	arg_1_0._inputcamera = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top/#go_camera/#input_camera")
	arg_1_0._btncameraadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_camera/#btn_add")
	arg_1_0._btnFocusPosXReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_focusposX/#btn_reduce")
	arg_1_0._inputFocusPosX = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top/#go_focusposX/#input_posX")
	arg_1_0._btnFocusPosXAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_focusposX/#btn_add")
	arg_1_0._btnFocusPosYReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_focusposY/#btn_reduce")
	arg_1_0._inputFocusPosY = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top/#go_focusposY/#input_posY")
	arg_1_0._btnFocusPosYAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top/#go_focusposY/#btn_add")
	arg_1_0._btnStartPosXReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_startposX/#btn_reduce")
	arg_1_0._inputStartPosX = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top1/#go_startposX/#input_posX")
	arg_1_0._btnStartPosXAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_startposX/#btn_add")
	arg_1_0._btnStartPosYReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_startposY/#btn_reduce")
	arg_1_0._inputStartPosY = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top1/#go_startposY/#input_posY")
	arg_1_0._btnStartPosYAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_startposY/#btn_add")
	arg_1_0._btnEndPosXReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_endposX/#btn_reduce")
	arg_1_0._inputEndPosX = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top1/#go_endposX/#input_posX")
	arg_1_0._btnEndPosXAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_endposX/#btn_add")
	arg_1_0._btnEndPosYReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_endposY/#btn_reduce")
	arg_1_0._inputEndPosY = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top1/#go_endposY/#input_posY")
	arg_1_0._btnEndPosYAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top1/#go_endposY/#btn_add")
	arg_1_0._btnSelectLinePosXReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineposX/#btn_reduce")
	arg_1_0._inputSelectLinePosX = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top2/#go_lineposX/#input_posX")
	arg_1_0._btnSelectLinePosXAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineposX/#btn_add")
	arg_1_0._btnSelectLinePosYReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineposY/#btn_reduce")
	arg_1_0._inputSelectLinePosY = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top2/#go_lineposY/#input_posY")
	arg_1_0._btnSelectLinePosYAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineposY/#btn_add")
	arg_1_0._btnLineIconPosXReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineiconposX/#btn_reduce")
	arg_1_0._inputLineIconPosX = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top2/#go_lineiconposX/#input_posX")
	arg_1_0._btnLineIconPosXAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineiconposX/#btn_add")
	arg_1_0._btnLineIconPosYReduce = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineiconposY/#btn_reduce")
	arg_1_0._inputLineIconPosY = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_top2/#go_lineiconposY/#input_posY")
	arg_1_0._btnLineIconPosYAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_top2/#go_lineiconposY/#btn_add")
	arg_1_0.dropMap = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_top/#go_dropmap/#drop_map")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncamerareduce:AddClickListener(arg_2_0.onClickCameraReduceBtn, arg_2_0)
	arg_2_0._btncameraadd:AddClickListener(arg_2_0.onClickCameraAddBtn, arg_2_0)
	arg_2_0._inputcamera:AddOnValueChanged(arg_2_0.onCameraValueChange, arg_2_0)
	arg_2_0._btnFocusPosXReduce:AddClickListener(arg_2_0.onClickFocusPosXReduceBtn, arg_2_0)
	arg_2_0._btnFocusPosXAdd:AddClickListener(arg_2_0.onClickFocusPosXAddBtn, arg_2_0)
	arg_2_0._inputFocusPosX:AddOnValueChanged(arg_2_0.onInputFocusPosXChange, arg_2_0)
	arg_2_0._btnFocusPosYReduce:AddClickListener(arg_2_0.onClickFocusPosYReduceBtn, arg_2_0)
	arg_2_0._btnFocusPosYAdd:AddClickListener(arg_2_0.onClickFocusPosYAddBtn, arg_2_0)
	arg_2_0._inputFocusPosY:AddOnValueChanged(arg_2_0.onInputFocusPosYChange, arg_2_0)
	arg_2_0._btnStartPosXReduce:AddClickListener(arg_2_0.onClickStartPosXReduceBtn, arg_2_0)
	arg_2_0._btnStartPosXAdd:AddClickListener(arg_2_0.onClickStartPosXAddBtn, arg_2_0)
	arg_2_0._inputStartPosX:AddOnValueChanged(arg_2_0.onInputStartPosXChange, arg_2_0)
	arg_2_0._btnStartPosYReduce:AddClickListener(arg_2_0.onClickStartPosYReduceBtn, arg_2_0)
	arg_2_0._btnStartPosYAdd:AddClickListener(arg_2_0.onClickStartPosYAddBtn, arg_2_0)
	arg_2_0._inputStartPosY:AddOnValueChanged(arg_2_0.onInputStartPosYChange, arg_2_0)
	arg_2_0._btnEndPosXReduce:AddClickListener(arg_2_0.onClickEndPosXReduceBtn, arg_2_0)
	arg_2_0._btnEndPosXAdd:AddClickListener(arg_2_0.onClickEndPosXAddBtn, arg_2_0)
	arg_2_0._inputEndPosX:AddOnValueChanged(arg_2_0.onInputEndPosXChange, arg_2_0)
	arg_2_0._btnEndPosYReduce:AddClickListener(arg_2_0.onClickEndPosYReduceBtn, arg_2_0)
	arg_2_0._btnEndPosYAdd:AddClickListener(arg_2_0.onClickEndPosYAddBtn, arg_2_0)
	arg_2_0._inputEndPosY:AddOnValueChanged(arg_2_0.onInputEndPosYChange, arg_2_0)
	arg_2_0._btnSelectLinePosXReduce:AddClickListener(arg_2_0.onClickLinePosXReduceBtn, arg_2_0)
	arg_2_0._btnSelectLinePosXAdd:AddClickListener(arg_2_0.onClickLinePosXAddBtn, arg_2_0)
	arg_2_0._inputSelectLinePosX:AddOnValueChanged(arg_2_0.onInputSelectLinePosXChange, arg_2_0)
	arg_2_0._btnSelectLinePosYReduce:AddClickListener(arg_2_0.onClickLinePosYReduceBtn, arg_2_0)
	arg_2_0._btnSelectLinePosYAdd:AddClickListener(arg_2_0.onClickLinePosYAddBtn, arg_2_0)
	arg_2_0._inputSelectLinePosY:AddOnValueChanged(arg_2_0.onInputSelectLinePosYChange, arg_2_0)
	arg_2_0._btnLineIconPosXReduce:AddClickListener(arg_2_0.onClickLineIconXReduceBtn, arg_2_0)
	arg_2_0._btnLineIconPosXAdd:AddClickListener(arg_2_0.onClickLineIconXAddBtn, arg_2_0)
	arg_2_0._inputLineIconPosX:AddOnValueChanged(arg_2_0.onInputLineIconPosXChange, arg_2_0)
	arg_2_0._btnLineIconPosYReduce:AddClickListener(arg_2_0.onClickLineIconYReduceBtn, arg_2_0)
	arg_2_0._btnLineIconPosYAdd:AddClickListener(arg_2_0.onClickLineIconYAddBtn, arg_2_0)
	arg_2_0._inputLineIconPosY:AddOnValueChanged(arg_2_0.onInputLineIconPosYChange, arg_2_0)
	arg_2_0.dropMap:AddOnValueChanged(arg_2_0.onDropMapValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncamerareduce:RemoveClickListener()
	arg_3_0._btncameraadd:RemoveClickListener()
	arg_3_0._inputcamera:RemoveOnValueChanged()
	arg_3_0._btnFocusPosXReduce:RemoveClickListener()
	arg_3_0._btnFocusPosXAdd:RemoveClickListener()
	arg_3_0._btnFocusPosYReduce:RemoveClickListener()
	arg_3_0._btnFocusPosYAdd:RemoveClickListener()
	arg_3_0._inputFocusPosX:RemoveOnValueChanged()
	arg_3_0._inputFocusPosY:RemoveOnValueChanged()
	arg_3_0._btnStartPosXReduce:RemoveClickListener()
	arg_3_0._btnStartPosXAdd:RemoveClickListener()
	arg_3_0._btnStartPosYReduce:RemoveClickListener()
	arg_3_0._btnStartPosYAdd:RemoveClickListener()
	arg_3_0._inputStartPosX:RemoveOnValueChanged()
	arg_3_0._inputStartPosY:RemoveOnValueChanged()
	arg_3_0._btnEndPosXReduce:RemoveClickListener()
	arg_3_0._btnEndPosXAdd:RemoveClickListener()
	arg_3_0._btnEndPosYReduce:RemoveClickListener()
	arg_3_0._btnEndPosYAdd:RemoveClickListener()
	arg_3_0._inputEndPosX:RemoveOnValueChanged()
	arg_3_0._inputEndPosY:RemoveOnValueChanged()
	arg_3_0._btnSelectLinePosXReduce:RemoveClickListener()
	arg_3_0._btnSelectLinePosXAdd:RemoveClickListener()
	arg_3_0._btnSelectLinePosYReduce:RemoveClickListener()
	arg_3_0._btnSelectLinePosYAdd:RemoveClickListener()
	arg_3_0._inputSelectLinePosX:RemoveOnValueChanged()
	arg_3_0._inputSelectLinePosY:RemoveOnValueChanged()
	arg_3_0._btnLineIconPosXReduce:RemoveClickListener()
	arg_3_0._btnLineIconPosXAdd:RemoveClickListener()
	arg_3_0._btnLineIconPosYReduce:RemoveClickListener()
	arg_3_0._btnLineIconPosYAdd:RemoveClickListener()
	arg_3_0._inputLineIconPosX:RemoveOnValueChanged()
	arg_3_0._inputLineIconPosY:RemoveOnValueChanged()
	arg_3_0.dropMap:RemoveOnValueChanged()
end

function var_0_0.onDropMapValueChanged(arg_4_0, arg_4_1)
	if arg_4_0.switchLayering then
		arg_4_0.dropMap:SetValue(arg_4_0.curLayerIndex - 1)

		return
	end

	local var_4_0 = arg_4_0.layerIdList[arg_4_1 + 1]

	if var_4_0 == arg_4_0.curLayerId then
		return
	end

	if not RougeMapConfig.instance:getNextLayerList(var_4_0) then
		arg_4_0.dropMap:SetValue(arg_4_0.curLayerIndex - 1)
		GameFacade.showToastString(var_4_0 .. " 层 没有下一层 ")

		return
	end

	arg_4_0.switchLayering = true
	arg_4_0.curLayerIndex = arg_4_1 + 1
	arg_4_0.curLayerId = var_4_0

	RougeMapModel.instance:updateMapInfo({
		mapType = RougeMapEnum.MapType.Middle,
		middleLayerInfo = {
			layerId = 101,
			positionIndex = RougeMapEnum.PathSelectIndex,
			middleLayerId = var_4_0
		},
		HasField = function()
			return false
		end
	})
end

function var_0_0.onPathSelectMapFocusDone(arg_6_0)
	arg_6_0.switchLayering = false

	ViewMgr.instance:openView(arg_6_0.viewName, nil, true)

	arg_6_0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	arg_6_0.map = RougeMapController.instance:getMapComp()
	arg_6_0.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	arg_6_0:initPos()
end

function var_0_0.onClickCameraReduceBtn(arg_7_0)
	arg_7_0.cameraSize = arg_7_0.cameraSize - var_0_0.Interval

	arg_7_0:onCameraSizeChange()
end

function var_0_0.onClickCameraAddBtn(arg_8_0)
	arg_8_0.cameraSize = arg_8_0.cameraSize + var_0_0.Interval

	arg_8_0:onCameraSizeChange()
end

function var_0_0.onCameraValueChange(arg_9_0, arg_9_1)
	arg_9_0.cameraSize = arg_9_1

	arg_9_0:onCameraSizeChange()
end

function var_0_0.onClickFocusPosXReduceBtn(arg_10_0)
	arg_10_0.focusPosX = arg_10_0.focusPosX + var_0_0.Interval

	arg_10_0:onFocusPosChange()
end

function var_0_0.onClickFocusPosXAddBtn(arg_11_0)
	arg_11_0.focusPosX = arg_11_0.focusPosX - var_0_0.Interval

	arg_11_0:onFocusPosChange()
end

function var_0_0.onClickFocusPosYReduceBtn(arg_12_0)
	arg_12_0.focusPosY = arg_12_0.focusPosY + var_0_0.Interval

	arg_12_0:onFocusPosChange()
end

function var_0_0.onClickFocusPosYAddBtn(arg_13_0)
	arg_13_0.focusPosY = arg_13_0.focusPosY - var_0_0.Interval

	arg_13_0:onFocusPosChange()
end

function var_0_0.onInputFocusPosXChange(arg_14_0, arg_14_1)
	arg_14_1 = tonumber(arg_14_1)

	if not arg_14_1 then
		return
	end

	arg_14_0.focusPosX = arg_14_1

	arg_14_0:onFocusPosChange()
end

function var_0_0.onInputFocusPosYChange(arg_15_0, arg_15_1)
	arg_15_1 = tonumber(arg_15_1)

	if not arg_15_1 then
		return
	end

	arg_15_0.focusPosY = arg_15_1

	arg_15_0:onFocusPosChange()
end

function var_0_0.onClickStartPosXReduceBtn(arg_16_0)
	arg_16_0.startPosX = arg_16_0.startPosX + var_0_0.Interval

	arg_16_0:onStartPosChange()
end

function var_0_0.onClickStartPosXAddBtn(arg_17_0)
	arg_17_0.startPosX = arg_17_0.startPosX - var_0_0.Interval

	arg_17_0:onStartPosChange()
end

function var_0_0.onClickStartPosYReduceBtn(arg_18_0)
	arg_18_0.startPosY = arg_18_0.startPosY + var_0_0.Interval

	arg_18_0:onStartPosChange()
end

function var_0_0.onClickStartPosYAddBtn(arg_19_0)
	arg_19_0.startPosY = arg_19_0.startPosY - var_0_0.Interval

	arg_19_0:onStartPosChange()
end

function var_0_0.onInputStartPosXChange(arg_20_0, arg_20_1)
	arg_20_1 = tonumber(arg_20_1)

	if not arg_20_1 then
		return
	end

	arg_20_0.startPosX = arg_20_1

	arg_20_0:onStartPosChange()
end

function var_0_0.onInputStartPosYChange(arg_21_0, arg_21_1)
	arg_21_1 = tonumber(arg_21_1)

	if not arg_21_1 then
		return
	end

	arg_21_0.startPosY = arg_21_1

	arg_21_0:onStartPosChange()
end

function var_0_0.onClickEndPosXReduceBtn(arg_22_0)
	arg_22_0.endPosX = arg_22_0.endPosX + var_0_0.Interval

	arg_22_0:onEndPosChange()
end

function var_0_0.onClickEndPosXAddBtn(arg_23_0)
	arg_23_0.endPosX = arg_23_0.endPosX - var_0_0.Interval

	arg_23_0:onEndPosChange()
end

function var_0_0.onClickEndPosYReduceBtn(arg_24_0)
	arg_24_0.endPosY = arg_24_0.endPosY + var_0_0.Interval

	arg_24_0:onEndPosChange()
end

function var_0_0.onClickEndPosYAddBtn(arg_25_0)
	arg_25_0.endPosY = arg_25_0.endPosY - var_0_0.Interval

	arg_25_0:onEndPosChange()
end

function var_0_0.onInputEndPosXChange(arg_26_0, arg_26_1)
	arg_26_1 = tonumber(arg_26_1)

	if not arg_26_1 then
		return
	end

	arg_26_0.endPosX = arg_26_1

	arg_26_0:onEndPosChange()
end

function var_0_0.onInputEndPosYChange(arg_27_0, arg_27_1)
	arg_27_1 = tonumber(arg_27_1)

	if not arg_27_1 then
		return
	end

	arg_27_0.endPosY = arg_27_1

	arg_27_0:onEndPosChange()
end

function var_0_0.onClickLinePosXReduceBtn(arg_28_0)
	arg_28_0.linePosX = arg_28_0.linePosX + var_0_0.Interval

	arg_28_0:onSelectLinePosChange()
end

function var_0_0.onClickLinePosXAddBtn(arg_29_0)
	arg_29_0.linePosX = arg_29_0.linePosX - var_0_0.Interval

	arg_29_0:onSelectLinePosChange()
end

function var_0_0.onClickLinePosYReduceBtn(arg_30_0)
	arg_30_0.linePosY = arg_30_0.linePosY + var_0_0.Interval

	arg_30_0:onSelectLinePosChange()
end

function var_0_0.onClickLinePosYAddBtn(arg_31_0)
	arg_31_0.linePosY = arg_31_0.linePosY - var_0_0.Interval

	arg_31_0:onSelectLinePosChange()
end

function var_0_0.onInputSelectLinePosXChange(arg_32_0, arg_32_1)
	arg_32_1 = tonumber(arg_32_1)

	if not arg_32_1 then
		return
	end

	arg_32_0.linePosX = arg_32_1

	arg_32_0:onSelectLinePosChange()
end

function var_0_0.onInputSelectLinePosYChange(arg_33_0, arg_33_1)
	arg_33_1 = tonumber(arg_33_1)

	if not arg_33_1 then
		return
	end

	arg_33_0.linePosY = arg_33_1

	arg_33_0:onSelectLinePosChange()
end

function var_0_0.onClickLineIconXReduceBtn(arg_34_0)
	arg_34_0.lineIconPosX = arg_34_0.lineIconPosX + var_0_0.Interval

	arg_34_0:onLineIconPosChange()
end

function var_0_0.onClickLineIconXAddBtn(arg_35_0)
	arg_35_0.lineIconPosX = arg_35_0.lineIconPosX - var_0_0.Interval

	arg_35_0:onLineIconPosChange()
end

function var_0_0.onClickLineIconYReduceBtn(arg_36_0)
	arg_36_0.lineIconPosY = arg_36_0.lineIconPosY + var_0_0.Interval

	arg_36_0:onLineIconPosChange()
end

function var_0_0.onClickLineIconYAddBtn(arg_37_0)
	arg_37_0.lineIconPosY = arg_37_0.lineIconPosY - var_0_0.Interval

	arg_37_0:onLineIconPosChange()
end

function var_0_0.onInputLineIconPosXChange(arg_38_0, arg_38_1)
	arg_38_1 = tonumber(arg_38_1)

	if not arg_38_1 then
		return
	end

	arg_38_0.lineIconPosX = arg_38_1

	arg_38_0:onLineIconPosChange()
end

function var_0_0.onInputLineIconPosYChange(arg_39_0, arg_39_1)
	arg_39_1 = tonumber(arg_39_1)

	if not arg_39_1 then
		return
	end

	arg_39_0.lineIconPosY = arg_39_1

	arg_39_0:onLineIconPosChange()
end

var_0_0.Interval = 0.01

function var_0_0.onOpen(arg_40_0)
	arg_40_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, arg_40_0.onPathSelectMapFocusDone, arg_40_0, LuaEventSystem.Low)
	arg_40_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, arg_40_0.onSelectLayerChange, arg_40_0, LuaEventSystem.Low)

	arg_40_0.pathSelectCo = RougeMapModel.instance:getPathSelectCo()
	arg_40_0.map = RougeMapController.instance:getMapComp()
	arg_40_0.mapViewGo = ViewMgr.instance:getContainer(ViewName.RougeMapView).viewGO

	arg_40_0:initPos()
	arg_40_0:initLayerDrop()
end

function var_0_0.initPos(arg_41_0)
	arg_41_0:initCamera()
	arg_41_0:initFocusPos()
	arg_41_0:initStartPos()
	arg_41_0:initEndPos()
	arg_41_0:initSelectLinePos()
	arg_41_0:initLineIconPos()
end

function var_0_0.onSelectLayerChange(arg_42_0, arg_42_1)
	arg_42_0:initSelectLinePos()
	arg_42_0:initLineIconPos()
end

function var_0_0.initCamera(arg_43_0)
	arg_43_0.cameraSize = arg_43_0.pathSelectCo.focusCameraSize
	arg_43_0.camera = CameraMgr.instance:getMainCamera()

	arg_43_0:onCameraSizeChange()
end

function var_0_0.onCameraSizeChange(arg_44_0)
	arg_44_0.camera.orthographicSize = arg_44_0.cameraSize

	arg_44_0._inputcamera:SetText(arg_44_0.cameraSize)
end

function var_0_0.initFocusPos(arg_45_0)
	arg_45_0.focusPosX, arg_45_0.focusPosY = RougeMapHelper.getPos(arg_45_0.pathSelectCo.focusMapPos)
	arg_45_0.mapTransform = arg_45_0.map.mapTransform

	arg_45_0:onFocusPosChange()
end

function var_0_0.onFocusPosChange(arg_46_0)
	transformhelper.setLocalPos(arg_46_0.mapTransform, arg_46_0.focusPosX, arg_46_0.focusPosY, RougeMapEnum.OffsetZ.Map)
	arg_46_0._inputFocusPosX:SetText(arg_46_0.focusPosX)
	arg_46_0._inputFocusPosY:SetText(arg_46_0.focusPosY)
end

function var_0_0.initStartPos(arg_47_0)
	arg_47_0.startPosX, arg_47_0.startPosY = RougeMapHelper.getPos(arg_47_0.pathSelectCo.startPos)
	arg_47_0.rectTrStart = gohelper.findChild(arg_47_0.mapViewGo, "#go_linecontainer/#go_start"):GetComponent(gohelper.Type_RectTransform)

	arg_47_0:onStartPosChange()
end

function var_0_0.onStartPosChange(arg_48_0)
	recthelper.setAnchor(arg_48_0.rectTrStart, arg_48_0.startPosX, arg_48_0.startPosY)
	arg_48_0._inputStartPosX:SetText(arg_48_0.startPosX)
	arg_48_0._inputStartPosY:SetText(arg_48_0.startPosY)
end

function var_0_0.initEndPos(arg_49_0)
	arg_49_0.endPosX, arg_49_0.endPosY = RougeMapHelper.getPos(arg_49_0.pathSelectCo.endPos)
	arg_49_0.rectTrEnd = gohelper.findChild(arg_49_0.mapViewGo, "#go_linecontainer/#go_end"):GetComponent(gohelper.Type_RectTransform)

	arg_49_0:onEndPosChange()
end

function var_0_0.onEndPosChange(arg_50_0)
	recthelper.setAnchor(arg_50_0.rectTrEnd, arg_50_0.endPosX, arg_50_0.endPosY)
	arg_50_0._inputEndPosX:SetText(arg_50_0.endPosX)
	arg_50_0._inputEndPosY:SetText(arg_50_0.endPosY)
end

function var_0_0.initSelectLinePos(arg_51_0)
	local var_51_0 = RougeMapModel.instance:getSelectLayerId()
	local var_51_1 = lua_rouge_layer.configDict[var_51_0]

	arg_51_0.linePosX, arg_51_0.linePosY = RougeMapHelper.getPos(var_51_1.pathPos)

	local var_51_2 = string.format("#go_linecontainer/%s/line", var_51_1.id)
	local var_51_3 = gohelper.findChild(arg_51_0.mapViewGo, var_51_2)

	if not var_51_3 then
		return
	end

	arg_51_0.rectTrLine = var_51_3:GetComponent(gohelper.Type_RectTransform)

	arg_51_0:onSelectLinePosChange()
end

function var_0_0.onSelectLinePosChange(arg_52_0)
	arg_52_0._inputSelectLinePosX:SetText(arg_52_0.linePosX)
	arg_52_0._inputSelectLinePosY:SetText(arg_52_0.linePosY)
	recthelper.setAnchor(arg_52_0.rectTrLine, arg_52_0.linePosX, arg_52_0.linePosY)
end

function var_0_0.initLineIconPos(arg_53_0)
	local var_53_0 = RougeMapModel.instance:getSelectLayerId()
	local var_53_1 = lua_rouge_layer.configDict[var_53_0]

	arg_53_0.lineIconPosX, arg_53_0.lineIconPosY = RougeMapHelper.getPos(var_53_1.iconPos)

	local var_53_2 = string.format("#go_linecontainer/%s/lineIcon", var_53_1.id)
	local var_53_3 = gohelper.findChild(arg_53_0.mapViewGo, var_53_2)

	if not var_53_3 then
		return
	end

	arg_53_0.rectTrLineIcon = var_53_3:GetComponent(gohelper.Type_RectTransform)

	arg_53_0:onLineIconPosChange()
end

function var_0_0.onLineIconPosChange(arg_54_0)
	arg_54_0._inputLineIconPosX:SetText(arg_54_0.lineIconPosX)
	arg_54_0._inputLineIconPosY:SetText(arg_54_0.lineIconPosY)
	recthelper.setAnchor(arg_54_0.rectTrLineIcon, arg_54_0.lineIconPosX, arg_54_0.lineIconPosY)
end

function var_0_0.initLayerDrop(arg_55_0)
	arg_55_0.curLayerId = RougeMapModel.instance:getMiddleLayerId()
	arg_55_0.curLayerIndex = 1
	arg_55_0.layerIdList = {}
	arg_55_0.layerStrList = {}

	for iter_55_0, iter_55_1 in ipairs(lua_rouge_middle_layer.configList) do
		local var_55_0 = iter_55_1.id

		table.insert(arg_55_0.layerIdList, var_55_0)
		table.insert(arg_55_0.layerStrList, tostring(var_55_0))

		if var_55_0 == arg_55_0.curLayerId then
			arg_55_0.curLayerIndex = iter_55_0
		end
	end

	arg_55_0.dropMap:ClearOptions()
	arg_55_0.dropMap:AddOptions(arg_55_0.layerStrList)
	arg_55_0.dropMap:SetValue(arg_55_0.curLayerIndex - 1)
end

return var_0_0

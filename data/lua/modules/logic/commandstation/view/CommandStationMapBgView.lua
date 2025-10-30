module("modules.logic.commandstation.view.CommandStationMapBgView", package.seeall)

local var_0_0 = class("CommandStationMapBgView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_bg/#simage_FullBG")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._tempVector = Vector2()
	arg_2_0._dragDeltaPos = Vector2()

	arg_2_0:_initDrag()
end

function var_0_0._initDrag(arg_3_0)
	arg_3_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_3_0._gobg)

	arg_3_0._drag:AddDragBeginListener(arg_3_0._onDragBegin, arg_3_0)
	arg_3_0._drag:AddDragEndListener(arg_3_0._onDragEnd, arg_3_0)
	arg_3_0._drag:AddDragListener(arg_3_0._onDrag, arg_3_0)
end

function var_0_0._onDragBegin(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._dragBeginPos = arg_4_2.position
	arg_4_0._bgBeginPos = arg_4_0._gobg.transform.localPosition
end

function var_0_0._onDragEnd(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._dragBeginPos = nil
	arg_5_0._bgBeginPos = nil
end

function var_0_0._onDrag(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._dragBeginPos then
		return
	end

	local var_6_0 = arg_6_2.position - arg_6_0._dragBeginPos

	arg_6_0:drag(var_6_0)
end

function var_0_0.drag(arg_7_0, arg_7_1)
	if not arg_7_0._bgBeginPos then
		return
	end

	arg_7_0._dragDeltaPos.x = arg_7_1.x
	arg_7_0._dragDeltaPos.y = arg_7_1.y

	local var_7_0 = arg_7_0:vectorAdd(arg_7_0._bgBeginPos, arg_7_0._dragDeltaPos)

	arg_7_0:setBgPosSafety(var_7_0)
end

function var_0_0.vectorAdd(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._tempVector

	var_8_0.x = arg_8_1.x + arg_8_2.x
	var_8_0.y = arg_8_1.y + arg_8_2.y

	return var_8_0
end

function var_0_0.setBgPosSafety(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1.x < arg_9_0._mapMinX then
		arg_9_1.x = arg_9_0._mapMinX
	elseif arg_9_1.x > arg_9_0._mapMaxX then
		arg_9_1.x = arg_9_0._mapMaxX
	end

	if arg_9_1.y < arg_9_0._mapMinY then
		arg_9_1.y = arg_9_0._mapMinY
	elseif arg_9_1.y > arg_9_0._mapMaxY then
		arg_9_1.y = arg_9_0._mapMaxY
	end

	arg_9_0._targetPos = arg_9_1

	recthelper.setAnchor(arg_9_0._gobg.transform, arg_9_1.x, arg_9_1.y)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:addEventCb(CommandStationController.instance, CommandStationEvent.SelectTimePoint, arg_10_0._onSelectTimePoint, arg_10_0)
	arg_10_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_10_0._onScreenResize, arg_10_0)
	arg_10_0:_showTimeId(CommandStationMapModel.instance:getTimeId())
end

function var_0_0._onScreenResize(arg_11_0)
	if arg_11_0._targetPos then
		arg_11_0:setBgPosSafety(arg_11_0._targetPos)
	end
end

function var_0_0._onSelectTimePoint(arg_12_0, arg_12_1)
	arg_12_0:_showTimeId(arg_12_1)
end

function var_0_0._showTimeId(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	if arg_13_0._timeId == arg_13_1 then
		return
	end

	arg_13_0._timeId = arg_13_1

	CommandStationMapModel.instance:setTimeId(arg_13_1)

	local var_13_0 = CommandStationConfig.instance:getTimeGroupByTimeId(arg_13_1)

	arg_13_0._simageFullBG:LoadImage("singlebg/commandstation/map/commandstation_map2.png", arg_13_0._loadedFullBGComplete, arg_13_0)
end

function var_0_0._loadedFullBGComplete(arg_14_0)
	arg_14_0:_initSceneBoundary()
	arg_14_0:setBgPosSafety(Vector2())
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish)
end

function var_0_0._initSceneBoundary(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0:_getScreenSize()

	arg_15_0._bgWidth = recthelper.getWidth(arg_15_0._simageFullBG.transform)
	arg_15_0._bgHeight = recthelper.getHeight(arg_15_0._simageFullBG.transform)

	local var_15_2 = arg_15_0._bgWidth - var_15_0
	local var_15_3 = math.max(0, var_15_2 / 2)
	local var_15_4 = arg_15_0._bgHeight - var_15_1
	local var_15_5 = math.max(0, var_15_4 / 2)

	arg_15_0._mapMinX = -var_15_3
	arg_15_0._mapMaxX = var_15_3
	arg_15_0._mapMinY = -var_15_5
	arg_15_0._mapMaxY = var_15_5
end

function var_0_0._getScreenSize(arg_16_0)
	return recthelper.getWidth(ViewMgr.instance:getUIRoot().transform), recthelper.getHeight(ViewMgr.instance:getUIRoot().transform)
end

function var_0_0.onClose(arg_17_0)
	if arg_17_0._drag then
		arg_17_0._drag:RemoveDragBeginListener()
		arg_17_0._drag:RemoveDragListener()
		arg_17_0._drag:RemoveDragEndListener()

		arg_17_0._drag = nil
	end
end

return var_0_0

module("modules.logic.versionactivity1_2.jiexika.view.Activity114Live2dView", package.seeall)

local var_0_0 = class("Activity114Live2dView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._path = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.go = gohelper.findChild(arg_2_0.viewGO, arg_2_0._path or "")
	arg_2_0._lightspine = gohelper.findChild(arg_2_0.go, "#simage_spinemask/roleContainer/#go_lightspine")
	arg_2_0._btnClick = gohelper.findChildButton(arg_2_0.go, "#simage_spinemask/#btn_click")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessStart, arg_3_0._onEventBegin, arg_3_0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventEndWithResult, arg_3_0._onEventEnd, arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0._onClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessStart, arg_4_0._onEventBegin, arg_4_0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventEndWithResult, arg_4_0._onEventEnd, arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._motionCo = Activity114Config.instance:getMotionCo()
end

function var_0_0._onOpenView(arg_6_0, arg_6_1)
	if arg_6_1 ~= ViewName.Activity114PhotoView then
		return
	end

	arg_6_0._pauseAnim = true

	TaskDispatcher.cancelTask(arg_6_0._playTriggerAnim, arg_6_0)
end

function var_0_0._onClick(arg_7_0)
	local var_7_0 = arg_7_0._motionCo[Activity114Enum.MotionType.Click]

	if arg_7_0._clickDt and ServerTime.now() - arg_7_0._clickDt < tonumber(var_7_0.param) then
		return
	end

	arg_7_0._clickDt = math.huge

	TaskDispatcher.cancelTask(arg_7_0._playTriggerAnim, arg_7_0)

	arg_7_0._isFirstTime = true

	arg_7_0:_playMotion(var_7_0)
end

function var_0_0._playMotion(arg_8_0, arg_8_1)
	if not arg_8_0._uiSpine then
		return
	end

	local var_8_0 = {
		mouth = "",
		motion = arg_8_1.motion,
		face = arg_8_1.face
	}

	arg_8_0._uiSpine:playVoice(var_8_0)
end

function var_0_0._onEventBegin(arg_9_0)
	arg_9_0._pauseAnim = true

	TaskDispatcher.cancelTask(arg_9_0._playTriggerAnim, arg_9_0)
end

function var_0_0._onEventEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._pauseAnim = false

	local var_10_0

	if arg_10_1 == Activity114Enum.EventType.Rest then
		var_10_0 = Activity114Enum.MotionType.Rest
	elseif arg_10_1 == Activity114Enum.EventType.KeyDay then
		var_10_0 = Activity114Enum.MotionType.KeyDay
	elseif arg_10_1 == Activity114Enum.EventType.Edu then
		var_10_0 = Activity114Enum.MotionType.Edu
	else
		return
	end

	local var_10_1 = arg_10_0._motionCo[var_10_0]

	var_10_1 = var_10_1 and var_10_1[arg_10_2]
	arg_10_0._isFirstTime = true

	if var_10_1 then
		arg_10_0:_playMotion(var_10_1)
	else
		TaskDispatcher.runDelay(arg_10_0._playTriggerAnim, arg_10_0, arg_10_0._motionCo.firstTime)
	end
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if arg_11_1 ~= ViewName.Activity114PhotoView then
		return
	end

	arg_11_0._pauseAnim = false
	arg_11_0._isFirstTime = true

	TaskDispatcher.runDelay(arg_11_0._playTriggerAnim, arg_11_0, arg_11_0._motionCo.firstTime)
end

function var_0_0._playTriggerAnim(arg_12_0)
	arg_12_0._isFirstTime = false

	local var_12_0 = arg_12_0._motionCo[Activity114Enum.MotionType.Time]
	local var_12_1 = var_12_0[math.random(1, #var_12_0)]

	arg_12_0:_playMotion(var_12_1)
end

function var_0_0._onAnimEnd(arg_13_0, arg_13_1)
	if arg_13_0._clickDt == math.huge then
		arg_13_0._clickDt = ServerTime.now()
	end

	if arg_13_0._pauseAnim then
		return
	end

	if arg_13_0._isFirstTime then
		TaskDispatcher.runDelay(arg_13_0._playTriggerAnim, arg_13_0, arg_13_0._motionCo.firstTime)
	else
		TaskDispatcher.runDelay(arg_13_0._playTriggerAnim, arg_13_0, arg_13_0._motionCo.nextTime)
	end
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._uiSpine = GuiModelAgent.Create(arg_14_0._lightspine, true)

	local var_14_0 = lua_skin.configDict[305601]

	arg_14_0._uiSpine:setResPath(var_14_0, arg_14_0.onSpineLoaded, arg_14_0)
	arg_14_0._uiSpine:setModelVisible(true)

	arg_14_0._l2d = arg_14_0._uiSpine:_getLive2d()

	arg_14_0._l2d:setActionEventCb(arg_14_0._onAnimEnd, arg_14_0)
end

function var_0_0.onSpineLoaded(arg_15_0)
	return
end

function var_0_0.getUISpine(arg_16_0)
	if arg_16_0._uiSpine then
		return arg_16_0._uiSpine
	end
end

function var_0_0.onClose(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._playTriggerAnim, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._playTriggerAnim, arg_18_0)

	if arg_18_0._uiSpine then
		arg_18_0._uiSpine:onDestroy()

		arg_18_0._uiSpine = nil
	end
end

return var_0_0

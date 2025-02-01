module("modules.logic.versionactivity1_2.jiexika.view.Activity114Live2dView", package.seeall)

slot0 = class("Activity114Live2dView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._path = slot1
end

function slot0.onInitView(slot0)
	slot0.go = gohelper.findChild(slot0.viewGO, slot0._path or "")
	slot0._lightspine = gohelper.findChild(slot0.go, "#simage_spinemask/roleContainer/#go_lightspine")
	slot0._btnClick = gohelper.findChildButton(slot0.go, "#simage_spinemask/#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessStart, slot0._onEventBegin, slot0)
	Activity114Controller.instance:registerCallback(Activity114Event.OnEventEndWithResult, slot0._onEventEnd, slot0)
	slot0._btnClick:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessStart, slot0._onEventBegin, slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventEndWithResult, slot0._onEventEnd, slot0)
	slot0._btnClick:RemoveClickListener()
end

function slot0.onOpen(slot0)
	slot0._motionCo = Activity114Config.instance:getMotionCo()
end

function slot0._onOpenView(slot0, slot1)
	if slot1 ~= ViewName.Activity114PhotoView then
		return
	end

	slot0._pauseAnim = true

	TaskDispatcher.cancelTask(slot0._playTriggerAnim, slot0)
end

function slot0._onClick(slot0)
	slot1 = slot0._motionCo[Activity114Enum.MotionType.Click]

	if slot0._clickDt and ServerTime.now() - slot0._clickDt < tonumber(slot1.param) then
		return
	end

	slot0._clickDt = math.huge

	TaskDispatcher.cancelTask(slot0._playTriggerAnim, slot0)

	slot0._isFirstTime = true

	slot0:_playMotion(slot1)
end

function slot0._playMotion(slot0, slot1)
	if not slot0._uiSpine then
		return
	end

	slot0._uiSpine:playVoice({
		mouth = "",
		motion = slot1.motion,
		face = slot1.face
	})
end

function slot0._onEventBegin(slot0)
	slot0._pauseAnim = true

	TaskDispatcher.cancelTask(slot0._playTriggerAnim, slot0)
end

function slot0._onEventEnd(slot0, slot1, slot2)
	slot0._pauseAnim = false
	slot3 = nil

	if slot1 == Activity114Enum.EventType.Rest then
		slot3 = Activity114Enum.MotionType.Rest
	elseif slot1 == Activity114Enum.EventType.KeyDay then
		slot3 = Activity114Enum.MotionType.KeyDay
	elseif slot1 == Activity114Enum.EventType.Edu then
		slot3 = Activity114Enum.MotionType.Edu
	else
		return
	end

	slot0._isFirstTime = true

	if slot0._motionCo[slot3] and slot4[slot2] then
		slot0:_playMotion(slot4)
	else
		TaskDispatcher.runDelay(slot0._playTriggerAnim, slot0, slot0._motionCo.firstTime)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 ~= ViewName.Activity114PhotoView then
		return
	end

	slot0._pauseAnim = false
	slot0._isFirstTime = true

	TaskDispatcher.runDelay(slot0._playTriggerAnim, slot0, slot0._motionCo.firstTime)
end

function slot0._playTriggerAnim(slot0)
	slot0._isFirstTime = false
	slot1 = slot0._motionCo[Activity114Enum.MotionType.Time]

	slot0:_playMotion(slot1[math.random(1, #slot1)])
end

function slot0._onAnimEnd(slot0, slot1)
	if slot0._clickDt == math.huge then
		slot0._clickDt = ServerTime.now()
	end

	if slot0._pauseAnim then
		return
	end

	if slot0._isFirstTime then
		TaskDispatcher.runDelay(slot0._playTriggerAnim, slot0, slot0._motionCo.firstTime)
	else
		TaskDispatcher.runDelay(slot0._playTriggerAnim, slot0, slot0._motionCo.nextTime)
	end
end

function slot0._editableInitView(slot0)
	slot0._uiSpine = GuiModelAgent.Create(slot0._lightspine, true)

	slot0._uiSpine:setResPath(lua_skin.configDict[305601], slot0.onSpineLoaded, slot0)
	slot0._uiSpine:setModelVisible(true)

	slot0._l2d = slot0._uiSpine:_getLive2d()

	slot0._l2d:setActionEventCb(slot0._onAnimEnd, slot0)
end

function slot0.onSpineLoaded(slot0)
end

function slot0.getUISpine(slot0)
	if slot0._uiSpine then
		return slot0._uiSpine
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._playTriggerAnim, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._playTriggerAnim, slot0)

	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end
end

return slot0

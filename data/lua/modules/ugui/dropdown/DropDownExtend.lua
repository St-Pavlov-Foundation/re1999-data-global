module("modules.ugui.dropdown.DropDownExtend", package.seeall)

local var_0_0 = class("DropDownExtend", UserDataDispose)

function var_0_0.Get(arg_1_0)
	return var_0_0.New(arg_1_0)
end

var_0_0.DropListName = "Dropdown List"

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.goDrop = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.onDropShowCb = arg_3_1
	arg_3_0.onDropHideCb = arg_3_2
	arg_3_0.cbObj = arg_3_3

	arg_3_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreenUp, arg_3_0._onTouchUp, arg_3_0)
end

function var_0_0.addEventsListener(arg_4_0)
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnStart, arg_4_0.triggerShow, arg_4_0)
	GameObjectLiveMgr.instance:registerCallback(GameObjectLiveEvent.OnDestroy, arg_4_0.OnDropListDestroy, arg_4_0)
end

function var_0_0.removeEventsListener(arg_5_0)
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnStart, arg_5_0.triggerShow, arg_5_0)
	GameObjectLiveMgr.instance:unregisterCallback(GameObjectLiveEvent.OnDestroy, arg_5_0.OnDropListDestroy, arg_5_0)
end

function var_0_0._onTouchUp(arg_6_0)
	local var_6_0 = gohelper.findChild(arg_6_0.goDrop, var_0_0.DropListName)

	arg_6_0:addLiveComp(var_6_0)
end

function var_0_0.addLiveComp(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0.dropList then
		return
	end

	arg_7_0.dropList = arg_7_1

	if not gohelper.isNil(arg_7_0.dropList) then
		arg_7_0:addEventsListener()

		arg_7_0.liveComp = MonoHelper.addLuaComOnceToGo(arg_7_0.dropList, GameObjectLiveEventComp)
	end
end

function var_0_0.OnDropListDestroy(arg_8_0, arg_8_1)
	if arg_8_0.dropList ~= arg_8_1 then
		return
	end

	arg_8_0.liveComp = nil

	arg_8_0:removeEventsListener()
	TaskDispatcher.runDelay(arg_8_0.afterDestroyDelay, arg_8_0, 0.01)
end

function var_0_0.afterDestroyDelay(arg_9_0)
	local var_9_0 = gohelper.findChild(arg_9_0.goDrop, var_0_0.DropListName)

	if gohelper.isNil(var_9_0) then
		arg_9_0:triggerHide()

		return
	end

	arg_9_0:addLiveComp(var_9_0)
end

function var_0_0.triggerHide(arg_10_0)
	if arg_10_0.onDropHideCb then
		arg_10_0.onDropHideCb(arg_10_0.cbObj)
	end
end

function var_0_0.triggerShow(arg_11_0, arg_11_1)
	if arg_11_0.dropList ~= arg_11_1 then
		return
	end

	if arg_11_0.onDropShowCb then
		arg_11_0.onDropShowCb(arg_11_0.cbObj)
	end
end

function var_0_0.dispose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.afterDestroyDelay, arg_12_0)

	arg_12_0.liveComp = nil

	arg_12_0:removeEventsListener()
	arg_12_0:__onDispose()
end

return var_0_0

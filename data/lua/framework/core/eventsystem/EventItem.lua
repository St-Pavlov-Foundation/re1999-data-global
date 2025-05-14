module("framework.core.eventsystem.EventItem", package.seeall)

local var_0_0 = class("EventItem")

var_0_0.IsIOSPlayer = SLFramework.FrameworkSettings.CurPlatform == SLFramework.FrameworkSettings.IOSPlayer

local var_0_1 = _G.callWithCatch
local var_0_2 = xpcall

function var_0_0.getPool()
	if var_0_0._pool == nil then
		var_0_0._pool = LuaObjPool.New(32, var_0_0._poolNew, var_0_0._poolRelease, var_0_0._poolReset)
	end

	return var_0_0._pool
end

function var_0_0._poolNew()
	return var_0_0.New()
end

function var_0_0._poolRelease(arg_3_0)
	arg_3_0:release()
end

function var_0_0._poolReset(arg_4_0)
	arg_4_0:reset()
end

function var_0_0.ctor(arg_5_0)
	arg_5_0:reset()
end

function var_0_0.release(arg_6_0)
	arg_6_0:reset()
end

function var_0_0.ctor(arg_7_0)
	arg_7_0.cbObjContainer = {}

	setmetatable(arg_7_0.cbObjContainer, {
		__mode = "v"
	})
	arg_7_0:reset()
end

function var_0_0.reset(arg_8_0)
	arg_8_0.eventName = nil
	arg_8_0.callback = nil
	arg_8_0.cbObjContainer.value = nil
	arg_8_0.hasCbObj = false
	arg_8_0.status = LuaEventSystem.Idle
	arg_8_0.priority = LuaEventSystem.Low
	arg_8_0.removeAll = nil
end

function var_0_0.setCbObj(arg_9_0, arg_9_1)
	arg_9_0.hasCbObj = arg_9_1 ~= nil

	if arg_9_0.hasCbObj then
		arg_9_0.cbObjContainer.value = arg_9_1
	end
end

function var_0_0.getCbObj(arg_10_0)
	if arg_10_0.hasCbObj then
		return arg_10_0.cbObjContainer.value
	end

	return nil
end

function var_0_0.dispatch(arg_11_0, ...)
	if arg_11_0.hasCbObj and not arg_11_0.cbObjContainer.value then
		return false
	end

	if not arg_11_0.hasCbObj then
		var_0_1(arg_11_0.callback, ...)
	elseif (... ~= nil and select("#", ...) or 0) > 0 then
		var_0_2(arg_11_0.callback, __G__TRACKBACK__, arg_11_0.cbObjContainer.value, select(1, ...))
	else
		var_0_2(arg_11_0.callback, __G__TRACKBACK__, arg_11_0.cbObjContainer.value)
	end

	return true
end

return var_0_0

module("framework.core.eventsystem.DispatchItem", package.seeall)

local var_0_0 = class("DispatchItem")

function var_0_0.createPool()
	var_0_0._pool = LuaObjPool.New(32, var_0_0._poolNew, var_0_0._poolRelease, var_0_0._poolReset)
end

function var_0_0.getPool()
	if var_0_0._pool == nil then
		var_0_0.createPool()
	end

	return var_0_0._pool
end

function var_0_0._poolNew()
	return var_0_0.New()
end

function var_0_0._poolRelease(arg_4_0)
	arg_4_0:release()
end

function var_0_0._poolReset(arg_5_0)
	arg_5_0:reset()
end

function var_0_0.ctor(arg_6_0)
	arg_6_0:reset()
end

function var_0_0.release(arg_7_0)
	arg_7_0:reset()
end

function var_0_0.reset(arg_8_0)
	arg_8_0.eventName = nil
	arg_8_0.eventArgs = nil
end

return var_0_0

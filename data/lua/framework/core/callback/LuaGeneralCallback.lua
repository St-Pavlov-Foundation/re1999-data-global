module("framework.core.callback.LuaGeneralCallback", package.seeall)

local var_0_0 = class("LuaGeneralCallback")

var_0_0._pool = nil

function var_0_0.getPool()
	if not var_0_0._pool then
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
	arg_5_0.id = 0
	arg_5_0.callback = nil
	arg_5_0.hasCbObj = false
	arg_5_0.cbObjContainer = {}

	setmetatable(arg_5_0.cbObjContainer, {
		__mode = "v"
	})

	arg_5_0.cbObjContainer.value = nil
end

function var_0_0.setCbObj(arg_6_0, arg_6_1)
	arg_6_0.hasCbObj = arg_6_1 ~= nil

	if arg_6_0.hasCbObj then
		arg_6_0.cbObjContainer.value = arg_6_1
	end
end

function var_0_0.invoke(arg_7_0, ...)
	if arg_7_0.hasCbObj and not arg_7_0.cbObjContainer.value then
		return false
	end

	local var_7_0 = {
		...
	}

	if not arg_7_0.hasCbObj then
		arg_7_0.callback(unpack(var_7_0))
	else
		arg_7_0.callback(arg_7_0.cbObjContainer.value, unpack(var_7_0))
	end

	return true
end

function var_0_0.reset(arg_8_0)
	arg_8_0.id = 0
	arg_8_0.callback = nil
	arg_8_0.hasCbObj = false
	arg_8_0.cbObjContainer.value = nil
end

function var_0_0.release(arg_9_0)
	arg_9_0:reset()
end

return var_0_0

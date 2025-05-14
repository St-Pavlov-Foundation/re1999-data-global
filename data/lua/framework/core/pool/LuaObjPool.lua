module("framework.core.pool.LuaObjPool", package.seeall)

local var_0_0 = class("LuaObjPool")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._maxCount = arg_1_1
	arg_1_0._newFunc = arg_1_2
	arg_1_0._releaseFunc = arg_1_3
	arg_1_0._resetFunc = arg_1_4

	if arg_1_1 == nil or arg_1_2 == nil or arg_1_3 == nil or arg_1_4 == nil then
		logError("LuaObjPool, 对象池构造，所有参数都不能为nil")
	end

	if arg_1_0._maxCount == 0 then
		arg_1_0._maxCount = 32
	end

	arg_1_0._cacheList = {}
end

function var_0_0.getObject(arg_2_0)
	if #arg_2_0._cacheList < 1 then
		return arg_2_0._newFunc()
	else
		return table.remove(arg_2_0._cacheList)
	end
end

function var_0_0.putObject(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_0._cacheList

	arg_3_0._resetFunc(arg_3_1)

	if var_3_0 >= arg_3_0._maxCount then
		arg_3_0._releaseFunc(arg_3_1)
	elseif not tabletool.indexOf(arg_3_0._cacheList, arg_3_1) then
		table.insert(arg_3_0._cacheList, arg_3_1)
	end
end

function var_0_0.dispose(arg_4_0)
	local var_4_0 = #arg_4_0._cacheList

	if var_4_0 == 0 then
		return
	end

	local var_4_1

	for iter_4_0 = 1, var_4_0 do
		local var_4_2 = arg_4_0._cacheList[iter_4_0]

		arg_4_0._releaseFunc(var_4_2)

		arg_4_0._cacheList[iter_4_0] = nil
	end
end

return var_0_0

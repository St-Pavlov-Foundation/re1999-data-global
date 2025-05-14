module("modules.logic.room.utils.RoomVectorPool", package.seeall)

local var_0_0 = class("RoomVectorPool")

function var_0_0.ctor(arg_1_0)
	arg_1_0._posList = {}
	arg_1_0._xCache = {}
	arg_1_0._yCache = {}
	arg_1_0._zCache = {}
end

function var_0_0.packPosList(arg_2_0, arg_2_1)
	local var_2_0 = {}

	ZProj.AStarPathBridge.PosListToLuaTable(arg_2_1, arg_2_0._xCache, arg_2_0._yCache, arg_2_0._zCache)

	for iter_2_0 = 1, #arg_2_0._xCache do
		local var_2_1 = arg_2_0:get()

		var_2_1.x, var_2_1.y, var_2_1.z = arg_2_0._xCache[iter_2_0], arg_2_0._yCache[iter_2_0], arg_2_0._zCache[iter_2_0]

		table.insert(var_2_0, var_2_1)
	end

	arg_2_0:cleanTable(arg_2_0._xCache)
	arg_2_0:cleanTable(arg_2_0._yCache)
	arg_2_0:cleanTable(arg_2_0._zCache)

	return var_2_0
end

function var_0_0.get(arg_3_0)
	local var_3_0 = #arg_3_0._posList

	if var_3_0 > 0 then
		local var_3_1 = arg_3_0._posList[var_3_0]

		arg_3_0._posList[var_3_0] = nil

		return var_3_1
	end

	return Vector3.New()
end

function var_0_0.recycle(arg_4_0, arg_4_1)
	arg_4_1:Set(0, 0, 0)
	table.insert(arg_4_0._posList, arg_4_1)
end

function var_0_0.clean(arg_5_0)
	arg_5_0:cleanTable(arg_5_0._posList)
end

function var_0_0.cleanTable(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		arg_6_1[iter_6_0] = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

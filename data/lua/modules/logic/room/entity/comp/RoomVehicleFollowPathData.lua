module("modules.logic.room.entity.comp.RoomVehicleFollowPathData", package.seeall)

local var_0_0 = class("RoomVehicleFollowPathData")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._pathPosList = {}
	arg_1_0._pathDisList = {}
	arg_1_0._pathPosDistance = 0
	arg_1_0._maxDistance = 5
end

function var_0_0.setMaxDistance(arg_2_0, arg_2_1)
	arg_2_0._maxDistance = arg_2_1 or 3
end

function var_0_0.getMaxDistance(arg_3_0)
	return arg_3_0._maxDistance
end

function var_0_0.clear(arg_4_0)
	if #arg_4_0._pathPosList > 0 then
		arg_4_0._pathPosList = {}
		arg_4_0._pathDisList = {}
		arg_4_0._pathPosDistance = 0
	end
end

function var_0_0.addPathPos(arg_5_0, arg_5_1)
	if #arg_5_0._pathPosList > 0 then
		local var_5_0 = Vector3.Distance(arg_5_0._pathPosList[1], arg_5_1)

		table.insert(arg_5_0._pathDisList, 1, var_5_0)

		arg_5_0._pathPosDistance = arg_5_0._pathPosDistance + var_5_0
	end

	table.insert(arg_5_0._pathPosList, 1, arg_5_1)
	arg_5_0:_checkPath()
end

function var_0_0.getPosByDistance(arg_6_0, arg_6_1)
	if arg_6_1 >= arg_6_0._pathPosDistance then
		return arg_6_0:getLastPos()
	elseif arg_6_1 <= 0 then
		return arg_6_0:getFirstPos()
	end

	local var_6_0 = 0 + arg_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._pathDisList) do
		if iter_6_1 == var_6_0 then
			return arg_6_0._pathPosList[iter_6_0 + 1]
		elseif var_6_0 < iter_6_1 then
			return Vector3.Lerp(arg_6_0._pathPosList[iter_6_0], arg_6_0._pathPosList[iter_6_0 + 1], var_6_0 / iter_6_1)
		end

		var_6_0 = var_6_0 - iter_6_1
	end

	return arg_6_0:getLastPos()
end

function var_0_0._checkPath(arg_7_0)
	if arg_7_0._pathPosDistance < arg_7_0._maxDistance or #arg_7_0._pathDisList < 2 then
		return
	end

	for iter_7_0 = #arg_7_0._pathDisList, 2, -1 do
		local var_7_0 = arg_7_0._pathDisList[#arg_7_0._pathDisList]

		if arg_7_0._pathPosDistance - var_7_0 > arg_7_0._maxDistance then
			arg_7_0._pathPosDistance = arg_7_0._pathPosDistance - var_7_0

			table.remove(arg_7_0._pathDisList, #arg_7_0._pathDisList)
			table.remove(arg_7_0._pathPosList, #arg_7_0._pathPosList)
		else
			break
		end
	end
end

function var_0_0.getPathDistance(arg_8_0)
	return arg_8_0._pathPosDistance
end

function var_0_0.getPosCount(arg_9_0)
	return #arg_9_0._pathPosList
end

function var_0_0.getFirstPos(arg_10_0)
	return arg_10_0._pathPosList[1]
end

function var_0_0.getLastPos(arg_11_0)
	return arg_11_0._pathPosList[#arg_11_0._pathPosList]
end

return var_0_0

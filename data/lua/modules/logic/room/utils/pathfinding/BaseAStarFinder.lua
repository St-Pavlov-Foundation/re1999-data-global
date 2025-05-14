module("modules.logic.room.utils.pathfinding.BaseAStarFinder", package.seeall)

local var_0_0 = class("BaseAStarFinder")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.pathFinding(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == arg_2_2 then
		return {}
	end

	if not arg_2_0:isWalkable(arg_2_1) or not arg_2_0:isWalkable(arg_2_2) then
		return nil
	end

	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = {
		cost = 0,
		point = arg_2_1,
		heuristic = arg_2_0:heuristic(arg_2_1, arg_2_2)
	}

	var_2_0[tostring(var_2_2.point)] = var_2_2

	return (arg_2_0:_pathFinding(arg_2_1, arg_2_2, var_2_0, var_2_1))
end

function var_0_0._pathFinding(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	while LuaUtil.tableNotEmpty(arg_3_3) do
		local var_3_0 = arg_3_0:_getNextNode(arg_3_3)
		local var_3_1 = var_3_0.point
		local var_3_2, var_3_3 = arg_3_0:getConnectPointsAndCost(var_3_1)

		for iter_3_0 = 1, #var_3_2 do
			local var_3_4 = var_3_2[iter_3_0]
			local var_3_5 = var_3_3[iter_3_0] or 0

			if not arg_3_4[tostring(var_3_4)] and arg_3_0:isWalkable(var_3_4) then
				local var_3_6 = var_3_0.cost + var_3_5
				local var_3_7 = arg_3_3[tostring(var_3_4)]

				if not var_3_7 or var_3_6 < var_3_7.cost then
					var_3_7 = {
						point = var_3_4,
						cost = var_3_0.cost + var_3_5,
						heuristic = arg_3_0:heuristic(var_3_4, arg_3_2),
						last = var_3_0
					}
					arg_3_3[tostring(var_3_7.point)] = var_3_7
				end

				if var_3_7.point == arg_3_2 then
					return arg_3_0:_makePath(var_3_7)
				end
			end
		end

		arg_3_4[tostring(var_3_0.point)] = var_3_0
	end

	return nil
end

function var_0_0._getNextNode(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in pairs(arg_4_1) do
		if not var_4_0 or iter_4_1.cost + iter_4_1.heuristic < var_4_0.cost + var_4_0.heuristic then
			var_4_0 = iter_4_1
		end
	end

	arg_4_1[tostring(var_4_0.point)] = nil

	return var_4_0
end

function var_0_0._makePath(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = arg_5_1

	while var_5_1.last ~= nil do
		table.insert(var_5_0, var_5_1.point)

		var_5_1 = var_5_1.last
	end

	local var_5_2 = {}

	for iter_5_0 = #var_5_0, 1, -1 do
		table.insert(var_5_2, var_5_0[iter_5_0])
	end

	return var_5_2
end

function var_0_0.getConnectPointsAndCost(arg_6_0, arg_6_1)
	return
end

function var_0_0.heuristic(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.isWalkable(arg_8_0, arg_8_1)
	return
end

return var_0_0

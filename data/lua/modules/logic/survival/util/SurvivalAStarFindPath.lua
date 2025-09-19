module("modules.logic.survival.util.SurvivalAStarFindPath", package.seeall)

local var_0_0 = class("SurvivalAStarFindPath")

function var_0_0.retracePath(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1 = arg_1_2

	while var_1_1 ~= arg_1_1 do
		table.insert(var_1_0, 1, var_1_1)

		var_1_1 = var_1_1.parent
	end

	return var_1_0
end

function var_0_0.findPath(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 == arg_2_2 or not SurvivalHelper.instance:isHaveNode(arg_2_3, arg_2_1) then
		return nil
	end

	local var_2_0 = {}
	local var_2_1 = {}
	local var_2_2 = arg_2_1
	local var_2_3 = SurvivalHelper.instance:getDistance(arg_2_1, arg_2_2)

	if SurvivalHelper.instance:isHaveNode(arg_2_3, arg_2_2) then
		var_2_2 = arg_2_2
		var_2_3 = 0
	end

	SurvivalHelper.instance:addNodeToDict(var_2_0, arg_2_1)

	while true do
		local var_2_4

		for iter_2_0, iter_2_1 in pairs(var_2_0) do
			for iter_2_2, iter_2_3 in pairs(iter_2_1) do
				if not var_2_4 then
					var_2_4 = iter_2_3
				elseif iter_2_3:fCost() < var_2_4:fCost() or iter_2_3:fCost() == var_2_4:fCost() and iter_2_3.hCost < var_2_4.hCost then
					var_2_4 = iter_2_3
				end
			end
		end

		if not var_2_4 then
			if var_2_2 == arg_2_1 or not arg_2_4 then
				return nil
			else
				return arg_2_0:retracePath(arg_2_1, var_2_2)
			end
		end

		SurvivalHelper.instance:removeNodeToDict(var_2_0, var_2_4)
		SurvivalHelper.instance:addNodeToDict(var_2_1, var_2_4)

		local var_2_5 = SurvivalHelper.instance:getDistance(var_2_4, arg_2_2)

		if var_2_5 < var_2_3 then
			var_2_2 = var_2_4
			var_2_3 = var_2_5
		end

		if var_2_4 == arg_2_2 then
			return arg_2_0:retracePath(arg_2_1, var_2_4)
		end

		for iter_2_4, iter_2_5 in pairs(SurvivalEnum.DirToPos) do
			local var_2_6 = var_2_4 + iter_2_5

			if SurvivalHelper.instance:isHaveNode(arg_2_3, var_2_6) then
				local var_2_7 = var_2_4.gCost + 1
				local var_2_8 = SurvivalHelper.instance:isHaveNode(var_2_0, var_2_6)
				local var_2_9 = not var_2_8
				local var_2_10 = not SurvivalHelper.instance:isHaveNode(var_2_1, var_2_6)

				if var_2_8 and var_2_7 < var_2_8.gCost or var_2_9 and var_2_10 then
					var_2_6.gCost = var_2_7
					var_2_6.hCost = SurvivalHelper.instance:getDistance(var_2_6, arg_2_2)
					var_2_6.parent = var_2_4

					if var_2_9 or var_2_7 < var_2_8.gCost then
						SurvivalHelper.instance:addNodeToDict(var_2_0, var_2_6)
					end
				end
			end
		end
	end
end

function var_0_0.findNearestPath(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if not arg_3_1 or not arg_3_2 or #arg_3_2 == 0 then
		return nil
	end

	local var_3_0
	local var_3_1 = math.huge

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		local var_3_2 = arg_3_0:findPath(arg_3_1, iter_3_1, arg_3_3, arg_3_4)

		if var_3_2 then
			local var_3_3 = SurvivalHelper.instance:getDistance(arg_3_1, iter_3_1)

			if var_3_3 < var_3_1 then
				var_3_1 = var_3_3
				var_3_0 = var_3_2
			end
		else
			return nil
		end
	end

	return var_3_0
end

var_0_0.instance = var_0_0.New()

return var_0_0

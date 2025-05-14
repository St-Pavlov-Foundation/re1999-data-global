module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameTree", package.seeall)

local var_0_0 = class("YaXianGameTree")

var_0_0.MaxBucket = 16

function var_0_0.buildTree(arg_1_0, arg_1_1)
	arg_1_0.allNodes = {}

	local var_1_0 = 50
	local var_1_1 = {
		arg_1_1
	}
	local var_1_2 = 1

	while #var_1_1 > 0 and var_1_2 <= var_1_0 do
		var_1_2 = var_1_2 + 1

		if var_1_0 < var_1_2 then
			logError("max exclusive !")

			break
		end

		local var_1_3 = table.remove(var_1_1)

		table.insert(arg_1_0.allNodes, var_1_3)

		for iter_1_0, iter_1_1 in pairs(var_1_3.nodes) do
			arg_1_0:processChildNode(var_1_3, iter_1_1, iter_1_1.x, iter_1_1.y)
			arg_1_0:processChildNode(var_1_3, iter_1_1, iter_1_1.x - YaXianGameEnum.ClickRangeX, iter_1_1.y)
			arg_1_0:processChildNode(var_1_3, iter_1_1, iter_1_1.x + YaXianGameEnum.ClickRangeX, iter_1_1.y)
			arg_1_0:processChildNode(var_1_3, iter_1_1, iter_1_1.x, iter_1_1.y - YaXianGameEnum.ClickRangeY)
			arg_1_0:processChildNode(var_1_3, iter_1_1, iter_1_1.x, iter_1_1.y + YaXianGameEnum.ClickRangeY)
		end

		for iter_1_2 = 1, 4 do
			local var_1_4 = var_1_3.children[iter_1_2]

			if #var_1_4.nodes > var_0_0.MaxBucket then
				arg_1_0:growToBranch(var_1_4)
				table.insert(var_1_1, var_1_4)
			end
		end
	end

	logNormal("build tree in " .. tostring(var_1_2))

	arg_1_0.root = arg_1_1
end

function var_0_0.processChildNode(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_0:getFixNode(arg_2_1, arg_2_3, arg_2_4)

	if not var_2_0.keys[arg_2_2] then
		table.insert(var_2_0.nodes, arg_2_2)
		table.insert(var_2_0.centerNodes, arg_2_2)

		var_2_0.keys[arg_2_2] = true
	end
end

function var_0_0.createLeaveNode(arg_3_0)
	return {
		nodes = {},
		keys = {},
		centerNodes = {}
	}
end

function var_0_0.growToBranch(arg_4_0, arg_4_1)
	local var_4_0 = 9999
	local var_4_1 = 9999
	local var_4_2 = -9999
	local var_4_3 = -9999

	for iter_4_0, iter_4_1 in pairs(arg_4_1.centerNodes) do
		var_4_0 = math.min(var_4_0, iter_4_1.x)
		var_4_1 = math.min(var_4_1, iter_4_1.y)
		var_4_2 = math.max(var_4_2, iter_4_1.x)
		var_4_3 = math.max(var_4_3, iter_4_1.y)
	end

	arg_4_1.x = (var_4_0 + var_4_2) * 0.5
	arg_4_1.y = (var_4_1 + var_4_3) * 0.5
	arg_4_1.children = {}

	for iter_4_2 = 1, 4 do
		arg_4_1.children[iter_4_2] = arg_4_0:createLeaveNode()
		arg_4_1.children[iter_4_2].parent = arg_4_1
	end
end

function var_0_0.getFixNode(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 > arg_5_1.x then
		if arg_5_3 > arg_5_1.y then
			return arg_5_1.children[1]
		else
			return arg_5_1.children[4]
		end
	elseif arg_5_3 > arg_5_1.y then
		return arg_5_1.children[2]
	else
		return arg_5_1.children[3]
	end
end

function var_0_0.search(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.root

	while var_6_0.children ~= nil do
		var_6_0 = arg_6_0:getFixNode(var_6_0, arg_6_1, arg_6_2)
	end

	local var_6_1 = var_6_0.parent

	if var_6_1 ~= nil then
		return var_6_1.nodes
	else
		return var_6_0.nodes
	end
end

return var_0_0

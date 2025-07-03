module("modules.logic.tower.model.TowerTalentTreeNode", package.seeall)

local var_0_0 = class("TowerTalentTreeNode")

function var_0_0.ctor(arg_1_0)
	arg_1_0.parents = {}
	arg_1_0.childs = {}
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.tree = arg_2_2
	arg_2_0.nodeId = arg_2_1.nodeId
	arg_2_0.id = arg_2_0.nodeId
	arg_2_0.config = arg_2_1
	arg_2_0.isOr = not string.find(arg_2_1.preNodeIds, "&")
end

function var_0_0.isRootNode(arg_3_0)
	return arg_3_0.config.startNode == 1
end

function var_0_0.setParent(arg_4_0, arg_4_1)
	arg_4_0.parents[arg_4_1.nodeId] = arg_4_1
end

function var_0_0.getParents(arg_5_0)
	return arg_5_0.parents
end

function var_0_0.setChild(arg_6_0, arg_6_1)
	arg_6_0.childs[arg_6_1.nodeId] = arg_6_1
end

function var_0_0.isActiveTalent(arg_7_0)
	return arg_7_0.tree:isActiveTalent(arg_7_0.nodeId)
end

function var_0_0.isSelectedSystemTalentPlan(arg_8_0)
	return arg_8_0.tree:isSelectedSystemTalentPlan()
end

function var_0_0.isParentActive(arg_9_0)
	local var_9_0

	if arg_9_0.isOr then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.parents) do
			if iter_9_1:isActiveTalent() then
				var_9_0 = true

				break
			else
				var_9_0 = false
			end
		end
	else
		for iter_9_2, iter_9_3 in pairs(arg_9_0.parents) do
			if not iter_9_3:isActiveTalent() then
				var_9_0 = false

				break
			end
		end
	end

	if var_9_0 == nil then
		var_9_0 = true
	end

	return var_9_0
end

function var_0_0.getParentActiveResult(arg_10_0)
	local var_10_0 = 2

	if arg_10_0.isOr then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.parents) do
			if iter_10_1:isActiveTalent() then
				var_10_0 = 2

				break
			else
				var_10_0 = 0
			end
		end
	else
		local var_10_1 = 0
		local var_10_2 = 0

		for iter_10_2, iter_10_3 in pairs(arg_10_0.parents) do
			if iter_10_3:isActiveTalent() then
				var_10_2 = var_10_2 + 1
			end

			var_10_1 = var_10_1 + 1
		end

		if var_10_1 > 0 then
			var_10_0 = var_10_1 <= var_10_2 and 2 or var_10_2 == 0 and 0 or 1
		end
	end

	return var_10_0
end

function var_0_0.isTalentCanActive(arg_11_0)
	return arg_11_0:isParentActive() and arg_11_0:isTalentConsumeEnough()
end

function var_0_0.isTalentConsumeEnough(arg_12_0)
	return arg_12_0.tree:getTalentPoint() >= arg_12_0.config.consume
end

function var_0_0.isActiveGroup(arg_13_0)
	return arg_13_0.tree:isActiveGroup(arg_13_0.config.nodeGroup)
end

function var_0_0.isLeafNode(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.childs) do
		if iter_14_1:isActiveTalent() then
			return false
		end
	end

	return true
end

return var_0_0

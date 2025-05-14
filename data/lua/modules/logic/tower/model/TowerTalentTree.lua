module("modules.logic.tower.model.TowerTalentTree", package.seeall)

local var_0_0 = class("TowerTalentTree")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.initTree(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.nodeDict = {}
	arg_2_0.nodeGroupDict = {}
	arg_2_0.rootNode = nil
	arg_2_0.bossMo = arg_2_1
	arg_2_0.talentCount = 0

	if arg_2_2 then
		for iter_2_0, iter_2_1 in pairs(arg_2_2) do
			local var_2_0 = arg_2_0:makeNode(iter_2_1)

			arg_2_0.nodeDict[iter_2_1.nodeId] = var_2_0

			if var_2_0:isRootNode() then
				arg_2_0.rootNode = var_2_0
			end

			if iter_2_1.nodeGroup ~= 0 then
				if arg_2_0.nodeGroupDict[iter_2_1.nodeGroup] == nil then
					arg_2_0.nodeGroupDict[iter_2_1.nodeGroup] = {}
				end

				table.insert(arg_2_0.nodeGroupDict[iter_2_1.nodeGroup], iter_2_1.nodeId)
			end

			arg_2_0.talentCount = arg_2_0.talentCount + 1
		end

		for iter_2_2, iter_2_3 in pairs(arg_2_2) do
			arg_2_0:setNodeParentAndChild(iter_2_3)
		end
	end
end

function var_0_0.makeNode(arg_3_0, arg_3_1)
	local var_3_0 = TowerTalentTreeNode.New()

	var_3_0:init(arg_3_1, arg_3_0)

	return var_3_0
end

function var_0_0.setNodeParentAndChild(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getNode(arg_4_1.nodeId)
	local var_4_1

	if var_4_0.isOr then
		var_4_1 = string.splitToNumber(arg_4_1.preNodeIds, "#")
	else
		var_4_1 = string.splitToNumber(arg_4_1.preNodeIds, "&")
	end

	if var_4_1 then
		for iter_4_0, iter_4_1 in pairs(var_4_1) do
			local var_4_2 = arg_4_0:getNode(iter_4_1)

			if var_4_2 then
				var_4_0:setParent(var_4_2)
				var_4_2:setChild(var_4_0)
			end
		end
	end
end

function var_0_0.getNode(arg_5_0, arg_5_1)
	return arg_5_0.nodeDict[arg_5_1]
end

function var_0_0.isActiveTalent(arg_6_0, arg_6_1)
	return arg_6_0.bossMo:isActiveTalent(arg_6_1)
end

function var_0_0.isActiveGroup(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.nodeGroupDict[arg_7_1]
	local var_7_1 = false
	local var_7_2

	if var_7_0 then
		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if arg_7_0:isActiveTalent(iter_7_1) then
				var_7_1 = true
				var_7_2 = iter_7_1

				break
			end
		end
	end

	return var_7_1, var_7_2
end

function var_0_0.getTalentPoint(arg_8_0)
	return arg_8_0.bossMo:getTalentPoint()
end

function var_0_0.getList(arg_9_0)
	if not arg_9_0.nodeList then
		arg_9_0.nodeList = {}

		for iter_9_0, iter_9_1 in pairs(arg_9_0.nodeDict) do
			table.insert(arg_9_0.nodeList, iter_9_1)
		end

		if #arg_9_0.nodeList > 1 then
			table.sort(arg_9_0.nodeList, SortUtil.keyLower("nodeId"))
		end
	end

	return arg_9_0.nodeList
end

function var_0_0.hasTalentCanActive(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.nodeDict) do
		if iter_10_1:isTalentCanActive() then
			return true
		end
	end

	return false
end

function var_0_0.getActiveTalentList(arg_11_0)
	local var_11_0 = arg_11_0:getList()
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if iter_11_1:isActiveTalent() then
			table.insert(var_11_1, iter_11_1)
		end
	end

	return var_11_1
end

return var_0_0

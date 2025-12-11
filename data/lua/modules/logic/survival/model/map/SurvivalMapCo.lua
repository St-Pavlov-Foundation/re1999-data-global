module("modules.logic.survival.model.map.SurvivalMapCo", package.seeall)

local var_0_0 = pureTable("SurvivalMapCo")
local var_0_1 = math.sqrt(3)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.allBlocks = {}
	arg_1_0.allPaths = arg_1_1[2]
	arg_1_0.rawWalkables = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[1]) do
		local var_1_0 = SurvivalBlockCo.New()

		var_1_0:init(iter_1_1, arg_1_0.allPaths)
		table.insert(arg_1_0.allBlocks, var_1_0)
		SurvivalHelper.instance:addNodeToDict(arg_1_0.rawWalkables, var_1_0.pos)

		arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY = var_1_0:getRange(arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY)
	end

	if not arg_1_0.minX then
		arg_1_0.minX, arg_1_0.maxX, arg_1_0.minY, arg_1_0.maxY = 0, 0, 0, 0
	end

	arg_1_0.minX = arg_1_0.minX * var_0_1 / 2
	arg_1_0.maxX = arg_1_0.maxX * var_0_1 / 2
	arg_1_0.minY = arg_1_0.minY * 3 / 4
	arg_1_0.maxY = arg_1_0.maxY * 3 / 4
	arg_1_0.allHightValueNode = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1[3]) do
		table.insert(arg_1_0.allHightValueNode, SurvivalHexNode.New(iter_1_3[1], iter_1_3[2]))
	end

	if arg_1_1[4] then
		arg_1_0.exitPos = SurvivalHexNode.New(arg_1_1[4][1], arg_1_1[4][2])
	else
		arg_1_0.exitPos = SurvivalHexNode.New()
	end

	arg_1_0:resetWalkables()
end

function var_0_0.resetWalkables(arg_2_0)
	arg_2_0.walkables = LuaUtil.deepCopySimple(arg_2_0.rawWalkables)
end

function var_0_0.setWalkByUnitMo(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		SurvivalHelper.instance:addNodeToDict(arg_3_0.walkables, arg_3_1.pos)
	else
		SurvivalHelper.instance:removeNodeToDict(arg_3_0.walkables, arg_3_1.pos)
	end

	if arg_3_1.exPoints then
		if arg_3_2 then
			for iter_3_0, iter_3_1 in pairs(arg_3_1.exPoints) do
				SurvivalHelper.instance:addNodeToDict(arg_3_0.walkables, iter_3_1)
			end
		else
			for iter_3_2, iter_3_3 in pairs(arg_3_1.exPoints) do
				SurvivalHelper.instance:removeNodeToDict(arg_3_0.walkables, iter_3_3)
			end
		end
	end
end

return var_0_0

module("modules.logic.survival.model.shelter.SurvivalShelterBuildingCo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterBuildingCo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.ponitRange = {}
	arg_1_0.pointRangeList = {}
	arg_1_0.pos = SurvivalHexNode.New(arg_1_1[1], arg_1_1[2])
	arg_1_0.id = arg_1_1[3]
	arg_1_0.cfgId = arg_1_1[4]
	arg_1_0.dir = arg_1_1[5]
	arg_1_0.assetPath = arg_1_2[arg_1_1[6]]
	arg_1_0.exPoints = {}

	if arg_1_1[7] then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1[7]) do
			local var_1_0 = SurvivalHexNode.New(iter_1_1[1], iter_1_1[2])

			table.insert(arg_1_0.exPoints, var_1_0)
			table.insert(arg_1_0.pointRangeList, var_1_0)
			SurvivalHelper.instance:addNodeToDict(arg_1_0.ponitRange, var_1_0)
		end
	end

	SurvivalHelper.instance:addNodeToDict(arg_1_0.ponitRange, arg_1_0.pos)
	table.insert(arg_1_0.pointRangeList, arg_1_0.pos)
end

function var_0_0.isInRange(arg_2_0, arg_2_1)
	return SurvivalHelper.instance:isHaveNode(arg_2_0.ponitRange, arg_2_1)
end

return var_0_0

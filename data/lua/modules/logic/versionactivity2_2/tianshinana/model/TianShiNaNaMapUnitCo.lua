module("modules.logic.versionactivity2_2.tianshinana.model.TianShiNaNaMapUnitCo", package.seeall)

local var_0_0 = pureTable("TianShiNaNaMapUnitCo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1[1]
	arg_1_0.unitType = arg_1_1[2]
	arg_1_0.x = arg_1_1[3]
	arg_1_0.y = arg_1_1[4]
	arg_1_0.unitPath = arg_1_1[5]
	arg_1_0.offset = Vector3(arg_1_1[6][1], arg_1_1[6][2], arg_1_1[6][3])
	arg_1_0.specialData = arg_1_1[7]
	arg_1_0.dir = arg_1_1[8]
	arg_1_0.walkable = arg_1_1[9]
	arg_1_0.effects = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1[10]) do
		table.insert(arg_1_0.effects, {
			type = iter_1_1[1],
			param = iter_1_1[2]
		})
	end
end

return var_0_0

module("modules.logic.explore.model.mo.unit.ExploreMapAreaMO", package.seeall)

local var_0_0 = pureTable("ExploreMapAreaMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1[1]
	arg_1_0._unitData = arg_1_1[2]
	arg_1_0.isCanReset = arg_1_1[3]
	arg_1_0.visible = ExploreModel.instance:isAreaShow(arg_1_0.id)
	arg_1_0.unitList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._unitData) do
		local var_1_0 = iter_1_1[1]

		if ExploreModel.instance:hasInteractInfo(var_1_0) then
			local var_1_1 = ExploreMapModel.instance:createUnitMO(iter_1_1)

			if var_1_1 then
				table.insert(arg_1_0.unitList, var_1_1)
			end
		end
	end
end

return var_0_0

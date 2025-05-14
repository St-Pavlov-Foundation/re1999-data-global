module("modules.logic.explore.model.mo.unit.ExploreArchiveUnitMO", package.seeall)

local var_0_0 = class("ExploreArchiveUnitMO", ExploreBaseUnitMO)

function var_0_0.initTypeData(arg_1_0)
	arg_1_0.archiveId = tonumber(arg_1_0.specialDatas[1])
	arg_1_0.triggerEffects = tabletool.copy(arg_1_0.triggerEffects)

	local var_1_0 = {
		ExploreEnum.TriggerEvent.OpenArchiveView
	}
	local var_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.triggerEffects) do
		if iter_1_1[1] == ExploreEnum.TriggerEvent.Dialogue then
			var_1_1 = iter_1_0

			break
		end
	end

	if var_1_1 then
		table.insert(arg_1_0.triggerEffects, var_1_1 + 1, var_1_0)
	else
		table.insert(arg_1_0.triggerEffects, 1, var_1_0)
	end
end

return var_0_0

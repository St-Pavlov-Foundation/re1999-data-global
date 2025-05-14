module("modules.logic.fight.entity.pool.FightSpineMatPool", package.seeall)

local var_0_0 = class("FightSpineMatPool")
local var_0_1 = 10
local var_0_2 = {}

function var_0_0.getMat(arg_1_0)
	local var_1_0 = var_0_2[arg_1_0]

	if not var_1_0 then
		var_1_0 = {}
		var_0_2[arg_1_0] = var_1_0
	end

	if #var_1_0 > 0 then
		return table.remove(var_1_0, #var_1_0)
	else
		local var_1_1 = ResUrl.getRoleSpineMat(arg_1_0)
		local var_1_2 = FightHelper.getPreloadAssetItem(var_1_1)

		if var_1_2 then
			local var_1_3 = var_1_2:GetResource()

			if var_1_3 then
				return UnityEngine.Object.Instantiate(var_1_3)
			end
		end
	end

	logError("Material has not preload: " .. arg_1_0)
end

function var_0_0.returnMat(arg_2_0, arg_2_1)
	local var_2_0 = var_0_2[arg_2_0]

	if not var_2_0 then
		var_2_0 = {}
		var_0_2[arg_2_0] = var_2_0
	end

	if #var_2_0 > var_0_1 then
		gohelper.destroy(arg_2_1)
	else
		table.insert(var_2_0, arg_2_1)
	end
end

function var_0_0.dispose()
	for iter_3_0, iter_3_1 in pairs(var_0_2) do
		for iter_3_2, iter_3_3 in ipairs(iter_3_1) do
			gohelper.destroy(iter_3_3)
		end
	end

	var_0_2 = {}
end

return var_0_0

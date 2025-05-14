module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRevivalPrepareListModel", package.seeall)

local var_0_0 = class("V1a6_CachotRoleRevivalPrepareListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.initList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = V1a6_CachotModel.instance:getTeamInfo()

	for iter_3_0, iter_3_1 in ipairs(var_3_1.lifes) do
		if iter_3_1.life <= 0 then
			local var_3_2 = HeroModel.instance:getByHeroId(iter_3_1.heroId)
			local var_3_3 = HeroSingleGroupMO.New()

			var_3_3.heroUid = var_3_2.uid

			table.insert(var_3_0, var_3_3)
		end
	end

	arg_3_0:setList(var_3_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0

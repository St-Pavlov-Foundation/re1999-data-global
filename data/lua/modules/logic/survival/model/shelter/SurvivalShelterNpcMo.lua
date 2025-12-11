module("modules.logic.survival.model.shelter.SurvivalShelterNpcMo", package.seeall)

local var_0_0 = pureTable("SurvivalShelterNpcMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.status = arg_1_1.status
	arg_1_0.co = SurvivalConfig.instance:getNpcConfig(arg_1_0.id)
end

function var_0_0.sort(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = arg_2_0:getShelterNpcStatus()
	local var_2_2, var_2_3 = arg_2_1:getShelterNpcStatus()

	if var_2_0 ~= var_2_2 then
		return var_2_0 < var_2_2
	end

	if var_2_1 and var_2_3 and var_2_1 ~= var_2_3 then
		return var_2_1 < var_2_3
	end

	return arg_2_0.id < arg_2_1.id
end

function var_0_0.getShelterNpcStatus(arg_3_0)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_3_1 = var_3_0:getNpcPostion(arg_3_0.id)

	if var_3_1 then
		local var_3_2 = var_3_0:getBuildingInfo(var_3_1)

		if var_3_2 and var_3_2:isDestoryed() then
			return SurvivalEnum.ShelterNpcStatus.InDestoryBuild
		else
			return SurvivalEnum.ShelterNpcStatus.InBuild, var_3_1
		end
	else
		return SurvivalEnum.ShelterNpcStatus.NotInBuild
	end
end

function var_0_0.isEqualStatus(arg_4_0, arg_4_1)
	return arg_4_0:getShelterNpcStatus() == arg_4_1
end

function var_0_0.isRecommend(arg_5_0, arg_5_1)
	local var_5_0 = lua_survival_map_group_mapping.configDict[arg_5_1].id
	local var_5_1 = lua_survival_map_group.configDict[var_5_0].type
	local var_5_2 = SurvivalConfig.instance:getNpcConfigTag(arg_5_0.co.id)

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		local var_5_3 = SurvivalConfig:getTagCo(iter_5_1)

		if not string.nilorempty(var_5_3.suggestMap) then
			local var_5_4 = string.splitToNumber(var_5_3.suggestMap, "#")

			for iter_5_2, iter_5_3 in ipairs(var_5_4) do
				if iter_5_3 == var_5_1 then
					return true
				end
			end
		end
	end

	return false
end

return var_0_0

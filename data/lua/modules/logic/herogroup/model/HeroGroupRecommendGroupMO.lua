module("modules.logic.herogroup.model.HeroGroupRecommendGroupMO", package.seeall)

local var_0_0 = pureTable("HeroGroupRecommendGroupMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if not arg_1_1 or not arg_1_1.rate then
		arg_1_0.isEmpty = true

		return
	end

	arg_1_0.heroIdList = {}
	arg_1_0.levels = {}
	arg_1_0.heroDataList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.heroIds) do
		if iter_1_1 > 0 then
			local var_1_0 = {
				heroId = iter_1_1,
				level = arg_1_1.levels[iter_1_0]
			}

			table.insert(arg_1_0.heroDataList, var_1_0)
		end
	end

	arg_1_0.aidDict = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.subHeroIds) do
		if iter_1_3 > 0 then
			local var_1_1 = {
				heroId = iter_1_3,
				level = arg_1_1.levels[#arg_1_1.heroIds + iter_1_2]
			}

			table.insert(arg_1_0.heroDataList, var_1_1)

			arg_1_0.aidDict[iter_1_3] = true
		end
	end

	arg_1_0.cloth = arg_1_1.cloth
	arg_1_0.rate = arg_1_1.rate
	arg_1_0.assistBossId = arg_1_1.assistBossId
end

return var_0_0

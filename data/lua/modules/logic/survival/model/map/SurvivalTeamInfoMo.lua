module("modules.logic.survival.model.map.SurvivalTeamInfoMo", package.seeall)

local var_0_0 = pureTable("SurvivalTeamInfoMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.heros = {}
	arg_1_0.heroUids = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hero) do
		arg_1_0.heroUids[iter_1_1.uid] = true

		table.insert(arg_1_0.heros, iter_1_1.uid)
	end

	arg_1_0.npcId = arg_1_1.npcId
end

function var_0_0.getHeroMo(arg_2_0, arg_2_1)
	if not arg_2_0.heroUids[arg_2_1] then
		return
	end

	return HeroModel.instance:getById(arg_2_1)
end

return var_0_0

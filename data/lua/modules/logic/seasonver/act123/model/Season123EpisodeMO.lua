module("modules.logic.seasonver.act123.model.Season123EpisodeMO", package.seeall)

local var_0_0 = pureTable("Season123EpisodeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.state = arg_1_1.state or 0
	arg_1_0.round = arg_1_1.round or 0
	arg_1_0.effectMainCelebrityEquipIds = arg_1_1.effectMainCelebrityEquipIds or {}

	arg_1_0:initHeroes(arg_1_1.heroInfos)
end

function var_0_0.update(arg_2_0, arg_2_1)
	arg_2_0.state = arg_2_1.state
	arg_2_0.round = arg_2_1.round
	arg_2_0.effectMainCelebrityEquipIds = arg_2_1.effectMainCelebrityEquipIds

	arg_2_0:updateHeroes(arg_2_1.heroInfos)
end

function var_0_0.isFinished(arg_3_0)
	return arg_3_0.state == 1
end

function var_0_0.initHeroes(arg_4_0, arg_4_1)
	arg_4_0.heroes = {}
	arg_4_0.heroesMap = {}

	if not arg_4_1 then
		return
	end

	for iter_4_0 = 1, #arg_4_1 do
		local var_4_0 = arg_4_1[iter_4_0]
		local var_4_1 = Season123HeroMO.New()

		var_4_1:init(var_4_0)
		table.insert(arg_4_0.heroes, var_4_1)

		arg_4_0.heroesMap[var_4_1.heroUid] = var_4_1
	end
end

function var_0_0.updateHeroes(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return
	end

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_0 = arg_5_1[iter_5_0]
		local var_5_1 = arg_5_0.heroesMap[var_5_0.heroUid]

		if not var_5_1 then
			var_5_1 = Season123HeroMO.New()

			var_5_1:init(var_5_0)
			table.insert(arg_5_0.heroes, var_5_1)

			arg_5_0.heroesMap[var_5_1.heroUid] = var_5_1
		else
			var_5_1:update(var_5_0)
		end
	end
end

return var_0_0

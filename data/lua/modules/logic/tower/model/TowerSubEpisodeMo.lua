module("modules.logic.tower.model.TowerSubEpisodeMo", package.seeall)

local var_0_0 = pureTable("TowerSubEpisodeMo")

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.status = arg_1_1.status
	arg_1_0.heros = arg_1_1.heros
	arg_1_0.assistBossId = arg_1_1.assistBossId
	arg_1_0.heroIds = {}
	arg_1_0.equipUids = {}
	arg_1_0.trialHeroIds = {}

	if arg_1_0.heros then
		for iter_1_0 = 1, #arg_1_0.heros do
			local var_1_0 = arg_1_0.heros[iter_1_0]

			arg_1_0.heroIds[iter_1_0] = var_1_0 and var_1_0.heroId or 0
			arg_1_0.trialHeroIds[iter_1_0] = var_1_0 and var_1_0.trialId or 0

			if var_1_0 and var_1_0.equipUid and #var_1_0.equipUid > 0 then
				arg_1_0.equipUids[iter_1_0] = {}

				for iter_1_1 = 1, #var_1_0.equipUid do
					table.insert(arg_1_0.equipUids[iter_1_0], var_1_0.equipUid[iter_1_1])
				end
			end
		end
	end
end

function var_0_0.getHeros(arg_2_0, arg_2_1)
	if arg_2_0.status == 1 and arg_2_0.heroIds then
		for iter_2_0 = 1, #arg_2_0.heroIds do
			arg_2_1[arg_2_0.heroIds[iter_2_0]] = 1
		end
	end
end

function var_0_0.getAssistBossId(arg_3_0, arg_3_1)
	if arg_3_0.status == 1 and arg_3_0.assistBossId then
		arg_3_1[arg_3_0.assistBossId] = 1
	end
end

function var_0_0.getTrialHeros(arg_4_0, arg_4_1)
	if arg_4_0.status == 1 and arg_4_0.trialHeroIds then
		for iter_4_0 = 1, #arg_4_0.trialHeroIds do
			arg_4_1[arg_4_0.trialHeroIds[iter_4_0]] = 1
		end
	end
end

return var_0_0

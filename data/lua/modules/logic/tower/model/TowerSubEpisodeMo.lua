module("modules.logic.tower.model.TowerSubEpisodeMo", package.seeall)

local var_0_0 = pureTable("TowerSubEpisodeMo")

function var_0_0.updateInfo(arg_1_0, arg_1_1)
	arg_1_0.episodeId = arg_1_1.episodeId
	arg_1_0.status = arg_1_1.status
	arg_1_0.heroIds = arg_1_1.heroIds
	arg_1_0.assistBossId = arg_1_1.assistBossId
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

return var_0_0

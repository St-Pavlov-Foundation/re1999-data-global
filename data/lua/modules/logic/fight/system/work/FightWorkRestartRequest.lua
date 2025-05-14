module("modules.logic.fight.system.work.FightWorkRestartRequest", package.seeall)

local var_0_0 = class("FightWorkRestartRequest", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._fightParam = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.episode_config = arg_2_0._fightParam:getCurEpisodeConfig()
	arg_2_0.chapter_config = DungeonConfig.instance:getChapterCO(arg_2_0.episode_config.chapterId)

	local var_2_0 = arg_2_0.chapter_config.type
	local var_2_1 = _G["FightRestartRequestType" .. var_2_0] or _G["FightRestartRequestType" .. (FightRestartSequence.RestartType2Type[var_2_0] or var_2_0)]

	if var_2_1 then
		arg_2_0._request_class = var_2_1.New(arg_2_0, arg_2_0._fightParam, arg_2_0.episode_config, arg_2_0.chapter_config)

		if arg_2_0._request_class.requestFight then
			arg_2_0._request_class:requestFight()
		else
			FightSystem.instance:cancelRestart()
		end
	else
		FightSystem.instance:cancelRestart()
	end
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._request_class then
		arg_3_0._request_class:releaseSelf()

		arg_3_0._request_class = nil
	end
end

return var_0_0

module("modules.logic.fight.system.work.FightWorkRestartAbandon", package.seeall)

local var_0_0 = class("FightWorkRestartAbandon", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._fightParam = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.episode_config = arg_2_0._fightParam:getCurEpisodeConfig()
	arg_2_0.chapter_config = DungeonConfig.instance:getChapterCO(arg_2_0.episode_config.chapterId)

	local var_2_0 = arg_2_0.chapter_config.type
	local var_2_1 = _G["FightRestartAbandonType" .. var_2_0] or _G["FightRestartAbandonType" .. (FightRestartSequence.RestartType2Type[var_2_0] or var_2_0)]

	if var_2_1 then
		arg_2_0._abandon_class = var_2_1.New(arg_2_0, arg_2_0._fightParam, arg_2_0.episode_config, arg_2_0.chapter_config)

		if arg_2_0._abandon_class:canRestart() then
			arg_2_0._abandon_class:abandon()
		else
			FightSystem.instance:cancelRestart()
		end
	else
		FightSystem.instance:cancelRestart()
	end
end

function var_0_0.clearWork(arg_3_0)
	if arg_3_0._abandon_class then
		arg_3_0._abandon_class:releaseEvent()
		arg_3_0._abandon_class:releaseSelf()

		arg_3_0._abandon_class = nil
	end
end

return var_0_0

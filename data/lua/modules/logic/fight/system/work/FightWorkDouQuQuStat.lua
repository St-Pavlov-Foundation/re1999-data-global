module("modules.logic.fight.system.work.FightWorkDouQuQuStat", package.seeall)

local var_0_0 = class("FightWorkDouQuQuStat", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataModel.instance.douQuQuMgr

	if var_1_0.isRecord then
		arg_1_0:onDone(true)

		return
	end

	local var_1_1 = {
		[StatEnum.EventProperties.DouQuQuFightActivityId] = tostring(Activity174Model.instance:getCurActId() or 12304),
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - var_0_0.startTime,
		[StatEnum.EventProperties.DouQuQuFightTotalRound] = var_1_0.round or -1,
		[StatEnum.EventProperties.DouQuQuFightResult] = var_1_0.param.win[var_1_0.index] and "成功" or "失败",
		[StatEnum.EventProperties.DouQuQuFightPlayerTeamInfo] = {},
		[StatEnum.EventProperties.DouQuQuFightEnemyTeamInfo] = {}
	}

	arg_1_0:_setTeamData(var_1_1[StatEnum.EventProperties.DouQuQuFightPlayerTeamInfo], var_1_0.param.player[var_1_0.index])
	arg_1_0:_setTeamData(var_1_1[StatEnum.EventProperties.DouQuQuFightEnemyTeamInfo], var_1_0.param.enemy[var_1_0.index])
	StatController.instance:track(StatEnum.EventName.DouQuQuFight, var_1_1)
	arg_1_0:onDone(true)
end

function var_0_0._setTeamData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = FightDataModel.instance.douQuQuMgr.index

	for iter_2_0, iter_2_1 in ipairs(arg_2_2.battleHeroInfo) do
		local var_2_1 = {
			team_id = var_2_0,
			hero = iter_2_1.heroId,
			item = iter_2_1.itemId,
			skill = iter_2_1.priorSkill
		}

		table.insert(arg_2_1, var_2_1)
	end
end

return var_0_0

module("modules.logic.fight.view.indicator.FightIndicatorMgrView", package.seeall)

local var_0_0 = class("FightIndicatorMgrView", BaseView)

var_0_0.IndicatorId2Behaviour = {
	[FightEnum.IndicatorId.Season] = FightIndicatorView,
	[FightEnum.IndicatorId.FightSucc] = FightSuccIndicator,
	[FightEnum.IndicatorId.Season1_2] = FightIndicatorView,
	[FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips] = V1a4_BossRush_ig_ScoreTips,
	[FightEnum.IndicatorId.Id4140004] = FightIndicatorView4140004,
	[FightEnum.IndicatorId.Act1_6DungeonBoss] = VersionActivity1_6_BossFightIndicatorView,
	[FightEnum.IndicatorId.Id6181] = FightIndicatorView6181,
	[FightEnum.IndicatorId.Id6182] = FightIndicatorView6182,
	[FightEnum.IndicatorId.Id6201] = FightIndicatorView6201,
	[FightEnum.IndicatorId.Id6202] = FightIndicatorView6202
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0.indicatorId2View = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnIndicatorChange, arg_2_0.onIndicatorChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnIndicatorChange, arg_3_0.onIndicatorChange, arg_3_0)
end

function var_0_0.checkNeedInitFightSuccIndicator(arg_4_0)
	local var_4_0 = 8
	local var_4_1 = FightModel.instance:getFightParam()
	local var_4_2 = var_4_1 and var_4_1.episodeId
	local var_4_3

	var_4_3 = var_4_2 and DungeonConfig.instance:getEpisodeCO(var_4_2)

	local var_4_4 = var_4_2 and DungeonConfig.instance:getEpisodeCondition(var_4_2)
	local var_4_5 = var_4_4 and FightStrUtil.instance:getSplitString2Cache(var_4_4, false, "|", "#")

	if BossRushController.instance:isInBossRushFight() then
		arg_4_0:createBehaviour(FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips, 0)
	elseif VersionActivity1_6DungeonBossModel.instance:isInBossFight() then
		arg_4_0:createBehaviour(FightEnum.IndicatorId.Act1_6DungeonBoss, 0)
	end

	if var_4_5 then
		for iter_4_0, iter_4_1 in ipairs(var_4_5) do
			if tonumber(iter_4_1[1]) == var_4_0 then
				arg_4_0:createBehaviour(tonumber(iter_4_1[2]), tonumber(iter_4_1[3]) or 0)

				return
			end
		end
	end
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:checkNeedInitFightSuccIndicator()
end

function var_0_0.createBehaviour(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_0.IndicatorId2Behaviour[arg_6_1]
	local var_6_1

	if var_6_0 then
		var_6_1 = var_6_0.New()
		var_6_1.viewContainer = arg_6_0.viewContainer

		var_6_1:initView(arg_6_0, arg_6_1, arg_6_2)
		var_6_1:startLoadPrefab()

		arg_6_0.indicatorId2View[arg_6_1] = var_6_1
	else
		return nil
	end

	return var_6_1
end

function var_0_0.onIndicatorChange(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.indicatorId2View[arg_7_1] or arg_7_0:createBehaviour(arg_7_1)

	if var_7_0 then
		var_7_0:onIndicatorChange()
	end
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.indicatorId2View) do
		iter_8_1:onDestroy()
	end
end

return var_0_0

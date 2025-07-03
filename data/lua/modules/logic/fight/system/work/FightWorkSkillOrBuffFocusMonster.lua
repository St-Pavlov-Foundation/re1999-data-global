module("modules.logic.fight.system.work.FightWorkSkillOrBuffFocusMonster", package.seeall)

local var_0_0 = class("FightWorkSkillOrBuffFocusMonster", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.fightStepData = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0:isSkillFocus(arg_2_0.fightStepData)

	if var_2_0 then
		ViewMgr.instance:openView(ViewName.FightTechniqueGuideView, {
			entity = FightDataHelper.entityMgr:getById(var_2_0),
			config = arg_2_0.monster_guide_focus_config
		})
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.FightTechniqueGuideView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, FightWorkFocusMonster.EaseTime)
	end
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.isSkillFocus(arg_5_0, arg_5_1)
	local var_5_0 = FightModel.instance:getFightParam()
	local var_5_1 = FightHelper.getEntity(arg_5_1.fromId)

	if not var_5_1 or not var_5_1:getMO() then
		return
	end

	if FightReplayModel.instance:isReplay() then
		return
	end

	if DungeonModel.instance:hasPassLevel(var_5_0.episodeId) then
		return
	end

	if not lua_monster_guide_focus.configDict[var_5_0.episodeId] then
		return
	end

	local var_5_2 = FightConfig.instance:getMonsterGuideFocusConfig(var_5_0.episodeId, arg_5_1.actType, arg_5_1.actId, var_5_1:getMO().modelId)

	if not var_5_2 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.actEffect) do
			if iter_5_1.effectType == FightEnum.EffectType.BUFFADD then
				local var_5_3 = FightDataHelper.entityMgr:getById(iter_5_1.targetId)

				if var_5_3 then
					var_5_2 = FightConfig.instance:getMonsterGuideFocusConfig(var_5_0.episodeId, FightWorkFocusMonster.invokeType.Buff, iter_5_1.buff.buffId, var_5_3.modelId)

					if var_5_2 then
						break
					end
				end
			end
		end

		if not var_5_2 then
			return
		end
	end

	arg_5_0.monster_guide_focus_config = var_5_2

	local var_5_4 = var_0_0.getPlayerPrefKey(var_5_2)

	if PlayerPrefsHelper.hasKey(var_5_4) then
		return
	end

	return arg_5_1.fromId
end

function var_0_0.getPlayerPrefKey(arg_6_0)
	local var_6_0 = PlayerModel.instance:getPlayinfo()

	return string.format("%s_%s_%s_%s_%s_%s", PlayerPrefsKey.FightFocusSkillOrBuffMonster, var_6_0.userId, tostring(arg_6_0.id), tostring(arg_6_0.invokeType), tostring(arg_6_0.param), tostring(arg_6_0.monster))
end

function var_0_0.clearWork(arg_7_0)
	return
end

return var_0_0

module("modules.logic.fight.entity.comp.skill.FightTLEventSetSign", package.seeall)

local var_0_0 = class("FightTLEventSetSign", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.duration = arg_1_2
	arg_1_0.paramsArr = arg_1_3

	if arg_1_3[1] == "1" then
		arg_1_0.workTimelineItem.skipAfterTimelineFunc = true
	end

	local var_1_0 = arg_1_3[2]

	if not string.nilorempty(var_1_0) then
		local var_1_1 = string.split(var_1_0, "#")
		local var_1_2 = table.remove(var_1_1, 1)

		arg_1_0:com_sendFightEvent(FightEvent.SetBtnListVisibleWhenHidingFightView, var_1_2 == "show", var_1_1)
	end

	local var_1_3 = arg_1_3[3]

	if not string.nilorempty(var_1_3) then
		local var_1_4 = string.split(var_1_3, "#")
		local var_1_5 = var_1_4[1]
		local var_1_6 = var_1_4[2]

		if var_1_5 == "1" then
			local var_1_7 = arg_1_1.toId
			local var_1_8 = FightDataHelper.entityMgr:getById(var_1_7)
			local var_1_9 = FightHelper.checkIsBossByMonsterId(var_1_8.modelId)

			if lua_fight_assembled_monster.configDict[var_1_8.skin] then
				var_1_9 = true
			end

			if var_1_9 then
				arg_1_0:com_sendFightEvent(FightEvent.SetBossHpVisibleWhenHidingFightView, var_1_6 == "show")
			end
		end
	end

	local var_1_10 = arg_1_3[4]

	if not string.nilorempty(var_1_10) then
		FightDataHelper.tempMgr.hideNameUIByTimeline = var_1_10 == "hide"
	end

	if arg_1_3[5] == "1" then
		arg_1_1.forceShowDamageTotalFloat = true
	end

	local var_1_11 = arg_1_3[6]

	if var_1_11 == "aiJiAoQteStart" then
		FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	elseif var_1_11 == "aiJiAoQteEnd" then
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AiJiAoQteIng)
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	if arg_2_0.workTimelineItem.skipAfterTimelineFunc then
		local var_2_0 = FightSkillMgr.instance

		var_2_0._playingSkillCount = var_2_0._playingSkillCount - 1

		if var_2_0._playingSkillCount < 0 then
			var_2_0._playingSkillCount = 0
		end

		var_2_0._playingEntityId2StepData[arg_2_0.fightStepData.fromId] = nil
	end
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0

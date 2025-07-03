module("modules.logic.fight.system.work.FightWorkPlayEffectTimelineByOperation", package.seeall)

local var_0_0 = class("FightWorkPlayEffectTimelineByOperation", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.actEffectData = arg_1_1
	arg_1_0.param = arg_1_2
	arg_1_0.originFightStepData = arg_1_3
	arg_1_0.SAFETIME = 30
	arg_1_0.timelineDic = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_2_0._onSkillPlayFinish, LuaEventSystem.Low)
end

function var_0_0._onSkillPlayFinish(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_3 == arg_3_0.fightStepData then
		arg_3_0:onDone(true)
	end
end

function var_0_0.sortTimelineDic(arg_4_0, arg_4_1, arg_4_2)
	return arg_4_1.count < arg_4_2.count
end

function var_0_0.playTimeline(arg_5_0)
	if arg_5_0.played then
		return
	end

	arg_5_0.played = true

	local var_5_0 = {
		actId = 0,
		actEffect = {
			arg_5_0.actEffectData
		},
		fromId = arg_5_0.originFightStepData.fromId,
		toId = arg_5_0.actEffectData.targetId,
		actType = FightEnum.ActType.SKILL,
		stepUid = FightTLEventEntityVisible.latestStepUid or 0
	}
	local var_5_1 = (arg_5_0.param.count or 0) + 1

	arg_5_0.param.count = var_5_1

	local var_5_2 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_0.timelineDic) do
		table.insert(var_5_2, {
			count = iter_5_0,
			timelineList = iter_5_1
		})
	end

	table.sort(var_5_2, var_0_0.sortTimelineDic)

	local var_5_3

	for iter_5_2, iter_5_3 in ipairs(var_5_2) do
		if var_5_1 <= iter_5_3.count and #iter_5_3.timelineList > 0 then
			var_5_3 = iter_5_3.timelineList[math.random(1, #iter_5_3.timelineList)]
		end
	end

	if not var_5_3 then
		arg_5_0:onDone(true)

		return
	end

	local var_5_4 = FightHelper.getEntity("0")

	if not var_5_4 then
		arg_5_0:onDone(true)

		return
	end

	arg_5_0.fightStepData = var_5_0
	var_5_0.playerOperationCountForPlayEffectTimeline = var_5_1

	local var_5_5 = var_5_4.skill:registTimelineWork(var_5_3, var_5_0)

	var_5_5.skipAfterTimelineFunc = true

	var_5_5:start()
end

return var_0_0

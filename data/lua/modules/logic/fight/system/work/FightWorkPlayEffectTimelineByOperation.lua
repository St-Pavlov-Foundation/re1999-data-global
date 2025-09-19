module("modules.logic.fight.system.work.FightWorkPlayEffectTimelineByOperation", package.seeall)

local var_0_0 = class("FightWorkPlayEffectTimelineByOperation", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.actEffectData = arg_1_1
	arg_1_0.param = arg_1_2
	arg_1_0.originFightStepData = arg_1_3
	arg_1_0.SAFETIME = 300
	arg_1_0.timelineDic = arg_1_4
	arg_1_0.timelineOriginDic = arg_1_5
end

function var_0_0.onStart(arg_2_0)
	return
end

function var_0_0.sortTimelineDic(arg_3_0, arg_3_1)
	return arg_3_0.count < arg_3_1.count
end

function var_0_0.playTimeline(arg_4_0)
	if arg_4_0.played then
		return
	end

	arg_4_0.played = true

	local var_4_0 = {
		actId = 0,
		actEffect = {
			arg_4_0.actEffectData
		},
		fromId = arg_4_0.originFightStepData.fromId,
		toId = arg_4_0.actEffectData.targetId,
		actType = FightEnum.ActType.SKILL,
		stepUid = FightTLEventEntityVisible.latestStepUid or 0
	}
	local var_4_1 = (arg_4_0.param.count or 0) + 1

	arg_4_0.param.count = var_4_1

	local var_4_2 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0.timelineDic) do
		table.insert(var_4_2, {
			count = iter_4_0,
			timelineList = iter_4_1
		})
	end

	table.sort(var_4_2, var_0_0.sortTimelineDic)

	local var_4_3

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		if var_4_1 <= iter_4_3.count then
			local var_4_4 = iter_4_3.timelineList

			if #var_4_4 == 0 then
				var_4_4 = FightDataUtil.coverData(arg_4_0.timelineOriginDic[iter_4_3.count], arg_4_0.timelineDic[iter_4_3.count])
			end

			local var_4_5 = math.random(1, #var_4_4)

			var_4_3 = var_4_4[var_4_5]

			table.remove(var_4_4, var_4_5)

			break
		end
	end

	if not var_4_3 then
		arg_4_0:onDone(true)

		return
	end

	local var_4_6 = FightHelper.getEntity("0")

	if not var_4_6 then
		arg_4_0:onDone(true)

		return
	end

	arg_4_0.fightStepData = var_4_0
	var_4_0.playerOperationCountForPlayEffectTimeline = var_4_1
	var_4_0.maxPlayerOperationCountForPlayEffectTimeline = arg_4_0.originFightStepData.maxPlayerOperationCountForPlayEffectTimeline
	arg_4_0.originFightStepData.playerOperationCountForPlayEffectTimeline = var_4_1

	local var_4_7 = var_4_6.skill:registTimelineWork(var_4_3, var_4_0)

	var_4_7.skipAfterTimelineFunc = true

	var_4_7:registFinishCallback(arg_4_0.onTimelineFinish, arg_4_0)
	var_4_7:start()
end

function var_0_0.onTimelineFinish(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.onDestructor(arg_6_0)
	local var_6_0 = FightSkillMgr.instance

	var_6_0._playingSkillCount = var_6_0._playingSkillCount - 1

	if var_6_0._playingSkillCount < 0 then
		var_6_0._playingSkillCount = 0
	end

	var_6_0._playingEntityId2StepData["0"] = nil
end

return var_0_0

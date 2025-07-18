﻿module("modules.logic.fight.system.work.FightWorkTimelineItem", package.seeall)

local var_0_0 = class("FightWorkTimelineItem", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.entity = arg_1_1
	arg_1_0.timelineName = arg_1_2
	arg_1_0.fightStepData = arg_1_3
	arg_1_0.skillId = arg_1_0.fightStepData.actId
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightHelper.getRolesTimelinePath(arg_2_0.timelineName)

	arg_2_0.timelineUrl = ResUrl.getSkillTimeline(arg_2_0.timelineName)

	arg_2_0:com_loadAsset(var_2_0, arg_2_0.onTimelineLoaded, arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()
end

function var_0_0.onTimelineLoaded(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_1 then
		logError("timeline资源加载失败,路径:" .. arg_3_0.timelineUrl)
		arg_3_0:onDone(true)

		return
	end

	arg_3_0.assetLoader = arg_3_2

	FightHelper.logForPCSkillEditor("播放timeline:" .. arg_3_0.timelineName)
	arg_3_0:startTimeline()
end

function var_0_0.dealSpeed(arg_4_0)
	FightHelper.setBossSkillSpeed(arg_4_0.entity.id)
	FightHelper.setTimelineExclusiveSpeed(arg_4_0.timelineName)
	FightModel.instance:updateRTPCSpeed()
end

function var_0_0.startTimeline(arg_5_0)
	arg_5_0:dealSpeed()

	arg_5_0._startTime = Time.time

	arg_5_0:beforePlayTimeline()

	arg_5_0.timelineItem = arg_5_0:newClass(FightSkillTimelineItem, arg_5_0)

	arg_5_0.timelineItem:play()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkill, arg_5_0.entity, arg_5_0.skillId, arg_5_0.fightStepData, arg_5_0.timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayStart, arg_5_0.entity, arg_5_0.skillId, arg_5_0.fightStepData, arg_5_0.timelineName)
end

function var_0_0.sameSkillPlaying(arg_6_0)
	return false
end

function var_0_0.onUpdate(arg_7_0)
	if arg_7_0.timelineItem then
		arg_7_0.timelineItem:onUpdate()
	end
end

function var_0_0.setTimeScale(arg_8_0, arg_8_1)
	if arg_8_0.timelineItem then
		arg_8_0.timelineItem:setTimeScale(arg_8_1)
	end
end

function var_0_0.getBinder(arg_9_0)
	return arg_9_0.timelineItem and arg_9_0.timelineItem.binder
end

function var_0_0.skipSkill(arg_10_0)
	arg_10_0.timelineItem:skipSkill()
	arg_10_0.timelineItem:onTimelineEnd()
end

function var_0_0.onTimelineFinish(arg_11_0)
	if not arg_11_0.skipAfterTimelineFunc then
		arg_11_0:afterPlayTimeline()
	end

	CameraMgr.instance:getCameraShake():StopShake()
	FightHelper.cancelBossSkillSpeed()
	FightHelper.cancelExclusiveSpeed()
	FightModel.instance:updateRTPCSpeed()
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, arg_11_0.entity, arg_11_0.skillId, arg_11_0.fightStepData, arg_11_0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, arg_11_0.entity, arg_11_0.skillId, arg_11_0.fightStepData, arg_11_0._timelineName)

	if not arg_11_0.IS_DISPOSED then
		arg_11_0:onDone(true)
	end
end

function var_0_0.afterPlayTimeline(arg_12_0)
	FightSkillMgr.instance:afterTimeline(arg_12_0.entity, arg_12_0.fightStepData)
	arg_12_0:_resetTargetHp()

	if arg_12_0.timelineItem then
		arg_12_0:_checkFloatTable(arg_12_0.timelineItem.timelineContext.floatNum, "伤害")
		arg_12_0:_checkFloatTable(arg_12_0.timelineItem.timelineContext.healFloatNum, "回血")
	end

	if arg_12_0.entity.buff then
		arg_12_0.entity.buff:showBuffEffects("before_skill_timeline")
	end

	if arg_12_0._hide_defenders_buff_effect then
		FightHelper.revertDefenderBuffEffect(arg_12_0._hide_defenders_buff_effect, "before_skill_timeline")

		arg_12_0._hide_defenders_buff_effect = nil
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		FightFloatMgr.instance:resetInterval()
		arg_12_0:_cancelSideRenderOrder()
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)

		if arg_12_0.fightStepData.hasPlayTimelineCamera then
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end

		GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = true

		local var_12_0 = arg_12_0.entity:getMO()

		if var_12_0 and var_12_0:isPassiveSkill(arg_12_0.skillId) then
			-- block empty
		else
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
		end

		FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	end
end

function var_0_0.beforePlayTimeline(arg_13_0)
	arg_13_0:setSideRenderOrder()

	if arg_13_0.entity.buff then
		arg_13_0.entity.buff:hideLoopEffects("before_skill_timeline")
	end

	for iter_13_0, iter_13_1 in pairs(FightHelper.hideDefenderBuffEffect(arg_13_0.fightStepData, "before_skill_timeline")) do
		arg_13_0.hide_defenders_buff_effect = arg_13_0.hide_defenders_buff_effect or {}

		table.insert(arg_13_0.hide_defenders_buff_effect, iter_13_1)
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		if not arg_13_0.entity.skill:sameSkillPlaying() then
			FightFloatMgr.instance:removeInterval()
		end

		local var_13_0 = arg_13_0.entity:getMO()

		if var_13_0 and var_13_0:isPassiveSkill(arg_13_0.skillId) then
			-- block empty
		else
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(false)
		end
	end

	FightSkillMgr.instance:beforeTimeline(arg_13_0.entity, arg_13_0.fightStepData)
end

function var_0_0.setSideRenderOrder(arg_14_0)
	local var_14_0 = FightHelper.getSideEntitys(arg_14_0.entity:getSide(), true)
	local var_14_1 = FightModel.instance:getFightParam().battleId

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2
		local var_14_3 = FightEnum.AtkRenderOrderIgnore[var_14_1]

		if var_14_3 then
			local var_14_4 = var_14_3[iter_14_1:getSide()]

			if var_14_4 and tabletool.indexOf(var_14_4, iter_14_1:getMO().position) then
				var_14_2 = true
			end
		end

		if not var_14_2 then
			var_14_0[iter_14_0] = iter_14_1.id
		end
	end

	local var_14_5 = FightRenderOrderMgr.sortOrder(FightEnum.RenderOrderType.StandPos, var_14_0)

	for iter_14_2, iter_14_3 in pairs(var_14_5) do
		FightRenderOrderMgr.instance:setOrder(iter_14_2, FightEnum.TopOrderFactor + iter_14_3 - 1)
	end
end

function var_0_0._cancelSideRenderOrder(arg_15_0)
	local var_15_0 = FightHelper.getAllEntitys(arg_15_0.entity:getSide())

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		FightRenderOrderMgr.instance:cancelOrder(iter_15_1.id)
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

function var_0_0._resetTargetHp(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.fightStepData.actEffect) do
		local var_16_0 = FightHelper.getEntity(iter_16_1.targetId)

		if var_16_0 and var_16_0.nameUI then
			var_16_0.nameUI:resetHp()
		end
	end
end

function var_0_0._checkFloatTable(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_1 then
		return
	end

	if not isDebugBuild then
		return
	end

	if Time.timeScale > 1 then
		return
	end

	if FightModel.instance:getSpeed() > 1.5 then
		return
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		for iter_17_2, iter_17_3 in pairs(iter_17_1) do
			if math.abs(iter_17_3.ratio - 1) > 0.0001 then
				logError("技能" .. arg_17_2 .. "系数之和为" .. iter_17_3.ratio .. " " .. arg_17_0.timelineName)
			end

			return
		end
	end
end

function var_0_0.clearWork(arg_18_0)
	return
end

return var_0_0

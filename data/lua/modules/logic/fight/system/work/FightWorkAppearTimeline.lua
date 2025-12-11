module("modules.logic.fight.system.work.FightWorkAppearTimeline", package.seeall)

local var_0_0 = class("FightWorkAppearTimeline", BaseWork)

function var_0_0.getAppearTimeline()
	if FightDataHelper.stateMgr.isReplay then
		return false, nil
	end

	local var_1_0 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)
	local var_1_1 = FightModel.instance:getCurMonsterGroupId()
	local var_1_2 = var_1_1 and lua_monster_group.configDict[var_1_1]
	local var_1_3 = var_1_2 and var_1_2.appearTimeline

	if string.nilorempty(var_1_3) then
		return false, nil
	end

	local var_1_4 = lua_fight_appear_timeline_extend.configDict[var_1_1]

	if var_1_4 then
		local var_1_5 = FightStrUtil.instance:getSplitToNumberCache(var_1_4.monsterIdList, "#")

		if var_1_5 then
			for iter_1_0, iter_1_1 in ipairs(var_1_5) do
				local var_1_6 = var_0_0.getTargetEntity(var_1_0, iter_1_1)

				if var_1_6 then
					return var_1_3, var_1_6
				end
			end
		end

		return false, nil
	end

	local var_1_7 = var_1_2 and var_1_2.appearMonsterId or 0

	if var_1_7 == 0 then
		return false, nil
	end

	local var_1_8 = var_0_0.getTargetEntity(var_1_0, var_1_7)

	if not var_1_8 then
		return false, nil
	end

	return var_1_3, var_1_8
end

function var_0_0.getTargetEntity(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if iter_2_1:getMO().modelId == arg_2_1 then
			return iter_2_1
		end
	end
end

function var_0_0.onStart(arg_3_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)

	if FightDataHelper.stateMgr.isReplay then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0._timeline, arg_3_0._targetEntity = var_0_0.getAppearTimeline()

	if not arg_3_0._timeline or string.nilorempty(arg_3_0._timeline) then
		arg_3_0:onDone(true)

		return
	end

	if not arg_3_0._targetEntity then
		arg_3_0:onDone(true)

		return
	end

	arg_3_0:_beforePlayAppearTimeline()

	if arg_3_0:_checkAllSpineLoaded() then
		arg_3_0:_playTimeline()
	else
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_3_0._onOneSpineLoaded, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0._spineLoadedTimeout, arg_3_0, 1)
	end
end

function var_0_0._beforePlayAppearTimeline(arg_4_0)
	local var_4_0 = FightHelper.getAllEntitys()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		arg_4_0:_hideEntity(iter_4_1)
	end

	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
end

function var_0_0._onOneSpineLoaded(arg_5_0, arg_5_1)
	arg_5_0:_hideEntity(arg_5_1.unitSpawn)

	if arg_5_0:_checkAllSpineLoaded() then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_5_0._onOneSpineLoaded, arg_5_0)
		TaskDispatcher.cancelTask(arg_5_0._spineLoadedTimeout, arg_5_0)
		arg_5_0:_playTimeline()
	end
end

function var_0_0._checkAllSpineLoaded(arg_6_0)
	local var_6_0 = FightHelper.getAllEntitys()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1.spine and gohelper.isNil(iter_6_1.spine:getSpineGO()) then
			return false
		end
	end

	return true
end

function var_0_0._spineLoadedTimeout(arg_7_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_7_0._onOneSpineLoaded, arg_7_0)
	arg_7_0:_playTimeline()
end

function var_0_0._playTimeline(arg_8_0)
	FightController.instance:registerCallback(FightEvent.SkipAppearTimeline, arg_8_0._skipAppearTimeline, arg_8_0)
	ViewMgr.instance:openView(ViewName.FightSkipTimelineView, arg_8_0._timeline)

	local var_8_0 = {
		actType = FightEnum.ActType.SKILL,
		fromId = arg_8_0._targetEntity.id,
		toId = arg_8_0._targetEntity.id,
		actId = FightEnum.AppearTimelineSkillId,
		actEffect = {}
	}
	local var_8_1 = FightStepData.New(var_8_0)

	var_8_1.isFakeStep = true

	TaskDispatcher.runDelay(arg_8_0._delayDone, arg_8_0, 25)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_8_0._onSkillEnd, arg_8_0, LuaEventSystem.Low)
	arg_8_0._targetEntity.skill:playTimeline(arg_8_0._timeline, var_8_1)
end

function var_0_0._skipAppearTimeline(arg_9_0)
	if arg_9_0._targetEntity and arg_9_0._targetEntity.skill then
		arg_9_0._targetEntity.skill:skipSkill()
		GameSceneMgr.instance:getScene(SceneType.Fight).camera:enableClearSlot(0.1)
	end
end

function var_0_0._onSkillEnd(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:_done()
end

function var_0_0._delayDone(arg_11_0)
	logError("skill play timeout, skillId = " .. arg_11_0._timeline)
	arg_11_0:_done()
end

function var_0_0._done(arg_12_0)
	arg_12_0:_afterPlayAppearTimeline()
	arg_12_0:_removeEvents()
	arg_12_0:onDone(true)
end

function var_0_0._removeEvents(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayDone, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._spineLoadedTimeout, arg_13_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_13_0._onOneSpineLoaded, arg_13_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_13_0._onSkillEnd, arg_13_0)
	FightController.instance:unregisterCallback(FightEvent.SkipAppearTimeline, arg_13_0._skipAppearTimeline, arg_13_0)
end

function var_0_0._hideEntity(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	if arg_14_1.nameUI then
		arg_14_1.nameUI:setActive(false)
	end

	if arg_14_1.setAlpha then
		arg_14_1:setAlpha(0, 0)
	end
end

function var_0_0._afterPlayAppearTimeline(arg_15_0)
	ViewMgr.instance:closeView(ViewName.FightSkipTimelineView)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	FightController.instance:dispatchEvent(FightEvent.AfterPlayAppearTimeline)
	TaskDispatcher.runDelay(arg_15_0._delayRefreshAlpha, arg_15_0, 0.01)
end

function var_0_0._delayRefreshAlpha(arg_16_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function var_0_0.onResume(arg_17_0)
	logError("skill step can't resume")
end

function var_0_0.clearWork(arg_18_0)
	arg_18_0:_removeEvents()
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function var_0_0.onDestroy(arg_19_0)
	var_0_0.super.onDestroy(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._delayRefreshAlpha, arg_19_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

return var_0_0

module("modules.logic.fight.system.work.FightWorkAppearTimeline", package.seeall)

local var_0_0 = class("FightWorkAppearTimeline", BaseWork)

function var_0_0.hasAppearTimeline()
	if FightReplayModel.instance:isReplay() then
		return false
	end

	local var_1_0 = FightModel.instance:getCurMonsterGroupId()
	local var_1_1 = var_1_0 and lua_monster_group.configDict[var_1_0]
	local var_1_2 = var_1_1 and var_1_1.appearMonsterId or 0
	local var_1_3 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)
	local var_1_4

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		if iter_1_1:getMO().modelId == var_1_2 then
			var_1_4 = iter_1_1

			break
		end
	end

	if not var_1_4 then
		return false
	end

	local var_1_5 = var_1_1.appearTimeline

	return not string.nilorempty(var_1_5), var_1_4.id
end

function var_0_0.onStart(arg_2_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)

	if FightReplayModel.instance:isReplay() then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightModel.instance:getCurMonsterGroupId()
	local var_2_1 = var_2_0 and lua_monster_group.configDict[var_2_0]
	local var_2_2 = var_2_1 and var_2_1.appearMonsterId or 0
	local var_2_3 = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)

	arg_2_0._targetEntity = nil

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		if iter_2_1:getMO().modelId == var_2_2 then
			arg_2_0._targetEntity = iter_2_1
		end
	end

	if not arg_2_0._targetEntity then
		arg_2_0:onDone(true)

		return
	end

	local var_2_4 = var_2_1.appearTimeline

	if string.nilorempty(var_2_4) then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._timeline = var_2_4

	arg_2_0:_beforePlayAppearTimeline()

	if arg_2_0:_checkAllSpineLoaded() then
		arg_2_0:_playTimeline()
	else
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onOneSpineLoaded, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._spineLoadedTimeout, arg_2_0, 1)
	end
end

function var_0_0._beforePlayAppearTimeline(arg_3_0)
	local var_3_0 = FightHelper.getAllEntitys()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0:_hideEntity(iter_3_1)
	end

	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
end

function var_0_0._onOneSpineLoaded(arg_4_0, arg_4_1)
	arg_4_0:_hideEntity(arg_4_1.unitSpawn)

	if arg_4_0:_checkAllSpineLoaded() then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_4_0._onOneSpineLoaded, arg_4_0)
		TaskDispatcher.cancelTask(arg_4_0._spineLoadedTimeout, arg_4_0)
		arg_4_0:_playTimeline()
	end
end

function var_0_0._checkAllSpineLoaded(arg_5_0)
	local var_5_0 = FightHelper.getAllEntitys()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		if iter_5_1.spine and gohelper.isNil(iter_5_1.spine:getSpineGO()) then
			return false
		end
	end

	return true
end

function var_0_0._spineLoadedTimeout(arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_6_0._onOneSpineLoaded, arg_6_0)
	arg_6_0:_playTimeline()
end

function var_0_0._playTimeline(arg_7_0)
	FightController.instance:registerCallback(FightEvent.SkipAppearTimeline, arg_7_0._skipAppearTimeline, arg_7_0)
	ViewMgr.instance:openView(ViewName.FightSkipTimelineView, arg_7_0._timeline)

	local var_7_0 = {
		actType = FightEnum.ActType.SKILL,
		fromId = arg_7_0._targetEntity.id,
		toId = arg_7_0._targetEntity.id,
		actId = FightEnum.AppearTimelineSkillId,
		actEffect = {}
	}
	local var_7_1 = FightStepData.New(var_7_0)

	var_7_1.isFakeStep = true

	TaskDispatcher.runDelay(arg_7_0._delayDone, arg_7_0, 25)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_7_0._onSkillEnd, arg_7_0, LuaEventSystem.Low)
	arg_7_0._targetEntity.skill:playTimeline(arg_7_0._timeline, var_7_1)
end

function var_0_0._skipAppearTimeline(arg_8_0)
	if arg_8_0._targetEntity and arg_8_0._targetEntity.skill then
		arg_8_0._targetEntity.skill:skipSkill()
		GameSceneMgr.instance:getScene(SceneType.Fight).camera:enableClearSlot(0.1)
	end
end

function var_0_0._onSkillEnd(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:_done()
end

function var_0_0._delayDone(arg_10_0)
	logError("skill play timeout, skillId = " .. arg_10_0._timeline)
	arg_10_0:_done()
end

function var_0_0._done(arg_11_0)
	arg_11_0:_afterPlayAppearTimeline()
	arg_11_0:_removeEvents()
	arg_11_0:onDone(true)
end

function var_0_0._removeEvents(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayDone, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._spineLoadedTimeout, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_12_0._onOneSpineLoaded, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_12_0._onSkillEnd, arg_12_0)
	FightController.instance:unregisterCallback(FightEvent.SkipAppearTimeline, arg_12_0._skipAppearTimeline, arg_12_0)
end

function var_0_0._hideEntity(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	if arg_13_1.nameUI then
		arg_13_1.nameUI:setActive(false)
	end

	if arg_13_1.setAlpha then
		arg_13_1:setAlpha(0, 0)
	end
end

function var_0_0._afterPlayAppearTimeline(arg_14_0)
	ViewMgr.instance:closeView(ViewName.FightSkipTimelineView)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	FightController.instance:dispatchEvent(FightEvent.AfterPlayAppearTimeline)
	TaskDispatcher.runDelay(arg_14_0._delayRefreshAlpha, arg_14_0, 0.01)
end

function var_0_0._delayRefreshAlpha(arg_15_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function var_0_0.onResume(arg_16_0)
	logError("skill step can't resume")
end

function var_0_0.clearWork(arg_17_0)
	arg_17_0:_removeEvents()
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function var_0_0.onDestroy(arg_18_0)
	var_0_0.super.onDestroy(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._delayRefreshAlpha, arg_18_0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

return var_0_0

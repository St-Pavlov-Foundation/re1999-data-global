module("modules.logic.fight.system.work.FightWorkAppearTimeline", package.seeall)

slot0 = class("FightWorkAppearTimeline", BaseWork)

function slot0.hasAppearTimeline()
	if FightReplayModel.instance:isReplay() then
		return false
	end

	slot1 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot0]
	slot4 = nil

	for slot8, slot9 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)) do
		if slot9:getMO().modelId == (slot1 and slot1.appearMonsterId or 0) then
			slot4 = slot9

			break
		end
	end

	if not slot4 then
		return false
	end

	return not string.nilorempty(slot1.appearTimeline), slot4.id
end

function slot0.onStart(slot0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)

	if FightReplayModel.instance:isReplay() then
		slot0:onDone(true)

		return
	end

	slot2 = FightModel.instance:getCurMonsterGroupId() and lua_monster_group.configDict[slot1]
	slot0._targetEntity = nil

	for slot8, slot9 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, false)) do
		if slot9:getMO().modelId == (slot2 and slot2.appearMonsterId or 0) then
			slot0._targetEntity = slot9
		end
	end

	if not slot0._targetEntity then
		slot0:onDone(true)

		return
	end

	if string.nilorempty(slot2.appearTimeline) then
		slot0:onDone(true)

		return
	end

	slot0._timeline = slot5

	slot0:_beforePlayAppearTimeline()

	if slot0:_checkAllSpineLoaded() then
		slot0:_playTimeline()
	else
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onOneSpineLoaded, slot0)
		TaskDispatcher.runDelay(slot0._spineLoadedTimeout, slot0, 1)
	end
end

function slot0._beforePlayAppearTimeline(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		slot0:_hideEntity(slot6)
	end

	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), false)

	if slot0._timeline == "650402_born" then
		for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
			if slot7.nameUI then
				slot7.nameUI:setActive(false)
			end
		end

		slot0._targetEntity:setAlpha(1, 0)
		slot0._targetEntity.spine:getSkeletonAnim():SetMixDuration(0)
		slot0._targetEntity.spine:play(SpineAnimState.born, false, true)
		slot0._targetEntity.spine:getSkeletonAnim():ClearMixDuration()
	end
end

function slot0._onOneSpineLoaded(slot0, slot1)
	slot0:_hideEntity(slot1.unitSpawn)

	if slot0:_checkAllSpineLoaded() then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onOneSpineLoaded, slot0)
		TaskDispatcher.cancelTask(slot0._spineLoadedTimeout, slot0)
		slot0:_playTimeline()
	end
end

function slot0._checkAllSpineLoaded(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys()) do
		if slot6.spine and gohelper.isNil(slot6.spine:getSpineGO()) then
			return false
		end
	end

	return true
end

function slot0._spineLoadedTimeout(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onOneSpineLoaded, slot0)
	slot0:_playTimeline()
end

function slot0._playTimeline(slot0)
	FightController.instance:registerCallback(FightEvent.SkipAppearTimeline, slot0._skipAppearTimeline, slot0)
	ViewMgr.instance:openView(ViewName.FightSkipTimelineView, slot0._timeline)

	slot1 = FightStepMO.New()

	slot1:init({
		actType = FightEnum.ActType.SKILL,
		fromId = slot0._targetEntity.id,
		toId = slot0._targetEntity.id,
		actId = FightEnum.AppearTimelineSkillId,
		actEffect = {}
	})
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 25)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0, LuaEventSystem.Low)
	slot0._targetEntity.skill:playTimeline(slot0._timeline, slot1)
end

function slot0._skipAppearTimeline(slot0)
	if slot0._targetEntity and slot0._targetEntity.skill then
		slot0._targetEntity.skill:skipSkill()
		GameSceneMgr.instance:getScene(SceneType.Fight).camera:enableClearSlot(0.1)
	end
end

function slot0._onSkillEnd(slot0, slot1, slot2)
	slot0:_done()
end

function slot0._delayDone(slot0)
	logError("skill play timeout, skillId = " .. slot0._timeline)
	slot0:_done()
end

function slot0._done(slot0)
	slot0:_afterPlayAppearTimeline()
	slot0:_removeEvents()
	slot0:onDone(true)
end

function slot0._removeEvents(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._spineLoadedTimeout, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onOneSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.SkipAppearTimeline, slot0._skipAppearTimeline, slot0)
end

function slot0._hideEntity(slot0, slot1)
	if not slot1 then
		return
	end

	if slot1.nameUI then
		slot1.nameUI:setActive(false)
	end

	if slot1.setAlpha then
		slot1:setAlpha(0, 0)
	end
end

function slot0._afterPlayAppearTimeline(slot0)
	ViewMgr.instance:closeView(ViewName.FightSkipTimelineView)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
	FightController.instance:dispatchEvent(FightEvent.AfterPlayAppearTimeline)
	TaskDispatcher.runDelay(slot0._delayRefreshAlpha, slot0, 0.01)
end

function slot0._delayRefreshAlpha(slot0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function slot0.onResume(slot0)
	logError("skill step can't resume")
end

function slot0.clearWork(slot0)
	slot0:_removeEvents()
	gohelper.setActive(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayRefreshAlpha, slot0)
	gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), true)
end

return slot0

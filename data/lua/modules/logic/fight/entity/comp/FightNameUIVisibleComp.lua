module("modules.logic.fight.entity.comp.FightNameUIVisibleComp", package.seeall)

slot0 = class("FightNameUIVisibleComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._showBySkillStart = {}
	slot0._hideByEntity = {}
	slot0._showByTimeline = {}
	slot0._hideByTimeline = {}
end

function slot0.addEventListeners(slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
	FightController.instance:registerCallback(FightEvent.SetNameUIVisibleByTimeline, slot0._setNameUIVisibleByTimeline, slot0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0, LuaEventSystem.High)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.beforeDestroy(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityVisibleByTimeline, slot0._setEntityVisibleByTimeline, slot0)
	FightController.instance:unregisterCallback(FightEvent.SetNameUIVisibleByTimeline, slot0._setNameUIVisibleByTimeline, slot0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, slot0._forceEndSkillStep, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.FightQuitTipView and slot0.entity.nameUI then
		slot0.entity.nameUI:setActive(false)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.FightQuitTipView then
		slot0:_checkVisible()
	end
end

slot1 = {
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if FightHelper.getRelativeEntityIdDict(slot3, uv0)[slot0.entity.id] then
		table.insert(slot0._showBySkillStart, slot3)
	end

	slot0:_checkVisible()
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	tabletool.removeValue(slot0._showBySkillStart, slot3)
	tabletool.removeValue(slot0._hideByEntity, slot3)
	tabletool.removeValue(slot0._showByTimeline, slot3)
	tabletool.removeValue(slot0._hideByTimeline, slot3)

	slot4 = nil

	for slot9, slot10 in ipairs(FightHelper.getAllEntitys()) do
		if slot10.skill and slot10.skill:sameSkillPlaying() then
			slot4 = true

			break
		end
	end

	if slot4 then
		return
	end

	slot0:_checkVisible()
end

function slot0._forceEndSkillStep(slot0, slot1)
	tabletool.removeValue(slot0._hideByEntity, slot1)
end

function slot0._setEntityVisibleByTimeline(slot0, slot1, slot2, slot3, slot4)
	if slot0.entity.id ~= slot1.id then
		return
	end

	tabletool.removeValue(slot0._hideByEntity, slot2)

	if not slot3 then
		table.insert(slot0._hideByEntity, slot2)
	end

	slot0:_checkVisible()
end

function slot0._setNameUIVisibleByTimeline(slot0, slot1, slot2, slot3)
	if slot0.entity.id ~= slot1.id then
		return
	end

	if slot3 then
		if not tabletool.indexOf(slot0._showByTimeline, slot2) then
			table.insert(slot0._showByTimeline, slot2)
		end
	elseif not tabletool.indexOf(slot0._hideByTimeline, slot2) then
		table.insert(slot0._hideByTimeline, slot2)
	end

	slot0:_checkVisible()
end

function slot0._checkVisible(slot0)
	if slot0.entity.nameUI then
		if FightSkillMgr.instance:isPlayingAnyTimeline() then
			if #slot0._hideByEntity > 0 then
				slot0.entity.nameUI:setActive(false)
			elseif #slot0._showByTimeline > 0 then
				slot0.entity.nameUI:setActive(true)
			elseif #slot0._hideByTimeline > 0 then
				slot0.entity.nameUI:setActive(false)
			elseif #slot0._showBySkillStart > 0 then
				slot0.entity.nameUI:setActive(true)
			else
				slot0.entity.nameUI:setActive(false)
			end
		else
			slot0.entity.nameUI:setActive(true)
		end
	end
end

return slot0

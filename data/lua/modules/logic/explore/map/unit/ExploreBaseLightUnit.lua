module("modules.logic.explore.map.unit.ExploreBaseLightUnit", package.seeall)

slot0 = class("ExploreBaseLightUnit", ExploreBaseMoveUnit)

function slot0.initComponents(slot0, ...)
	uv0.super.initComponents(slot0, ...)
	slot0:addComp("lightComp", ExploreUnitLightComp)
end

function slot0.onInFOVChange(slot0, slot1)
	if slot1 then
		slot0:setupRes()
		TaskDispatcher.cancelTask(slot0._releaseDisplayGo, slot0)
	else
		TaskDispatcher.runDelay(slot0._releaseDisplayGo, slot0, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function slot0.setActiveAnim(slot0, slot1)
	if slot1 then
		slot0:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		slot0:playAnim(ExploreAnimEnum.AnimName.aToN)
	end
end

function slot0.onActiveChange(slot0, slot1)
end

function slot0.getIdleAnim(slot0)
	if not slot0.mo:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not slot0:haveLight() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

return slot0

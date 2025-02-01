module("modules.logic.explore.map.ExploreMapUnitCatchComp", package.seeall)

slot0 = class("ExploreMapUnitCatchComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._mapGo = slot1
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, slot0._onUpdateCatchUnit, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnClickHero, slot0._onClickHero, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.HeroResInitDone, slot0._onHeroInitDone, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, slot0._onUpdateCatchUnit, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.HeroResInitDone, slot0._onHeroInitDone, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnClickHero, slot0._onClickHero, slot0)
end

function slot0.setMap(slot0, slot1)
	slot0._map = slot1
	slot0._hero = slot1:getHero()

	slot0:_onUpdateCatchUnit()

	if slot0._catchUnit then
		slot0._catchUnit:setActive(false)
	end
end

function slot0._onHeroInitDone(slot0)
	if slot0._catchUnit then
		slot0._catchUnit:setActive(true)
		slot0._catchUnit:setupRes()
		slot0._hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Carry)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroCarryChange)

		if slot0._hero:getHangTrans(ExploreAnimEnum.RoleHangPointType.Hand_Right) then
			slot0._catchUnit:setParent(slot1, ExploreEnum.ExplorePipePotHangType.Carry)
		end
	end
end

function slot0._onUpdateCatchUnit(slot0, slot1)
	slot0._catchUnit = slot0._map:getUnit(tonumber(ExploreModel.instance:getUseItemUid()), true)
	slot4 = slot0._catchUnit ~= slot0._catchUnit

	if slot0._catchUnit then
		slot0._catchUnit:removeFromNode()
	end

	if slot4 and slot1 then
		if slot0._catchUnit ~= nil then
			if not slot0._catchUnit.nodePos then
				slot0._catchUnit.nodePos = slot0._catchUnit.mo.nodePos
			end

			ExploreHeroCatchUnitFlow.instance:catchUnit(slot0._catchUnit)
		else
			ExploreHeroCatchUnitFlow.instance:uncatchUnit(slot3)
		end
	end
end

function slot0.setCatchUnit(slot0, slot1)
	slot0._catchUnit = slot1
end

function slot0._onClickHero(slot0)
	if not ExploreModel.instance:isHeroInControl() then
		return
	end

	if slot0._hero:isMoving() then
		return
	end

	if slot0._catchUnit then
		ExploreController.instance:dispatchEvent(ExploreEvent.TryCancelTriggerUnit, slot0._catchUnit.id)
	end
end

function slot0.onDestroy(slot0)
	slot0._mapGo = nil
	slot0._map = nil
	slot0._catchUnit = nil
end

return slot0

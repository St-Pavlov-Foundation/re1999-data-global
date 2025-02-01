module("modules.logic.explore.map.unit.ExplorePipePotUnit", package.seeall)

slot0 = class("ExplorePipePotUnit", ExploreBaseMoveUnit)

function slot0.setPosByNode(slot0, ...)
	if not ExploreHeroResetFlow.instance:isReseting() and ExploreHeroCatchUnitFlow.instance:isInFlow(slot0) then
		return
	end

	uv0.super.setPosByNode(slot0, ...)
end

function slot0.setPosByFlow(slot0)
	uv0.super.setPosByNode(slot0, slot0.nodePos)
end

function slot0.onStatus2Change(slot0, slot1, slot2)
	if not ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	if (slot2.bindInteractId or 0) > 0 then
		slot0:setParent(ExploreController.instance:getMap():getUnit(slot4).trans, ExploreEnum.ExplorePipePotHangType.Put)
	else
		slot0:setParent(slot3:getUnitRoot().transform, ExploreEnum.ExplorePipePotHangType.UnCarry)
	end
end

function slot0.setParent(slot0, slot1, slot2)
	slot0.trans:SetParent(slot1, false)

	if slot2 == ExploreEnum.ExplorePipePotHangType.Carry then
		slot4 = ExploreController.instance:getMap():getHero().dir
		slot0._carryDir = slot4

		transformhelper.setLocalPos(slot0.trans, 0, 0, 0)
		transformhelper.setLocalRotation(slot0.trans, slot4 - 90 - slot0.mo.unitDir, 0, 90)
		slot0.clickComp:setEnable(false)
	elseif slot2 == ExploreEnum.ExplorePipePotHangType.UnCarry then
		slot0.mo.unitDir = ExploreController.instance:getMap():getHero().dir - (slot0._carryDir or 0) + slot0.mo.unitDir

		transformhelper.setLocalRotation(slot0.trans, 0, slot0.mo.unitDir, 0)
		slot0:setPosByFlow()
		slot0.clickComp:setEnable(true)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitNodeChange, slot0, slot0.nodePos, slot0.nodePos)
	elseif slot2 == ExploreEnum.ExplorePipePotHangType.Pick then
		transformhelper.setLocalPos(slot0.trans, 0, 0, 0)
		transformhelper.setLocalRotation(slot0.trans, 0, slot0.mo.unitDir, 0)
		slot0.clickComp:setEnable(false)
	elseif slot2 == ExploreEnum.ExplorePipePotHangType.Put then
		transformhelper.setLocalPos(slot0.trans, 0, 0.65, 0)
		transformhelper.setLocalRotation(slot0.trans, 180, 360 - slot0.mo.unitDir, 0)
		slot0.clickComp:setEnable(false)
	end
end

return slot0

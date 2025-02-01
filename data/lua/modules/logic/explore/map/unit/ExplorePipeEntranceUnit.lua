module("modules.logic.explore.map.unit.ExplorePipeEntranceUnit", package.seeall)

slot0 = class("ExplorePipeEntranceUnit", ExploreBaseDisplayUnit)

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
	slot0:addComp("pipeComp", ExplorePipeComp)
end

function slot0.setupMO(slot0)
	uv0.super.setupMO(slot0)
	slot0.pipeComp:initData()
end

function slot0.onMapInit(slot0)
	uv0.super.onMapInit(slot0)

	if ExploreController.instance:getMap():getUnit(slot0.mo:getBindPotId(), true) then
		slot2:setParent(slot0.trans, ExploreEnum.ExplorePipePotHangType.Put)
	end
end

function slot0.tryTrigger(slot0)
	slot4 = slot0.mo:getBindPotId()

	if ExploreController.instance:getMap():getUnit(tonumber(ExploreModel.instance:getUseItemUid()), true) and slot3:getUnitType() == ExploreEnum.ItemType.PipePot and slot4 == 0 or slot4 > 0 and not slot3 then
		uv0.super.tryTrigger(slot0)
	end
end

function slot0.onStatus2Change(slot0, slot1, slot2)
	if ExploreHeroResetFlow.instance:isReseting() then
		return
	end

	if (slot1.bindInteractId or 0) ~= (slot2.bindInteractId or 0) then
		if slot3 == 0 then
			ExploreModel.instance:setStepPause(true)

			slot5 = ExploreController.instance:getMap()

			ExploreHeroCatchUnitFlow.instance:uncatchUnitFrom(slot5:getUnit(slot4), slot0, slot0.onFlowEnd)
			ExploreModel.instance:setUseItemUid("0", true)
			slot5:getCatchComp():setCatchUnit(nil)
		elseif slot4 == 0 then
			ExploreModel.instance:setStepPause(true)

			slot6 = ExploreController.instance:getMap():getUnit(slot3)

			ExploreHeroCatchUnitFlow.instance:catchUnitFrom(slot6, slot0, slot0.onFlowEnd)
			ExploreModel.instance:setUseItemUid(tostring(slot3), true)
			ExploreController.instance:getMap():getCatchComp():setCatchUnit(slot6)
		else
			logError("???")
		end
	end
end

function slot0.onFlowEnd(slot0)
	ExploreModel.instance:setStepPause(false)
	ExploreController.instance:getMapPipe():initColors()
end

return slot0

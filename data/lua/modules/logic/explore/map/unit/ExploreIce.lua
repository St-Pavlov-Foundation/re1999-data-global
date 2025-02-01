module("modules.logic.explore.map.unit.ExploreIce", package.seeall)

slot0 = class("ExploreIce", ExploreBaseDisplayUnit)

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if slot3:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, true)
	end

	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)

	if slot3:isRole() and slot2 and ExploreModel.instance:isHeroInControl() then
		slot7 = slot1 - slot2
		slot9 = slot0.nodePos
		slot10 = ExploreController.instance:getMap():getUnitByPos(slot7 + slot1)
		slot11 = nil

		if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot7 + slot1)) and slot5:isWalkable(ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot0.nodePos)).height) then
			for slot15, slot16 in ipairs(slot10) do
				if slot16:getUnitType() == ExploreEnum.ItemType.Ice then
					slot11 = slot16
					slot9 = slot1 + slot7
				end
			end
		end

		while slot11 do
			slot12 = slot7 + slot9
			slot10 = slot8:getUnitByPos(slot12)
			slot11 = nil

			if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot12)) and slot5:isWalkable(slot6) then
				for slot16, slot17 in ipairs(slot10) do
					if slot17:getUnitType() == ExploreEnum.ItemType.Ice then
						slot11 = slot17
						slot9 = slot7 + slot9
					end
				end
			end
		end

		if ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot7 + slot9)) and slot5:isWalkable(slot6) then
			slot9 = slot12
		end

		if slot9 ~= slot0.nodePos then
			ExploreController.instance:dispatchEvent(ExploreEvent.MoveHeroToPos, slot9, slot0.onIceMoveEnd, slot0)
			ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Ice)
			slot3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Glide)
			ExploreRpc.instance:sendExploreMoveRequest(slot9.x, slot9.y)
		end
	end
end

function slot0.canTrigger(slot0)
	return false
end

function slot0.onRoleStay(slot0)
end

function slot0.onRoleLeave(slot0, slot1, slot2, slot3)
	if slot3:isRole() then
		ExploreController.instance:getMap():getHero():setBool(ExploreAnimEnum.RoleAnimKey.IsIce, false)
	end
end

function slot0.onIceMoveEnd(slot0)
	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Ice)
end

return slot0

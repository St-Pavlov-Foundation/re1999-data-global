module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractPlayerStatus", package.seeall)

slot0 = class("YaXianInteractPlayerStatus", YaXianInteractStatusBase)

function slot0.updateStatus(slot0)
	slot0.statusDict = {}
	slot0.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()
	slot0.hadThroughWallEffect = YaXianGameModel.instance:hasThroughWallEffect()
	slot0.canWalkDirection2Pos = YaXianGameModel.instance:getCanWalkTargetPosDict()
	slot0.canWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	slot0:addVisibleStatus()
	slot0:addThroughWallStatus()
	slot0:addAssassinateOrFightStatus()
end

function slot0.addVisibleStatus(slot0)
	if slot0.hadInVisibleEffect then
		slot0:addStatus(YaXianGameEnum.IconStatus.InVisible)
	end
end

function slot0.addThroughWallStatus(slot0)
	if slot0.hadThroughWallEffect then
		slot0:addStatus(YaXianGameEnum.IconStatus.ThroughWall)
	end
end

function slot0.addAssassinateOrFightStatus(slot0)
	if YaXianGameController.instance:getInteractItemList() and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6 and slot6:isEnemy() and not slot6:isDelete() then
				slot0:handleInteractPos(slot6)
				slot0:handleInteractAlertArea(slot6)
				slot0:handleInteractMoving(slot6)
			end
		end
	end
end

function slot0.handleInteractPos(slot0, slot1)
	for slot5, slot6 in pairs(slot0.canWalkDirection2Pos) do
		if slot1.interactMo.posX == slot6.x and slot7.posY == slot6.y then
			if slot1:isFighting() then
				slot0:addStatus(YaXianGameEnum.IconStatus.Fight, slot5)
			elseif not slot0.hadInVisibleEffect and slot7.direction == YaXianGameEnum.OppositeDirection[slot5] then
				slot0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, slot5)
			end
		end
	end
end

function slot0.handleInteractAlertArea(slot0, slot1)
	if slot1.interactMo.alertPosList and #slot2 > 0 then
		for slot6, slot7 in ipairs(slot2) do
			if slot0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot7.posX, slot7.posY)] then
				if slot1:isFighting() then
					slot0:addStatus(YaXianGameEnum.IconStatus.Fight, slot8)
				elseif not slot0.hadInVisibleEffect then
					slot0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, slot8)
				end
			end
		end
	end
end

function slot0.handleInteractMoving(slot0, slot1)
	slot2 = slot1.interactMo

	if not slot1.interactMo.nextPos then
		return
	end

	slot7 = slot2.posY
	slot8 = slot3.posX

	for slot7, slot8 in YaXianGameHelper.getPassPosGenerator(slot2.posX, slot7, slot8, slot3.posY) do
		if slot0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot7, slot8)] then
			if slot1:isFighting() then
				slot0:addStatus(YaXianGameEnum.IconStatus.Fight, slot9)
			elseif not slot0.hadInVisibleEffect then
				slot0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, slot9)
			end
		end
	end
end

return slot0

module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEnemyStatus", package.seeall)

slot0 = class("YaXianInteractEnemyStatus", YaXianInteractStatusBase)

function slot0.updateStatus(slot0)
	slot0.statusDict = {}
	slot0.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()

	if slot0.interactItem:isFighting() then
		slot0:addStatus(YaXianGameEnum.IconStatus.Fight)
	end

	slot0.playerCanWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	slot0:handleInteractPos()
	slot0:handleInteractAlertArea()
	slot0:handleInteractMoving()
end

function slot0.handleInteractPos(slot0)
	if not slot0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot0.interactMo.posX, slot0.interactMo.posY)] then
		return
	end

	if slot0.interactItem:isFighting() then
		slot0:addStatus(YaXianGameEnum.IconStatus.Fight, YaXianGameEnum.OppositeDirection[slot1])
	elseif slot0.hadInVisibleEffect then
		slot0:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	elseif YaXianGameEnum.OppositeDirection[slot1] ~= slot0.interactMo.direction then
		slot0:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	end
end

function slot0.handleInteractAlertArea(slot0)
	if not slot0.interactItem:isFighting() then
		return
	end

	if slot0.interactMo.alertPosList and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			if slot0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot6.posX, slot6.posY)] then
				slot0:addStatus(YaXianGameEnum.IconStatus.Fight)

				break
			end
		end
	end
end

function slot0.handleInteractMoving(slot0)
	slot1 = slot0.interactItem.interactMo

	if not slot0.interactItem.interactMo.nextPos then
		return
	end

	if not slot0.hadInVisibleEffect then
		return
	end

	slot6 = slot1.posY
	slot7 = slot2.posX

	for slot6, slot7 in YaXianGameHelper.getPassPosGenerator(slot1.posX, slot6, slot7, slot2.posY) do
		if slot0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(slot6, slot7)] then
			slot0:addStatus(YaXianGameEnum.IconStatus.Assassinate)

			break
		end
	end
end

return slot0

module("modules.logic.tower.model.TowerPermanentMo", package.seeall)

slot0 = pureTable("TowerPermanentMo")

function slot0.init(slot0, slot1, slot2)
	slot0.ItemType = 1
	slot0.stage = slot1
	slot0.configList = slot2
end

function slot0.reInit(slot0)
end

function slot0.getIsUnFold(slot0)
	return slot0.isUnFold
end

function slot0.setIsUnFold(slot0, slot1)
	slot0.isUnFold = slot1
end

function slot0.getAltitudeHeight(slot0, slot1)
	slot2 = tabletool.len(slot0.configList)

	if slot1 then
		return slot2 * TowerEnum.PermanentUI.SingleItemH + (slot2 - 1) * TowerEnum.PermanentUI.ItemSpaceH
	end

	return 0
end

function slot0.getStageHeight(slot0, slot1)
	if slot0.curUnFoldingH then
		return TowerEnum.PermanentUI.StageTitleH + slot0.curUnFoldingH
	end

	if tabletool.len(slot0.configList) == 0 then
		return TowerEnum.PermanentUI.LockTipH
	end

	return TowerEnum.PermanentUI.StageTitleH + slot0:getAltitudeHeight(slot1)
end

function slot0.overrideStageHeight(slot0, slot1)
	slot0.curUnFoldingH = slot1
end

function slot0.cleanCurUnFoldingH(slot0)
	slot0.curUnFoldingH = nil
end

function slot0.checkIsOnline(slot0)
	return TowerPermanentModel.instance:checkStageIsOnline(slot0.stage)
end

return slot0

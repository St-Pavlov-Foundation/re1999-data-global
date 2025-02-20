module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessPieceSkillMO", package.seeall)

slot0 = class("WarChessPieceSkillMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.tag = slot1.tag
	slot0.currGrowUpTime = slot1.currGrowUpTime
	slot0.growUpTime = slot1.growUpTime
	slot0.canGrowUp = slot1.canGrowUp
end

function slot0.updateSkillGrowUp(slot0, slot1)
	slot0.currGrowUpTime = math.max(slot0.currGrowUpTime + slot1, 0)
end

function slot0.needShowGrowUp(slot0)
	return slot0.growUpTime ~= 0
end

function slot0.getGrowUpProgress(slot0)
	return (slot0.growUpTime - slot0.currGrowUpTime) / slot0.growUpTime
end

return slot0

module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType6", package.seeall)

slot0 = class("FightRestartAbandonType6", FightRestartAbandonType1)

function slot0.episodeCostIsEnough(slot0)
	if DungeonModel.instance:getChapterRemainingNum(DungeonEnum.ChapterType.Equip) > 0 then
		slot0._box_type = MessageBoxIdDefine.EquipFreeRestart

		return true
	end

	return uv0.super.episodeCostIsEnough(slot0)
end

return slot0

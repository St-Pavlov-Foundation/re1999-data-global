module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType6", package.seeall)

local var_0_0 = class("FightRestartAbandonType6", FightRestartAbandonType1)

function var_0_0.episodeCostIsEnough(arg_1_0)
	if DungeonModel.instance:getChapterRemainingNum(DungeonEnum.ChapterType.Equip) > 0 then
		arg_1_0._box_type = MessageBoxIdDefine.EquipFreeRestart

		return true
	end

	return var_0_0.super.episodeCostIsEnough(arg_1_0)
end

return var_0_0

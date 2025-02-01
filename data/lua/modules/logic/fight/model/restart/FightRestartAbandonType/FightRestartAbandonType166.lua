module("modules.logic.fight.model.restart.FightRestartAbandonType.FightRestartAbandonType166", package.seeall)

slot0 = class("FightRestartAbandonType166", FightRestartAbandonType1)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0:__onInit()

	slot0._fight_work = slot1
	slot0._fightParam = slot2
	slot0._episode_config = slot3
	slot0._chapter_config = slot4
end

function slot0.canRestart(slot0)
	if ActivityHelper.getActivityStatusAndToast(Season166Model.instance:getBattleContext().actId) ~= ActivityEnum.ActivityStatus.Normal or not Season166Model.instance:getActInfo(slot2) then
		return false
	end

	return uv0.super.canRestart(slot0)
end

return slot0

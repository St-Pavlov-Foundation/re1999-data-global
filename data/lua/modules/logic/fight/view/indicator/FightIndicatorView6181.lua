module("modules.logic.fight.view.indicator.FightIndicatorView6181", package.seeall)

slot0 = class("FightIndicatorView6181", FightIndicatorView)

function slot0.getCardConfig(slot0)
	return Season123Config.instance:getSeasonEquipCo(slot0:getCardId())
end

function slot0.getCardId(slot0)
	return 180040
end

return slot0

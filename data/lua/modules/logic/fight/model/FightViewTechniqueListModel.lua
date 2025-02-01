module("modules.logic.fight.model.FightViewTechniqueListModel", package.seeall)

slot0 = class("FightViewTechniqueListModel", ListScrollModel)

function slot0.showUnreadFightViewTechniqueList(slot0, slot1)
	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0

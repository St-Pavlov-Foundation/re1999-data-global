module("modules.logic.fight.entity.FightEntityLyTemp", package.seeall)

slot0 = class("FightEntityLyTemp", FightEntityTemp)

function slot0.initComponents(slot0)
	slot0:addComp("spine", UnitSpine)
	slot0:addComp("spineRenderer", UnitSpineRenderer)
	slot0:addComp("effect", FightEffectComp)
end

return slot0

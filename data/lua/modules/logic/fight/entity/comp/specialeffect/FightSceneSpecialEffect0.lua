-- chunkname: @modules/logic/fight/entity/comp/specialeffect/FightSceneSpecialEffect0.lua

module("modules.logic.fight.entity.comp.specialeffect.FightSceneSpecialEffect0", package.seeall)

local FightSceneSpecialEffect0 = class("FightSceneSpecialEffect0", FightEntitySpecialEffectBase)

function FightSceneSpecialEffect0:initClass()
	self:newClass(FightSceneSpecialEffect0_HuanJingKa)
end

return FightSceneSpecialEffect0

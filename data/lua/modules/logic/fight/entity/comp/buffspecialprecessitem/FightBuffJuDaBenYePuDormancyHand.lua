module("modules.logic.fight.entity.comp.buffspecialprecessitem.FightBuffJuDaBenYePuDormancyHand", package.seeall)

slot0 = class("FightBuffJuDaBenYePuDormancyHand", FightBuffJuDaBenYePuDormancyTail)

function slot0.getPlayValue(slot0)
	slot1 = MaterialUtil.getPropValueFromMat(slot0._entityMat, "_TempOffset3", "Vector4")

	return MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", slot1.z)), MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", slot1.z))
end

function slot0.getCloseValue(slot0)
	slot1 = MaterialUtil.getPropValueFromMat(slot0._entityMat, "_TempOffset3", "Vector4")

	return MaterialUtil.getPropValueFromStr("Vector4", string.format("3,1,%f,0", slot1.z)), MaterialUtil.getPropValueFromStr("Vector4", string.format("3,0,%f,0", slot1.z))
end

return slot0

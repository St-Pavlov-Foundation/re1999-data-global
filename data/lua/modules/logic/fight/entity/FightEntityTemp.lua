module("modules.logic.fight.entity.FightEntityTemp", package.seeall)

slot0 = class("FightEntityTemp", BaseFightEntity)

function slot0.getTag(slot0)
	return SceneTag.UnitNpc
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
	FightRenderOrderMgr.instance:unregister(slot0.id)
end

function slot0.initComponents(slot0)
	slot0:addComp("spine", UnitSpine)
	slot0:addComp("spineRenderer", UnitSpineRenderer)
	slot0:addComp("mover", UnitMoverEase)
	slot0:addComp("parabolaMover", UnitMoverParabola)
	slot0:addComp("bezierMover", UnitMoverBezier)
	slot0:addComp("curveMover", UnitMoverCurve)
	slot0:addComp("moveHandler", UnitMoverHandler)
	slot0:addComp("effect", FightEffectComp)
	slot0:addComp("variantHeart", FightVariantHeartComp)
	slot0:addComp("entityVisible", FightEntityVisibleComp)
end

function slot0.setSide(slot0, slot1)
	slot0._tempSide = slot1
end

function slot0.getSide(slot0)
	return slot0._tempSide
end

function slot0.loadSpine(slot0, slot1, slot2, slot3)
	slot0._callback = slot2
	slot0._callbackObj = slot3

	slot0.spine:setResPath(ResUrl.getSpineFightPrefab(slot1), slot0._onSpineLoaded, slot0)
end

function slot0.loadSpineBySkin(slot0, slot1, slot2, slot3)
	slot0._callback = slot2
	slot0._callbackObj = slot3

	slot0.spine:setResPath(ResUrl.getSpineFightPrefabBySkin(slot1), slot0._onSpineLoaded, slot0)
end

function slot0.loadSpineBySpinePath(slot0, slot1, slot2, slot3)
	slot0._callback = slot2
	slot0._callbackObj = slot3

	slot0.spine:setResPath(slot1, slot0._onSpineLoaded, slot0)
end

return slot0

module("modules.logic.fight.entity.FightEntitySub", package.seeall)

slot0 = class("FightEntitySub", BaseFightEntity)
slot0.Online = true

function slot0.getTag(slot0)
	return slot0:isMySide() and SceneTag.UnitPlayer or SceneTag.UnitMonster
end

function slot0.ctor(slot0, slot1)
	slot0.isSub = true

	uv0.super.ctor(slot0, slot1)
end

function slot0.initComponents(slot0)
	slot0:addComp("spine", UnitSpine)
	slot0:addComp("spineRenderer", UnitSpineRenderer)
	slot0:addComp("entityVisible", FightEntityVisibleComp)
	slot0:addComp("effect", FightEffectComp)
	slot0:addComp("variantCrayon", FightVariantCrayonComp)
end

function slot0.setRenderOrder(slot0, slot1)
	uv0.super.setRenderOrder(slot0, slot1)
end

function slot0.setAlpha(slot0, slot1, slot2)
	if slot0.spineRenderer then
		slot0.spineRenderer:setAlpha(slot1, slot2)
	end
end

function slot0.loadSpine(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2

	slot0.spine:setResPath(ResUrl.getSpineFightPrefab(FightConfig.instance:getSkinCO(slot0:getMO().skin) and slot4.alternateSpine), slot0._onSpineLoaded, slot0)
end

function slot0._getOrCreateBoxSpine(slot0, slot1)
	slot2 = gohelper.findChild(slot0.go, slot1) or gohelper.create3d(slot0.go, slot1)

	return slot2, MonoHelper.addNoUpdateLuaComOnceToGo(slot2, UnitSpine)
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0.spineRenderer then
		slot0.spineRenderer:setSpine(slot1)
	end

	if slot0._callback then
		if slot0._callbackObj then
			slot0._callback(slot0._callbackObj, slot1, slot0)
		else
			slot0._callback(slot1, slot0)
		end
	end

	slot0._callback = nil
	slot0._callbackObj = nil
	slot0.parabolaMover = MonoHelper.addLuaComOnceToGo(slot0.spine:getSpineGO(), UnitMoverParabola, slot0)

	MonoHelper.addLuaComOnceToGo(slot0.spine:getSpineGO(), UnitMoverHandler, slot0)
end

return slot0

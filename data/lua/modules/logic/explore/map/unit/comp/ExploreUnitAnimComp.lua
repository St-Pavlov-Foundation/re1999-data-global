module("modules.logic.explore.map.unit.comp.ExploreUnitAnimComp", package.seeall)

slot0 = class("ExploreUnitAnimComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0._curAnim = nil
	slot0._curAnimHash = nil
	slot0._checkTime = 0
	slot0._playTime = 0
	slot0._showEffect = true
end

function slot0.setup(slot0, slot1)
	slot0.animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	if slot0.animator then
		slot0._goName = slot0.animator.runtimeAnimatorController.name
		slot0.animator.keepAnimatorControllerStateOnDisable = true
	else
		slot0._goName = nil
	end

	if slot0._curAnim then
		slot0:playAnim(slot0._curAnim)
	else
		slot0:playIdleAnim()
	end
end

function slot0.playIdleAnim(slot0)
	slot0:playAnim(slot0.unit:getIdleAnim(), true)
end

function slot0.onUpdate(slot0)
	if not slot0.animator then
		return
	end

	if slot0:isIdleAnim() then
		return
	end

	if slot0.unit:needUpdateHeroPos() then
		slot1 = ExploreController.instance:getMap():getHero()

		slot1:setPos(slot1:getPos())
	end

	if slot0._curAnim == ExploreAnimEnum.AnimName.exit and slot0.animator:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
		slot0:onAnimPlayEnd(ExploreAnimEnum.AnimName.exit, nil)
	elseif slot0._curAnimHash ~= slot1.shortNameHash then
		slot0:onAnimPlayEnd(slot0._curAnim, ExploreAnimEnum.AnimHashToName[slot1.shortNameHash])
	end
end

function slot0.onAnimPlayEnd(slot0, slot1, slot2)
	slot0:_setCurAnimName(slot2)
	slot0.unit:onAnimEnd(slot1, slot2)
end

function slot0.isIdleAnim(slot0, slot1)
	slot1 = slot1 or slot0._curAnim

	return ExploreAnimEnum.LoopAnims[slot1] or slot1 == nil
end

function slot0.haveAnim(slot0, slot1)
	if slot1 == nil then
		return false
	end

	if not slot0._goName then
		return false
	end

	return ExploreConfig.instance:getAnimLength(slot0._goName, slot1)
end

function slot0.playAnim(slot0, slot1, slot2)
	if not slot0.animator then
		slot0:_setCurAnimName(slot1, slot2)

		if ExploreAnimEnum.NextAnimName[slot1] and ExploreAnimEnum.NextAnimName[slot1] ~= slot1 then
			slot0.unit:onAnimEnd(slot1, ExploreAnimEnum.NextAnimName[slot1])
			slot0:playAnim(ExploreAnimEnum.NextAnimName[slot1], slot2)
		elseif not slot0:isIdleAnim(slot1) then
			slot0.unit:onAnimEnd(slot1, nil)
		end

		return
	end

	slot3 = nil

	if not slot0:haveAnim(slot1) and ExploreAnimEnum.NextAnimName[slot1] and ExploreAnimEnum.NextAnimName[slot1] ~= slot1 then
		slot3 = slot1
		slot1 = ExploreAnimEnum.NextAnimName[slot1]
	end

	slot4 = slot0._curAnim

	slot0:_setCurAnimName(slot1, slot2)

	slot6 = 0

	if slot0.animator:GetCurrentAnimatorStateInfo(0).shortNameHash ~= slot0._curAnimHash then
		slot4 = ExploreAnimEnum.AnimHashToName[slot7.shortNameHash]
	end

	if slot5 == slot0._curAnimHash then
		slot6 = slot7.normalizedTime
	elseif slot0.unit:isPairAnim(slot4, slot0._curAnim) then
		slot9 = ExploreConfig.instance:getAnimLength(slot0._goName, slot0._curAnim)

		if ExploreConfig.instance:getAnimLength(slot0._goName, slot4) and slot9 then
			slot6 = math.max(0, slot8 == slot9 and 1 - slot7.normalizedTime or 1 - (slot8 * slot7.normalizedTime - (slot8 - slot9)) / slot9)
		end
	end

	if slot0:haveAnim(slot1) then
		slot0.animator:Play(slot1, 0, slot6)
		slot0.animator:Update(0)
	end

	if slot3 then
		slot0.unit:onAnimEnd(slot3, slot1)
	end
end

function slot0.setShowEffect(slot0, slot1)
	slot0._showEffect = slot1
end

function slot0._setCurAnimName(slot0, slot1, slot2)
	slot0._curAnim = slot1
	slot0._curAnimHash = ExploreAnimEnum.AnimNameToHash[slot1]

	if slot0.unit.animEffectComp and slot0._showEffect then
		slot0.unit.animEffectComp:playAnim(slot1, slot2)
	end
end

function slot0.clear(slot0)
	if not slot0:isIdleAnim() then
		ExploreController.instance:dispatchEvent(ExploreEvent.OnUnitAnimEnd, slot0.unit.id, slot0._curAnim)
	end

	slot0._curAnim = nil
	slot0.animator = nil
end

function slot0.onDestroy(slot0)
	slot0:clear()
end

return slot0

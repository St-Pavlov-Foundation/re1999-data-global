module("modules.logic.explore.map.unit.comp.ExploreRoleAnimComp", package.seeall)

slot0 = class("ExploreRoleAnimComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0._curAnim = nil
	slot0._checkTime = 0
	slot0._lastSetIntValue = {}
	slot0._lastSetBoolValue = {}
	slot0._lastSetFloatValue = {}
end

function slot0.setup(slot0, slot1)
	slot0.animator = slot1:GetComponent(typeof(UnityEngine.Animator))

	if slot0._curAnim then
		slot0:playAnim(slot0._curAnim)
	else
		slot0:playIdleAnim()
	end
end

function slot0.playIdleAnim(slot0)
	slot0:playAnim(ExploreAnimEnum.RoleAnimName.idle)
end

function slot0.onUpdate(slot0)
	if not slot0.animator then
		return
	end

	if slot0:isIdleAnim() then
		return
	end

	slot0._checkTime = slot0._checkTime + UnityEngine.Time.deltaTime

	if slot0._checkTime < 0.1 then
		return
	end

	slot0._checkTime = 0

	if not slot0.animator:GetCurrentAnimatorStateInfo(0):IsName(slot0._curAnim) or slot1.normalizedTime >= 1 then
		slot0:onAnimPlayEnd()
	end
end

function slot0.onAnimPlayEnd(slot0)
end

function slot0.isIdleAnim(slot0)
	return slot0._curAnim == ExploreAnimEnum.RoleAnimName.idle
end

function slot0.onEnable(slot0)
	for slot4, slot5 in pairs(slot0._lastSetBoolValue) do
		slot0:setBool(slot4, slot5)
	end

	for slot4, slot5 in pairs(slot0._lastSetFloatValue) do
		slot0:setFloat(slot4, slot5)
	end

	for slot4, slot5 in pairs(slot0._lastSetIntValue) do
		slot0:setInteger(slot4, slot5)
	end
end

function slot0.setBool(slot0, slot1, slot2)
	if slot0.animator then
		slot0.animator:SetBool(slot1, slot2)
	end

	slot0._lastSetBoolValue[slot1] = slot2
end

function slot0.getBool(slot0, slot1)
	return slot0._lastSetBoolValue[slot1] or false
end

function slot0.setFloat(slot0, slot1, slot2)
	if slot0.animator then
		slot0.animator:SetFloat(slot1, slot2)
	end

	slot0._lastSetFloatValue[slot1] = slot2
end

function slot0.setInteger(slot0, slot1, slot2)
	if slot0.animator then
		slot0.animator:SetInteger(slot1, slot2)
	end

	slot0._lastSetIntValue[slot1] = slot2
end

function slot0.playAnim(slot0, slot1)
	if slot0._curAnim ~= slot1 then
		slot0._curAnim = slot1
		slot0._checkTime = 0

		if not slot0.animator then
			return
		end

		slot0.animator:Play(slot1, 0, 0)
	end
end

function slot0.clear(slot0)
	slot0._curAnim = nil
	slot0.animator = nil
end

function slot0.onDestroy(slot0)
	slot0:clear()

	slot0._lastSetIntValue = {}
	slot0._lastSetBoolValue = {}
	slot0._lastSetFloatValue = {}
end

return slot0

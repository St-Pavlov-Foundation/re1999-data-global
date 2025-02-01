module("modules.logic.fight.entity.comp.skill.FightTLEventCameraTrace", package.seeall)

slot0 = class("FightTLEventCameraTrace")
slot1 = {
	Attacker = 1,
	Defender = 2,
	Reset = 0,
	PosAbsDistRelateAtk = 4,
	PosAbs = 3
}

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot4 = GameSceneMgr.instance:getCurScene().camera

	slot4:setEaseTime(slot2)
	slot4:setEaseType(EaseType.Str2Type(slot3[5]))

	if (tonumber(slot3[1]) or 0) == uv0.Reset then
		slot4:resetParam()
	else
		if (tonumber(slot3[2]) or 0) > 0 then
			slot7 = slot4:getCurCO()

			if slot5 == uv0.PosAbsDistRelateAtk then
				slot9, slot10, slot11 = transformhelper.getPos(FightHelper.getEntity(slot1.fromId).go.transform)

				slot4:setDistance(slot6 - slot11)
			else
				slot4:setDistance(slot6)
			end
		else
			slot4:resetDistance(slot6)
		end

		if slot3[3] == "1" then
			slot10 = tonumber(slot8[2]) or 0
			slot11 = tonumber(slot8[3]) or 0
			slot12 = 0
			slot13 = 0
			slot14 = 0

			if slot5 == uv0.Attacker or slot5 == uv0.Defender then
				if FightHelper.getEntity(slot5 == uv0.Attacker and slot1.fromId or slot1.toId) then
					slot12, slot13, slot14 = FightHelper.getEntityWorldCenterPos(slot16)

					if not slot16:isMySide() then
						slot9 = -(tonumber(string.split(slot3[4], ",")[1]) or 0)
					end
				end
			elseif (slot5 == uv0.PosAbs or slot5 == uv0.PosAbsDistRelateAtk) and FightHelper.getEntity(slot1.fromId) and not slot15:isMySide() then
				slot9 = -slot9
			end

			slot4:setFocus(slot12 + slot9, slot13 + slot10, slot14 + slot11)
		else
			slot8 = slot4:getCurCO()

			slot4:setFocus(0, slot8.yOffset, slot8.focusZ)
		end
	end
end

return slot0

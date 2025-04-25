module("modules.logic.fight.entity.comp.skill.FightTLEventAtkFullEffect", package.seeall)

slot0 = class("FightTLEventAtkFullEffect")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	if not FightHelper.detectTimelinePlayEffectCondition(slot1, slot3[4]) then
		return
	end

	slot0._attacker = FightHelper.getEntity(slot1.fromId)

	if not slot0._attacker then
		return
	end

	if not string.nilorempty(slot3[10]) then
		slot0._attacker.effect:_onInvokeTokenRelease(slot3[10])

		return
	end

	slot4 = slot3[1]
	slot6 = 0
	slot7 = 0

	if slot3[2] then
		if string.split(slot3[2], ",")[1] then
			slot5 = tonumber(slot8[1]) or 0
		end

		if not slot0._attacker:isMySide() and slot3[5] ~= "1" then
			slot5 = -slot5
		end

		if slot8[2] then
			slot6 = tonumber(slot8[2]) or slot6
		end

		if slot8[3] then
			slot7 = tonumber(slot8[3]) or slot7
		end
	end

	if not string.nilorempty(slot3[6]) then
		for slot15, slot16 in ipairs(GameUtil.splitString2(slot3[6], true)) do
			if GameSceneMgr.instance:getCurScene():getCurLevelId() == slot16[1] and FightHelper.getEntityStanceId(slot0._attacker:getMO()) == slot16[2] then
				slot5 = slot5 + slot16[3] or 0
				slot6 = slot6 + slot16[4] or 0
				slot7 = slot7 + slot16[5] or 0
			end
		end
	end

	if not string.nilorempty(slot3[7]) and FightDataHelper.entityMgr:getNormalList(slot0._attacker:getSide() == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide)[1] then
		for slot17, slot18 in ipairs(GameUtil.splitString2(slot3[7], true)) do
			if GameSceneMgr.instance:getCurScene():getCurLevelId() == slot18[1] and FightHelper.getEntityStanceId(slot9) == slot18[2] then
				slot5 = slot5 + slot18[3] or 0
				slot6 = slot6 + slot18[4] or 0
				slot7 = slot7 + slot18[5] or 0
			end
		end
	end

	if string.nilorempty(slot4) then
		logError("atk effect name is nil")
	else
		slot0._releaseTime = nil

		if not string.nilorempty(slot3[11]) and slot3[11] ~= "0" then
			slot0._releaseTime = tonumber(slot3[11]) / FightModel.instance:getSpeed()
		end

		slot0._effectWrap = slot0._attacker.effect:addGlobalEffect(slot4, nil, slot0._releaseTime)
		slot8 = true

		if slot3[13] == "1" then
			gohelper.addChild(CameraMgr.instance:getMainCameraGO(), slot0._effectWrap.containerGO)

			slot8 = false
		end

		if (tonumber(slot3[3]) or -1) == -1 then
			FightRenderOrderMgr.instance:onAddEffectWrap(slot0._attacker.id, slot0._effectWrap)
		else
			FightRenderOrderMgr.instance:setEffectOrder(slot0._effectWrap, slot9)
		end

		if slot8 then
			slot0._effectWrap:setWorldPos(slot5, slot6, slot7)
		else
			slot0._effectWrap:setLocalPos(slot5, slot6, slot7)
		end

		slot0._releaseByServer = tonumber(slot3[8])

		if slot0._releaseByServer then
			slot0._attacker.effect:addServerRelease(slot0._releaseByServer, slot0._effectWrap)
		end

		slot0._tokenRelease = not string.nilorempty(slot3[9])

		if slot0._tokenRelease then
			slot0._attacker.effect:addTokenRelease(slot3[9], slot0._effectWrap)
		end

		slot0._roundRelease = not string.nilorempty(slot3[12])

		if slot0._roundRelease then
			slot0._attacker.effect:addRoundRelease(tonumber(slot3[12]), slot0._effectWrap)
		end
	end
end

function slot0.handleSkillEventEnd(slot0)
	slot0:_removeEffect()
end

function slot0.reset(slot0)
	slot0:_removeEffect()
end

function slot0.dispose(slot0)
	slot0:_removeEffect()
end

function slot0._removeEffect(slot0)
	slot1 = true

	if slot0._releaseByServer then
		slot1 = false
	end

	if slot0._tokenRelease then
		slot1 = false
	end

	if slot0._releaseTime then
		slot1 = false
	end

	if slot0._roundRelease then
		slot1 = false
	end

	if slot1 and slot0._effectWrap then
		slot0._attacker.effect:removeEffect(slot0._effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._attacker.id, slot0._effectWrap)
	end

	slot0._effectWrap = nil
	slot0._attacker = nil
end

return slot0

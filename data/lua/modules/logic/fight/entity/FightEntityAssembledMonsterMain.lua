module("modules.logic.fight.entity.FightEntityAssembledMonsterMain", package.seeall)

slot0 = class("FightEntityAssembledMonsterMain", FightEntityMonster)

function slot0.getHangPoint(slot0, slot1, slot2)
	if not slot2 and not string.nilorempty(slot1) and ModuleEnum.SpineHangPointRoot ~= slot1 then
		slot1 = string.format("%s_part_%d", slot1, slot0:getPartIndex())
	end

	return uv0.super.getHangPoint(slot0, slot1)
end

function slot0.getBuffAnim(slot0)
	slot1 = {}
	slot2 = {
		[slot10.uid] = slot9
	}

	for slot7, slot8 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if (isTypeOf(slot8, uv0) or isTypeOf(slot8, FightEntityAssembledMonsterSub)) and slot8.buff then
			slot9, slot10 = slot8.buff:getBuffAnim()

			if slot9 then
				table.insert(slot1, slot10)
			end
		end
	end

	if #slot1 > 0 then
		table.sort(slot1, FightBuffComp.buffCompareFuncAni)

		return slot2[slot1[1].uid]
	end
end

function slot0.getDefaultMatName(slot0)
	slot1 = {}
	slot2 = {
		[slot10.uid] = slot9
	}

	for slot7, slot8 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if (isTypeOf(slot8, uv0) or isTypeOf(slot8, FightEntityAssembledMonsterSub)) and slot8.buff then
			slot9, slot10 = slot8.buff:getBuffMatName()

			if slot9 then
				table.insert(slot1, slot10)
			end
		end
	end

	if #slot1 > 0 then
		table.sort(slot1, FightBuffComp.buffCompareFuncMat)

		return slot2[slot1[1].uid]
	end
end

function slot0.setAlpha(slot0, slot1, slot2)
	slot0:setAlphaData(slot0.id, slot1, slot2)
end

function slot0.setAlphaData(slot0, slot1, slot2, slot3)
	slot0._alphaDic = slot0._alphaDic or {}
	slot0._alphaDic[slot1] = slot2

	for slot7, slot8 in pairs(slot0._alphaDic) do
		if slot8 ~= slot2 then
			uv0.super.setAlpha(slot0, 1, 0)

			return
		end
	end

	uv0.super.setAlpha(slot0, slot2, slot3)
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
end

function slot0.getSpineClass(slot0)
	return FightAssembledMonsterSpine
end

function slot0.getPartIndex(slot0)
	if slot0:getMO() then
		return lua_fight_assembled_monster.configDict[slot1.skin].part
	end
end

function slot0.killAllSubMonster(slot0)
	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if FightHelper.isAssembledMonster(slot7) and slot7 ~= slot0 then
			GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(slot7:getTag(), slot7.id)

			slot8 = FightDataHelper.entityMgr:getById(slot7.id)

			slot8:setDead()
			FightDataHelper.entityMgr:addDeadUid(slot8.id)

			slot0._alphaDic[slot7.id] = nil
		end
	end
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
end

return slot0

module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

slot0 = class("FightEntityDataMgr")

function slot0.ctor(slot0)
	slot0._entityDataDic = {}
end

function slot0.getEntityMO(slot0, slot1)
	return slot0._entityDataDic[slot1]
end

function slot0.getAllEntityMO(slot0)
	return slot0._entityDataDic
end

function slot0.replaceEntityMO(slot0, slot1)
	slot0:refreshEntityByEntityMO(slot1)
end

function slot0.refreshEntityByEntityMO(slot0, slot1)
	if not slot0._entityDataDic[slot1.id] then
		slot0._entityDataDic[slot1.id] = FightEntityMO.New()
	end

	uv0.copyEntityMO(slot1, slot0._entityDataDic[slot1.id])
	slot0.dataMgr:getEntityEXDataMgr():setEXDataAfterAddEntityMO(slot1)
end

function slot0.addEntityMO(slot0, slot1, slot2)
	slot3 = FightEntityMO.New()

	slot3:init(slot1, slot2)
	slot3:setIsOnlyData()

	if slot3.currentHp <= 0 then
		slot3.isDead = true
	end

	slot0:refreshEntityByEntityMO(slot3)
end

function slot0.addEntityMOList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		slot0:addEntityMO(slot7, slot2)
	end
end

function slot0.addEntityMOListByFightMsg(slot0, slot1)
	slot0:addEntityMOList(slot1.attacker.entitys, FightEnum.EntitySide.MySide)
	slot0:addEntityMOList(slot1.attacker.subEntitys, FightEnum.EntitySide.MySide)
	slot0:addEntityMOList(slot1.defender.entitys, FightEnum.EntitySide.EnemySide)
	slot0:addEntityMOList(slot1.defender.subEntitys, FightEnum.EntitySide.EnemySide)
end

slot1 = {
	class = true,
	isOnlyData = true
}

function slot0.copyEntityMO(slot0, slot1)
	tabletool.clear(slot1)

	for slot5, slot6 in pairs(slot0) do
		slot7 = false

		if uv0 and uv0[slot5] then
			slot7 = true
		end

		if not slot7 then
			if type(slot6) == "table" then
				slot1[slot5] = FightHelper.deepCopySimpleWithMeta(slot6, uv0)
			else
				slot1[slot5] = slot6
			end
		end
	end

	slot1.buffModel:clear()

	for slot6, slot7 in ipairs(slot0.buffModel:getList()) do
		slot1:addBuff(slot7)
	end
end

return slot0

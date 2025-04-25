module("modules.logic.fight.model.data.FightEntityDataMgr", package.seeall)

slot0 = FightDataClass("FightEntityDataMgr")
slot1 = {
	normal = "normal",
	assistBoss = "assistBoss",
	ASFD_emitter = "ASFD_emitter",
	sp = "sp",
	sub = "sub",
	player = "player"
}

function slot0.onConstructor(slot0)
	slot0._entityDataDic = {}
	slot0._sideDic = {}

	for slot5, slot6 in ipairs({
		FightEnum.EntitySide.MySide,
		FightEnum.EntitySide.EnemySide
	}) do
		slot0._sideDic[slot6] = {}

		for slot10, slot11 in pairs(uv0) do
			slot0._sideDic[slot6][slot11] = {}
		end
	end

	slot0._deadUids = {}
end

function slot0.getAllEntityList(slot0, slot1, slot2)
	slot1 = slot1 or {}

	for slot6, slot7 in pairs(uv0) do
		slot0:getList(FightEnum.EntitySide.MySide, slot7, slot1, slot2)
		slot0:getList(FightEnum.EntitySide.EnemySide, slot7, slot1, slot2)
	end

	return slot1
end

function slot0.getSideList(slot0, slot1, slot2, slot3)
	slot4 = slot2 or {}

	for slot8, slot9 in pairs(uv0) do
		slot0:getList(slot1, slot9, slot4, slot3)
	end

	return slot4
end

function slot0.getPlayerList(slot0, slot1, slot2, slot3)
	return slot0:getList(slot1, uv0.player, slot2, slot3)
end

function slot0.getMyPlayerList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.MySide, uv0.player, slot1, slot2)
end

function slot0.getEnemyPlayerList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.EnemySide, uv0.player, slot1, slot2)
end

function slot0.getMyVertin(slot0)
	return slot0:getMyPlayerList()[1]
end

function slot0.getEnemyVertin(slot0)
	return slot0:getEnemyPlayerList()[1]
end

function slot0.getNormalList(slot0, slot1, slot2, slot3)
	return slot0:getList(slot1, uv0.normal, slot2, slot3)
end

function slot0.getMyNormalList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.MySide, uv0.normal, slot1, slot2)
end

function slot0.getEnemyNormalList(slot0, slot1, slot2)
	slot3 = slot0:getList(FightEnum.EntitySide.EnemySide, uv0.normal, slot1, slot2)

	table.sort(slot3, FightHelper.sortAssembledMonsterFunc)

	return slot3
end

function slot0.getSubList(slot0, slot1, slot2, slot3)
	return slot0:getList(slot1, uv0.sub, slot2, slot3)
end

function slot0.getMySubList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.MySide, uv0.sub, slot1, slot2)
end

function slot0.getEnemySubList(slot0, slot1, slot2, slot3)
	return slot0:getList(FightEnum.EntitySide.EnemySide, uv0.sub, slot2, slot3)
end

function slot0.getSpList(slot0, slot1, slot2, slot3)
	return slot0:getList(slot1, uv0.sp, slot2, slot3)
end

function slot0.getMySpList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.MySide, uv0.sp, slot1, slot2)
end

function slot0.getEnemySpList(slot0, slot1, slot2)
	return slot0:getList(FightEnum.EntitySide.EnemySide, uv0.sp, slot1, slot2)
end

function slot0.getAssistBoss(slot0)
	return slot0._sideDic[FightEnum.EntitySide.MySide][uv0.assistBoss][1]
end

function slot0.getASFDEntityMo(slot0, slot1)
	slot3 = slot0._sideDic[slot1] and slot2[uv0.ASFD_emitter]

	return slot3 and slot3[1]
end

function slot0.getDeadList(slot0, slot1, slot2)
	slot3 = slot2 or {}

	for slot7, slot8 in pairs(slot0._entityDataDic) do
		if slot8.side == slot1 and slot8:isStatusDead() then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getMyDeadList(slot0, slot1)
	return slot0:getDeadList(FightEnum.EntitySide.MySide, slot1)
end

function slot0.getEnemyDeadList(slot0, slot1, slot2)
	return slot0:getDeadList(FightEnum.EntitySide.EnemySide, slot2)
end

function slot0.getList(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot3 or {}

	for slot9, slot10 in ipairs(slot0._sideDic[slot1][slot2]) do
		slot11 = false

		if slot10:isStatusDead() and not slot4 then
			slot11 = true
		end

		if not slot11 then
			table.insert(slot5, slot10)
		end
	end

	return slot5
end

function slot0.getOriginSide(slot0, slot1)
	return slot0._sideDic[slot1]
end

function slot0.getOriginNormalList(slot0, slot1)
	return slot0._sideDic[slot1][uv0.normal]
end

function slot0.getOriginSubList(slot0, slot1)
	return slot0._sideDic[slot1][uv0.sub]
end

function slot0.getOriginSpList(slot0, slot1)
	return slot0._sideDic[slot1][uv0.sp]
end

function slot0.getOriginASFDEmitterList(slot0, slot1)
	return slot0._sideDic[slot1][uv0.ASFD_emitter]
end

function slot0.getOriginListById(slot0, slot1)
	if slot0:getById(slot1) then
		for slot8, slot9 in pairs(slot0._sideDic[slot2.side]) do
			for slot13, slot14 in ipairs(slot9) do
				if slot14.uid == slot2.uid then
					return slot9
				end
			end
		end
	end

	return {}
end

function slot0.isSub(slot0, slot1)
	for slot5, slot6 in pairs(slot0._sideDic) do
		for slot10, slot11 in ipairs(slot6[uv0.sub]) do
			if slot11.id == slot1 then
				return true
			end
		end
	end
end

function slot0.isMySub(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._sideDic[FightEnum.EntitySide.MySide][uv0.sub]) do
		if slot6.id == slot1 then
			return true
		end
	end
end

function slot0.isSp(slot0, slot1)
	for slot5, slot6 in pairs(slot0._sideDic) do
		for slot10, slot11 in ipairs(slot6[uv0.sp]) do
			if slot11.id == slot1 then
				return true
			end
		end
	end
end

function slot0.isAssistBoss(slot0, slot1)
	return slot0:getAssistBoss() and slot2.id == slot1
end

function slot0.isMySp(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._sideDic[FightEnum.EntitySide.MySide][uv0.sp]) do
		if slot6.id == slot1 then
			return true
		end
	end
end

function slot0.addDeadUid(slot0, slot1)
	slot0._deadUids[slot1] = true
end

function slot0.isDeadUid(slot0, slot1)
	return slot0._deadUids[slot1]
end

function slot0.removeEntity(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._entityDataDic[slot1] then
		return
	end

	slot0._entityDataDic[slot1] = nil

	for slot6, slot7 in pairs(slot0._sideDic) do
		for slot11, slot12 in pairs(slot7) do
			for slot16, slot17 in ipairs(slot12) do
				if slot17.id == slot2.id then
					table.remove(slot12, slot16)

					break
				end
			end
		end
	end

	return slot2
end

function slot0.getById(slot0, slot1)
	return slot0._entityDataDic[slot1]
end

function slot0.getByPosId(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0._sideDic[slot1]) do
		for slot11, slot12 in ipairs(slot7) do
			if not slot12:isStatusDead() and slot12.position == slot2 then
				return slot12
			end
		end
	end
end

function slot0.getOldEntityMO(slot0, slot1)
	slot2 = FightEntityMO.New()

	FightDataHelper.coverData(slot0:getById(slot1), slot2)

	return slot2
end

function slot0.getAllEntityData(slot0)
	return slot0._entityDataDic
end

function slot0.getAllEntityMO(slot0)
	return slot0._entityDataDic
end

function slot0.addEntityMO(slot0, slot1)
	return slot0:refreshEntityByEntityMO(slot1)
end

function slot0.replaceEntityMO(slot0, slot1)
	return slot0:refreshEntityByEntityMO(slot1)
end

function slot0.refreshEntityByEntityMO(slot0, slot1)
	if not slot0._entityDataDic[slot1.id] then
		slot0._entityDataDic[slot1.id] = FightEntityMO.New()
	end

	FightEntityDataHelper.copyEntityMO(slot1, slot2)
	slot0.dataMgr.entityExMgr:setEXDataAfterAddEntityMO(slot1)

	return slot2
end

function slot0.addEntityMOByProto(slot0, slot1, slot2)
	FightEntityMO.New():init(slot1, slot2)

	if FightModel.instance:getVersion() >= 4 then
		if slot3:isStatusDead() then
			slot0:addDeadUid(slot3.id)
		end
	elseif slot3.currentHp <= 0 then
		slot3:setDead()
		slot0:addDeadUid(slot3.id)
	end

	return slot0:addEntityMO(slot3)
end

function slot0.initEntityListByProto(slot0, slot1, slot2, slot3)
	tabletool.clear(slot3)

	for slot7, slot8 in ipairs(slot1) do
		table.insert(slot3, slot0:addEntityMOByProto(slot8, slot2))
	end
end

function slot0.initOneEntityListByProto(slot0, slot1, slot2, slot3)
	tabletool.clear(slot3)
	table.insert(slot3, slot0:addEntityMOByProto(slot1, slot2))
end

function slot0.updateData(slot0, slot1)
	slot2 = slot0._sideDic[FightEnum.EntitySide.MySide]
	slot3 = slot0._sideDic[FightEnum.EntitySide.EnemySide]

	if slot1.attacker:HasField("playerEntity") then
		slot0:initOneEntityListByProto(slot1.attacker.playerEntity, FightEnum.EntitySide.MySide, slot2[uv0.player])
	end

	slot0:initEntityListByProto(slot1.attacker.entitys, FightEnum.EntitySide.MySide, slot2[uv0.normal])
	slot0:initEntityListByProto(slot1.attacker.subEntitys, FightEnum.EntitySide.MySide, slot2[uv0.sub])
	slot0:initEntityListByProto(slot1.attacker.spEntitys, FightEnum.EntitySide.MySide, slot2[uv0.sp])

	if slot1.attacker:HasField("assistBoss") then
		slot0:initOneEntityListByProto(slot1.attacker.assistBoss, FightEnum.EntitySide.MySide, slot2[uv0.assistBoss])
	end

	if slot1.attacker:HasField("emitter") then
		slot0:initOneEntityListByProto(slot1.attacker.emitter, FightEnum.EntitySide.MySide, slot2[uv0.ASFD_emitter])
	end

	if slot1.defender:HasField("playerEntity") then
		slot0:initOneEntityListByProto(slot1.defender.playerEntity, FightEnum.EntitySide.EnemySide, slot3[uv0.player])
	end

	slot0:initEntityListByProto(slot1.defender.entitys, FightEnum.EntitySide.EnemySide, slot3[uv0.normal])
	slot0:initEntityListByProto(slot1.defender.subEntitys, FightEnum.EntitySide.EnemySide, slot3[uv0.sub])
	slot0:initEntityListByProto(slot1.defender.spEntitys, FightEnum.EntitySide.EnemySide, slot3[uv0.sp])

	if slot1.defender:HasField("emitter") then
		slot0:initOneEntityListByProto(slot1.defender.emitter, FightEnum.EntitySide.EnemySide, slot3[uv0.ASFD_emitter])
	end
end

function slot0.clientTestSetEntity(slot0, slot1, slot2, slot3)
	slot0:clientSetEntityList(slot1, uv0.normal, slot2)
	slot0:clientSetEntityList(slot1, uv0.sub, slot3)
end

function slot0.clientSetEntityList(slot0, slot1, slot2, slot3)
	tabletool.clear(slot0._sideDic[slot1][slot2])

	for slot8, slot9 in ipairs(slot3) do
		table.insert(slot4, slot0:addEntityMO(slot9))
	end
end

function slot0.clientSetSubEntityList(slot0, slot1, slot2)
	slot0:clientSetEntityList(slot1, uv0.sub, slot2)
end

return slot0

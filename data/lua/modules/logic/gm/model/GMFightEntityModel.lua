module("modules.logic.gm.model.GMFightEntityModel", package.seeall)

slot0 = class("GMFightEntityModel", ListScrollModel)

function slot0.ctor(slot0)
	uv0.super.ctor(slot0)

	slot0.entityMO = nil
	slot0.buffModel = ListScrollModel.New()
	slot0.skillModel = ListScrollModel.New()
	slot0.attrModel = ListScrollModel.New()
end

function slot0.onOpen(slot0)
	slot1 = {}

	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, slot1, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, slot1, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide, slot1, true)
	FightDataHelper.entityMgr:getMyPlayerList(slot1, true)

	if FightDataHelper.entityMgr:getAssistBoss() then
		table.insert(slot1, slot2)
	end

	if FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide) then
		table.insert(slot1, slot3)
	end

	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, slot1, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.EnemySide, slot1, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide, slot1, true)
	FightDataHelper.entityMgr:getEnemyPlayerList(slot1, true)

	if FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide) then
		table.insert(slot1, slot3)
	end

	slot0:setList(slot1)
end

function slot0._addList(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2:getList()) do
		table.insert(slot1, slot7)
	end
end

function slot0.setEntityMO(slot0, slot1)
	slot0.entityMO = slot1

	slot0.buffModel:setList(slot1:getBuffList())

	slot2 = {}

	for slot6, slot7 in ipairs(slot1.skillList) do
		if lua_skill.configDict[slot7] then
			table.insert(slot2, slot8)
		end
	end

	slot0.skillModel:setList(slot2)
	slot0:setEntityDetailInfo(slot1)
end

function slot0.onGetSingleEntityInfo(slot0, slot1)
	slot0:setEntityMO(slot0.entityMO)
end

function slot0.onGetEntityDetailInfos(slot0, slot1)
	slot0._attrEntityList = {}
	slot0._attrEntityDict = {}

	for slot5, slot6 in ipairs(slot1.teamAInfos) do
		table.insert(slot0._attrEntityList, slot6)

		slot0._attrEntityDict[slot6.info.uid] = slot6
	end

	for slot5, slot6 in ipairs(slot1.teamBInfos) do
		table.insert(slot0._attrEntityList, slot6)

		slot0._attrEntityDict[slot6.info.uid] = slot6
	end

	slot0:setEntityDetailInfo(slot0.entityMO)
end

function slot0.setEntityDetailInfo(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._attrEntityDict[slot1.id] then
		return
	end

	slot3 = slot2.info.attr
	slot4 = slot2.exAttr
	slot5 = slot2.spAttr
	slot6 = slot2.addAttrPer
	slot7 = slot2.addExAttr
	slot8 = slot2.addSpAttr
	slot9 = slot2.testAddAttrPer
	slot10 = slot2.testAddExAttr
	slot11 = slot2.testAddSpAttr
	slot12 = slot2.partAttrBase
	slot13 = slot2.partExAttr
	slot14 = slot2.partSpAttr
	slot15 = slot2.testPartAttrBase
	slot16 = slot2.testPartExAttr
	slot17 = slot2.testPartSpAttr
	slot18 = slot2.finalAttrBase
	slot19 = slot2.finalExAttr
	slot20 = slot2.finalSpAttr
	slot21 = {}

	table.insert(slot21, slot0:getAttrMo(101, slot3.hp, slot6.hp, slot9.hp, slot12.hp, slot15.hp, slot18.hp))
	table.insert(slot21, slot0:getAttrMo(102, slot3.attack, slot6.attack, slot9.attack, slot12.attack, slot15.attack, slot18.attack))
	table.insert(slot21, slot0:getAttrMo(103, slot3.defense, slot6.defense, slot9.defense, slot12.defense, slot15.defense, slot18.defense))
	table.insert(slot21, slot0:getAttrMo(104, slot3.mdefense, slot6.mdefense, slot9.mdefense, slot12.mdefense, slot15.mdefense, slot18.mdefense))
	table.insert(slot21, slot0:getAttrMo(105, slot3.technic, slot6.technic, slot9.technic, slot12.technic, slot15.technic, slot18.technic))
	table.insert(slot21, slot0:getAttrMo(201, slot4.cri, slot7.cri, slot10.cri, slot13.cri, slot16.cri, slot19.cri))
	table.insert(slot21, slot0:getAttrMo(202, slot4.recri, slot7.recri, slot10.recri, slot13.recri, slot16.recri, slot19.recri))
	table.insert(slot21, slot0:getAttrMo(203, slot4.criDmg, slot7.criDmg, slot10.criDmg, slot13.criDmg, slot16.criDmg, slot19.criDmg))
	table.insert(slot21, slot0:getAttrMo(204, slot4.criDef, slot7.criDef, slot10.criDef, slot13.criDef, slot16.criDef, slot19.criDef))
	table.insert(slot21, slot0:getAttrMo(205, slot4.addDmg, slot7.addDmg, slot10.addDmg, slot13.addDmg, slot16.addDmg, slot19.addDmg))
	table.insert(slot21, slot0:getAttrMo(206, slot4.dropDmg, slot7.dropDmg, slot10.dropDmg, slot13.dropDmg, slot16.dropDmg, slot19.dropDmg))
	table.insert(slot21, slot0:getAttrMo(207, slot5.finalAddDmg, slot8.finalAddDmg, slot11.finalAddDmg, slot14.finalAddDmg, slot17.finalAddDmg, slot20.finalAddDmg))
	table.insert(slot21, slot0:getAttrMo(208, slot5.finalDropDmg, slot8.finalDropDmg, slot11.finalDropDmg, slot14.finalDropDmg, slot17.finalDropDmg, slot20.dropDmg))
	table.insert(slot21, slot0:getAttrMo(209, slot5.revive, slot8.revive, slot11.revive, slot14.revive, slot17.revive, slot20.revive))
	table.insert(slot21, slot0:getAttrMo(210, slot5.absorb, slot8.absorb, slot11.absorb, slot14.absorb, slot17.absorb, slot20.absorb))
	table.insert(slot21, slot0:getAttrMo(211, slot5.clutch, slot8.clutch, slot11.clutch, slot14.clutch, slot17.clutch, slot20.clutch))
	table.insert(slot21, slot0:getAttrMo(212, slot5.heal, slot8.heal, slot11.heal, slot14.heal, slot17.heal, slot20.heal))
	table.insert(slot21, slot0:getAttrMo(213, slot5.defenseIgnore, slot8.defenseIgnore, slot11.defenseIgnore, slot14.defenseIgnore, slot17.defenseIgnore, slot20.defenseIgnore))
	table.insert(slot21, slot0:getAttrMo(214, slot5.normalSkillRate, slot8.normalSkillRate, slot11.normalSkillRate, slot14.normalSkillRate, slot17.normalSkillRate, slot20.normalSkillRate))
	table.insert(slot21, slot0:getAttrMo(215, slot5.playAddRate, slot8.playAddRate, slot11.playAddRate, slot14.playAddRate, slot17.playAddRate, slot20.playAddRate))
	table.insert(slot21, slot0:getAttrMo(216, slot5.playDropRate, slot8.playDropRate, slot11.playDropRate, slot14.playDropRate, slot17.playDropRate, slot20.playDropRate))
	table.insert(slot21, slot0:getAttrMo(401, slot5.dizzyResistances, slot8.dizzyResistances, slot11.dizzyResistances, slot14.dizzyResistances, slot17.dizzyResistances, slot20.dizzyResistances))
	table.insert(slot21, slot0:getAttrMo(402, slot5.sleepResistances, slot8.sleepResistances, slot11.sleepResistances, slot14.sleepResistances, slot17.sleepResistances, slot20.sleepResistances))
	table.insert(slot21, slot0:getAttrMo(403, slot5.petrifiedResistances, slot8.petrifiedResistances, slot11.petrifiedResistances, slot14.petrifiedResistances, slot17.petrifiedResistances, slot20.petrifiedResistances))
	table.insert(slot21, slot0:getAttrMo(404, slot5.frozenResistances, slot8.frozenResistances, slot11.frozenResistances, slot14.frozenResistances, slot17.frozenResistances, slot20.frozenResistances))
	table.insert(slot21, slot0:getAttrMo(405, slot5.disarmResistances, slot8.disarmResistances, slot11.disarmResistances, slot14.disarmResistances, slot17.disarmResistances, slot20.disarmResistances))
	table.insert(slot21, slot0:getAttrMo(406, slot5.forbidResistances, slot8.forbidResistances, slot11.forbidResistances, slot14.forbidResistances, slot17.forbidResistances, slot20.forbidResistances))
	table.insert(slot21, slot0:getAttrMo(407, slot5.sealResistances, slot8.sealResistances, slot11.sealResistances, slot14.sealResistances, slot17.sealResistances, slot20.sealResistances))
	table.insert(slot21, slot0:getAttrMo(408, slot5.cantGetExskillResistances, slot8.cantGetExskillResistances, slot11.cantGetExskillResistances, slot14.cantGetExskillResistances, slot17.cantGetExskillResistances, slot20.cantGetExskillResistances))
	table.insert(slot21, slot0:getAttrMo(409, slot5.delExPointResistances, slot8.delExPointResistances, slot11.delExPointResistances, slot14.delExPointResistances, slot17.delExPointResistances, slot20.delExPointResistances))
	table.insert(slot21, slot0:getAttrMo(410, slot5.stressUpResistances, slot8.stressUpResistances, slot11.stressUpResistances, slot14.stressUpResistances, slot17.stressUpResistances, slot20.stressUpResistances))
	table.insert(slot21, slot0:getAttrMo(411, slot5.charmResistances, slot8.charmResistances, slot11.charmResistances, slot14.charmResistances, slot17.charmResistances, slot20.charmResistances))
	table.insert(slot21, slot0:getAttrMo(501, slot5.controlResilience, slot8.controlResilience, slot11.controlResilience, slot14.controlResilience, slot17.controlResilience, slot20.controlResilience))
	table.insert(slot21, slot0:getAttrMo(502, slot5.delExPointResilience, slot8.delExPointResilience, slot11.delExPointResilience, slot14.delExPointResilience, slot17.delExPointResilience, slot20.delExPointResilience))
	table.insert(slot21, slot0:getAttrMo(503, slot5.stressUpResilience, slot8.stressUpResilience, slot11.stressUpResilience, slot14.stressUpResilience, slot17.stressUpResilience, slot20.stressUpResilience))
	slot0.attrModel:setList(slot21)
end

function slot0.getAttrMo(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot0.attrPool = slot0.attrPool or {}

	if not slot0.attrPool[slot1] then
		slot0.attrPool[slot1] = {
			id = slot1
		}
	end

	slot8.base = slot2
	slot8.add = slot3
	slot8.test = slot4
	slot8.partAdd = slot5
	slot8.partTest = slot6
	slot8.final = slot7

	return slot8
end

slot0.instance = slot0.New()

return slot0

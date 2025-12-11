module("modules.logic.gm.model.GMFightEntityModel", package.seeall)

local var_0_0 = class("GMFightEntityModel", ListScrollModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.entityMO = nil
	arg_1_0.buffModel = ListScrollModel.New()
	arg_1_0.skillModel = ListScrollModel.New()
	arg_1_0.attrModel = ListScrollModel.New()
end

function var_0_0.onOpen(arg_2_0)
	local var_2_0 = {}

	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, var_2_0, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, var_2_0, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.MySide, var_2_0, true)
	FightDataHelper.entityMgr:getMyPlayerList(var_2_0, true)

	local var_2_1 = FightDataHelper.entityMgr:getAssistBoss()

	if var_2_1 then
		table.insert(var_2_0, var_2_1)
	end

	local var_2_2 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.MySide)

	if var_2_2 then
		table.insert(var_2_0, var_2_2)
	end

	local var_2_3 = FightDataHelper.entityMgr:getVorpalith()

	if var_2_3 then
		table.insert(var_2_0, var_2_3)
	end

	FightDataHelper.entityMgr:getMySpFightEntities(var_2_0, true)
	FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.EnemySide, var_2_0, true)
	FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.EnemySide, var_2_0, true)
	FightDataHelper.entityMgr:getSpList(FightEnum.EntitySide.EnemySide, var_2_0, true)
	FightDataHelper.entityMgr:getEnemyPlayerList(var_2_0, true)

	local var_2_4 = FightDataHelper.entityMgr:getASFDEntityMo(FightEnum.EntitySide.EnemySide)

	if var_2_4 then
		table.insert(var_2_0, var_2_4)
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0._addList(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in ipairs(arg_3_2:getList()) do
		table.insert(arg_3_1, iter_3_1)
	end
end

function var_0_0.setEntityMO(arg_4_0, arg_4_1)
	arg_4_0.entityMO = arg_4_1

	arg_4_0.buffModel:setList(arg_4_1:getBuffList())

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.skillList) do
		local var_4_1 = lua_skill.configDict[iter_4_1]

		if var_4_1 then
			table.insert(var_4_0, var_4_1)
		end
	end

	arg_4_0.skillModel:setList(var_4_0)
	arg_4_0:setEntityDetailInfo(arg_4_1)
end

function var_0_0.onGetSingleEntityInfo(arg_5_0, arg_5_1)
	arg_5_0:setEntityMO(arg_5_0.entityMO)
end

function var_0_0.onGetEntityDetailInfos(arg_6_0, arg_6_1)
	arg_6_0._attrEntityList = {}
	arg_6_0._attrEntityDict = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.teamAInfos) do
		table.insert(arg_6_0._attrEntityList, iter_6_1)

		arg_6_0._attrEntityDict[iter_6_1.info.uid] = iter_6_1
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.teamBInfos) do
		table.insert(arg_6_0._attrEntityList, iter_6_3)

		arg_6_0._attrEntityDict[iter_6_3.info.uid] = iter_6_3
	end

	arg_6_0:setEntityDetailInfo(arg_6_0.entityMO)
end

function var_0_0.setEntityDetailInfo(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = arg_7_0._attrEntityDict and arg_7_0._attrEntityDict[arg_7_1.id]

	if not var_7_0 then
		return
	end

	local var_7_1 = var_7_0.info.attr
	local var_7_2 = var_7_0.exAttr
	local var_7_3 = var_7_0.spAttr
	local var_7_4 = var_7_0.addAttrPer
	local var_7_5 = var_7_0.addExAttr
	local var_7_6 = var_7_0.addSpAttr
	local var_7_7 = var_7_0.testAddAttrPer
	local var_7_8 = var_7_0.testAddExAttr
	local var_7_9 = var_7_0.testAddSpAttr
	local var_7_10 = var_7_0.partAttrBase
	local var_7_11 = var_7_0.partExAttr
	local var_7_12 = var_7_0.partSpAttr
	local var_7_13 = var_7_0.testPartAttrBase
	local var_7_14 = var_7_0.testPartExAttr
	local var_7_15 = var_7_0.testPartSpAttr
	local var_7_16 = var_7_0.finalAttrBase
	local var_7_17 = var_7_0.finalExAttr
	local var_7_18 = var_7_0.finalSpAttr
	local var_7_19 = {}

	table.insert(var_7_19, arg_7_0:getAttrMo(101, var_7_1.hp, var_7_4.hp, var_7_7.hp, var_7_10.hp, var_7_13.hp, var_7_16.hp))
	table.insert(var_7_19, arg_7_0:getAttrMo(102, var_7_1.attack, var_7_4.attack, var_7_7.attack, var_7_10.attack, var_7_13.attack, var_7_16.attack))
	table.insert(var_7_19, arg_7_0:getAttrMo(103, var_7_1.defense, var_7_4.defense, var_7_7.defense, var_7_10.defense, var_7_13.defense, var_7_16.defense))
	table.insert(var_7_19, arg_7_0:getAttrMo(104, var_7_1.mdefense, var_7_4.mdefense, var_7_7.mdefense, var_7_10.mdefense, var_7_13.mdefense, var_7_16.mdefense))
	table.insert(var_7_19, arg_7_0:getAttrMo(105, var_7_1.technic, var_7_4.technic, var_7_7.technic, var_7_10.technic, var_7_13.technic, var_7_16.technic))
	table.insert(var_7_19, arg_7_0:getAttrMo(201, var_7_2.cri, var_7_5.cri, var_7_8.cri, var_7_11.cri, var_7_14.cri, var_7_17.cri))
	table.insert(var_7_19, arg_7_0:getAttrMo(202, var_7_2.recri, var_7_5.recri, var_7_8.recri, var_7_11.recri, var_7_14.recri, var_7_17.recri))
	table.insert(var_7_19, arg_7_0:getAttrMo(203, var_7_2.criDmg, var_7_5.criDmg, var_7_8.criDmg, var_7_11.criDmg, var_7_14.criDmg, var_7_17.criDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(204, var_7_2.criDef, var_7_5.criDef, var_7_8.criDef, var_7_11.criDef, var_7_14.criDef, var_7_17.criDef))
	table.insert(var_7_19, arg_7_0:getAttrMo(205, var_7_2.addDmg, var_7_5.addDmg, var_7_8.addDmg, var_7_11.addDmg, var_7_14.addDmg, var_7_17.addDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(206, var_7_2.dropDmg, var_7_5.dropDmg, var_7_8.dropDmg, var_7_11.dropDmg, var_7_14.dropDmg, var_7_17.dropDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(207, var_7_3.finalAddDmg, var_7_6.finalAddDmg, var_7_9.finalAddDmg, var_7_12.finalAddDmg, var_7_15.finalAddDmg, var_7_18.finalAddDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(208, var_7_3.finalDropDmg, var_7_6.finalDropDmg, var_7_9.finalDropDmg, var_7_12.finalDropDmg, var_7_15.finalDropDmg, var_7_18.dropDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(209, var_7_3.revive, var_7_6.revive, var_7_9.revive, var_7_12.revive, var_7_15.revive, var_7_18.revive))
	table.insert(var_7_19, arg_7_0:getAttrMo(210, var_7_3.absorb, var_7_6.absorb, var_7_9.absorb, var_7_12.absorb, var_7_15.absorb, var_7_18.absorb))
	table.insert(var_7_19, arg_7_0:getAttrMo(211, var_7_3.clutch, var_7_6.clutch, var_7_9.clutch, var_7_12.clutch, var_7_15.clutch, var_7_18.clutch))
	table.insert(var_7_19, arg_7_0:getAttrMo(212, var_7_3.heal, var_7_6.heal, var_7_9.heal, var_7_12.heal, var_7_15.heal, var_7_18.heal))
	table.insert(var_7_19, arg_7_0:getAttrMo(213, var_7_3.defenseIgnore, var_7_6.defenseIgnore, var_7_9.defenseIgnore, var_7_12.defenseIgnore, var_7_15.defenseIgnore, var_7_18.defenseIgnore))
	table.insert(var_7_19, arg_7_0:getAttrMo(214, var_7_3.normalSkillRate, var_7_6.normalSkillRate, var_7_9.normalSkillRate, var_7_12.normalSkillRate, var_7_15.normalSkillRate, var_7_18.normalSkillRate))
	table.insert(var_7_19, arg_7_0:getAttrMo(215, var_7_3.playAddRate, var_7_6.playAddRate, var_7_9.playAddRate, var_7_12.playAddRate, var_7_15.playAddRate, var_7_18.playAddRate))
	table.insert(var_7_19, arg_7_0:getAttrMo(216, var_7_3.playDropRate, var_7_6.playDropRate, var_7_9.playDropRate, var_7_12.playDropRate, var_7_15.playDropRate, var_7_18.playDropRate))
	table.insert(var_7_19, arg_7_0:getAttrMo(218, var_7_3.reboundDmg, var_7_6.reboundDmg, var_7_9.reboundDmg, var_7_12.reboundDmg, var_7_15.reboundDmg, var_7_18.reboundDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(219, var_7_3.extraDmg, var_7_6.extraDmg, var_7_9.extraDmg, var_7_12.extraDmg, var_7_15.extraDmg, var_7_18.extraDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(220, var_7_3.reuseDmg, var_7_6.reuseDmg, var_7_9.reuseDmg, var_7_12.reuseDmg, var_7_15.reuseDmg, var_7_18.reuseDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(221, var_7_3.bigSkillRate, var_7_6.bigSkillRate, var_7_9.bigSkillRate, var_7_12.bigSkillRate, var_7_15.bigSkillRate, var_7_18.bigSkillRate))
	table.insert(var_7_19, arg_7_0:getAttrMo(222, var_7_3.clutchDmg, var_7_6.clutchDmg, var_7_9.clutchDmg, var_7_12.clutchDmg, var_7_15.clutchDmg, var_7_18.clutchDmg))
	table.insert(var_7_19, arg_7_0:getAttrMo(401, var_7_3.dizzyResistances, var_7_6.dizzyResistances, var_7_9.dizzyResistances, var_7_12.dizzyResistances, var_7_15.dizzyResistances, var_7_18.dizzyResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(402, var_7_3.sleepResistances, var_7_6.sleepResistances, var_7_9.sleepResistances, var_7_12.sleepResistances, var_7_15.sleepResistances, var_7_18.sleepResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(403, var_7_3.petrifiedResistances, var_7_6.petrifiedResistances, var_7_9.petrifiedResistances, var_7_12.petrifiedResistances, var_7_15.petrifiedResistances, var_7_18.petrifiedResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(404, var_7_3.frozenResistances, var_7_6.frozenResistances, var_7_9.frozenResistances, var_7_12.frozenResistances, var_7_15.frozenResistances, var_7_18.frozenResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(405, var_7_3.disarmResistances, var_7_6.disarmResistances, var_7_9.disarmResistances, var_7_12.disarmResistances, var_7_15.disarmResistances, var_7_18.disarmResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(406, var_7_3.forbidResistances, var_7_6.forbidResistances, var_7_9.forbidResistances, var_7_12.forbidResistances, var_7_15.forbidResistances, var_7_18.forbidResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(407, var_7_3.sealResistances, var_7_6.sealResistances, var_7_9.sealResistances, var_7_12.sealResistances, var_7_15.sealResistances, var_7_18.sealResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(408, var_7_3.cantGetExskillResistances, var_7_6.cantGetExskillResistances, var_7_9.cantGetExskillResistances, var_7_12.cantGetExskillResistances, var_7_15.cantGetExskillResistances, var_7_18.cantGetExskillResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(409, var_7_3.delExPointResistances, var_7_6.delExPointResistances, var_7_9.delExPointResistances, var_7_12.delExPointResistances, var_7_15.delExPointResistances, var_7_18.delExPointResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(410, var_7_3.stressUpResistances, var_7_6.stressUpResistances, var_7_9.stressUpResistances, var_7_12.stressUpResistances, var_7_15.stressUpResistances, var_7_18.stressUpResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(411, var_7_3.charmResistances, var_7_6.charmResistances, var_7_9.charmResistances, var_7_12.charmResistances, var_7_15.charmResistances, var_7_18.charmResistances))
	table.insert(var_7_19, arg_7_0:getAttrMo(501, var_7_3.controlResilience, var_7_6.controlResilience, var_7_9.controlResilience, var_7_12.controlResilience, var_7_15.controlResilience, var_7_18.controlResilience))
	table.insert(var_7_19, arg_7_0:getAttrMo(502, var_7_3.delExPointResilience, var_7_6.delExPointResilience, var_7_9.delExPointResilience, var_7_12.delExPointResilience, var_7_15.delExPointResilience, var_7_18.delExPointResilience))
	table.insert(var_7_19, arg_7_0:getAttrMo(503, var_7_3.stressUpResilience, var_7_6.stressUpResilience, var_7_9.stressUpResilience, var_7_12.stressUpResilience, var_7_15.stressUpResilience, var_7_18.stressUpResilience))
	arg_7_0.attrModel:setList(var_7_19)
end

function var_0_0.getAttrMo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	arg_8_0.attrPool = arg_8_0.attrPool or {}

	local var_8_0 = arg_8_0.attrPool[arg_8_1]

	if not var_8_0 then
		var_8_0 = {
			id = arg_8_1
		}
		arg_8_0.attrPool[arg_8_1] = var_8_0
	end

	var_8_0.base = arg_8_2
	var_8_0.add = arg_8_3
	var_8_0.test = arg_8_4
	var_8_0.partAdd = arg_8_5
	var_8_0.partTest = arg_8_6
	var_8_0.final = arg_8_7

	return var_8_0
end

var_0_0.instance = var_0_0.New()

return var_0_0

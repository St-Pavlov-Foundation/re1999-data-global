module("modules.logic.fight.model.data.FightEntityInfoData", package.seeall)

local var_0_0 = FightDataClass("FightEntityInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.modelId = arg_1_1.modelId
	arg_1_0.skin = arg_1_1.skin
	arg_1_0.position = arg_1_1.position
	arg_1_0.entityType = arg_1_1.entityType
	arg_1_0.userId = arg_1_1.userId
	arg_1_0.exPoint = arg_1_1.exPoint
	arg_1_0.level = arg_1_1.level
	arg_1_0.currentHp = arg_1_1.currentHp
	arg_1_0.attr = FightHeroAttributeData.New(arg_1_1.attr)
	arg_1_0.buffDic = {}

	arg_1_0:buildBuffs(arg_1_1.buffs)

	arg_1_0.skillGroup1 = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.skillGroup1) do
		table.insert(arg_1_0.skillGroup1, iter_1_1)
	end

	arg_1_0.skillGroup2 = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.skillGroup2) do
		table.insert(arg_1_0.skillGroup2, iter_1_3)
	end

	arg_1_0.passiveSkill = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.passiveSkill) do
		table.insert(arg_1_0.passiveSkill, iter_1_5)
	end

	arg_1_0.exSkill = arg_1_1.exSkill
	arg_1_0.shieldValue = arg_1_1.shieldValue
	arg_1_0.expointMaxAdd = arg_1_1.expointMaxAdd
	arg_1_0.equipUid = arg_1_1.equipUid

	local var_1_0 = arg_1_1.trialEquip

	if var_1_0 then
		arg_1_0.trialEquip = {}
		arg_1_0.trialEquip.equipUid = var_1_0.equipUid
		arg_1_0.trialEquip.equipId = var_1_0.equipId
		arg_1_0.trialEquip.equipLv = var_1_0.equipLv
		arg_1_0.trialEquip.refineLv = var_1_0.refineLv
	else
		arg_1_0.trialEquip = nil
	end

	arg_1_0.exSkillLevel = arg_1_1.exSkillLevel
	arg_1_0.powerDataDic = {}

	arg_1_0:buildPowerInfos(arg_1_1.powerInfos)

	arg_1_0.summonedDataDic = {}

	arg_1_0:buildSummonedInfoData(arg_1_1.SummonedList)

	arg_1_0.exSkillPointChange = arg_1_1.exSkillPointChange
	arg_1_0.teamType = arg_1_1.teamType
	arg_1_0.enhanceInfoBox = FightEnhanceInfoBoxData.New(arg_1_1.enhanceInfoBox)
	arg_1_0.trialId = arg_1_1.trialId
	arg_1_0.career = arg_1_1.career
	arg_1_0.status = arg_1_1.status
	arg_1_0.guard = arg_1_1.guard
	arg_1_0.subCd = arg_1_1.subCd
end

function var_0_0.buildBuffs(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = FightBuffInfoData.New(iter_2_1)

		arg_2_0.buffDic[iter_2_1.uid] = var_2_0
	end
end

function var_0_0.buildPowerInfos(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = FightPowerInfoData.New(iter_3_1)

		arg_3_0.powerDataDic[iter_3_1.powerId] = var_3_0
	end
end

function var_0_0.buildSummonedInfoData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = FightSummonedInfoData.New(iter_4_1)

		arg_4_0.summonedDataDic[iter_4_1.summonedId] = var_4_0
	end
end

return var_0_0

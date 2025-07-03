module("modules.logic.fight.model.data.FightEntityInfoData", package.seeall)

local var_0_0 = FightDataClass("FightEntityInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.uid
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
	arg_1_0.buffs = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.buffs) do
		table.insert(arg_1_0.buffs, FightBuffInfoData.New(iter_1_1))
	end

	arg_1_0.skillGroup1 = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.skillGroup1) do
		table.insert(arg_1_0.skillGroup1, iter_1_3)
	end

	arg_1_0.skillGroup2 = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.skillGroup2) do
		table.insert(arg_1_0.skillGroup2, iter_1_5)
	end

	arg_1_0.passiveSkill = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.passiveSkill) do
		table.insert(arg_1_0.passiveSkill, iter_1_7)
	end

	arg_1_0.exSkill = arg_1_1.exSkill
	arg_1_0.shieldValue = arg_1_1.shieldValue
	arg_1_0.expointMaxAdd = arg_1_1.expointMaxAdd
	arg_1_0.equipUid = arg_1_1.equipUid

	if arg_1_1:HasField("trialEquip") then
		local var_1_0 = arg_1_1.trialEquip

		arg_1_0.trialEquip = {}
		arg_1_0.trialEquip.equipUid = var_1_0.equipUid
		arg_1_0.trialEquip.equipId = var_1_0.equipId
		arg_1_0.trialEquip.equipLv = var_1_0.equipLv
		arg_1_0.trialEquip.refineLv = var_1_0.refineLv
	end

	arg_1_0.exSkillLevel = arg_1_1.exSkillLevel
	arg_1_0.powerInfos = {}

	for iter_1_8, iter_1_9 in ipairs(arg_1_1.powerInfos) do
		local var_1_1 = FightPowerInfoData.New(iter_1_9)

		table.insert(arg_1_0.powerInfos, var_1_1)
	end

	arg_1_0.SummonedList = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.SummonedList) do
		table.insert(arg_1_0.SummonedList, FightSummonedInfoData.New(iter_1_11))
	end

	arg_1_0.exSkillPointChange = arg_1_1.exSkillPointChange
	arg_1_0.teamType = arg_1_1.teamType

	if arg_1_1:HasField("enhanceInfoBox") then
		arg_1_0.enhanceInfoBox = FightEnhanceInfoBoxData.New(arg_1_1.enhanceInfoBox)
	end

	arg_1_0.trialId = arg_1_1.trialId
	arg_1_0.career = arg_1_1.career
	arg_1_0.status = arg_1_1.status
	arg_1_0.guard = arg_1_1.guard
	arg_1_0.subCd = arg_1_1.subCd
	arg_1_0.exPointType = arg_1_1.exPointType
end

return var_0_0

module("modules.logic.sp01.odyssey.model.OdysseyHeroGroupEquipMo", package.seeall)

local var_0_0 = pureTable("OdysseyHeroGroupEquipMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.index = arg_1_1.position - 1
	arg_1_0.equipUid = {}

	local var_1_0 = 0
	local var_1_1 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_1_2

	if arg_1_1 and arg_1_1.trialId and arg_1_1.trialId > 0 and arg_1_1.trialId == tonumber(var_1_1.value) then
		var_1_2 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	else
		var_1_2 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.NormalHeroEquipCount)
	end

	local var_1_3 = tonumber(var_1_2.value)

	for iter_1_0 = 1, var_1_3 do
		table.insert(arg_1_0.equipUid, "0")
	end

	if not arg_1_1.equips then
		return
	end

	for iter_1_1, iter_1_2 in ipairs(arg_1_1.equips) do
		arg_1_0.equipUid[iter_1_2.slotId] = iter_1_2.equipUid
	end
end

function var_0_0.getEquipUID(arg_2_0, arg_2_1)
	if not arg_2_0.equipUid then
		return nil
	end

	return arg_2_0.equipUid[arg_2_1]
end

return var_0_0

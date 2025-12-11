module("modules.logic.survival.model.handbook.SurvivalHandbookMo", package.seeall)

local var_0_0 = pureTable("SurvivalHandbookMo")

function var_0_0.setData(arg_1_0, arg_1_1)
	arg_1_0.cfg = arg_1_1
	arg_1_0.id = arg_1_1.id
	arg_1_0.links = string.splitToNumber(arg_1_1.link, "|")
	arg_1_0.isUnlock = false
end

function var_0_0.setCellCfgId(arg_2_0, arg_2_1)
	arg_2_0.cellCfgId = arg_2_1

	arg_2_0:updateSurvivalBagItemMo()
end

function var_0_0.getCellCfgId(arg_3_0)
	return arg_3_0.cellCfgId
end

function var_0_0.getRare(arg_4_0)
	if arg_4_0.isUnlock then
		local var_4_0 = arg_4_0:getSurvivalBagItemMo()

		if var_4_0 then
			return var_4_0:getRare()
		end
	end

	return 0
end

function var_0_0.setIsNew(arg_5_0, arg_5_1)
	arg_5_0.isNew = arg_5_1
end

function var_0_0.getType(arg_6_0)
	return arg_6_0.cfg.type
end

function var_0_0.getSubType(arg_7_0)
	return arg_7_0.cfg.subtype
end

function var_0_0.getName(arg_8_0)
	return arg_8_0.cfg.name
end

function var_0_0.getDesc(arg_9_0)
	return arg_9_0.cfg.desc
end

function var_0_0.isLinkGroup(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.links) do
		if iter_10_1 == arg_10_1 then
			return true
		end
	end
end

function var_0_0.setIsUnlock(arg_11_0, arg_11_1)
	arg_11_0.isUnlock = arg_11_1

	if arg_11_0.survivalBagItemMo then
		arg_11_0.survivalBagItemMo.isUnknown = not arg_11_0.isUnlock
	end
end

function var_0_0.getSurvivalBagItemMo(arg_12_0)
	if arg_12_0.survivalBagItemMo == nil then
		arg_12_0.survivalBagItemMo = SurvivalBagItemMo.New()

		arg_12_0:updateSurvivalBagItemMo()
	end

	return arg_12_0.survivalBagItemMo
end

function var_0_0.updateSurvivalBagItemMo(arg_13_0)
	if not arg_13_0.survivalBagItemMo then
		return
	end

	local var_13_0 = arg_13_0:getCellCfgId()

	arg_13_0.survivalBagItemMo:init({
		count = 1,
		id = var_13_0
	})

	arg_13_0.survivalBagItemMo.source = SurvivalEnum.ItemSource.None
	arg_13_0.survivalBagItemMo.isUnknown = not arg_13_0.isUnlock
end

function var_0_0.getEventShowId(arg_14_0)
	if arg_14_0.cfg.eventId > 0 then
		return arg_14_0.cfg.eventId
	end
end

function var_0_0.getResultTitle(arg_15_0)
	return arg_15_0:getName()
end

function var_0_0.getResultDesc(arg_16_0)
	local var_16_0 = arg_16_0:getCellCfgId()

	return lua_survival_end.configDict[var_16_0].endDesc
end

function var_0_0.getResultImage(arg_17_0)
	local var_17_0 = arg_17_0:getCellCfgId()

	return lua_survival_end.configDict[var_17_0].endImg
end

return var_0_0

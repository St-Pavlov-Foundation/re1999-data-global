module("modules.logic.survival.model.SurvivalBagItemMo", package.seeall)

local var_0_0 = pureTable("SurvivalBagItemMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.count = 0
	arg_1_0.exScore = 0
	arg_1_0.equipLevel = 0
	arg_1_0.source = SurvivalEnum.ItemSource.None
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.id = arg_2_1.id
	arg_2_0.count = arg_2_1.count and arg_2_1.count or arg_2_0.count
	arg_2_0.param = arg_2_1.param
	arg_2_0.bagReason = arg_2_1.bagReason
	arg_2_0.co = lua_survival_item.configDict[arg_2_0.id]

	if arg_2_0.co and arg_2_0.co.type == SurvivalEnum.ItemType.Equip then
		arg_2_0.equipCo = lua_survival_equip.configDict[arg_2_0.id]
	elseif arg_2_0.co and arg_2_0.co.type == SurvivalEnum.ItemType.NPC then
		local var_2_0 = tonumber(arg_2_0.co.effect) or 0

		arg_2_0.npcCo = SurvivalConfig.instance:getNpcConfig(var_2_0)
	end

	arg_2_0.sellPrice = 0

	if arg_2_0.co and not string.nilorempty(arg_2_0.co.sellPrice) then
		local var_2_1 = string.match(arg_2_0.co.sellPrice, "^item#1:(.+)$")

		if var_2_1 then
			arg_2_0.sellPrice = tonumber(var_2_1) or 0
		end
	end
end

function var_0_0.getSellPrice(arg_3_0)
	return SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.SellPriceFix, arg_3_0.sellPrice)
end

function var_0_0.isCurrency(arg_4_0)
	return arg_4_0.co and arg_4_0.co.type == SurvivalEnum.ItemType.Currency
end

function var_0_0.getMass(arg_5_0)
	return arg_5_0.co.mass * arg_5_0.count
end

function var_0_0.isNPC(arg_6_0)
	return arg_6_0.co.type == SurvivalEnum.ItemType.NPC
end

function var_0_0.isEmpty(arg_7_0)
	return arg_7_0.id == 0 and arg_7_0.count == 0
end

function var_0_0.getEquipEffectDesc(arg_8_0)
	if not arg_8_0.equipCo then
		return ""
	end

	local var_8_0 = arg_8_0.equipCo.effectDesc

	if SurvivalModel.instance._isUseSimpleDesc == 1 then
		var_8_0 = arg_8_0.equipCo.effectDesc2
	end

	local var_8_1 = arg_8_0.equipValues or {}
	local var_8_2 = {}

	if not string.nilorempty(var_8_0) then
		local var_8_3 = {}
		local var_8_4 = {}
		local var_8_5

		if arg_8_0.source == SurvivalEnum.ItemSource.Equip then
			var_8_5 = SurvivalShelterModel.instance:getWeekInfo().equipBox.values
		end

		for iter_8_0, iter_8_1 in ipairs(string.split(var_8_0, "|")) do
			local var_8_6, var_8_7 = SurvivalDescExpressionHelper.instance:parstDesc(iter_8_1, var_8_1, var_8_5)

			if var_8_7 then
				table.insert(var_8_3, {
					var_8_6,
					var_8_7
				})
			else
				table.insert(var_8_4, {
					var_8_6,
					var_8_7
				})
			end
		end

		tabletool.addValues(var_8_2, var_8_3)
		tabletool.addValues(var_8_2, var_8_4)
	end

	return var_8_2
end

local var_0_1 = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function var_0_0.getEquipScoreLevel(arg_9_0)
	if not arg_9_0.equipCo then
		return 1, var_0_1[1]
	end

	local var_9_0 = arg_9_0.equipCo.score + arg_9_0.exScore
	local var_9_1 = 1

	if SurvivalModel.instance:getOutSideInfo().inWeek then
		var_9_1 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.WorldLevel)
	end

	local var_9_2 = lua_survival_equip_score.configDict[var_9_1][1].level
	local var_9_3 = 1

	if not string.nilorempty(var_9_2) then
		for iter_9_0, iter_9_1 in ipairs(string.splitToNumber(var_9_2, "#")) do
			if iter_9_1 <= var_9_0 then
				var_9_3 = iter_9_0 + 1
			end
		end
	end

	return var_9_3, var_0_1[var_9_3] or var_0_1[1]
end

function var_0_0.clone(arg_10_0)
	local var_10_0 = var_0_0.New()

	var_10_0:init(arg_10_0)

	return var_10_0
end

rawset(var_0_0, "Empty", var_0_0.New())

return var_0_0

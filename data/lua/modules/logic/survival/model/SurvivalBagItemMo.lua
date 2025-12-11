module("modules.logic.survival.model.SurvivalBagItemMo", package.seeall)

local var_0_0 = pureTable("SurvivalBagItemMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.uid = nil
	arg_1_0.co = nil
	arg_1_0.id = 0
	arg_1_0.count = 0
	arg_1_0.exScore = 0
	arg_1_0.equipLevel = 0
	arg_1_0.source = SurvivalEnum.ItemSource.None
	arg_1_0.isUnknown = false
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

	arg_2_0.shopPrice = {}

	if arg_2_0.co and not string.nilorempty(arg_2_0.co.specialSellPrice) then
		local var_2_2 = GameUtil.splitString2(arg_2_0.co.specialSellPrice, false, ",", "#")

		for iter_2_0, iter_2_1 in ipairs(var_2_2) do
			local var_2_3 = tonumber(iter_2_1[1])
			local var_2_4 = string.splitToNumber(iter_2_1[3], ":")

			arg_2_0.shopPrice[var_2_3] = {
				price = var_2_4[2]
			}
		end
	end
end

function var_0_0.getSellPrice(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_3_1 = SurvivalEnum.ShopType.Normal
	local var_3_2 = arg_3_0.sellPrice

	if arg_3_1 then
		var_3_1 = SurvivalConfig.instance:getShopType(arg_3_1)

		local var_3_3 = arg_3_0.shopPrice[arg_3_1]

		if var_3_3 then
			var_3_2 = var_3_3.price
		end
	end

	local var_3_4 = var_3_0:getAttrRaw(SurvivalEnum.AttrType.SellPriceFix)
	local var_3_5 = 0

	if var_3_1 == SurvivalEnum.ShopType.Normal then
		var_3_5 = var_3_0:getAttrRaw(SurvivalEnum.AttrType.MapSellPriceFix)
	else
		var_3_5 = var_3_0:getAttr(SurvivalEnum.AttrType.BuildSellPriceFix)
	end

	return math.floor(var_3_2 * (1 + (var_3_4 + var_3_5) / 1000))
end

function var_0_0.isCurrency(arg_4_0)
	return arg_4_0.co and arg_4_0.co.type == SurvivalEnum.ItemType.Currency
end

function var_0_0.getMass(arg_5_0)
	return arg_5_0.co.mass * arg_5_0.count
end

function var_0_0.getRare(arg_6_0)
	return arg_6_0.co.rare
end

function var_0_0.isNPC(arg_7_0)
	return arg_7_0.co.type == SurvivalEnum.ItemType.NPC
end

function var_0_0.isEmpty(arg_8_0)
	return arg_8_0.id == 0 or arg_8_0.count == 0
end

function var_0_0.isReputationItem(arg_9_0)
	if arg_9_0.co then
		return arg_9_0.co.type == SurvivalEnum.ItemType.Reputation
	end
end

function var_0_0.canExchangeReputationItem(arg_10_0)
	return arg_10_0.isExchangeReputationItem
end

function var_0_0.getExchangeReputationAmountTotal(arg_11_0)
	local var_11_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_11_1 = tonumber(arg_11_0.co.effect)
	local var_11_2 = var_11_0:getAttr(SurvivalEnum.AttrType.RenownChangeFix, var_11_1)

	return arg_11_0.count * var_11_2
end

function var_0_0.getEquipEffectDesc(arg_12_0)
	if not arg_12_0.equipCo then
		return ""
	end

	local var_12_0 = arg_12_0.equipCo.effectDesc

	if SurvivalModel.instance._isUseSimpleDesc == 1 then
		var_12_0 = arg_12_0.equipCo.effectDesc2
	end

	local var_12_1 = arg_12_0.equipValues or {}
	local var_12_2 = {}

	if not string.nilorempty(var_12_0) then
		local var_12_3 = {}
		local var_12_4 = {}
		local var_12_5

		if arg_12_0.source == SurvivalEnum.ItemSource.Equip then
			var_12_5 = SurvivalShelterModel.instance:getWeekInfo().equipBox.values
		end

		for iter_12_0, iter_12_1 in ipairs(string.split(var_12_0, "|")) do
			local var_12_6, var_12_7 = SurvivalDescExpressionHelper.instance:parstDesc(iter_12_1, var_12_1, var_12_5)

			if var_12_7 then
				table.insert(var_12_3, {
					var_12_6,
					var_12_7
				})
			else
				table.insert(var_12_4, {
					var_12_6,
					var_12_7
				})
			end
		end

		tabletool.addValues(var_12_2, var_12_3)
		tabletool.addValues(var_12_2, var_12_4)
	end

	return var_12_2
end

local var_0_1 = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function var_0_0.getEquipScoreLevel(arg_13_0)
	if not arg_13_0.equipCo then
		return 1, var_0_1[1]
	end

	local var_13_0 = arg_13_0.equipCo.score + arg_13_0.exScore
	local var_13_1 = 1

	if SurvivalModel.instance:getOutSideInfo().inWeek then
		local var_13_2 = SurvivalShelterModel.instance:getWeekInfo()

		if var_13_2 then
			var_13_1 = var_13_2:getAttr(SurvivalEnum.AttrType.WorldLevel)
		end
	end

	local var_13_3 = lua_survival_equip_score.configDict[var_13_1][1].level
	local var_13_4 = 1

	if not string.nilorempty(var_13_3) then
		for iter_13_0, iter_13_1 in ipairs(string.splitToNumber(var_13_3, "#")) do
			if iter_13_1 <= var_13_0 then
				var_13_4 = iter_13_0 + 1
			end
		end
	end

	return var_13_4, var_0_1[var_13_4] or var_0_1[1]
end

function var_0_0.isDisasterRecommendItem(arg_14_0, arg_14_1)
	if not arg_14_0.co then
		return false
	end

	if arg_14_1 then
		local var_14_0 = lua_survival_map_group_mapping.configDict[arg_14_1]
		local var_14_1 = var_14_0 and var_14_0.id or 0
		local var_14_2 = lua_survival_map_group.configDict[var_14_1].initDisaster
		local var_14_3 = lua_survival_disaster.configDict[var_14_2]
		local var_14_4 = SurvivalShelterModel.instance:getWeekInfo():getSurvivalMapInfoMo(arg_14_1).disasterCo

		if var_14_3 and var_14_3.recommend == arg_14_0.co.id or var_14_4 and var_14_4.recommend == arg_14_0.co.id then
			return true
		end
	else
		local var_14_5 = SurvivalMapModel.instance:getSceneMo()

		if not var_14_5 then
			return false
		end

		if not var_14_5._mapInfo.groupCo or not var_14_5._mapInfo.disasterCo then
			return false
		end

		local var_14_6 = var_14_5._mapInfo.groupCo.initDisaster
		local var_14_7 = lua_survival_disaster.configDict[var_14_6]

		if var_14_7 and var_14_7.recommend == arg_14_0.co.id or var_14_5._mapInfo.disasterCo.recommend == arg_14_0.co.id then
			return true
		end
	end

	return false
end

function var_0_0.isNPCRecommendItem(arg_15_0)
	if not arg_15_0.co then
		return false
	end

	return arg_15_0.co.type == SurvivalEnum.ItemType.Material and arg_15_0.co.subType == SurvivalEnum.ItemSubType.Material_NPCItem
end

function var_0_0.getExtendCost(arg_16_0)
	if arg_16_0.co.type == SurvivalEnum.ItemType.Equip then
		return arg_16_0.equipCo.extendCost
	elseif arg_16_0.co.type == SurvivalEnum.ItemType.NPC then
		return arg_16_0.npcCo.extendCost
	end

	return 0
end

function var_0_0.clone(arg_17_0)
	local var_17_0 = var_0_0.New()

	var_17_0:init(arg_17_0)

	return var_17_0
end

rawset(var_0_0, "Empty", var_0_0.New())

return var_0_0

module("modules.logic.versionactivity2_3.act174.model.Act174GameMO", package.seeall)

local var_0_0 = pureTable("Act174GameMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.hp = arg_1_1.hp
	arg_1_0.coin = arg_1_1.coin
	arg_1_0.gameCount = arg_1_1.gameCount
	arg_1_0.winCount = arg_1_1.winCount
	arg_1_0.score = arg_1_1.score
	arg_1_0.state = arg_1_1.state
	arg_1_0.forceBagInfo = arg_1_1.forceBagInfo
	arg_1_0.shopInfo = arg_1_1.shopInfo

	arg_1_0:updateTeamMo(arg_1_1.teamInfo)
	arg_1_0:updateWareHouseMo(arg_1_1.warehouseInfo, arg_1_2)

	arg_1_0.fightInfo = arg_1_1.fightInfo
	arg_1_0.season = arg_1_1.season
	arg_1_0.param = arg_1_1.param
end

function var_0_0.updateShopInfo(arg_2_0, arg_2_1)
	arg_2_0.shopInfo = arg_2_1
end

function var_0_0.updateTeamMo(arg_3_0, arg_3_1)
	arg_3_0.teamMoList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		local var_3_0 = Act174TeamMO.New()

		var_3_0:init(iter_3_1)

		arg_3_0.teamMoList[iter_3_0] = var_3_0
	end
end

function var_0_0.updateWareHouseMo(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.warehouseMo then
		if arg_4_2 then
			arg_4_0.warehouseMo:update(arg_4_1)
		else
			arg_4_0.warehouseMo:init(arg_4_1)
		end
	else
		arg_4_0.warehouseMo = Act174WareHouseMO.New()

		arg_4_0.warehouseMo:init(arg_4_1)
	end
end

function var_0_0.buyInShopReply(arg_5_0, arg_5_1)
	arg_5_0.shopInfo = arg_5_1.shopInfo

	arg_5_0.warehouseMo:clearNewSign()
	arg_5_0.warehouseMo:update(arg_5_1.warehouseInfo)

	arg_5_0.coin = arg_5_1.coin
end

function var_0_0.updateIsBet(arg_6_0, arg_6_1)
	arg_6_0.fightInfo.betHp = arg_6_1
end

function var_0_0.isInGame(arg_7_0)
	return arg_7_0.state ~= Activity174Enum.GameState.None
end

function var_0_0.getForceBagsInfo(arg_8_0)
	return arg_8_0.forceBagInfo
end

function var_0_0.getShopInfo(arg_9_0)
	return arg_9_0.shopInfo
end

function var_0_0.getTeamMoList(arg_10_0)
	return arg_10_0.teamMoList
end

function var_0_0.getWarehouseInfo(arg_11_0)
	return arg_11_0.warehouseMo
end

function var_0_0.getFightInfo(arg_12_0)
	return arg_12_0.fightInfo
end

function var_0_0.setBattleHeroInTeam(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_3.heroId and not arg_13_3.itemId then
		arg_13_0:delBattleHeroInTeam(arg_13_1, arg_13_2)

		return
	end

	local var_13_0 = Activity174Helper.MatchKeyInArray(arg_13_0.teamMoList, arg_13_1, "index")

	if var_13_0 then
		local var_13_1 = var_13_0.battleHeroInfo
		local var_13_2 = Activity174Helper.MatchKeyInArray(var_13_1, arg_13_2, "index")

		if var_13_2 then
			var_13_2.index = arg_13_3.index
			var_13_2.heroId = arg_13_3.heroId
			var_13_2.itemId = arg_13_3.itemId
			var_13_2.priorSkill = arg_13_3.priorSkill
		else
			table.insert(var_13_1, arg_13_3)
		end
	else
		local var_13_3 = {
			index = arg_13_1,
			battleHeroInfo = {
				arg_13_3
			}
		}
		local var_13_4 = Act174TeamMO.New()

		var_13_4:init(var_13_3)
		table.insert(arg_13_0.teamMoList, var_13_4)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function var_0_0.delBattleHeroInTeam(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = Activity174Helper.MatchKeyInArray(arg_14_0.teamMoList, arg_14_1, "index")

	if var_14_0 then
		local var_14_1 = var_14_0.battleHeroInfo
		local var_14_2 = Activity174Helper.MatchKeyInArray(var_14_1, arg_14_2, "index")

		if var_14_2 then
			tabletool.removeValue(var_14_1, var_14_2)
		end
	else
		logError("teamInfo dont exist" .. arg_14_1)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function var_0_0.isHeroInTeam(arg_15_0, arg_15_1)
	for iter_15_0 = 1, #arg_15_0.teamMoList do
		local var_15_0 = arg_15_0.teamMoList[iter_15_0]

		for iter_15_1 = 1, #var_15_0.battleHeroInfo do
			if var_15_0.battleHeroInfo[iter_15_1].heroId == arg_15_1 then
				return 1
			end
		end
	end

	return 0
end

function var_0_0.getCollectionEquipCnt(arg_16_0, arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.teamMoList) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1.battleHeroInfo) do
			if iter_16_3.itemId == arg_16_1 then
				var_16_0 = var_16_0 + 1
			end
		end
	end

	return var_16_0
end

function var_0_0.exchangeTempCollection(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.fightInfo.tempInfo
	local var_17_1 = Activity174Helper.MatchKeyInArray(var_17_0, arg_17_1, "index")
	local var_17_2 = Activity174Helper.MatchKeyInArray(var_17_0, arg_17_2, "index")

	if var_17_1 and var_17_2 then
		var_17_1.index = arg_17_2
		var_17_2.index = arg_17_1
	end
end

function var_0_0.getTempCollectionId(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = arg_18_3 and arg_18_0.fightInfo.matchInfo.tempInfo or arg_18_0.fightInfo.tempInfo
	local var_18_1 = Activity174Helper.MatchKeyInArray(var_18_0, arg_18_1, "index")

	if var_18_1 then
		return var_18_1.collectionId[arg_18_2]
	end

	return 0
end

function var_0_0.getBetScore(arg_19_0)
	local var_19_0 = 0

	if not string.nilorempty(arg_19_0.param) and string.find(arg_19_0.param, "betScore") then
		local var_19_1 = string.split(arg_19_0.param, "#")
		local var_19_2 = string.split(var_19_1[1], ":")

		var_19_0 = tonumber(var_19_2[2])
	end

	return var_19_0
end

return var_0_0

module("modules.logic.versionactivity1_6.v1a6_cachot.model.mo.RogueInfoMO", package.seeall)

local var_0_0 = pureTable("RogueInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.activityId = arg_1_1.activityId
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.room = arg_1_1.room
	arg_1_0.coin = arg_1_1.coin
	arg_1_0.currency = arg_1_1.currency
	arg_1_0.heart = arg_1_1.heart
	arg_1_0.isFinish = arg_1_1.isFinish
	arg_1_0.score = arg_1_1.score
	arg_1_0.sceneId = arg_1_1.sceneId
	arg_1_0.currencyTotal = arg_1_1.currencyTotal

	arg_1_0:updateTeamInfo(arg_1_1.teamInfo)

	arg_1_0.currentEvents = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.currentEvents) do
		local var_1_0 = RogueEventMO.New()

		var_1_0:init(iter_1_1)
		table.insert(arg_1_0.currentEvents, var_1_0)
	end

	arg_1_0.nextEvents = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.nextEvents) do
		local var_1_1 = RogueEventMO.New()

		var_1_1:init(iter_1_3)
		table.insert(arg_1_0.nextEvents, var_1_1)
	end

	arg_1_0:updateCollections(arg_1_1.collections)

	arg_1_0.selectedEvents = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.selectedEvents) do
		if iter_1_5.status ~= V1a6_CachotEnum.EventStatus.Finish then
			local var_1_2 = RogueEventMO.New()

			var_1_2:init(iter_1_5)
			table.insert(arg_1_0.selectedEvents, var_1_2)
		end
	end
end

function var_0_0.updateTeamInfo(arg_2_0, arg_2_1)
	arg_2_0.teamInfo = RogueTeamInfoMO.New()

	arg_2_0.teamInfo:init(arg_2_1)
end

function var_0_0.updateCoin(arg_3_0, arg_3_1)
	arg_3_0.coin = arg_3_1
end

function var_0_0.updateCurrency(arg_4_0, arg_4_1)
	arg_4_0.currency = arg_4_1
end

function var_0_0.updateCurrencyTotal(arg_5_0, arg_5_1)
	arg_5_0.currencyTotal = arg_5_1
end

function var_0_0.updateHeart(arg_6_0, arg_6_1)
	arg_6_0.heart = arg_6_1
end

function var_0_0.updateCollections(arg_7_0, arg_7_1)
	arg_7_0.collections = {}
	arg_7_0.collectionCfgMap = {}
	arg_7_0.collectionBaseMap = {}
	arg_7_0.enchants = {}
	arg_7_0.collectionMap = {}

	if arg_7_1 then
		for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
			local var_7_0 = RogueCollectionMO.New()

			var_7_0:init(iter_7_1)

			local var_7_1 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_7_0.cfgId)

			if var_7_1 and var_7_1.type == V1a6_CachotEnum.CollectionType.Enchant then
				table.insert(arg_7_0.enchants, var_7_0)
			end

			if not var_7_0:isEnchant() then
				table.insert(arg_7_0.collections, var_7_0)
			end

			arg_7_0.collectionMap[var_7_0.id] = var_7_0
			arg_7_0.collectionCfgMap[var_7_0.cfgId] = arg_7_0.collectionCfgMap[var_7_0.cfgId] or {}

			table.insert(arg_7_0.collectionCfgMap[var_7_0.cfgId], var_7_0)

			if var_7_0 and var_7_0.baseId and var_7_0.baseId ~= 0 then
				arg_7_0.collectionBaseMap[var_7_0.baseId] = arg_7_0.collectionBaseMap[var_7_0.baseId] or {}

				table.insert(arg_7_0.collectionBaseMap[var_7_0.baseId], var_7_0)
			end
		end
	end
end

function var_0_0.getCollectionByUid(arg_8_0, arg_8_1)
	return arg_8_0.collectionMap and arg_8_0.collectionMap[arg_8_1]
end

function var_0_0.getSelectEvents(arg_9_0)
	return arg_9_0.selectedEvents
end

return var_0_0

module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightHandCardDataMgr")

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.handCard = {}
	arg_1_0.originCard = {}
	arg_1_0.redealCard = {}
end

function var_0_0.setOriginCard(arg_2_0)
	FightDataHelper.coverData(arg_2_0.handCard, arg_2_0.originCard)
end

function var_0_0.updateHandCardByProto(arg_3_0, arg_3_1)
	local var_3_0 = FightCardDataHelper.newCardList(arg_3_1)

	FightDataHelper.coverData(var_3_0, arg_3_0.handCard)
end

function var_0_0.cacheDistributeCard(arg_4_0, arg_4_1)
	arg_4_0.beforeCards1 = FightCardDataHelper.newCardList(arg_4_1.beforeCards1)
	arg_4_0.teamACards1 = FightCardDataHelper.newCardList(arg_4_1.teamACards1)
	arg_4_0.beforeCards2 = FightCardDataHelper.newCardList(arg_4_1.beforeCards2)
	arg_4_0.teamACards2 = FightCardDataHelper.newCardList(arg_4_1.teamACards2)
end

function var_0_0.cacheRedealCard(arg_5_0, arg_5_1)
	table.insert(arg_5_0.redealCard, FightCardDataHelper.newCardList(arg_5_1))
end

function var_0_0.getRedealCard(arg_6_0)
	return table.remove(arg_6_0.redealCard, 1)
end

function var_0_0.getHandCard(arg_7_0)
	return arg_7_0.handCard
end

function var_0_0.distribute(arg_8_0, arg_8_1, arg_8_2)
	FightDataHelper.coverData(arg_8_1, arg_8_0.handCard)

	arg_8_2 = FightDataHelper.coverData(arg_8_2)

	tabletool.addValues(arg_8_0.handCard, arg_8_2)
	FightCardDataHelper.combineCardListForLocal(arg_8_0.handCard)
end

return var_0_0

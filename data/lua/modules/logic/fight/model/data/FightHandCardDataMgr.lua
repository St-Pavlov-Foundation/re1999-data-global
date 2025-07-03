module("modules.logic.fight.model.data.FightHandCardDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightHandCardDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.handCard = {}
	arg_1_0.originCard = {}
	arg_1_0.redealCard = {}
end

function var_0_0.onStageChanged(arg_2_0, arg_2_1, arg_2_2)
	for iter_2_0 = 1, #arg_2_0.handCard do
		arg_2_0.handCard[iter_2_0].originHandCardIndex = iter_2_0
	end

	FightDataUtil.coverData(arg_2_0.handCard, arg_2_0.originCard)
end

function var_0_0.onCancelOperation(arg_3_0)
	FightDataUtil.coverData(arg_3_0.originCard, arg_3_0.handCard)
end

function var_0_0.getHandCard(arg_4_0)
	return arg_4_0.handCard
end

function var_0_0.coverCard(arg_5_0, arg_5_1)
	FightDataUtil.coverData(arg_5_1, arg_5_0.handCard)
end

function var_0_0.setOriginCard(arg_6_0)
	FightDataUtil.coverData(arg_6_0.handCard, arg_6_0.originCard)
end

function var_0_0.updateHandCardByProto(arg_7_0, arg_7_1)
	local var_7_0 = FightCardDataHelper.newCardList(arg_7_1)

	FightDataUtil.coverData(var_7_0, arg_7_0.handCard)
end

function var_0_0.cacheDistributeCard(arg_8_0, arg_8_1)
	arg_8_0.beforeCards1 = FightCardDataHelper.newCardList(arg_8_1.beforeCards1)
	arg_8_0.teamACards1 = FightCardDataHelper.newCardList(arg_8_1.teamACards1)
	arg_8_0.beforeCards2 = FightCardDataHelper.newCardList(arg_8_1.beforeCards2)
	arg_8_0.teamACards2 = FightCardDataHelper.newCardList(arg_8_1.teamACards2)
end

function var_0_0.cacheRedealCard(arg_9_0, arg_9_1)
	table.insert(arg_9_0.redealCard, FightCardDataHelper.newCardList(arg_9_1))
end

function var_0_0.getRedealCard(arg_10_0)
	return table.remove(arg_10_0.redealCard, 1)
end

function var_0_0.distribute(arg_11_0, arg_11_1, arg_11_2)
	FightDataUtil.coverData(arg_11_1, arg_11_0.handCard)

	arg_11_2 = FightDataUtil.coverData(arg_11_2)

	tabletool.addValues(arg_11_0.handCard, arg_11_2)
	FightCardDataHelper.combineCardList(arg_11_0.handCard, arg_11_0.dataMgr.entityMgr)
end

return var_0_0

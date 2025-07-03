module("modules.logic.fight.model.data.FightPlayCardDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightPlayCardDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.playCard = {}
	arg_1_0.enemyPlayCard = {}
	arg_1_0.enemyAct174PlayCard = {}
end

function var_0_0.setAct174EnemyCard(arg_2_0, arg_2_1)
	FightDataUtil.coverData(FightCardDataHelper.newPlayCardList(arg_2_1), arg_2_0.enemyAct174PlayCard)
end

return var_0_0

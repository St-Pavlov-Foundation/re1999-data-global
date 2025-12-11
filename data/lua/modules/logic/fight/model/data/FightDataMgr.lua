module("modules.logic.fight.model.data.FightDataMgr", package.seeall)

local var_0_0 = class("FightDataMgr", BaseModel)

function var_0_0.registMgr(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.New()

	var_1_0.dataMgr = arg_1_0

	table.insert(arg_1_0.mgrList, var_1_0)

	return var_1_0
end

function var_0_0.initDataMgr(arg_2_0)
	arg_2_0.mgrList = {}

	arg_2_0:initTrueDataMgr()
	arg_2_0:initTempDataMgr()
end

function var_0_0.initTrueDataMgr(arg_3_0)
	arg_3_0.calMgr = arg_3_0:registMgr(FightCalculateDataMgr)
	arg_3_0.roundMgr = arg_3_0:registMgr(FightRoundDataMgr)
	arg_3_0.cacheFightMgr = arg_3_0:registMgr(FightCacheFightDataMgr)
	arg_3_0.protoCacheMgr = arg_3_0:registMgr(FightProtoCacheDataMgr)
	arg_3_0.entityMgr = arg_3_0:registMgr(FightEntityDataMgr)
	arg_3_0.entityExMgr = arg_3_0:registMgr(FightEntityExDataMgr)
	arg_3_0.handCardMgr = arg_3_0:registMgr(FightHandCardDataMgr)
	arg_3_0.fieldMgr = arg_3_0:registMgr(FightFieldDataMgr)
	arg_3_0.paTaMgr = arg_3_0:registMgr(FightPaTaDataMgr)
	arg_3_0.playCardMgr = arg_3_0:registMgr(FightPlayCardDataMgr)
	arg_3_0.ASFDDataMgr = arg_3_0:registMgr(FightASFDDataMgr)
	arg_3_0.teamDataMgr = arg_3_0:registMgr(FightTeamDataMgr)
end

function var_0_0.initTempDataMgr(arg_4_0)
	arg_4_0.stageMgr = arg_4_0:registMgr(FightStageMgr)
	arg_4_0.stateMgr = arg_4_0:registMgr(FightStateDataMgr)
	arg_4_0.lockOperateMgr = arg_4_0:registMgr(FightLockOperateDataMgr)
	arg_4_0.counterMgr = arg_4_0:registMgr(FightCounterDataMgr)
	arg_4_0.operationDataMgr = arg_4_0:registMgr(FightOperationDataMgr)
	arg_4_0.tempMgr = arg_4_0:registMgr(FightTempDataMgr)
	arg_4_0.LYDataMgr = arg_4_0:registMgr(FightLYDataMgr)
	arg_4_0.bloodPoolDataMgr = arg_4_0:registMgr(FightBloodPoolDataMgr)
end

function var_0_0.cancelOperation(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.mgrList) do
		iter_5_1:onCancelOperation()
	end
end

function var_0_0.updateFightData(arg_6_0, arg_6_1)
	arg_6_0.calMgr:updateFightData(arg_6_1)
end

function var_0_0.getEntityById(arg_7_0, arg_7_1)
	return arg_7_0.entityMgr:getById(arg_7_1)
end

function var_0_0.beforePlayRoundData(arg_8_0, arg_8_1)
	arg_8_0.calMgr:beforePlayRoundData(arg_8_1)
end

function var_0_0.afterPlayRoundData(arg_9_0, arg_9_1)
	arg_9_0.calMgr:afterPlayRoundData(arg_9_1)
end

function var_0_0.dealRoundData(arg_10_0, arg_10_1)
	arg_10_0.calMgr:playStepDataList(arg_10_1.fightStep)
	arg_10_0.calMgr:playStepDataList(arg_10_1.nextRoundBeginStep)
	arg_10_0.calMgr:dealExPointInfo(arg_10_1.exPointInfo)
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:initDataMgr()

return var_0_0

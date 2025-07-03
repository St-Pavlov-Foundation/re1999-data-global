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
	arg_3_0.entityExMgr = arg_3_0:registMgr(FightEntityEXDataMgr)
	arg_3_0.handCardMgr = arg_3_0:registMgr(FightHandCardDataMgr)
	arg_3_0.fieldMgr = arg_3_0:registMgr(FightFieldDataMgr)
	arg_3_0.paTaMgr = arg_3_0:registMgr(FightPaTaDataMgr)
	arg_3_0.playCardMgr = arg_3_0:registMgr(FightPlayCardDataMgr)
	arg_3_0.ASFDDataMgr = arg_3_0:registMgr(FightASFDDataMgr)
	arg_3_0.teamDataMgr = arg_3_0:registMgr(FightTeamDataMgr)
end

function var_0_0.initTempDataMgr(arg_4_0)
	arg_4_0.stageMgr = arg_4_0:registMgr(FightStageMgr)
	arg_4_0.operationDataMgr = arg_4_0:registMgr(FightOperationDataMgr)
	arg_4_0.operationStateMgr = arg_4_0:registMgr(FightOperationStateMgr)
	arg_4_0.simulationMgr = arg_4_0:registMgr(FightSimulationDataMgr)
	arg_4_0.tempMgr = arg_4_0:registMgr(FightTempDataMgr)
	arg_4_0.LYDataMgr = arg_4_0:registMgr(FightLYDataMgr)
	arg_4_0.bloodPoolDataMgr = arg_4_0:registMgr(FightBloodPoolDataMgr)
end

function var_0_0.cancelOperation(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.mgrList) do
		iter_5_1:onCancelOperation()
	end
end

function var_0_0.enterStage(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.stageMgr:getCurStage()

	arg_6_0.stageMgr:enterStage(arg_6_1, arg_6_2)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.mgrList) do
		iter_6_1:onEnterStage(arg_6_1)
		iter_6_1:onStageChanged(arg_6_1, var_6_0)
	end
end

function var_0_0.exitStage(arg_7_0, arg_7_1)
	arg_7_0.stageMgr:exitStage(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.mgrList) do
		iter_7_1:onExitStage(arg_7_1)

		local var_7_0 = arg_7_0.stageMgr:getCurStage()

		iter_7_1:onStageChanged(var_7_0, arg_7_1)
	end
end

function var_0_0.updateFightData(arg_8_0, arg_8_1)
	arg_8_0.calMgr:updateFightData(arg_8_1)
end

function var_0_0.getEntityById(arg_9_0, arg_9_1)
	return arg_9_0.entityMgr:getById(arg_9_1)
end

function var_0_0.beforePlayRoundData(arg_10_0, arg_10_1)
	arg_10_0.calMgr:beforePlayRoundData(arg_10_1)
end

function var_0_0.afterPlayRoundData(arg_11_0, arg_11_1)
	arg_11_0.calMgr:afterPlayRoundData(arg_11_1)
end

function var_0_0.dealRoundData(arg_12_0, arg_12_1)
	arg_12_0.calMgr:playStepDataList(arg_12_1.fightStep)
	arg_12_0.calMgr:playStepDataList(arg_12_1.nextRoundBeginStep)
	arg_12_0.calMgr:dealExPointInfo(arg_12_1.exPointInfo)
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:initDataMgr()

return var_0_0

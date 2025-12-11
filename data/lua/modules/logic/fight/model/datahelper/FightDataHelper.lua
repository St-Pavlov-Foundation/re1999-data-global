module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

local var_0_0 = {}

function var_0_0.defineMgrRef()
	local var_1_0 = FightDataMgr.instance.mgrList

	for iter_1_0, iter_1_1 in pairs(FightDataMgr.instance) do
		for iter_1_2, iter_1_3 in ipairs(var_1_0) do
			if iter_1_3 == iter_1_1 then
				var_0_0[iter_1_0] = iter_1_3

				break
			end
		end
	end
end

function var_0_0.initDataMgr()
	var_0_0.lastFightResult = nil

	FightLocalDataMgr.instance:initDataMgr()
	FightDataMgr.instance:initDataMgr()
	var_0_0.defineMgrRef()
	FightMsgMgr.sendMsg(FightMsgId.AfterInitDataMgrRef)
end

function var_0_0.initFightData(arg_3_0)
	var_0_0.version = FightModel.GMForceVersion or arg_3_0.version or 0
	FightModel.instance._version = var_0_0.version

	FightLocalDataMgr.instance:updateFightData(arg_3_0)
	FightDataMgr.instance:updateFightData(arg_3_0)
	var_0_0.stateMgr:initReplayState()
	var_0_0.stateMgr:initAutoState()

	if isDebugBuild then
		FightLocalDataMgr.instance.roundMgr.enterData = arg_3_0
		FightDataMgr.instance.roundMgr.enterData = arg_3_0
	end
end

function var_0_0.playEffectData(arg_4_0)
	if arg_4_0:isDone() then
		return
	end

	var_0_0.calMgr:playActEffectData(arg_4_0)
end

function var_0_0.cacheFightWavePush(arg_5_0)
	FightLocalDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_5_0)
	FightDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_5_0)
end

function var_0_0.setRoundDataByProto(arg_6_0)
	local var_6_0 = FightRoundData.New(arg_6_0)

	if isDebugBuild then
		local var_6_1 = FightDataUtil.coverData(var_6_0)

		FightLocalDataMgr.instance.roundMgr:setOriginRoundData(var_6_1)
		FightDataMgr.instance.roundMgr:setOriginRoundData(var_6_1)
		FightDataMgr.instance.protoCacheMgr:addRoundProto(arg_6_0)
	end

	FightLocalDataMgr.instance.roundMgr:setRoundData(var_6_0)
	FightDataMgr.instance.roundMgr:setRoundData(var_6_0)
end

function var_0_0.getBloodPool(arg_7_0)
	local var_7_0 = var_0_0.teamDataMgr
	local var_7_1 = var_7_0 and var_7_0[arg_7_0]

	return var_7_1 and var_7_1.bloodPool
end

var_0_0.initDataMgr()

return var_0_0

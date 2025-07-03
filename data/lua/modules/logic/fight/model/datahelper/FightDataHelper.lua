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
	if not arg_3_0 then
		var_0_0.version = 999
		FightModel.instance._version = var_0_0.version

		return
	end

	var_0_0.version = FightModel.GMForceVersion or arg_3_0.version or 0
	FightModel.instance._version = var_0_0.version

	var_0_0.checkReplay(arg_3_0)
	FightLocalDataMgr.instance:updateFightData(arg_3_0)
	FightDataMgr.instance:updateFightData(arg_3_0)

	if isDebugBuild then
		FightLocalDataMgr.instance.roundMgr.enterData = arg_3_0
		FightDataMgr.instance.roundMgr.enterData = arg_3_0
	end
end

function var_0_0.checkReplay(arg_4_0)
	local var_4_0 = var_0_0.version
	local var_4_1 = arg_4_0.isRecord

	if var_4_0 >= 1 then
		if var_4_1 then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	else
		local var_4_2 = FightModel.instance:getFightParam()

		if var_4_2 and var_4_2.isReplay then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		elseif FightReplayModel.instance:isReconnectReplay() then
			var_0_0.stageMgr:enterFightState(FightStageMgr.FightStateType.Replay)
		end
	end
end

function var_0_0.playEffectData(arg_5_0)
	if arg_5_0:isDone() then
		return
	end

	var_0_0.calMgr:playActEffectData(arg_5_0)
end

function var_0_0.cacheFightWavePush(arg_6_0)
	FightLocalDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_6_0)
	FightDataMgr.instance.cacheFightMgr:cacheFightWavePush(arg_6_0)
end

function var_0_0.setRoundDataByProto(arg_7_0)
	local var_7_0 = FightRoundData.New(arg_7_0)

	if isDebugBuild then
		local var_7_1 = FightDataUtil.coverData(var_7_0)

		FightLocalDataMgr.instance.roundMgr:setOriginRoundData(var_7_1)
		FightDataMgr.instance.roundMgr:setOriginRoundData(var_7_1)
		FightDataMgr.instance.protoCacheMgr:addRoundProto(arg_7_0)
	end

	FightLocalDataMgr.instance.roundMgr:setRoundData(var_7_0)
	FightDataMgr.instance.roundMgr:setRoundData(var_7_0)
end

function var_0_0.getBloodPool(arg_8_0)
	local var_8_0 = var_0_0.teamDataMgr
	local var_8_1 = var_8_0 and var_8_0[arg_8_0]

	return var_8_1 and var_8_1.bloodPool
end

var_0_0.initDataMgr()

return var_0_0

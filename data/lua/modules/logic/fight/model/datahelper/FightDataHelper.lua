-- chunkname: @modules/logic/fight/model/datahelper/FightDataHelper.lua

module("modules.logic.fight.model.datahelper.FightDataHelper", package.seeall)

local FightDataHelper = {}

function FightDataHelper.defineMgrRef()
	local mgrList = FightDataMgr.instance.mgrList

	for k, v in pairs(FightDataMgr.instance) do
		for index, mgr in ipairs(mgrList) do
			if mgr == v then
				FightDataHelper[k] = mgr

				break
			end
		end
	end
end

function FightDataHelper.initDataMgr()
	FightDataHelper.lastFightResult = nil

	FightLocalDataMgr.instance:initDataMgr()
	FightDataMgr.instance:initDataMgr()
	FightDataHelper.defineMgrRef()
	FightMsgMgr.sendMsg(FightMsgId.AfterInitDataMgrRef)
end

function FightDataHelper.initFightData(fightData)
	FightDataHelper.version = FightModel.GMForceVersion or fightData.version or 0
	FightModel.instance._version = FightDataHelper.version

	FightLocalDataMgr.instance:updateFightData(fightData)
	FightDataMgr.instance:updateFightData(fightData)
	FightDataHelper.stateMgr:initReplayState()
	FightDataHelper.stateMgr:initAutoState()

	if isDebugBuild then
		FightLocalDataMgr.instance.roundMgr.enterData = fightData
		FightDataMgr.instance.roundMgr.enterData = fightData
	end
end

function FightDataHelper.playEffectData(actEffectData)
	if actEffectData:isDone() then
		return
	end

	FightDataHelper.calMgr:playActEffectData(actEffectData)
end

function FightDataHelper.cacheFightWavePush(fightData)
	local mgr = FightLocalDataMgr.instance.cacheFightMgr

	mgr:cacheFightWavePush(fightData)

	mgr = FightDataMgr.instance.cacheFightMgr

	mgr:cacheFightWavePush(fightData)
end

function FightDataHelper.setRoundDataByProto(proto)
	local fightRoundData = FightRoundData.New(proto)

	if isDebugBuild then
		local originRoundData = FightDataUtil.coverData(fightRoundData)

		FightLocalDataMgr.instance.roundMgr:setOriginRoundData(originRoundData)
		FightDataMgr.instance.roundMgr:setOriginRoundData(originRoundData)
		FightDataMgr.instance.protoCacheMgr:addRoundProto(proto)
	end

	FightLocalDataMgr.instance.roundMgr:setRoundData(fightRoundData)
	FightDataMgr.instance.roundMgr:setRoundData(fightRoundData)
end

function FightDataHelper.getBloodPool(teamType)
	local teamDataMgr = FightDataHelper.teamDataMgr
	local teamData = teamDataMgr and teamDataMgr[teamType]

	return teamData and teamData.bloodPool
end

function FightDataHelper.getHeatScale(teamType)
	local teamDataMgr = FightDataHelper.teamDataMgr
	local teamData = teamDataMgr and teamDataMgr[teamType]

	return teamData and teamData.heatScale
end

FightDataHelper.initDataMgr()

return FightDataHelper

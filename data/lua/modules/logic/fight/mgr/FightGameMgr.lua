-- chunkname: @modules/logic/fight/mgr/FightGameMgr.lua

module("modules.logic.fight.mgr.FightGameMgr", package.seeall)

local FightGameMgr = class("FightGameMgr", FightBaseClass)

function FightGameMgr:onConstructor()
	self.mgrList = {}

	self:com_registEvent(ConnectAliveMgr.instance, ConnectEvent.OnLostConnect, self.onLostConnect)
	self:com_registMsg(FightMsgId.RestartGame, self.onRestartGame)

	FightGameMgr.restartMgr = self:newClass(FightRestartMgr)
end

function FightGameMgr:onLogicEnter()
	self:registMgr()
	self:defineMgrRef()
end

function FightGameMgr:registMgr()
	self.loaderMgr = self:addMgr(FightLoaderMgr)
	self.playMgr = self:addMgr(FightPlayMgr)
	self.operateMgr = self:addMgr(FightOperateMgr)
	self.checkCrashMgr = self:addMgr(FightCheckCrashMgr)
	self.entrustEntityMgr = self:addMgr(FightEntrustEntityMgr)
	self.entrustDeadEntityMgr = self:addMgr(FightEntrustDeadEntityMgr)
	self.wadingEffect = self:addMgr(FightWadingEffectMgr)

	if GameSceneMgr.instance:useDefaultScene() == false then
		self.sceneTriggerSceneAnimatorMgr = self:addMgr(FightSceneTriggerSceneAnimatorMgr)
	end

	self.userDataClassMgr = self:addMgr(FightUserDataClassMgr)
	self.magicCirCleMgr = self:addMgr(FightMagicCircleMgr)
	self.entrustedWorkMgr = self:addMgr(FightEntrustedWorkMgr)
	self.buffTypeId2EffectMgr = self:addMgr(FightBuffTypeId2EffectMgr)
	self.entityEvolutionMgr = self:addMgr(FightEntityEvolutionMgr)
	self.specialSceneEffectMgr = self:addMgr(FightSpecialSceneEffectMgr)
	self.specialSceneIdleMgr = self:addMgr(FightSpecialSceneIdleMgr)
	self.dynamicShadowMgr = self:addMgr(FightDynamicShadowMgr)
	self.thunderMatMgr = self:addMgr(FightThunderMatMgr)
	self.entityFootRingMgr = self:addMgr(FightEntityFootRingMgr)
	self.weatherEffectMgr = self:addMgr(FightWeatherEffectMgr)
	self.spineColorBySceneMgr = self:addMgr(FightSpineColorBySceneMgr)
	self.bgmMgr = self:addMgr(FightBgmMgr)
	self.bloomMgr = self:addMgr(FightBloomMgr)
end

function FightGameMgr:addMgr(class)
	local mgr = self:newClass(class)

	table.insert(self.mgrList, mgr)

	return mgr
end

function FightGameMgr:defineMgrRef()
	for i, mgr in ipairs(self.mgrList) do
		for k, v in pairs(self) do
			if v == mgr then
				FightGameMgr[k] = mgr

				break
			end
		end
	end
end

function FightGameMgr:onRestartGame()
	for i = #self.mgrList, 1, -1 do
		self.mgrList[i]:disposeSelf()
		table.remove(self.mgrList, i)
	end

	self:registMgr()
	self:defineMgrRef()
end

function FightGameMgr:onLostConnect()
	local playerInfo = PlayerModel.instance:getPlayinfo()
	local str = "战斗超时断线,玩家uid:%d, 战斗id: %d"

	str = string.format(str, playerInfo.userId, FightDataHelper.fieldMgr.battleId)

	local entityDataDic = FightDataHelper.entityMgr.entityDataDic

	for entityId, entityData in pairs(entityDataDic) do
		local needPrint = true

		if not entityData:isMySide() then
			needPrint = false
		end

		if entityId == "0" then
			needPrint = false
		end

		if needPrint then
			str = str .. ", heroId:" .. entityData.modelId
		end
	end

	logError(str)
end

function FightGameMgr:onDestructor()
	return
end

return FightGameMgr

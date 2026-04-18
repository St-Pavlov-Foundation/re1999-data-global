-- chunkname: @modules/logic/survival/controller/work/SurvivalSettleWeekPushWork.lua

module("modules.logic.survival.controller.work.SurvivalSettleWeekPushWork", package.seeall)

local SurvivalSettleWeekPushWork = class("SurvivalSettleWeekPushWork", BaseWork)

function SurvivalSettleWeekPushWork:ctor(msg)
	self._msg = msg
end

function SurvivalSettleWeekPushWork:onStart(context)
	SurvivalModel.instance:clearDebugSettleStr()
	SurvivalModel.instance:setSurvivalSettleInfo(self._msg)

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo and weekInfo.intrudeBox and weekInfo.intrudeBox.fight and self._msg.win then
		local fight = weekInfo.intrudeBox.fight
		local isFight = fight:isFighting()

		fight:setWin()

		if isFight then
			SurvivalModel.instance:addDebugSettleStr("setNeedShowFightSuccess - SurvivalSettleWeekPushWork")
			SurvivalShelterModel.instance:setNeedShowFightSuccess(true, fight.fightId)
		end
	end

	UIBlockHelper.instance:endBlock(SurvivalEnum.SurvivalIntrudeAbandonBlock)

	local curSceneType = GameSceneMgr.instance:getCurSceneType()
	local curScene = GameSceneMgr.instance:getCurScene()

	if curSceneType == SceneType.Fight then
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	elseif curSceneType == SceneType.SurvivalShelter then
		if GameSceneMgr.instance:isLoading() then
			GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
		else
			self:_onEnterOneSceneFinish(curSceneType)
		end
	else
		self:showSettle(true)
	end
end

function SurvivalSettleWeekPushWork:_onEnterOneSceneFinish(sceneType)
	if sceneType ~= SceneType.SurvivalShelter then
		self:showResultPanel(false)

		return
	end

	self:setActiveUIBlock("SurvivalSettleWeekPushWork", true, false)
	TaskDispatcher.cancelTask(self.delayProtectFinish, self)

	local needShowDestroy, _ = SurvivalShelterModel.instance:getNeedShowFightSuccess()

	if needShowDestroy then
		SurvivalModel.instance:addDebugSettleStr("registerCallback BossPerformFinish")
		SurvivalController.instance:registerCallback(SurvivalEvent.BossPerformFinish, self._bossPerformFinish, self)
		TaskDispatcher.runDelay(self.delayProtectFinish, self, 5)
	else
		self:_bossPerformFinish()
	end
end

function SurvivalSettleWeekPushWork:delayProtectFinish()
	SurvivalModel.instance:addDebugSettleStr("雨前结算打印 延迟强制结算")
	logError(SurvivalModel.instance.debugSettleStr)
	self:_bossPerformFinish()
end

function SurvivalSettleWeekPushWork:setActiveUIBlock(blockKey, isActiveBlock, isNeedCircleMv)
	if type(blockKey) ~= "string" then
		logError("blockKey can't be " .. type(blockKey))
	end

	isNeedCircleMv = isNeedCircleMv ~= false and true or false

	UIBlockMgrExtend.setNeedCircleMv(isNeedCircleMv)

	if isActiveBlock then
		UIBlockHelper.instance:startBlock(blockKey, 6)
	else
		UIBlockHelper.instance:endBlock(blockKey)
	end
end

function SurvivalSettleWeekPushWork:_bossPerformFinish()
	SurvivalModel.instance:addDebugSettleStr("_bossPerformFinish")
	TaskDispatcher.cancelTask(self.delayProtectFinish, self)
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Npc, false)
	SurvivalMapHelper.instance:hideUnitVisible(SurvivalEnum.ShelterUnitType.Monster, false)
	SurvivalMapHelper.instance:refreshPlayerEntity()
	SurvivalMapHelper.instance:stopShelterPlayerMove()
	TaskDispatcher.runDelay(self._tweenToPlayerPos, self, 0.5)
end

function SurvivalSettleWeekPushWork:_tweenToPlayerPos()
	local curScene = GameSceneMgr.instance:getCurScene()
	local player = curScene and curScene.unit and curScene.unit:getPlayer()

	if not player then
		self:showResultPanel(false)

		return
	end

	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale, 1, true)
	player:focusEntity(1, self.playEntityAnim, self)
end

function SurvivalSettleWeekPushWork:playEntityAnim()
	local curScene = GameSceneMgr.instance:getCurScene()
	local player = curScene and curScene.unit and curScene.unit:getPlayer()

	if not player then
		self:showResultPanel(false)

		return
	end

	local info = SurvivalModel.instance:getSurvivalSettleInfo()
	local isWin = info and info.win or false

	if isWin then
		player:playAnim("jump2")
		TaskDispatcher.runDelay(self.onPlayerAnimFinish, self, 1)
	else
		player:playAnim("die")
		TaskDispatcher.runDelay(self.onPlayerAnimFinish, self, 2)
	end
end

function SurvivalSettleWeekPushWork:onPlayerAnimFinish()
	local curScene = GameSceneMgr.instance:getCurScene()
	local player = curScene and curScene.unit and curScene.unit:getPlayer()
	local info = SurvivalModel.instance:getSurvivalSettleInfo()

	if player then
		local isWin = info and info.win or false

		if isWin then
			player:playAnim("idle")
		end
	end

	self:showResultPanel(true)
end

function SurvivalSettleWeekPushWork:_onStoryEnd()
	self:showResultPanel(true)
end

function SurvivalSettleWeekPushWork:isHideEnding()
	local report = self._msg.report

	if string.nilorempty(report) then
		return false
	end

	local endId = cjson.decode(report).endId
	local endConfig = lua_survival_end.configDict[endId]

	return endConfig and endConfig.type == 3
end

function SurvivalSettleWeekPushWork:showSettle(isSuccess)
	self:setActiveUIBlock("SurvivalSettleWeekPushWork", false, true)
	SurvivalController.instance:enterSurvivalSettle()
	self:onDone(isSuccess)
end

function SurvivalSettleWeekPushWork:showResultPanel(isSuccess)
	self:setActiveUIBlock("SurvivalSettleWeekPushWork", false, true)

	local info = SurvivalModel.instance:getSurvivalSettleInfo()
	local isWin = info and info.win

	ViewMgr.instance:openView(ViewName.SurvivalShelterResultPanelView, {
		isWin = isWin
	})
	self:onDone(isSuccess)
end

function SurvivalSettleWeekPushWork:clearWork()
	TaskDispatcher.cancelTask(self.delayProtectFinish, self)
	TaskDispatcher.cancelTask(self._tweenToPlayerPos, self)
	TaskDispatcher.cancelTask(self.onPlayerAnimFinish, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.EnterSceneFinish, self._onEnterOneSceneFinish, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.BossPerformFinish, self._bossPerformFinish, self)
	SurvivalShelterModel.instance:setNeedShowFightSuccess(nil, nil)
end

return SurvivalSettleWeekPushWork

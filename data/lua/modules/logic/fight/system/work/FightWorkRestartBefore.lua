-- chunkname: @modules/logic/fight/system/work/FightWorkRestartBefore.lua

module("modules.logic.fight.system.work.FightWorkRestartBefore", package.seeall)

local FightWorkRestartBefore = class("FightWorkRestartBefore", BaseWork)

function FightWorkRestartBefore:ctor()
	return
end

function FightWorkRestartBefore:onStart()
	self.work = FightWorkClearBeforeRestart.New()

	self.work:registFinishCallback(self._onWorkFinish, self)
	self.work:start()
end

function FightWorkRestartBefore:_onWorkFinish()
	if self.context and self.context.noReloadScene then
		self:_correctRootState()
		self:onDone(true)

		return
	end

	local prevSceneLevelId = GameSceneMgr.instance:getCurLevelId()
	local fightParam = FightModel.instance:getFightParam()
	local firstLevelId = fightParam:getSceneLevel(1)

	if prevSceneLevelId ~= firstLevelId then
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
		GameSceneMgr.instance:showLoading(SceneType.Fight)
		TaskDispatcher.runDelay(self._delayDone, self, 5)
		TaskDispatcher.runDelay(self._startLoadLevel, self, 0.25)

		self._loadTime = Time.time
	else
		self:_correctRootState()
		self:onDone(true)
	end
end

function FightWorkRestartBefore:_correctRootState()
	local fightScene = GameSceneMgr.instance:getCurScene()
	local sceneObj = fightScene.level:getSceneGo()

	gohelper.setActive(sceneObj, true)

	if GameSceneMgr.instance:getCurSceneId() == FightTLEventMarkSceneDefaultRoot.sceneId and GameSceneMgr.instance:getCurLevelId() == FightTLEventMarkSceneDefaultRoot.levelId and fightScene and sceneObj then
		local childCount = sceneObj.transform.childCount

		for i = 0, childCount - 1 do
			local childItem = sceneObj.transform:GetChild(i)

			gohelper.setActive(childItem.gameObject, childItem.name == FightTLEventMarkSceneDefaultRoot.rootName)
		end
	end
end

function FightWorkRestartBefore:_startLoadLevel()
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)
	local fightParam = FightModel.instance:getFightParam()
	local firstLevelId = fightParam:getSceneLevel(1)

	fightScene.level:onSceneStart(fightScene.level._sceneId, firstLevelId)
end

function FightWorkRestartBefore:_onLevelLoaded()
	local passTime = Time.time - self._loadTime
	local delay = 0.5 - passTime

	if delay <= 0 then
		self:onDone(true)
	else
		TaskDispatcher.cancelTask(self._delayDone, self)
		TaskDispatcher.runDelay(self._delayDone, self, delay)
	end

	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function FightWorkRestartBefore:_delayDone()
	local cur_scene = GameSceneMgr.instance:getCurScene()

	self:onDone(true)
end

function FightWorkRestartBefore:clearWork()
	GameSceneMgr.instance:hideLoading()
	TaskDispatcher.cancelTask(self._delayDone, self)
	TaskDispatcher.cancelTask(self._startLoadLevel, self)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, self._onLevelLoaded, self)

	if self.work then
		self.work:disposeSelf()

		self.work = nil
	end
end

return FightWorkRestartBefore

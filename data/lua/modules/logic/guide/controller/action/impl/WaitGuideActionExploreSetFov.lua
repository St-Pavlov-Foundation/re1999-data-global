-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreSetFov.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreSetFov", package.seeall)

local WaitGuideActionExploreSetFov = class("WaitGuideActionExploreSetFov", BaseGuideAction)

function WaitGuideActionExploreSetFov:onStart(context)
	local arr = string.splitToNumber(self.actionParam, "#")
	local fov = arr[1] or 35
	local time = arr[2] or 0
	local easeType = arr[3] or EaseType.Linear
	local cameraComp = GameSceneMgr.instance:getCurScene().camera

	if not cameraComp or not isTypeOf(cameraComp, ExploreSceneCameraComp) then
		self:onDone(true)

		return
	end

	if time > 0 then
		cameraComp:setEaseTime(time)
		cameraComp:setEaseType(easeType)
		cameraComp:setFov(fov)
		TaskDispatcher.runDelay(self.onCameraChangeDone, self, time)
	else
		cameraComp:setFov(fov)
		cameraComp:applyDirectly()
		self:onDone(true)
	end
end

function WaitGuideActionExploreSetFov:onCameraChangeDone()
	self:resetCameraParam()
	self:onDone(true)
end

function WaitGuideActionExploreSetFov:resetCameraParam()
	local cameraComp = GameSceneMgr.instance:getCurScene().camera

	if not cameraComp or not isTypeOf(cameraComp, ExploreSceneCameraComp) then
		return
	end

	cameraComp:setEaseTime(ExploreConstValue.CameraTraceTime)
	cameraComp:setEaseType(EaseType.Linear)
end

function WaitGuideActionExploreSetFov:clearWork()
	self:resetCameraParam()
	TaskDispatcher.cancelTask(self.onCameraChangeDone, self)
end

return WaitGuideActionExploreSetFov

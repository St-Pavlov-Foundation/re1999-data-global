-- chunkname: @modules/logic/scene/rouge2/comp/Rouge2_SceneCameraComp.lua

module("modules.logic.scene.rouge2.comp.Rouge2_SceneCameraComp", package.seeall)

local Rouge2_SceneCameraComp = class("Rouge2_SceneCameraComp", BaseSceneComp)

function Rouge2_SceneCameraComp:onInit()
	return
end

function Rouge2_SceneCameraComp:onSceneStart(sceneId, levelId)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onLoadMapDone, self.onLoadMapDone, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.focusChangeCameraSize, self.focusChangeCameraSize, self)

	self._cameraTrace = CameraMgr.instance:getCameraTrace()
	self._tranCameraTrace = CameraMgr.instance:getCameraTraceGO().transform
end

function Rouge2_SceneCameraComp:focusChangeCameraSize()
	if self.camera then
		self.camera.orthographicSize = Rouge2_MapModel.instance:getCameraSize()
	end
end

function Rouge2_SceneCameraComp:onLoadMapDone()
	self:initCameraSize()
	self:_resetCamera()
	TaskDispatcher.runRepeat(self._resetCamera, self, 1)

	if not self._sourceMt then
		self._sourceMt = getmetatable(self._cameraTrace)

		if self._sourceMt then
			self.__rawfunc = self._sourceMt.__newindex

			function self._sourceMt.__newindex(t, k, v)
				if k == "EnableTrace" then
					logError(string.format("尝试修改相机数据:%s %s", tostring(k), tostring(v)))
					self.__rawfunc(t, k, v)
				end
			end
		end
	end
end

local fixCount = 0
local fixDt

function Rouge2_SceneCameraComp:_resetCamera()
	local posX, posY, posZ = transformhelper.getLocalPos(self._tranCameraTrace)

	if posX ~= 0 or posY ~= 0 or posZ ~= 0 then
		local cameraTrace = CameraMgr.instance:getCameraTrace()
		local isEnableTrace = cameraTrace and cameraTrace.EnableTrace

		if fixDt and os.clock() - fixDt > 10 then
			fixCount = 0
		end

		fixCount = fixCount + 1
		fixDt = os.clock()

		logError(string.format("重置相机！！！  当前相机追踪状态: %s, 当前相机坐标 : %s, %s, %s, 修复次数：%s", isEnableTrace, posX, posY, posZ, fixCount))

		if isEnableTrace then
			cameraTrace.EnableTrace = false
		end

		transformhelper.setLocalPos(self._tranCameraTrace, 0, 0, 0)
	end
end

function Rouge2_SceneCameraComp:initCameraSize()
	gohelper.setActive(CameraMgr.instance:getVirtualCameraGO(), false)
	transformhelper.setLocalPos(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)
	transformhelper.setLocalRotation(CameraMgr.instance:getMainCameraTrs(), 0, 0, 0)

	local cameraTrace = CameraMgr.instance:getCameraTrace()

	if cameraTrace then
		cameraTrace.EnableTrace = false
	end

	self.camera = CameraMgr.instance:getMainCamera()
	self.camera.orthographic = true
	self.camera.orthographicSize = Rouge2_MapModel.instance:getCameraSize()
end

function Rouge2_SceneCameraComp:clearCamera()
	if self.camera then
		self.camera.orthographicSize = 5
		self.camera.orthographic = false
	end
end

function Rouge2_SceneCameraComp:onSceneClose()
	self:clearCamera()

	self.camera = nil

	if self._sourceMt then
		self._sourceMt.__newindex = self.__rawfunc
		self._sourceMt = nil
		self.__rawfunc = nil
	end

	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onLoadMapDone, self.onLoadMapDone, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onExitPieceChoiceEvent, self.onExitPieceChoiceEvent, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onMiddleActorBeforeMove, self.onMiddleActorBeforeMove, self)
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.focusChangeCameraSize, self.focusChangeCameraSize, self)
	TaskDispatcher.cancelTask(self._resetCamera, self)
	self:clearTween()
end

function Rouge2_SceneCameraComp:clearTween()
	if self.movingTweenId then
		ZProj.TweenHelper.KillById(self.movingTweenId)
	end

	self.movingTweenId = nil
end

function Rouge2_SceneCameraComp:onMiddleActorBeforeMove()
	AudioMgr.instance:trigger(AudioEnum.UI.MiddleLayerFocus)
	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, Rouge2_MapEnum.RevertDuration, self.frameCallback, self.onTweenDone, self, nil, Rouge2_MapEnum.CameraTweenLine)
end

function Rouge2_SceneCameraComp:onExitPieceChoiceEvent()
	if not Rouge2_MapModel.instance:isMiddle() then
		return
	end

	self:clearTween()

	self.movingTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, Rouge2_MapEnum.RevertDuration, self.frameCallback, self.onTweenDone, self, nil, Rouge2_MapEnum.CameraTweenLine)
end

function Rouge2_SceneCameraComp:frameCallback(value)
	local initCameraSize = Rouge2_MapModel.instance:getCameraSize()
	local focusCameraSize = Rouge2_MapEnum.MiddleLayerCameraSizeRate * initCameraSize
	local offset = initCameraSize - focusCameraSize
	local cameraSize = focusCameraSize + value * offset

	self.camera.orthographicSize = cameraSize

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onCameraSizeChange, cameraSize)
end

function Rouge2_SceneCameraComp:onTweenDone()
	self.movingTweenId = nil
end

return Rouge2_SceneCameraComp

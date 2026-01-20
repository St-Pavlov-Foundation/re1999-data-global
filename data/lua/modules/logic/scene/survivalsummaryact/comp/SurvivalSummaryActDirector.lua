-- chunkname: @modules/logic/scene/survivalsummaryact/comp/SurvivalSummaryActDirector.lua

module("modules.logic.scene.survivalsummaryact.comp.SurvivalSummaryActDirector", package.seeall)

local SurvivalSummaryActDirector = class("SurvivalSummaryActDirector", BaseSceneComp)

function SurvivalSummaryActDirector:onInit()
	self._scene = self:getCurScene()
end

function SurvivalSummaryActDirector:onSceneStart(sceneId, levelId)
	self._compInitSequence = FlowSequence.New()

	local levelAndPreloadWork = FlowParallel.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))

	if self._scene.fog then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.fog, SurvivalEvent.OnSurvivalFogLoaded))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.block, SurvivalEvent.OnSurvivalBlockLoadFinish))

	if self._scene.spBlock then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.spBlock, SurvivalEvent.OnSurvivalBlockLoadFinish))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, SurvivalEvent.OnSurvivalPreloadFinish))

	if self._scene.cloud then
		self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.cloud))
	end

	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.graphics))
	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function SurvivalSummaryActDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil

	ViewMgr.instance:closeView(ViewName.SurvivalLoadingView)
	SurvivalController.instance:playSummaryAct()
end

function SurvivalSummaryActDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:destroy()

		self._compInitSequence = nil
	end
end

return SurvivalSummaryActDirector

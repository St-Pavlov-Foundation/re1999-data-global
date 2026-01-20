-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneDirector.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneDirector", package.seeall)

local SurvivalShelterSceneDirector = class("SurvivalShelterSceneDirector", SurvivalSceneDirector)

function SurvivalShelterSceneDirector:startEnterProgress()
	self.survivalOpenViewWork = SurvivalOpenViewWork.New({
		viewName = ViewName.SurvivalMainView
	})

	self.survivalOpenViewWork:registerDoneListener(self.onOpenView, self)

	self.viewPopupFlow = FlowParallel.New()

	self.viewPopupFlow:addWork(self.survivalOpenViewWork)

	if PopupController.instance:getPopupCount() > 0 then
		self.viewPopupFlow:addWork(PopupViewFinishWork.New())
	end

	self.viewPopupFlow:start()
	self.viewPopupFlow:registerDoneListener(self.onSceneViewPopupFinish, self)
end

function SurvivalShelterSceneDirector:onSceneViewPopupFinish()
	SurvivalController.instance:onScenePopupFinish()
end

function SurvivalShelterSceneDirector:disposeEnterProgress()
	if self.viewPopupFlow then
		self.viewPopupFlow:destroy()

		self.viewPopupFlow = nil
	end
end

return SurvivalShelterSceneDirector

-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneDirector.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneDirector", package.seeall)

local SurvivalShelterSceneDirector = class("SurvivalShelterSceneDirector", SurvivalSceneDirector)

function SurvivalShelterSceneDirector:startEnterProgress()
	self._beginDt = ServerTime.now()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local have = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):haveReputationItem()

	if have and not weekInfo:isAllReputationShopMaxLevel() then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalReputationSelectView)
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	SurvivalMapHelper.instance:tryShowServerPanel(weekMo.panel)
	SurvivalModel.instance:checkBossFightItem()
	SurvivalMapHelper.instance:checkRoleLevelUpCache(true)

	if SurvivalShelterModel.instance:getNeedShowBossInvade() then
		SurvivalShelterModel.instance:setNeedShowBossInvade()
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalBossInvadeView)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Watch
		})
	end

	self.directorFlow = FlowSequence.New()

	local parallelWork1 = FlowParallel.New()
	local survivalOpenViewWork = SurvivalOpenViewWork.New({
		viewName = ViewName.SurvivalMainView
	})

	survivalOpenViewWork:registerDoneListener(self.onOpenView, self)
	parallelWork1:addWork(survivalOpenViewWork)

	if PopupController.instance:getPopupCount() > 0 then
		parallelWork1:addWork(PopupViewFinishWork.New())
	end

	self.directorFlow:addWork(parallelWork1)
	self.directorFlow:registerDoneListener(self.onSceneViewPopupFinish, self)
	self.directorFlow:start()
end

function SurvivalShelterSceneDirector:onSceneViewPopupFinish()
	SurvivalController.instance:onScenePopupFinish()
	self:processGuideEvent()
end

function SurvivalShelterSceneDirector:processGuideEvent()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if weekMo.day > 1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitWeekDay)
	end

	if weekMo.difficulty == 3 or weekMo.difficulty == 4 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideShelterHard)
	end
end

function SurvivalShelterSceneDirector:disposeEnterProgress()
	if self.directorFlow then
		self.directorFlow:destroy()

		self.directorFlow = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalMainView)
	ViewMgr.instance:closeAllPopupViews()

	local outSideMo = SurvivalModel.instance:getOutSideInfo()
	local type = "settle"

	if outSideMo and outSideMo.inWeek then
		type = "topleft"
	end

	SurvivalStatHelper.instance:statWeekClose(ServerTime.now() - self._beginDt, type)
end

return SurvivalShelterSceneDirector

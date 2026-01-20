-- chunkname: @modules/logic/scene/shelter/comp/SurvivalShelterSceneViewComp.lua

module("modules.logic.scene.shelter.comp.SurvivalShelterSceneViewComp", package.seeall)

local SurvivalShelterSceneViewComp = class("SurvivalShelterSceneViewComp", BaseSceneComp)

function SurvivalShelterSceneViewComp:onScenePrepared(sceneId, levelId)
	self._beginDt = ServerTime.now()

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local have = weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):haveReputationItem()

	if have and not weekInfo:isAllReputationShopMaxLevel() then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalReputationSelectView)
	end

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	SurvivalMapHelper.instance:tryShowServerPanel(weekMo.panel)

	if SurvivalShelterModel.instance:getNeedShowBossInvade() then
		SurvivalShelterModel.instance:setNeedShowBossInvade()
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalBossInvadeView)
	end

	TaskDispatcher.runDelay(self._delayProcessGuideEvent, self, 0.3)
end

function SurvivalShelterSceneViewComp:_delayProcessGuideEvent()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if weekMo.day > 1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitWeekDay)
	end

	if weekMo.difficulty == 3 or weekMo.difficulty == 4 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideShelterHard)
	end
end

function SurvivalShelterSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.SurvivalMainView)
	ViewMgr.instance:closeAllPopupViews()
	TaskDispatcher.cancelTask(self._delayProcessGuideEvent, self)

	local outSideMo = SurvivalModel.instance:getOutSideInfo()
	local type = "settle"

	if outSideMo and outSideMo.inWeek then
		type = "topleft"
	end

	SurvivalStatHelper.instance:statWeekClose(ServerTime.now() - self._beginDt, type)
end

return SurvivalShelterSceneViewComp

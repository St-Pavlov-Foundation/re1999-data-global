module("modules.logic.scene.shelter.comp.SurvivalShelterSceneViewComp", package.seeall)

local var_0_0 = class("SurvivalShelterSceneViewComp", BaseSceneComp)

function var_0_0.onScenePrepared(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._beginDt = ServerTime.now()

	local var_1_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_1_0:getBag(SurvivalEnum.ItemSource.Shelter):haveReputationItem() and not var_1_0:isAllReputationShopMaxLevel() then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalReputationSelectView)
	end

	local var_1_1 = SurvivalShelterModel.instance:getWeekInfo()

	SurvivalMapHelper.instance:tryShowServerPanel(var_1_1.panel)

	if SurvivalShelterModel.instance:getNeedShowBossInvade() then
		SurvivalShelterModel.instance:setNeedShowBossInvade()
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalBossInvadeView)
	end

	TaskDispatcher.runDelay(arg_1_0._delayProcessGuideEvent, arg_1_0, 0.3)
end

function var_0_0._delayProcessGuideEvent(arg_2_0)
	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()

	if var_2_0.day > 1 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitWeekDay)
	end

	if var_2_0.difficulty == 3 or var_2_0.difficulty == 4 then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideShelterHard)
	end
end

function var_0_0.onSceneClose(arg_3_0, arg_3_1, arg_3_2)
	ViewMgr.instance:closeView(ViewName.SurvivalMainView)
	ViewMgr.instance:closeAllPopupViews()
	TaskDispatcher.cancelTask(arg_3_0._delayProcessGuideEvent, arg_3_0)

	local var_3_0 = SurvivalModel.instance:getOutSideInfo()
	local var_3_1 = "settle"

	if var_3_0 and var_3_0.inWeek then
		var_3_1 = "topleft"
	end

	SurvivalStatHelper.instance:statWeekClose(ServerTime.now() - arg_3_0._beginDt, var_3_1)
end

return var_0_0

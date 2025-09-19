module("modules.logic.survival.view.map.SurvivalInitTeamViewContainer", package.seeall)

local var_0_0 = class("SurvivalInitTeamViewContainer", BaseViewContainer)
local var_0_1 = {
	Preview = 4,
	SelectMap = 1,
	SelectHero = 2,
	SelectNPC = 3
}
local var_0_2 = {}

for iter_0_0, iter_0_1 in pairs(var_0_1) do
	var_0_2[iter_0_1] = iter_0_0
end

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapSelectView = SurvivalMapSelectView.New("Panel/#go_Map")
	arg_1_0._initHeroView = SurvivalInitHeroView.New("Panel/#go_SelectMember")
	arg_1_0._initNpcView = SurvivalInitNpcView.New("Panel/#go_Partner")
	arg_1_0._previewTeamView = SurvivalPreviewTeamView.New("Panel/#go_Overview")

	return {
		arg_1_0._mapSelectView,
		arg_1_0._initHeroView,
		arg_1_0._initNpcView,
		arg_1_0._previewTeamView,
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.preStep(arg_3_0)
	arg_3_0._curProcess = arg_3_0._curProcess - 1

	if var_0_2[arg_3_0._curProcess] then
		arg_3_0:updateViewShow()
	else
		arg_3_0:closeThis()
	end
end

function var_0_0.nextStep(arg_4_0)
	arg_4_0._curProcess = arg_4_0._curProcess + 1

	if var_0_2[arg_4_0._curProcess] then
		arg_4_0:updateViewShow()
	else
		arg_4_0._curProcess = arg_4_0._curProcess - 1

		SurvivalController.instance:enterSurvivalMap(SurvivalMapModel.instance:getInitGroup())
	end
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0._lights = arg_5_0:getUserDataTb_()
	arg_5_0._viewAnim = gohelper.findChildAnim(arg_5_0.viewGO, "")
	arg_5_0._animWeight = gohelper.findChildAnim(arg_5_0.viewGO, "Panel/Weight")
	arg_5_0._txtWeight = gohelper.findChildTextMesh(arg_5_0.viewGO, "Panel/Weight/#txt_WeightNum")
	arg_5_0._curProcess = var_0_1.SelectMap

	for iter_5_0, iter_5_1 in pairs(var_0_1) do
		arg_5_0._lights[iter_5_1] = gohelper.findChild(arg_5_0.viewGO, "progress/" .. iter_5_1 .. "/light")
	end

	arg_5_0:updateViewShow()
	arg_5_0:addEventCb(GuideController.instance, GuideEvent.StartGuideStep, arg_5_0._onFinishGuideStep, arg_5_0)
end

function var_0_0.updateViewShow(arg_6_0)
	if arg_6_0._curProcess == var_0_1.SelectMap then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wenming_page)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	end

	arg_6_0._initHeroView:setIsShow(arg_6_0._curProcess == var_0_1.SelectHero)
	arg_6_0._initNpcView:setIsShow(arg_6_0._curProcess == var_0_1.SelectNPC)
	arg_6_0._previewTeamView:setIsShow(arg_6_0._curProcess == var_0_1.Preview)

	for iter_6_0, iter_6_1 in pairs(arg_6_0._lights) do
		gohelper.setActive(iter_6_1, iter_6_0 <= arg_6_0._curProcess)
	end

	gohelper.setActive(arg_6_0._animWeight, arg_6_0._curProcess ~= var_0_1.SelectMap)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitInitViewTab, tostring(arg_6_0._curProcess))
end

function var_0_0._onFinishGuideStep(arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._delayProcessEvent, arg_7_0, 0)
end

function var_0_0._delayProcessEvent(arg_8_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitInitViewTab, tostring(arg_8_0._curProcess))
end

function var_0_0.setWeightNum(arg_9_0)
	local var_9_0 = SurvivalMapModel.instance:getInitGroup()
	local var_9_1 = tabletool.len(var_9_0.allSelectHeroMos)
	local var_9_2 = tabletool.len(var_9_0.allSelectNpcs)
	local var_9_3 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.HeroWeight)
	local var_9_4 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)
	local var_9_5 = var_9_1 * var_9_3 + var_9_4

	arg_9_0:killTweenWeight()

	if not arg_9_0._totalWeight or var_9_5 <= arg_9_0._totalWeight then
		arg_9_0._txtWeight.text = var_9_5
	else
		arg_9_0._animWeight:Play("change", 0, 0)

		arg_9_0._tweenWeightId = ZProj.TweenHelper.DOTweenFloat(arg_9_0._totalWeight, var_9_5, 1, arg_9_0._onFrame, arg_9_0._onTweenFinish, arg_9_0)
	end

	arg_9_0._totalWeight = var_9_5
end

function var_0_0._onFrame(arg_10_0, arg_10_1)
	arg_10_0._txtWeight.text = math.floor(arg_10_1)
end

function var_0_0._onTweenFinish(arg_11_0)
	arg_11_0._tweenWeightId = nil
	arg_11_0._txtWeight.text = arg_11_0._totalWeight
end

function var_0_0.killTweenWeight(arg_12_0)
	if arg_12_0._tweenWeightId then
		ZProj.TweenHelper.KillById(arg_12_0._tweenWeightId)

		arg_12_0._tweenWeightId = nil
	end
end

function var_0_0.playAnim(arg_13_0, arg_13_1)
	arg_13_0._viewAnim:Play(arg_13_1, 0, 0)
end

function var_0_0.onContainerClose(arg_14_0)
	arg_14_0:removeEventCb(GuideController.instance, GuideEvent.StartGuideStep, arg_14_0._onFinishGuideStep, arg_14_0)
	arg_14_0:killTweenWeight()
	var_0_0.super.onContainerClose(arg_14_0)
end

return var_0_0

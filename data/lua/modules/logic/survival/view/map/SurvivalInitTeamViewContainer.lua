module("modules.logic.survival.view.map.SurvivalInitTeamViewContainer", package.seeall)

local var_0_0 = class("SurvivalInitTeamViewContainer", BaseViewContainer)
local var_0_1 = {
	SelectMap = 1,
	Preview = 2
}
local var_0_2 = {}

for iter_0_0, iter_0_1 in pairs(var_0_1) do
	var_0_2[iter_0_1] = iter_0_0
end

function var_0_0.buildViews(arg_1_0)
	arg_1_0._mapSelectView = SurvivalMapSelectView.New("Panel/#go_Map")
	arg_1_0._previewTeamView = SurvivalPreviewTeamView.New("Panel/#go_Overview")

	return {
		arg_1_0._mapSelectView,
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

		local var_4_0 = SurvivalShelterModel.instance:getWeekInfo()
		local var_4_1 = SurvivalMapModel.instance:getSelectMapId()

		ViewMgr.instance:openView(ViewName.SurvivalShopView, {
			shopMo = var_4_0.preExploreShop,
			mapId = var_4_1
		})
	end
end

function var_0_0.onContainerInit(arg_5_0)
	arg_5_0._lights = arg_5_0:getUserDataTb_()
	arg_5_0._viewAnim = gohelper.findChildAnim(arg_5_0.viewGO, "")
	arg_5_0._animWeight = gohelper.findChildAnim(arg_5_0.viewGO, "Panel/Weight")
	arg_5_0._txtWeight = gohelper.findChildTextMesh(arg_5_0.viewGO, "Panel/Weight/#txt_WeightNum")
	arg_5_0._curProcess = var_0_1.SelectMap

	arg_5_0:updateViewShow()
	arg_5_0:addEventCb(GuideController.instance, GuideEvent.StartGuideStep, arg_5_0._onFinishGuideStep, arg_5_0)
end

function var_0_0.updateViewShow(arg_6_0)
	if arg_6_0._curProcess == var_0_1.SelectMap then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wenming_page)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	end

	arg_6_0._previewTeamView:setIsShow(arg_6_0._curProcess == var_0_1.Preview)
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
	local var_9_2 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	arg_9_0._txtWeight.text = var_9_2
end

function var_0_0.playAnim(arg_10_0, arg_10_1)
	arg_10_0._viewAnim:Play(arg_10_1, 0, 0)
end

function var_0_0.onContainerClose(arg_11_0)
	arg_11_0:removeEventCb(GuideController.instance, GuideEvent.StartGuideStep, arg_11_0._onFinishGuideStep, arg_11_0)
	var_0_0.super.onContainerClose(arg_11_0)
end

return var_0_0

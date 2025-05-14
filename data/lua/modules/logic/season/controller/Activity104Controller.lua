module("modules.logic.season.controller.Activity104Controller", package.seeall)

local var_0_0 = class("Activity104Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.openSeasonMainView(arg_3_0, arg_3_1)
	local var_3_0 = Activity104Model.instance:getCurSeasonId()
	local var_3_1, var_3_2, var_3_3 = ActivityHelper.getActivityStatusAndToast(var_3_0)

	if var_3_1 ~= ActivityEnum.ActivityStatus.Normal then
		if var_3_2 then
			GameFacade.showToastWithTableParam(var_3_2, var_3_3)
		end

		return
	end

	local function var_3_4()
		local var_4_0 = SeasonConfig.instance:getStoryIds(var_3_0)

		if not StoryModel.instance:isStoryFinished(var_4_0[1]) then
			StoryController.instance:playStories(var_4_0, nil, arg_3_0.onStoryBack, arg_3_0, arg_3_1)

			return
		end

		SeasonViewHelper.openView(var_3_0, Activity104Enum.ViewName.MainView, arg_3_1)
	end

	if Activity104Model.instance:tryGetActivityInfo(var_3_0, var_3_4) then
		var_3_4()
	end
end

function var_0_0.onStoryBack(arg_5_0, arg_5_1)
	local var_5_0 = Activity104Model.instance:getCurSeasonId()

	Activity104Rpc.instance:sendMarkActivity104StoryRequest(var_5_0)
	var_0_0.instance:openSeasonMainView(arg_5_1)
end

function var_0_0.openSeasonMarketView(arg_6_0, arg_6_1)
	local var_6_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_6_0, Activity104Enum.ViewName.MarketView, arg_6_1)
end

function var_0_0.openSeasonSpecialMarketView(arg_7_0, arg_7_1)
	local var_7_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_7_0, Activity104Enum.ViewName.SpecialMarketView, arg_7_1)
end

function var_0_0.openSeasonTaskView(arg_8_0)
	local var_8_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_8_0, Activity104Enum.ViewName.TaskView)
end

function var_0_0.openSeasonCardBook(arg_9_0)
	local var_9_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_9_0, Activity104Enum.ViewName.EquipBookView)
end

function var_0_0.openSeasonEquipView(arg_10_0, arg_10_1)
	local var_10_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_10_0, Activity104Enum.ViewName.EquipView, arg_10_1)
end

function var_0_0.openSeasonEquipHeroView(arg_11_0, arg_11_1)
	local var_11_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_11_0, Activity104Enum.ViewName.EquipHeroView, arg_11_1)
end

function var_0_0.openSeasonFightRuleTipView(arg_12_0, arg_12_1)
	local var_12_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_12_0, Activity104Enum.ViewName.FightRuleTipView, arg_12_1)
end

function var_0_0.openSeasonRetailView(arg_13_0, arg_13_1)
	local var_13_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_13_0, Activity104Enum.ViewName.RetailView, arg_13_1)
end

function var_0_0.openSeasonRetailLevelInfoView(arg_14_0, arg_14_1)
	local var_14_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_14_0, Activity104Enum.ViewName.RetailLevelInfoView, arg_14_1)
end

function var_0_0.openSeasonHeroGroupFightView(arg_15_0, arg_15_1)
	local var_15_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_15_0, Activity104Enum.ViewName.HeroGroupFightView, arg_15_1)
end

function var_0_0.openSeasonSettlementView(arg_16_0, arg_16_1)
	local var_16_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_16_0, Activity104Enum.ViewName.SettlementView, arg_16_1)
end

function var_0_0.openSeasonFightSuccView(arg_17_0, arg_17_1)
	local var_17_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_17_0, Activity104Enum.ViewName.FightSuccView, arg_17_1)
end

function var_0_0.openSeasonEquipSelectChoiceView(arg_18_0, arg_18_1)
	if Activity104Model.instance:getAct104CurLayer() < 3 or ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_18_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_18_0, Activity104Enum.ViewName.EquipSelfChoiceView, arg_18_1)
end

function var_0_0.checkShowEquipSelfChoiceView(arg_19_0)
	if Activity104Model.instance:getAct104CurLayer() < 3 or ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	local var_19_0 = Activity104Model.instance:getCurSeasonId()
	local var_19_1 = Activity104Model.instance:getOptionalAct104Equips(var_19_0)

	if #var_19_1 > 0 then
		local var_19_2 = SeasonViewHelper.getViewName(var_19_0, Activity104Enum.ViewName.EquipSelfChoiceView)

		for iter_19_0 = 1, #var_19_1 do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, var_19_2, {
				actId = var_19_0,
				costItemUid = var_19_1[iter_19_0].uid
			})
		end
	end
end

function var_0_0.openSeasonCelebrityCardTipView(arg_20_0, arg_20_1)
	local var_20_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_20_0, Activity104Enum.ViewName.CelebrityCardTipView, arg_20_1)
end

function var_0_0.openSeasonAdditionRuleTipView(arg_21_0, arg_21_1)
	local var_21_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_21_0, Activity104Enum.ViewName.AdditionRuleTipView, arg_21_1)
end

function var_0_0.openSeasonCelebrityCardGetlView(arg_22_0, arg_22_1)
	local var_22_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_22_0, Activity104Enum.ViewName.CelebrityCardGetlView, arg_22_1)
end

function var_0_0.openSeasonFightFailView(arg_23_0, arg_23_1)
	local var_23_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_23_0, Activity104Enum.ViewName.FightFailView, arg_23_1)
end

function var_0_0.openSeasonSumView(arg_24_0, arg_24_1)
	local var_24_0 = Activity104Model.instance:getCurSeasonId()

	SeasonViewHelper.openView(var_24_0, Activity104Enum.ViewName.SumView, arg_24_1)
end

function var_0_0.openSeasonStoreView(arg_25_0)
	local var_25_0 = Activity104Model.instance:getCurSeasonId()
	local var_25_1 = SeasonViewHelper.getViewName(var_25_0, Activity104Enum.ViewName.StoreView)
	local var_25_2 = Activity104Enum.SeasonStore[var_25_0]

	arg_25_0:enterVersionActivityView(var_25_1, var_25_2, function()
		Activity107Rpc.instance:sendGet107GoodsInfoRequest(var_25_2, function()
			ViewMgr.instance:openView(var_25_1, {
				actId = var_25_2
			})
		end)
	end)
end

function var_0_0.closeSeasonView(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = Activity104Model.instance:getCurSeasonId()
	local var_28_1 = SeasonViewHelper.getViewName(var_28_0, arg_28_1)

	ViewMgr.instance:closeView(var_28_1, arg_28_2, arg_28_3)
end

function var_0_0.enterVersionActivityView(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0, var_29_1, var_29_2 = ActivityHelper.getActivityStatusAndToast(arg_29_2)

	if var_29_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_29_1 then
			GameFacade.showToast(var_29_1, var_29_2)
		end

		return
	end

	if arg_29_3 then
		arg_29_3(arg_29_4, arg_29_1, arg_29_2)

		return
	end

	ViewMgr.instance:openView(arg_29_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0

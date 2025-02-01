module("modules.logic.season.controller.Activity104Controller", package.seeall)

slot0 = class("Activity104Controller", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.openSeasonMainView(slot0, slot1)
	slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(Activity104Model.instance:getCurSeasonId())

	if slot3 ~= ActivityEnum.ActivityStatus.Normal then
		if slot4 then
			GameFacade.showToastWithTableParam(slot4, slot5)
		end

		return
	end

	if Activity104Model.instance:tryGetActivityInfo(slot2, function ()
		if not StoryModel.instance:isStoryFinished(SeasonConfig.instance:getStoryIds(uv0)[1]) then
			StoryController.instance:playStories(slot0, nil, uv1.onStoryBack, uv1, uv2)

			return
		end

		SeasonViewHelper.openView(uv0, Activity104Enum.ViewName.MainView, uv2)
	end) then
		slot6()
	end
end

function slot0.onStoryBack(slot0, slot1)
	Activity104Rpc.instance:sendMarkActivity104StoryRequest(Activity104Model.instance:getCurSeasonId())
	uv0.instance:openSeasonMainView(slot1)
end

function slot0.openSeasonMarketView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.MarketView, slot1)
end

function slot0.openSeasonSpecialMarketView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.SpecialMarketView, slot1)
end

function slot0.openSeasonTaskView(slot0)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.TaskView)
end

function slot0.openSeasonCardBook(slot0)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.EquipBookView)
end

function slot0.openSeasonEquipView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.EquipView, slot1)
end

function slot0.openSeasonEquipHeroView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.EquipHeroView, slot1)
end

function slot0.openSeasonFightRuleTipView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.FightRuleTipView, slot1)
end

function slot0.openSeasonRetailView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.RetailView, slot1)
end

function slot0.openSeasonRetailLevelInfoView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.RetailLevelInfoView, slot1)
end

function slot0.openSeasonHeroGroupFightView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.HeroGroupFightView, slot1)
end

function slot0.openSeasonSettlementView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.SettlementView, slot1)
end

function slot0.openSeasonFightSuccView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.FightSuccView, slot1)
end

function slot0.openSeasonEquipSelectChoiceView(slot0, slot1)
	if Activity104Model.instance:getAct104CurLayer() < 3 or ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.EquipSelfChoiceView, slot1)
end

function slot0.checkShowEquipSelfChoiceView(slot0)
	if Activity104Model.instance:getAct104CurLayer() < 3 or ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	if #Activity104Model.instance:getOptionalAct104Equips(Activity104Model.instance:getCurSeasonId()) > 0 then
		for slot8 = 1, #slot3 do
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, SeasonViewHelper.getViewName(slot2, Activity104Enum.ViewName.EquipSelfChoiceView), {
				actId = slot2,
				costItemUid = slot3[slot8].uid
			})
		end
	end
end

function slot0.openSeasonCelebrityCardTipView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardTipView, slot1)
end

function slot0.openSeasonAdditionRuleTipView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.AdditionRuleTipView, slot1)
end

function slot0.openSeasonCelebrityCardGetlView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.CelebrityCardGetlView, slot1)
end

function slot0.openSeasonFightFailView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.FightFailView, slot1)
end

function slot0.openSeasonSumView(slot0, slot1)
	SeasonViewHelper.openView(Activity104Model.instance:getCurSeasonId(), Activity104Enum.ViewName.SumView, slot1)
end

function slot0.openSeasonStoreView(slot0)
	slot1 = Activity104Model.instance:getCurSeasonId()

	slot0:enterVersionActivityView(SeasonViewHelper.getViewName(slot1, Activity104Enum.ViewName.StoreView), Activity104Enum.SeasonStore[slot1], function ()
		Activity107Rpc.instance:sendGet107GoodsInfoRequest(uv0, function ()
			ViewMgr.instance:openView(uv0, {
				actId = uv1
			})
		end)
	end)
end

function slot0.closeSeasonView(slot0, slot1, slot2, slot3)
	ViewMgr.instance:closeView(SeasonViewHelper.getViewName(Activity104Model.instance:getCurSeasonId(), slot1), slot2, slot3)
end

function slot0.enterVersionActivityView(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = ActivityHelper.getActivityStatusAndToast(slot2)

	if slot5 ~= ActivityEnum.ActivityStatus.Normal then
		if slot6 then
			GameFacade.showToast(slot6, slot7)
		end

		return
	end

	if slot3 then
		slot3(slot4, slot1, slot2)

		return
	end

	ViewMgr.instance:openView(slot1)
end

slot0.instance = slot0.New()

return slot0

module("modules.logic.bossrush.view.V1a4_BossRushMainView", package.seeall)

slot0 = class("V1a4_BossRushMainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/#txt_LimitTime")
	slot0._scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "Rewards/#scroll_Rewards")
	slot0._goRewards = gohelper.findChild(slot0.viewGO, "Rewards/#scroll_Rewards/Viewport/#go_Rewards")
	slot0._btnStore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Store/#btn_Store")
	slot0._simageProp = gohelper.findChildImage(slot0.viewGO, "Store/#btn_Store/#simage_Prop")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Store/#btn_Store/#txt_Num")
	slot0._scrollChapterList = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_ChapterList")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_ChapterList/Viewport/#go_Content")
	slot0._btnAchievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "TopRight/#btn_Achievement")
	slot0._txtAchievement = gohelper.findChildText(slot0.viewGO, "TopRight/#txt_Achievement")
	slot0._goStoreTip = gohelper.findChild(slot0.viewGO, "Store/image_Tips")
	slot0._txtStore = gohelper.findChildText(slot0.viewGO, "Store/#btn_Store/txt_Store")
	slot0._txtActDesc = gohelper.findChildText(slot0.viewGO, "txtDescr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStore:AddClickListener(slot0._btnStoreOnClick, slot0)
	slot0._btnAchievement:AddClickListener(slot0._btnAchievementOnClick, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshStoreTag, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0._refreshStoreTag, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, slot0._refreshStoreTag, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStore:RemoveClickListener()
	slot0._btnAchievement:RemoveClickListener()
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshStoreTag, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0._refreshStoreTag, slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, slot0._refreshStoreTag, slot0)
end

function slot0._btnStoreOnClick(slot0)
	BossRushController.instance:openBossRushStoreView(slot0.actId)
end

function slot0._btnAchievementOnClick(slot0)
	JumpController.instance:jump(ActivityConfig.instance:getActivityCo(slot0.actId) and slot1.achievementJumpId)
end

function slot0._editableInitView(slot0)
	slot0._txtLimitTime.text = ""

	slot0._simagebg:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_mainfullbg"))

	slot0._txtAchievement.text = luaLang("achievement_name")
	slot0._txtStore.text, slot2 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = BossRushConfig.instance:getActivityId()

	if slot0.viewParam and slot0.viewParam.isOpenLevelDetail then
		BossRushController.instance:openLevelDetailView({
			stage = slot0.viewParam.stage,
			layer = slot0.viewParam.layer
		})
	end

	slot0:_refresh()
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	slot0:_refreshCurrency()
	slot0:_refreshStoreTag()
end

function slot0._refreshStoreTag(slot0)
	gohelper.setActive(slot0._goStoreTip, V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore())
end

function slot0.onOpenFinish(slot0)
	BossRushRedModel.instance:setIsOpenActivity(false)

	for slot5, slot6 in ipairs(BossRushConfig.instance:getStages()) do
		if BossRushModel.instance:isBossOnline(slot6.stage) then
			BossRushRedModel.instance:setIsNewUnlockStage(slot7, false)
		end
	end
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMemberList(slot0, "_itemList")
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	slot0._simagebg:UnLoadImage()
end

function slot0._onRefreshDeadline(slot0)
	slot0._txtLimitTime.text = BossRushModel.instance:getRemainTimeStr()
end

function slot0._refresh(slot0)
	slot0:_refreshLeft()
	slot0:_refreshRight()
end

function slot0._refreshLeft(slot0)
	slot0:_refreshLeftTop()
	slot0:_refreshLeftBottom()
end

function slot0._refreshCurrency(slot0)
	if V1a6_BossRush_StoreModel.instance:getCurrencyCount(slot0.actId) then
		slot0._txtNum.text = slot1
	end
end

function slot0._create_V1a4_BossRushMainItem(slot0)
	slot1 = V1a4_BossRushMainItem

	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushmainitem, slot0._goContent, slot1.__cname), slot1)
end

function slot0._initItemList(slot0, slot1)
	if slot0._itemList then
		return
	end

	slot0._itemList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0:_create_V1a4_BossRushMainItem()
		slot7._index = slot5

		slot7:setData(slot6, true)
		table.insert(slot0._itemList, slot7)
	end
end

function slot0._refreshRight(slot0)
	slot0:_initItemList(BossRushModel.instance:getStagesInfo())
end

function slot0._refreshLeftTop(slot0)
	slot0:_onRefreshDeadline()
end

function slot0._refreshLeftBottom(slot0)
	IconMgr.instance:getCommonPropItemIconList(slot0, slot0._onRewardItemShow, ItemModel.instance:getItemDataListByConfigStr(BossRushConfig.instance:getActivityRewardStr()), slot0._goRewards)
end

function slot0._onRewardItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)
	slot1:setConsume(true)
	slot1:showStackableNum2()
	slot1:isShowEffect(true)
	slot1:setAutoPlay(true)
	slot1:setCountFontSize(48)
	slot1:isShowEquipAndItemCount(false)
end

return slot0

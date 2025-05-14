module("modules.logic.bossrush.view.V1a4_BossRushMainView", package.seeall)

local var_0_0 = class("V1a4_BossRushMainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._scrollRewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "Rewards/#scroll_Rewards")
	arg_1_0._goRewards = gohelper.findChild(arg_1_0.viewGO, "Rewards/#scroll_Rewards/Viewport/#go_Rewards")
	arg_1_0._btnStore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Store/#btn_Store")
	arg_1_0._simageProp = gohelper.findChildImage(arg_1_0.viewGO, "Store/#btn_Store/#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Store/#btn_Store/#txt_Num")
	arg_1_0._scrollChapterList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_ChapterList")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_ChapterList/Viewport/#go_Content")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "TopRight/#btn_Achievement")
	arg_1_0._txtAchievement = gohelper.findChildText(arg_1_0.viewGO, "TopRight/#txt_Achievement")
	arg_1_0._goStoreTip = gohelper.findChild(arg_1_0.viewGO, "Store/image_Tips")
	arg_1_0._txtStore = gohelper.findChildText(arg_1_0.viewGO, "Store/#btn_Store/txt_Store")
	arg_1_0._txtActDesc = gohelper.findChildText(arg_1_0.viewGO, "txtDescr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStore:AddClickListener(arg_2_0._btnStoreOnClick, arg_2_0)
	arg_2_0._btnAchievement:AddClickListener(arg_2_0._btnAchievementOnClick, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refreshCurrency, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._refreshStoreTag, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_2_0._refreshStoreTag, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, arg_2_0._refreshStoreTag, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStore:RemoveClickListener()
	arg_3_0._btnAchievement:RemoveClickListener()
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refreshCurrency, arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0._refreshStoreTag, arg_3_0)
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_3_0._refreshStoreTag, arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, arg_3_0._refreshStoreTag, arg_3_0)
end

function var_0_0._btnStoreOnClick(arg_4_0)
	BossRushController.instance:openBossRushStoreView(arg_4_0.actId)
end

function var_0_0._btnAchievementOnClick(arg_5_0)
	local var_5_0 = ActivityConfig.instance:getActivityCo(arg_5_0.actId)
	local var_5_1 = var_5_0 and var_5_0.achievementJumpId

	JumpController.instance:jump(var_5_1)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._txtLimitTime.text = ""

	arg_6_0._simagebg:LoadImage(ResUrl.getV1a4BossRushSinglebg("v1a4_bossrush_mainfullbg"))

	arg_6_0._txtAchievement.text = luaLang("achievement_name")

	local var_6_0, var_6_1 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	arg_6_0._txtStore.text = var_6_0
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.actId = BossRushConfig.instance:getActivityId()

	if arg_8_0.viewParam and arg_8_0.viewParam.isOpenLevelDetail then
		local var_8_0 = arg_8_0.viewParam.stage
		local var_8_1 = arg_8_0.viewParam.layer
		local var_8_2 = {
			stage = var_8_0,
			layer = var_8_1
		}

		BossRushController.instance:openLevelDetailView(var_8_2)
	end

	arg_8_0:_refresh()
	TaskDispatcher.runRepeat(arg_8_0._onRefreshDeadline, arg_8_0, 1)
	arg_8_0:_refreshCurrency()
	arg_8_0:_refreshStoreTag()
end

function var_0_0._refreshStoreTag(arg_9_0)
	local var_9_0 = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(arg_9_0._goStoreTip, var_9_0)
end

function var_0_0.onOpenFinish(arg_10_0)
	BossRushRedModel.instance:setIsOpenActivity(false)

	local var_10_0 = BossRushConfig.instance:getStages()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = iter_10_1.stage

		if BossRushModel.instance:isBossOnline(var_10_1) then
			BossRushRedModel.instance:setIsNewUnlockStage(var_10_1, false)
		end
	end
end

function var_0_0.onClose(arg_11_0)
	GameUtil.onDestroyViewMemberList(arg_11_0, "_itemList")
	TaskDispatcher.cancelTask(arg_11_0._onRefreshDeadline, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._onRefreshDeadline, arg_12_0)
	arg_12_0._simagebg:UnLoadImage()
end

function var_0_0._onRefreshDeadline(arg_13_0)
	arg_13_0._txtLimitTime.text = BossRushModel.instance:getRemainTimeStr()
end

function var_0_0._refresh(arg_14_0)
	arg_14_0:_refreshLeft()
	arg_14_0:_refreshRight()
end

function var_0_0._refreshLeft(arg_15_0)
	arg_15_0:_refreshLeftTop()
	arg_15_0:_refreshLeftBottom()
end

function var_0_0._refreshCurrency(arg_16_0)
	local var_16_0 = V1a6_BossRush_StoreModel.instance:getCurrencyCount(arg_16_0.actId)

	if var_16_0 then
		arg_16_0._txtNum.text = var_16_0
	end
end

function var_0_0._create_V1a4_BossRushMainItem(arg_17_0)
	local var_17_0 = V1a4_BossRushMainItem
	local var_17_1 = arg_17_0.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushmainitem, arg_17_0._goContent, var_17_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_17_1, var_17_0)
end

function var_0_0._initItemList(arg_18_0, arg_18_1)
	if arg_18_0._itemList then
		return
	end

	arg_18_0._itemList = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = arg_18_0:_create_V1a4_BossRushMainItem()

		var_18_0._index = iter_18_0

		var_18_0:setData(iter_18_1, true)
		table.insert(arg_18_0._itemList, var_18_0)
	end
end

function var_0_0._refreshRight(arg_19_0)
	local var_19_0 = BossRushModel.instance:getStagesInfo()

	arg_19_0:_initItemList(var_19_0)
end

function var_0_0._refreshLeftTop(arg_20_0)
	arg_20_0:_onRefreshDeadline()
end

function var_0_0._refreshLeftBottom(arg_21_0)
	local var_21_0 = BossRushConfig.instance:getActivityRewardStr()
	local var_21_1 = ItemModel.instance:getItemDataListByConfigStr(var_21_0)

	IconMgr.instance:getCommonPropItemIconList(arg_21_0, arg_21_0._onRewardItemShow, var_21_1, arg_21_0._goRewards)
end

function var_0_0._onRewardItemShow(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_1:onUpdateMO(arg_22_2)
	arg_22_1:setConsume(true)
	arg_22_1:showStackableNum2()
	arg_22_1:isShowEffect(true)
	arg_22_1:setAutoPlay(true)
	arg_22_1:setCountFontSize(48)
	arg_22_1:isShowEquipAndItemCount(false)
end

return var_0_0

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_EnterView", package.seeall)

local var_0_0 = class("V1a6_BossRush_EnterView", VersionActivityEnterBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageBOSS = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_BOSS")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_Title")
	arg_1_0._simageTitle_Layer4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_TitleLayer4")
	arg_1_0._simageFullBGLayer4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBGLayer4")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/#txt_LimitTime")
	arg_1_0._btnStore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/Store/#btn_Store/click")
	arg_1_0._simageProp = gohelper.findChildImage(arg_1_0.viewGO, "Right/Store/#btn_Store/#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Right/Store/#btn_Store/#txt_Num")
	arg_1_0._btnNormal = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Normal/click")
	arg_1_0._btnUnOpen = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_UnOpen/click")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Right/#btn_UnOpen/image_TIps/#txt_Tips")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._goStoreTip = gohelper.findChild(arg_1_0.viewGO, "Right/Store/image_Tips")
	arg_1_0._txtStore = gohelper.findChildText(arg_1_0.viewGO, "Right/Store/#btn_Store/txt_Store")
	arg_1_0._txtActDesc = gohelper.findChildText(arg_1_0.viewGO, "Left/txtDescr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStore:AddClickListener(arg_2_0._btnStoreOnClick, arg_2_0)
	arg_2_0._btnNormal:AddClickListener(arg_2_0._btnNormalOnClick, arg_2_0)
	arg_2_0._btnUnOpen:AddClickListener(arg_2_0._btnUnOpenOnClick, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._refreshStoreTag, arg_2_0)
	arg_2_0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_2_0._refreshStoreTag, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._refreshCurrency, arg_2_0)
	arg_2_0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, arg_2_0._refreshStoreTag, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStore:RemoveClickListener()
	arg_3_0._btnNormal:RemoveClickListener()
	arg_3_0._btnUnOpen:RemoveClickListener()
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0._refreshStoreTag, arg_3_0)
	arg_3_0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, arg_3_0._refreshStoreTag, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._refreshCurrency, arg_3_0)
	arg_3_0:removeEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, arg_3_0._refreshStoreTag, arg_3_0)
end

function var_0_0._btnUnOpenOnClick(arg_4_0)
	BossRushController.instance:openMainView()
end

function var_0_0._btnStoreOnClick(arg_5_0)
	BossRushController.instance:openBossRushStoreView(arg_5_0.actId)
end

function var_0_0._btnNormalOnClick(arg_6_0)
	BossRushController.instance:openMainView()
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0, var_7_1 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	arg_7_0._txtStore.text = var_7_0
	arg_7_0._itemObjects = {}

	local var_7_2 = BossRushModel.instance:getActivityMo()

	if var_7_2 then
		arg_7_0._txtActDesc.text = var_7_2.config.actDesc

		local var_7_3 = GameUtil.splitString2(var_7_2.config.activityBonus, true)

		if var_7_3 then
			for iter_7_0, iter_7_1 in ipairs(var_7_3) do
				local var_7_4 = arg_7_0._itemObjects[iter_7_0]

				if not var_7_4 then
					var_7_4 = IconMgr.instance:getCommonPropItemIcon(arg_7_0._gorewardcontent)

					table.insert(arg_7_0._itemObjects, var_7_4)
				end

				var_7_4:setMOValue(iter_7_1[1], iter_7_1[2], 1)
				var_7_4:isShowCount(false)
			end
		end

		if var_7_2.config.openId and var_7_2.config.openId > 0 then
			local var_7_5 = OpenHelper.getActivityUnlockTxt(var_7_2.config.openId)

			arg_7_0._txtTips.text = var_7_5
		end
	end
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	var_0_0.super.onOpen(arg_9_0)

	arg_9_0.actId = BossRushConfig.instance:getActivityId()

	local var_9_0 = ActivityModel.instance:getActivityInfo()[arg_9_0.actId]
	local var_9_1 = var_9_0 and ActivityHelper.getActivityStatus(arg_9_0.actId) == ActivityEnum.ActivityStatus.Normal
	local var_9_2 = gohelper.findChild(arg_9_0.viewGO, "Right/#btn_Normal")
	local var_9_3 = gohelper.findChild(arg_9_0.viewGO, "Right/#btn_UnOpen")
	local var_9_4 = gohelper.findChild(arg_9_0.viewGO, "Right/#btn_Normal/#go_reddot")

	gohelper.setActive(var_9_2, var_9_1)
	gohelper.setActive(var_9_3, not var_9_1)

	local var_9_5 = RedDotEnum.DotNode.BossRushEnter

	RedDotController.instance:addRedDot(var_9_4, var_9_5)

	if not var_9_0 then
		arg_9_0._txtLimitTime.text = ""
	end

	arg_9_0:_refreshCurrency()
	arg_9_0:_refreshTime()
	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	arg_9_0:_refreshStoreTag()

	local var_9_6 = false

	gohelper.setActive(arg_9_0._simageTitle.gameObject, not var_9_6)
	gohelper.setActive(arg_9_0._simageTitle_Layer4.gameObject, var_9_6)
	gohelper.setActive(arg_9_0._simageFullBGLayer4.gameObject, var_9_6)
end

function var_0_0.onClose(arg_10_0)
	var_0_0.super.onClose(arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0.rewardItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0.rewardItems) do
			iter_11_1:onDestroy()
		end

		arg_11_0.rewardItems = nil
	end
end

function var_0_0._refreshStoreTag(arg_12_0)
	local var_12_0 = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(arg_12_0._goStoreTip, var_12_0)
end

function var_0_0._refreshTime(arg_13_0)
	local var_13_0 = BossRushModel.instance:getActivityMo()

	if var_13_0 then
		local var_13_1 = var_13_0:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(arg_13_0._txtLimitTime.gameObject, var_13_1 > 0)

		if var_13_1 > 0 then
			local var_13_2 = TimeUtil.SecondToActivityTimeFormat(var_13_1)

			arg_13_0._txtLimitTime.text = var_13_2
		end
	end
end

function var_0_0._refreshCurrency(arg_14_0)
	local var_14_0 = V1a6_BossRush_StoreModel.instance:getCurrencyCount(arg_14_0.actId)

	if var_14_0 then
		arg_14_0._txtNum.text = var_14_0
	end
end

function var_0_0.everySecondCall(arg_15_0)
	arg_15_0:_refreshTime()
end

return var_0_0

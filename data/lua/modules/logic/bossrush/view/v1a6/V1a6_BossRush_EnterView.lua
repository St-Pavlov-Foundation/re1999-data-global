module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_EnterView", package.seeall)

slot0 = class("V1a6_BossRush_EnterView", VersionActivityEnterBaseSubView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageBOSS = gohelper.findChildSingleImage(slot0.viewGO, "#simage_BOSS")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_Title")
	slot0._simageTitle_Layer4 = gohelper.findChildSingleImage(slot0.viewGO, "Left/#simage_TitleLayer4")
	slot0._simageFullBGLayer4 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBGLayer4")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Left/LimitTime/#txt_LimitTime")
	slot0._btnStore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/Store/#btn_Store/click")
	slot0._simageProp = gohelper.findChildImage(slot0.viewGO, "Right/Store/#btn_Store/#simage_Prop")
	slot0._txtNum = gohelper.findChildText(slot0.viewGO, "Right/Store/#btn_Store/#txt_Num")
	slot0._btnNormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Normal/click")
	slot0._btnUnOpen = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_UnOpen/click")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Right/#btn_UnOpen/image_TIps/#txt_Tips")
	slot0._gorewardcontent = gohelper.findChild(slot0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	slot0._goStoreTip = gohelper.findChild(slot0.viewGO, "Right/Store/image_Tips")
	slot0._txtStore = gohelper.findChildText(slot0.viewGO, "Right/Store/#btn_Store/txt_Store")
	slot0._txtActDesc = gohelper.findChildText(slot0.viewGO, "Left/txtDescr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnStore:AddClickListener(slot0._btnStoreOnClick, slot0)
	slot0._btnNormal:AddClickListener(slot0._btnNormalOnClick, slot0)
	slot0._btnUnOpen:AddClickListener(slot0._btnUnOpenOnClick, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshStoreTag, slot0)
	slot0:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0._refreshStoreTag, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, slot0._refreshStoreTag, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnStore:RemoveClickListener()
	slot0._btnNormal:RemoveClickListener()
	slot0._btnUnOpen:RemoveClickListener()
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._refreshStoreTag, slot0)
	slot0:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, slot0._refreshStoreTag, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshCurrency, slot0)
	slot0:removeEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, slot0._refreshStoreTag, slot0)
end

function slot0._btnUnOpenOnClick(slot0)
	BossRushController.instance:openMainView()
end

function slot0._btnStoreOnClick(slot0)
	BossRushController.instance:openBossRushStoreView(slot0.actId)
end

function slot0._btnNormalOnClick(slot0)
	BossRushController.instance:openMainView()
end

function slot0._editableInitView(slot0)
	slot0._txtStore.text, slot2 = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)
	slot0._itemObjects = {}

	if BossRushModel.instance:getActivityMo() then
		slot0._txtActDesc.text = slot3.config.actDesc

		if GameUtil.splitString2(slot3.config.activityBonus, true) then
			for slot8, slot9 in ipairs(slot4) do
				if not slot0._itemObjects[slot8] then
					table.insert(slot0._itemObjects, IconMgr.instance:getCommonPropItemIcon(slot0._gorewardcontent))
				end

				slot10:setMOValue(slot9[1], slot9[2], 1)
				slot10:isShowCount(false)
			end
		end

		if slot3.config.openId and slot3.config.openId > 0 then
			slot0._txtTips.text = OpenHelper.getActivityUnlockTxt(slot3.config.openId)
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot0.actId = BossRushConfig.instance:getActivityId()
	slot2 = ActivityModel.instance:getActivityInfo()[slot0.actId] and ActivityHelper.getActivityStatus(slot0.actId) == ActivityEnum.ActivityStatus.Normal

	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Right/#btn_Normal"), slot2)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "Right/#btn_UnOpen"), not slot2)
	RedDotController.instance:addRedDot(gohelper.findChild(slot0.viewGO, "Right/#btn_Normal/#go_reddot"), RedDotEnum.DotNode.BossRushEnter)

	if not slot1 then
		slot0._txtLimitTime.text = ""
	end

	slot0:_refreshCurrency()
	slot0:_refreshTime()
	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	slot0:_refreshStoreTag()

	slot7 = false

	gohelper.setActive(slot0._simageTitle.gameObject, not slot7)
	gohelper.setActive(slot0._simageTitle_Layer4.gameObject, slot7)
	gohelper.setActive(slot0._simageFullBGLayer4.gameObject, slot7)
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0.rewardItems then
		for slot4, slot5 in pairs(slot0.rewardItems) do
			slot5:onDestroy()
		end

		slot0.rewardItems = nil
	end
end

function slot0._refreshStoreTag(slot0)
	gohelper.setActive(slot0._goStoreTip, V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore())
end

function slot0._refreshTime(slot0)
	if BossRushModel.instance:getActivityMo() then
		gohelper.setActive(slot0._txtLimitTime.gameObject, slot1:getRealEndTimeStamp() - ServerTime.now() > 0)

		if slot2 > 0 then
			slot0._txtLimitTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
		end
	end
end

function slot0._refreshCurrency(slot0)
	if V1a6_BossRush_StoreModel.instance:getCurrencyCount(slot0.actId) then
		slot0._txtNum.text = slot1
	end
end

function slot0.everySecondCall(slot0)
	slot0:_refreshTime()
end

return slot0

module("modules.logic.versionactivity1_6.enter.view.Va1_6DungeonEnterView", package.seeall)

slot0 = class("Va1_6DungeonEnterView", VersionActivityEnterBaseSubView)
slot1 = "v1a6_srsj"
slot2 = "srsj"

function slot0.onInitView(slot0)
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_store")
	slot0._txtStoreRemainTime = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/#go_time/#txt_time")
	slot0._txtStoreNum = gohelper.findChildText(slot0.viewGO, "entrance/#btn_store/normal/#txt_num")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "logo/#txt_time")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "logo/#txt_dec")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "entrance/#btn_enter")
	slot0._goEnterNormal = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/normal")
	slot0._goEnterLocked = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/locked")
	slot0._goEnterFinished = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/finished")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstore:AddClickListener(slot0._onClickStoreBtn, slot0)
	slot0._btnEnter:AddClickListener(slot0._onClickMainActivity, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstore:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:addEventCb(VersionActivity1_6EnterController.instance, VersionActivity1_6EnterEvent.OnEnterVideoFinished, slot0.onEnterVideoFinished, slot0)

	slot0.goRedDot = gohelper.findChild(slot0.viewGO, "entrance/#btn_enter/normal/#go_reddot")

	RedDotController.instance:addRedDot(slot0.goRedDot, RedDotEnum.DotNode.V1a6DungeonEnterBtn)

	slot0._uiSpine = GuiSpine.Create(slot0._gospine, true)
	slot0.actId = VersionActivity1_6Enum.ActivityId.Dungeon

	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshStoreCurrency, slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	slot0:refreshRemainTime()
	slot0:_refreshStoreCurrency()
	slot0:_initBgSpine()
	slot0:refreshDesc()
	slot0:refreshEnterState()
	slot0:refreshStoreRemainTime()
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshStoreCurrency()
	slot0:refreshRemainTime()
	slot0:refreshEnterState()
	slot0:refreshStoreRemainTime()
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine = nil
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshRemainTime()
	slot0:refreshEnterState()
	slot0:refreshStoreRemainTime()
end

function slot0.refreshDesc(slot0)
	slot0._txtdec.text = ActivityModel.instance:getActivityInfo()[slot0.actId].config.actDesc
end

function slot0.refreshEnterState(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	gohelper.setActive(slot0._goEnterLocked, false)
	gohelper.setActive(slot0._goEnterNormal, slot1 == ActivityEnum.ActivityStatus.Normal)
	gohelper.setActive(slot0._goEnterFinished, slot1 == ActivityEnum.ActivityStatus.Expired)
	gohelper.setActive(slot0._btnstore.gameObject, ActivityHelper.getActivityStatusAndToast(VersionActivity1_6Enum.ActivityId.DungeonStore) == ActivityEnum.ActivityStatus.Normal)
end

function slot0.everySecondCall(slot0)
	slot0:refreshUI()
end

function slot0._initBgSpine(slot0)
	slot0._uiSpine:setResPath(ResUrl.getRolesCgStory(uv0, uv1), slot0._onSpineLoaded, slot0)
end

function slot0._onSpineLoaded(slot0)
end

function slot0._refreshStoreCurrency(slot0)
	slot0._txtStoreNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V1a6Dungeon) and slot1.quantity or 0)
end

function slot0.refreshRemainTime(slot0)
	gohelper.setActive(slot0._txttime, ActivityModel.instance:getActivityInfo()[slot0.actId]:getRealEndTimeStamp() - ServerTime.now() > 0)

	slot0._txttime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
end

function slot0.refreshStoreRemainTime(slot0)
	if TimeUtil.OneDaySecond < ActivityModel.instance:getActivityInfo()[VersionActivity1_6Enum.ActivityId.DungeonStore]:getRealEndTimeStamp() - ServerTime.now() then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot3 / TimeUtil.OneDaySecond) .. "d"

		return
	end

	if TimeUtil.OneHourSecond < slot3 then
		slot0._txtStoreRemainTime.text = Mathf.Floor(slot3 / TimeUtil.OneHourSecond) .. "h"

		return
	end

	slot0._txtStoreRemainTime.text = "1h"
end

function slot0._onClickMainActivity(slot0)
	slot1, slot2, slot3 = ActivityHelper.getActivityStatusAndToast(slot0.actId)

	if slot1 ~= ActivityEnum.ActivityStatus.Normal and slot2 then
		GameFacade.showToastWithTableParam(slot2, slot3)

		return
	end

	VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView()
end

function slot0._onClickStoreBtn(slot0)
	VersionActivity1_6EnterController.instance:openStoreView()
end

return slot0

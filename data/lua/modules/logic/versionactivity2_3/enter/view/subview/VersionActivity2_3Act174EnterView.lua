module("modules.logic.versionactivity2_3.enter.view.subview.VersionActivity2_3Act174EnterView", package.seeall)

slot0 = class("VersionActivity2_3Act174EnterView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._btnShop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Shop")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#btn_Shop/#txt_num")
	slot0._btnEnter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Enter")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#txt_time")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnShop:AddClickListener(slot0._btnShopOnClick, slot0)
	slot0._btnEnter:AddClickListener(slot0._btnEnterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnShop:RemoveClickListener()
	slot0._btnEnter:RemoveClickListener()
end

function slot0._btnShopOnClick(slot0)
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function slot0._btnEnterOnClick(slot0)
	Activity174Controller.instance:openMainView({
		actId = slot0.actId
	})
end

function slot0._editableInitView(slot0)
	slot0.animComp = VersionActivitySubAnimatorComp.get(slot0.viewGO, slot0)
	slot0.actId = VersionActivity2_3Enum.ActivityId.Act174
	slot0._txtdesc.text = ActivityConfig.instance:getActivityCo(slot0.actId).actDesc
end

function slot0.onOpen(slot0)
	slot0.animComp:playOpenAnim()
	slot0:refreshUI()
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshCurrency, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.refreshLeftTime, slot0)
	slot0.animComp:destroy()
end

function slot0.refreshUI(slot0)
	slot0:refreshLeftTime()
	slot0:refreshCurrency()
	TaskDispatcher.runRepeat(slot0.refreshLeftTime, slot0, TimeUtil.OneSecond)
end

function slot0.refreshLeftTime(slot0)
	slot0._txttime.text = ActivityHelper.getActivityRemainTimeStr(slot0.actId)
end

function slot0.refreshCurrency(slot0)
	slot0._txtnum.text = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu).quantity
end

return slot0

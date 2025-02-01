module("modules.logic.battlepass.view.BpBuyBtn", package.seeall)

slot0 = class("BpBuyBtn", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "right/btngroup")
	slot0._btnGetAll = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/btngroup/#btnGetAll")
	slot0._btnSwitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btnSwitch")
	slot0._btnSwitch2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btnSwitch2")
	slot0._goSwitchRed = gohelper.findChild(slot0.viewGO, "right/#btnSwitch/#go_reddot")
	slot0._btnPay = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/btngroup/#btnPay", AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._imagePay = gohelper.findChildImage(slot0.viewGO, "right/btngroup/#btnPay/bg")
	slot0._txtPayStatus = gohelper.findChildText(slot0.viewGO, "right/btngroup/#btnPay/cn")
	slot0._txtPayStatusEn = gohelper.findChildText(slot0.viewGO, "right/btngroup/#btnPay/cn/en")
	slot0._btnGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_get")
end

function slot0.addEvents(slot0)
	slot0._btnGetAll:AddClickListener(slot0._onClickbtnGetAll, slot0)
	slot0._btnPay:AddClickListener(slot0._onClickbtnPay, slot0)

	if slot0._btnSwitch then
		slot0._btnSwitch:AddClickListener(slot0._onClickSwitch, slot0)
	end

	if slot0._btnGet then
		slot0._btnGet:AddClickListener(slot0._onClickbtnGetAll, slot0)
	end

	slot0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0.updatePayBtn, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.SetGetAllCallBack, slot0._setGetAllCb, slot0)
	slot0:addEventCb(BpController.instance, BpEvent.SetGetAllEnable, slot0.setGetAllEnable, slot0)
	slot0:addEventCb(slot0.viewContainer, BpEvent.TapViewCloseAnimBegin, slot0.closeAnimBegin, slot0)
	slot0:addEventCb(slot0.viewContainer, BpEvent.TapViewCloseAnimEnd, slot0.closeAnimEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnGetAll:RemoveClickListener()
	slot0._btnPay:RemoveClickListener()

	if slot0._btnSwitch then
		slot0._btnSwitch:RemoveClickListener()
	end

	if slot0._btnGet then
		slot0._btnGet:RemoveClickListener()
	end

	slot0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, slot0.updatePayBtn, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.SetGetAllCallBack, slot0._setGetAllCb, slot0)
	slot0:removeEventCb(BpController.instance, BpEvent.SetGetAllEnable, slot0.setGetAllEnable, slot0)
	slot0:removeEventCb(slot0.viewContainer, BpEvent.TapViewCloseAnimBegin, slot0.closeAnimBegin, slot0)
	slot0:removeEventCb(slot0.viewContainer, BpEvent.TapViewCloseAnimEnd, slot0.closeAnimEnd, slot0)
end

function slot0._setGetAllCb(slot0, slot1, slot2)
	slot0.getAllCb = slot1
	slot0.cbObj = slot2
end

function slot0.onClose(slot0)
	slot0.getAllCb = nil
	slot0.cbObj = nil

	TaskDispatcher.cancelTask(slot0._delaySwitch, slot0)
end

function slot0._onClickbtnGetAll(slot0)
	slot0.getAllCb(slot0.cbObj)
end

function slot0._onClickbtnPay(slot0)
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(ViewName.BpChargeView)
end

function slot0._onClickSwitch(slot0)
	if slot0.viewName == ViewName.BpSPView and BpModel.instance.firstShow then
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	else
		ViewMgr.instance:openView(ViewName.BpChangeView)
		TaskDispatcher.runDelay(slot0._delaySwitch, slot0, 0.5)
	end
end

function slot0._delaySwitch(slot0)
	if slot0.viewName == ViewName.BpView then
		BpController.instance:openBattlePassView(true, {
			isSwitch = true
		})
	else
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	end
end

function slot0.setGetAllEnable(slot0, slot1)
	gohelper.setActive(slot0._btnGetAll, not slot0._btnGet and slot1 or false)
	gohelper.setActive(slot0._btnGet, slot1)

	if not slot0._btnSwitch then
		return
	end

	if BpConfig.instance:getBpCO(BpModel.instance.id) and slot2.isSp and not BpModel.instance.firstShowSp then
		gohelper.setActive(slot0._btnSwitch, true)
		gohelper.setActive(slot0._btnSwitch2, true)
	else
		gohelper.setActive(slot0._btnSwitch, false)
		gohelper.setActive(slot0._btnSwitch2, false)
	end
end

function slot0.onOpen(slot0)
	if slot0._goSwitchRed then
		if slot0.viewName == ViewName.BpView then
			RedDotController.instance:addRedDot(slot0._goSwitchRed, RedDotEnum.DotNode.BattlePassSPMain)
		else
			RedDotController.instance:addRedDot(slot0._goSwitchRed, RedDotEnum.DotNode.BattlePass)
		end
	end

	slot0:updatePayBtn()
end

function slot0.closeAnimBegin(slot0)
	gohelper.setActive(slot0._gobtns, false)
end

function slot0.closeAnimEnd(slot0)
	gohelper.setActive(slot0._gobtns, true)
end

function slot0.updatePayBtn(slot0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.Pay2 or slot0.viewName == ViewName.BpSPView then
		gohelper.setActive(slot0._btnPay.gameObject, false)

		return
	end

	gohelper.setActive(slot0._btnPay.gameObject, true)

	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		slot0._txtPayStatus.text = luaLang("bp_active_pay1")
		slot0._txtPayStatusEn.text = luaLang("bp_active_pay1_en")
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		slot0._txtPayStatus.text = luaLang("bp_active_pay2")
		slot0._txtPayStatusEn.text = luaLang("bp_active_pay2_en")
	end

	if BpModel.instance:getBpChargeLeftSec() and slot1 < 0 then
		ZProj.UGUIHelper.SetGrayscale(slot0._imagePay.gameObject, true)
	end
end

return slot0

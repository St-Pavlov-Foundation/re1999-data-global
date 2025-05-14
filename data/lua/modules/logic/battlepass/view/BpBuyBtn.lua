module("modules.logic.battlepass.view.BpBuyBtn", package.seeall)

local var_0_0 = class("BpBuyBtn", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "right/btngroup")
	arg_1_0._btnGetAll = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/btngroup/#btnGetAll")
	arg_1_0._btnSwitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btnSwitch")
	arg_1_0._btnSwitch2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btnSwitch2")
	arg_1_0._goSwitchRed = gohelper.findChild(arg_1_0.viewGO, "right/#btnSwitch/#go_reddot")
	arg_1_0._btnPay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/btngroup/#btnPay", AudioEnum.UI.UI_vertical_first_tabs_click)
	arg_1_0._imagePay = gohelper.findChildImage(arg_1_0.viewGO, "right/btngroup/#btnPay/bg")
	arg_1_0._txtPayStatus = gohelper.findChildText(arg_1_0.viewGO, "right/btngroup/#btnPay/cn")
	arg_1_0._txtPayStatusEn = gohelper.findChildText(arg_1_0.viewGO, "right/btngroup/#btnPay/cn/en")
	arg_1_0._btnGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_get")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnGetAll:AddClickListener(arg_2_0._onClickbtnGetAll, arg_2_0)
	arg_2_0._btnPay:AddClickListener(arg_2_0._onClickbtnPay, arg_2_0)

	if arg_2_0._btnSwitch then
		arg_2_0._btnSwitch:AddClickListener(arg_2_0._onClickSwitch, arg_2_0)
	end

	if arg_2_0._btnGet then
		arg_2_0._btnGet:AddClickListener(arg_2_0._onClickbtnGetAll, arg_2_0)
	end

	arg_2_0:addEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_2_0.updatePayBtn, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.SetGetAllCallBack, arg_2_0._setGetAllCb, arg_2_0)
	arg_2_0:addEventCb(BpController.instance, BpEvent.SetGetAllEnable, arg_2_0.setGetAllEnable, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, BpEvent.TapViewCloseAnimBegin, arg_2_0.closeAnimBegin, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.viewContainer, BpEvent.TapViewCloseAnimEnd, arg_2_0.closeAnimEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnGetAll:RemoveClickListener()
	arg_3_0._btnPay:RemoveClickListener()

	if arg_3_0._btnSwitch then
		arg_3_0._btnSwitch:RemoveClickListener()
	end

	if arg_3_0._btnGet then
		arg_3_0._btnGet:RemoveClickListener()
	end

	arg_3_0:removeEventCb(BpController.instance, BpEvent.OnUpdatePayStatus, arg_3_0.updatePayBtn, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.SetGetAllCallBack, arg_3_0._setGetAllCb, arg_3_0)
	arg_3_0:removeEventCb(BpController.instance, BpEvent.SetGetAllEnable, arg_3_0.setGetAllEnable, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, BpEvent.TapViewCloseAnimBegin, arg_3_0.closeAnimBegin, arg_3_0)
	arg_3_0:removeEventCb(arg_3_0.viewContainer, BpEvent.TapViewCloseAnimEnd, arg_3_0.closeAnimEnd, arg_3_0)
end

function var_0_0._setGetAllCb(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.getAllCb = arg_4_1
	arg_4_0.cbObj = arg_4_2
end

function var_0_0.onClose(arg_5_0)
	arg_5_0.getAllCb = nil
	arg_5_0.cbObj = nil

	TaskDispatcher.cancelTask(arg_5_0._delaySwitch, arg_5_0)
end

function var_0_0._onClickbtnGetAll(arg_6_0)
	arg_6_0.getAllCb(arg_6_0.cbObj)
end

function var_0_0._onClickbtnPay(arg_7_0)
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(ViewName.BpChargeView)
end

function var_0_0._onClickSwitch(arg_8_0)
	if arg_8_0.viewName == ViewName.BpSPView and BpModel.instance.firstShow then
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	else
		ViewMgr.instance:openView(ViewName.BpChangeView)
		TaskDispatcher.runDelay(arg_8_0._delaySwitch, arg_8_0, 0.5)
	end
end

function var_0_0._delaySwitch(arg_9_0)
	if arg_9_0.viewName == ViewName.BpView then
		BpController.instance:openBattlePassView(true, {
			isSwitch = true
		})
	else
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	end
end

function var_0_0.setGetAllEnable(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._btnGetAll, not arg_10_0._btnGet and arg_10_1 or false)
	gohelper.setActive(arg_10_0._btnGet, arg_10_1)

	if not arg_10_0._btnSwitch then
		return
	end

	local var_10_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	if var_10_0 and var_10_0.isSp and not BpModel.instance.firstShowSp then
		gohelper.setActive(arg_10_0._btnSwitch, true)
		gohelper.setActive(arg_10_0._btnSwitch2, true)
	else
		gohelper.setActive(arg_10_0._btnSwitch, false)
		gohelper.setActive(arg_10_0._btnSwitch2, false)
	end
end

function var_0_0.onOpen(arg_11_0)
	if arg_11_0._goSwitchRed then
		if arg_11_0.viewName == ViewName.BpView then
			RedDotController.instance:addRedDot(arg_11_0._goSwitchRed, RedDotEnum.DotNode.BattlePassSPMain)
		else
			RedDotController.instance:addRedDot(arg_11_0._goSwitchRed, RedDotEnum.DotNode.BattlePass)
		end
	end

	arg_11_0:updatePayBtn()
end

function var_0_0.closeAnimBegin(arg_12_0)
	gohelper.setActive(arg_12_0._gobtns, false)
end

function var_0_0.closeAnimEnd(arg_13_0)
	gohelper.setActive(arg_13_0._gobtns, true)
end

function var_0_0.updatePayBtn(arg_14_0)
	if BpModel.instance.payStatus == BpEnum.PayStatus.Pay2 or arg_14_0.viewName == ViewName.BpSPView then
		gohelper.setActive(arg_14_0._btnPay.gameObject, false)

		return
	end

	gohelper.setActive(arg_14_0._btnPay.gameObject, true)

	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		arg_14_0._txtPayStatus.text = luaLang("bp_active_pay1")
		arg_14_0._txtPayStatusEn.text = luaLang("bp_active_pay1_en")
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		arg_14_0._txtPayStatus.text = luaLang("bp_active_pay2")
		arg_14_0._txtPayStatusEn.text = luaLang("bp_active_pay2_en")
	end

	local var_14_0 = BpModel.instance:getBpChargeLeftSec()

	if var_14_0 and var_14_0 < 0 then
		ZProj.UGUIHelper.SetGrayscale(arg_14_0._imagePay.gameObject, true)
	end
end

return var_0_0

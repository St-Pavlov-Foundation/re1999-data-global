module("modules.logic.rouge.map.view.piecechoice.RougeMapPieceOptionItem", package.seeall)

local var_0_0 = class("RougeMapPieceOptionItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.tr = arg_1_1:GetComponent(gohelper.Type_RectTransform)

	arg_1_0:_editableInitView()
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._refreshClick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#go_refresh")
	arg_2_0._exitClick = gohelper.findChildClickWithDefaultAudio(arg_2_0.go, "#go_exit")

	arg_2_0._refreshClick:AddClickListener(arg_2_0.onClickRefreshBtn, arg_2_0)
	arg_2_0._exitClick:AddClickListener(arg_2_0.onClickExitBtn, arg_2_0)

	arg_2_0.goNormal = gohelper.findChild(arg_2_0.go, "#go_refresh/normal")
	arg_2_0.goLock = gohelper.findChild(arg_2_0.go, "#go_refresh/locked")
	arg_2_0.txtNormalTime = gohelper.findChildText(arg_2_0.go, "#go_refresh/normal/txt_refresh/#txt_times")
	arg_2_0.txtLockTime = gohelper.findChildText(arg_2_0.go, "#go_refresh/locked/txt_refresh/#txt_times")
	arg_2_0.goRefresh = arg_2_0._refreshClick.gameObject

	arg_2_0:setRefreshActive()
end

function var_0_0.setRefreshActive(arg_3_0)
	local var_3_0 = RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh)

	gohelper.setActive(arg_3_0.goRefresh, var_3_0)
end

function var_0_0.onClickRefreshBtn(arg_4_0)
	if not RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockRestRefresh) then
		return
	end

	if arg_4_0.isLock then
		return
	end

	arg_4_0:clearCallback()

	arg_4_0.callbackId = RougeRpc.instance:sendRougeRepairShopRandomRequest(arg_4_0.onReceiveMsg, arg_4_0)
end

function var_0_0.onReceiveMsg(arg_5_0)
	arg_5_0.callbackId = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onRefreshPieceChoiceEvent)
end

function var_0_0.onClickExitBtn(arg_6_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceViewStatusChange, RougeMapEnum.PieceChoiceViewStatus.Choice)
end

function var_0_0.update(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.pieceMo = arg_7_2

	recthelper.setAnchor(arg_7_0.tr, arg_7_1.x, arg_7_1.y)
	arg_7_0:refreshExchangeUI()
end

function var_0_0.refreshExchangeUI(arg_8_0)
	local var_8_0 = arg_8_0.pieceMo.triggerStr and arg_8_0.pieceMo.triggerStr.repairRandomNum or 0
	local var_8_1 = RougeMapConfig.instance:getRestStoreRefreshCount()

	arg_8_0.isLock = var_8_1 <= var_8_0

	gohelper.setActive(arg_8_0.goNormal, not arg_8_0.isLock)
	gohelper.setActive(arg_8_0.goLock, arg_8_0.isLock)

	if arg_8_0.isLock then
		arg_8_0.txtLockTime.text = string.format("(<color=#d97373>0</color>/%s)", var_8_1)
	else
		local var_8_2 = var_8_1 - var_8_0

		arg_8_0.txtNormalTime.text = string.format("(%s/%s)", var_8_2, var_8_1)
	end
end

function var_0_0.show(arg_9_0)
	gohelper.setActive(arg_9_0.go, true)
end

function var_0_0.hide(arg_10_0)
	gohelper.setActive(arg_10_0.go, false)
end

function var_0_0.clearCallback(arg_11_0)
	if arg_11_0.callbackId then
		RougeRpc.instance:removeCallbackById(arg_11_0.callbackId)

		arg_11_0.callbackId = nil
	end
end

function var_0_0.destroy(arg_12_0)
	arg_12_0:clearCallback()
	arg_12_0._refreshClick:RemoveClickListener()
	arg_12_0._exitClick:RemoveClickListener()
	arg_12_0:__onDispose()
end

return var_0_0

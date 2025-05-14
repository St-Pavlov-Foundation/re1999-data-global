module("modules.logic.characterskin.view.CharacterSkinTipRightView", package.seeall)

local var_0_0 = class("CharacterSkinTipRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageskinSwitchBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/#simage_skinSwitchBg")
	arg_1_0._simageskinicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "container/skinTip/skinSwitch/skinmask/skinicon")
	arg_1_0._btnBpPay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/skinTip/skinSwitch/#btn_bpPay", AudioEnum.UI.UI_vertical_first_tabs_click)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnBpPay:AddClickListener(arg_2_0._jumpBpCharge, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnBpPay:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_3_0.OnOpenViewFinish, arg_3_0)
end

function var_0_0.refreshRightContainer(arg_4_0)
	arg_4_0.goSkinNormalContainer = gohelper.findChild(arg_4_0.viewGO, "container/normal")
	arg_4_0.goSkinTipContainer = gohelper.findChild(arg_4_0.viewGO, "container/skinTip")
	arg_4_0.goSkinStoreContainer = gohelper.findChild(arg_4_0.viewGO, "container/skinStore")

	gohelper.setActive(arg_4_0.goSkinNormalContainer, false)
	gohelper.setActive(arg_4_0.goSkinTipContainer, true)
	gohelper.setActive(arg_4_0.goSkinStoreContainer, false)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:refreshRightContainer()
	arg_5_0._simageskinSwitchBg:LoadImage(ResUrl.getCharacterSkinIcon("img_yulan_bg"))
end

function var_0_0.initViewParam(arg_6_0)
	if LuaUtil.isTable(arg_6_0.viewParam) then
		local var_6_0 = arg_6_0.viewParam.skinId

		arg_6_0.skinCo = SkinConfig.instance:getSkinCo(var_6_0)

		arg_6_0.viewContainer:setHomeBtnVisible(arg_6_0.viewParam.isShowHomeBtn)
	else
		arg_6_0.skinCo = SkinConfig.instance:getSkinCo(arg_6_0.viewParam)
	end
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:initViewParam()
	arg_7_0:refreshView()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	arg_9_0:refreshLeftUI()
	arg_9_0:refreshRightUI()
end

function var_0_0._jumpBpCharge(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.BpChargeView) then
		arg_10_0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_10_0.OnOpenViewFinish, arg_10_0)
	end

	BpController.instance:openBattlePassView(false, nil, true)
end

function var_0_0.OnOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.BpChargeView then
		arg_11_0:closeThis()
	end
end

function var_0_0.refreshLeftUI(arg_12_0)
	CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkin, arg_12_0.skinCo, arg_12_0.viewName)
end

function var_0_0.refreshRightUI(arg_13_0)
	arg_13_0._simageskinicon:LoadImage(ResUrl.getHeadSkinSmall(arg_13_0.skinCo.id))
	gohelper.setActive(arg_13_0._btnBpPay, false)

	if arg_13_0.skinCo.id == BpConfig.instance:getCurSkinId(BpModel.instance.id) and not BpModel.instance:isEnd() and BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		gohelper.setActive(arg_13_0._btnBpPay, true)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	arg_15_0._simageskinSwitchBg:UnLoadImage()
	arg_15_0._simageskinicon:UnLoadImage()
end

return var_0_0

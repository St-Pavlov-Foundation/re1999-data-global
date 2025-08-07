module("modules.logic.sp01.assassin2.outside.view.AssassinCurrencyToolView", package.seeall)

local var_0_0 = class("AssassinCurrencyToolView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_2_0.onCurrencyChanged, arg_2_0)
	arg_2_0:addEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_2_0.onCurrencyChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.UpdateCoinNum, arg_3_0.onCurrencyChanged, arg_3_0)
	arg_3_0:removeEventCb(AssassinController.instance, AssassinEvent.OnAllAssassinOutSideInfoUpdate, arg_3_0.onCurrencyChanged, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	arg_4_0:checkPlayGet()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshAssassinCurrency()
end

function var_0_0.refreshAssassinCurrency(arg_6_0)
	arg_6_0._txtnum.text = AssassinController.instance:getCoinNum()
end

function var_0_0.onCurrencyChanged(arg_7_0)
	arg_7_0:refreshAssassinCurrency()
end

function var_0_0.checkPlayGet(arg_8_0)
	if AssassinOutsideModel.instance:getIsNeedPlayGetCoin() then
		arg_8_0:playGetAnim()
	end
end

function var_0_0.playGetAnim(arg_9_0)
	if not arg_9_0.animator then
		return
	end

	arg_9_0.animator:Play("get", 0, 0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskring)
	AssassinOutsideModel.instance:updateIsNeedPlayGetCoin()
end

function var_0_0.definePrefabUrl(arg_10_0)
	arg_10_0:setPrefabUrl(AssassinEnum.CurrencyToolPrefabPath)
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0

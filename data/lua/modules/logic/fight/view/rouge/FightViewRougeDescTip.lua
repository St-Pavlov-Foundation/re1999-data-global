module("modules.logic.fight.view.rouge.FightViewRougeDescTip", package.seeall)

local var_0_0 = class("FightViewRougeDescTip", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._desTips = arg_1_0.viewGO
	arg_1_0._clickTips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._tipsContentObj = gohelper.findChild(arg_1_0.viewGO, "Content")
	arg_1_0._tipsContentTransform = arg_1_0._tipsContentObj and arg_1_0._tipsContentObj.transform
	arg_1_0._tipsNameText = gohelper.findChildText(arg_1_0.viewGO, "Content/#txt_title")
	arg_1_0._tipsDescText = gohelper.findChildText(arg_1_0.viewGO, "Content/#txt_details")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._clickTips, arg_2_0._onBtnTips, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.RougeShowTip, arg_2_0.onRougeShowTip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onRougeShowTip(arg_4_0, arg_4_1)
	arg_4_0:_showTips(arg_4_1)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.hideTipObj(arg_7_0)
	gohelper.setActive(arg_7_0._desTips, false)
end

function var_0_0.showTipObj(arg_8_0)
	gohelper.setActive(arg_8_0._desTips, true)
end

function var_0_0._onBtnTips(arg_9_0)
	arg_9_0:hideTipObj()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_10_0)
	arg_10_0:hideTipObj()
end

function var_0_0._onRoundSequenceFinish(arg_11_0)
	arg_11_0:hideTipObj()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:hideTipObj()
end

function var_0_0._showTips(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1.config

	if var_13_0 then
		gohelper.setActive(arg_13_0._desTips, true)

		arg_13_0._tipsNameText.text = var_13_0.name
		arg_13_0._tipsDescText.text = HeroSkillModel.instance:skillDesToSpot(var_13_0.desc)

		if arg_13_0._tipsContentTransform then
			local var_13_1, var_13_2 = recthelper.rectToRelativeAnchorPos2(arg_13_1.position, arg_13_0.viewGO.transform)

			recthelper.setAnchorY(arg_13_0._tipsContentTransform, var_13_2)
		end
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0

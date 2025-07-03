module("modules.logic.fight.view.rouge.FightViewRougeGongMing", package.seeall)

local var_0_0 = class("FightViewRougeGongMing", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._resonancelObj = arg_1_0.viewGO
	arg_1_0._resonancelNameText = gohelper.findChildText(arg_1_0.viewGO, "bg/#txt_name")
	arg_1_0._resonancelLevelText = gohelper.findChildText(arg_1_0.viewGO, "bg/#txt_level")
	arg_1_0._clickResonancel = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._clickResonancel, arg_2_0._onBtnResonancel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.ResonanceLevel, arg_2_0._onResonanceLevel, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_2_0._onClothSkillRoundSequenceFinish, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_2_0._onRoundSequenceFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onRefreshViewParam(arg_5_0)
	return
end

function var_0_0.hideResonanceObj(arg_6_0)
	gohelper.setActive(arg_6_0._resonancelObj, false)
	FightController.instance:dispatchEvent(FightEvent.RightElements_HideElement, FightRightElementEnum.Elements.RougeGongMing)
end

function var_0_0.showResonanceObj(arg_7_0)
	gohelper.setActive(arg_7_0._resonancelObj, true)
	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.RougeGongMing)
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_8_0)
	arg_8_0:hideResonanceObj()
end

function var_0_0._onRoundSequenceFinish(arg_9_0)
	arg_9_0:hideResonanceObj()
end

function var_0_0._onResonanceLevel(arg_10_0)
	arg_10_0:_refreshData()
end

function var_0_0._onPolarizationLevel(arg_11_0)
	arg_11_0:_refreshData()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:hideResonanceObj()
end

function var_0_0._refreshData(arg_13_0)
	gohelper.setActive(arg_13_0.viewGO, true)
	arg_13_0:_refreshGongMing()
end

var_0_0.TempParam = {}

function var_0_0._onBtnResonancel(arg_14_0)
	local var_14_0 = var_0_0.TempParam

	var_14_0.config = arg_14_0._resonancelConfig
	var_14_0.position = arg_14_0._resonancelObj.transform.position

	FightController.instance:dispatchEvent(FightEvent.RougeShowTip, var_14_0)
end

function var_0_0._refreshGongMing(arg_15_0)
	arg_15_0._resonancelLevel = FightRoundSequence.roundTempData.ResonanceLevel

	if arg_15_0._resonancelLevel and arg_15_0._resonancelLevel ~= 0 then
		local var_15_0 = lua_resonance.configDict[arg_15_0._resonancelLevel]

		if var_15_0 then
			arg_15_0:showResonanceObj()

			arg_15_0._resonancelConfig = var_15_0
			arg_15_0._resonancelNameText.text = var_15_0 and var_15_0.name
			arg_15_0._resonancelLevelText.text = "Lv." .. arg_15_0._resonancelLevel

			for iter_15_0 = 1, 3 do
				local var_15_1 = gohelper.findChild(arg_15_0.viewGO, "effect_lv/effect_lv" .. iter_15_0)

				gohelper.setActive(var_15_1, iter_15_0 == arg_15_0._resonancelLevel)
			end

			if arg_15_0._resonancelLevel > 3 then
				gohelper.setActive(gohelper.findChild(arg_15_0.viewGO, "effect_lv/effect_lv3"), true)
			end
		else
			arg_15_0:hideResonanceObj()
		end
	end
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

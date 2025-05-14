module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelOptionItem", package.seeall)

local var_0_0 = class("LoperaLevelOptionItem", ListScrollCellExtend)
local var_0_1 = VersionActivity2_2Enum.ActivityId.Lopera

function var_0_0.onInitView(arg_1_0)
	arg_1_0._optionText = gohelper.findChildText(arg_1_0.viewGO, "#txt_Choice")
	arg_1_0._optionEffectText = gohelper.findChildText(arg_1_0.viewGO, "#txt_Choice/#txt_effect")
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "image_ChoiceBG")
	arg_1_0._goProp = gohelper.findChild(arg_1_0.viewGO, "#image_Prop")
	arg_1_0._imgPropIcon = gohelper.findChildImage(arg_1_0.viewGO, "#image_Prop")
	arg_1_0._goPowerIcon = gohelper.findChild(arg_1_0.viewGO, "image_Power")
	arg_1_0._goOption = gohelper.findChild(arg_1_0.viewGO, "#txt_Choice")
	arg_1_0._goEffectOption = gohelper.findChild(arg_1_0.viewGO, "go_optionWithEffect")
	arg_1_0._txtEffectOption = gohelper.findChildText(arg_1_0.viewGO, "go_optionWithEffect/#txt_option")
	arg_1_0._txtEffect = gohelper.findChildText(arg_1_0.viewGO, "go_optionWithEffect/#txt_effect")
	arg_1_0._costText = gohelper.findChildText(arg_1_0.viewGO, "#txt_PowerNum")
	arg_1_0._goCostNum = gohelper.findChild(arg_1_0.viewGO, "#txt_PowerNum")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btn:AddClickListener(arg_2_0._clickOption, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn:RemoveClickListener()
end

function var_0_0._clickOption(arg_4_0)
	if not string.nilorempty(arg_4_0._mo.costItems) then
		local var_4_0 = string.split(arg_4_0._mo.costItems, "|")
		local var_4_1 = string.splitToNumber(var_4_0[1], "#")[1]
		local var_4_2 = string.splitToNumber(var_4_0[1], "#")[2]
		local var_4_3 = Activity168Model.instance:getItemCount(var_4_1)
		local var_4_4 = Activity168Config.instance:getGameItemCfg(var_0_1, var_4_1)
		local var_4_5 = Activity168Config.instance:getComposeTypeCfg(var_0_1, var_4_4.compostType)

		if var_4_3 < var_4_2 then
			local var_4_6 = var_4_5.name
			local var_4_7 = var_4_4.name
			local var_4_8 = formatLuaLang("store_currency_limit", var_4_6 .. "-" .. var_4_7)

			ToastController.instance:showToastWithString(var_4_8)

			return
		end
	end

	LoperaController.instance:selectOption(arg_4_0._mo.optionId)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, arg_6_0.refreshUI, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	arg_7_0:removeEventCb(LoperaController.instance, LoperaEvent.ComposeDone, arg_7_0.refreshUI, arg_7_0)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	if not arg_9_0._mo then
		return
	end

	gohelper.setActive(arg_9_0._goProp, false)
	gohelper.setActive(arg_9_0._goPowerIcon, false)
	gohelper.setActive(arg_9_0._goCostNum, false)
	gohelper.setActive(arg_9_0._goEffectOption, false)
	gohelper.setActive(arg_9_0._goOption, false)
	gohelper.setActive(arg_9_0._txtEffect.gameObject, true)
	gohelper.setActive(arg_9_0._optionEffectText.gameObject, false)

	arg_9_0._btn.enabled = true

	local var_9_0 = Activity168Config.instance:getOptionEffectCfg(arg_9_0._mo.effectId)

	if not string.nilorempty(arg_9_0._mo.costItems) then
		gohelper.setActive(arg_9_0._goProp, true)
		gohelper.setActive(arg_9_0._goCostNum, true)

		local var_9_1 = string.split(arg_9_0._mo.costItems, "|")
		local var_9_2 = string.splitToNumber(var_9_1[1], "#")[1]
		local var_9_3 = string.splitToNumber(var_9_1[1], "#")[2]
		local var_9_4 = Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, var_9_2)
		local var_9_5 = Activity168Model.instance:getItemCount(var_9_2)

		arg_9_0._optionText.text = arg_9_0._mo.name

		local var_9_6 = LoperaController.instance:checkOptionChoosed(arg_9_0._mo.optionId)

		gohelper.setActive(arg_9_0._optionEffectText.gameObject, true)

		arg_9_0._optionEffectText.text = var_9_6 and var_9_0 and var_9_0.desc or ""
		gohelper.findChildText(arg_9_0._goProp, "#txt_PropNum").text = var_9_5
		arg_9_0._costText.text = "-" .. var_9_3

		local var_9_7 = var_9_5 < var_9_3

		ZProj.UGUIHelper.SetGrayscale(arg_9_0._btn.gameObject, var_9_7)

		arg_9_0._btn.enabled = not var_9_7

		UISpriteSetMgr.instance:setLoperaItemSprite(arg_9_0._imgPropIcon, var_9_4.icon, false)
		gohelper.setActive(arg_9_0._goOption, true)
	elseif var_9_0 then
		gohelper.setActive(arg_9_0._goEffectOption, true)

		arg_9_0._txtEffectOption.text = arg_9_0._mo.name

		local var_9_8 = LoperaController.instance:checkOptionChoosed(arg_9_0._mo.optionId)

		gohelper.setActive(arg_9_0._txtEffect.gameObject, var_9_8)

		if var_9_8 then
			arg_9_0._txtEffect.text = var_9_0.desc
		end

		ZProj.UGUIHelper.SetGrayscale(arg_9_0._btn.gameObject, false)
	else
		gohelper.setActive(arg_9_0._goEffectOption, true)

		arg_9_0._txtEffectOption.text = arg_9_0._mo.name

		local var_9_9 = LoperaController.instance:checkOptionChoosed(arg_9_0._mo.optionId)

		gohelper.setActive(arg_9_0._txtEffect.gameObject, var_9_9)

		if var_9_9 then
			arg_9_0._txtEffect.text = luaLang("lopera_event_no_effect_buff")
		end

		ZProj.UGUIHelper.SetGrayscale(arg_9_0._btn.gameObject, false)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

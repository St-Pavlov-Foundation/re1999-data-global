module("modules.logic.resonance.view.CharacterTalentChessCopyView", package.seeall)

local var_0_0 = class("CharacterTalentChessCopyView", RoomLayoutInputBaseView)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "tips/txt_tips")

	local var_1_0 = gohelper.findChildImage(arg_1_0.viewGO, "tips/txt_tips/icon")

	arg_1_0._txttitlecn.text = luaLang("character_copy_talentLayout_title_cn")
	arg_1_0._txtinputlang.text = luaLang("character_copy_talentLayout_title_cn")
	arg_1_0._txttitleen.text = luaLang("character_copy_talentLayout_title_en")
	arg_1_0._txttip.text = luaLang("character_copy_talentLayout_tip")
	arg_1_0._gocaret = gohelper.findChild(arg_1_0.viewGO, "message/#input_signature/textarea/Caret")

	local var_1_1 = GameUtil.parseColor("#686664")

	arg_1_0._txttip.color = var_1_1
	var_1_0.color = var_1_1
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_2_0._onUseShareCode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_3_0._onUseShareCode, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._heroMo = arg_4_0.viewParam.heroMo
end

function var_0_0._btnsureOnClick(arg_5_0)
	local var_5_0 = arg_5_0._inputsignature:GetText()

	if string.nilorempty(var_5_0) then
		local var_5_1 = HeroResonaceModel.instance:getSpecialCn(arg_5_0._heroMo)

		ToastController.instance:showToast(ToastEnum.CharacterTalentCopyCodeNull, var_5_1)

		return
	end

	if not arg_5_0._heroMo then
		arg_5_0._heroMo = arg_5_0.viewParam.heroMo
	end

	local var_5_2, var_5_3 = HeroResonaceModel.instance:canUseLayoutShareCode(arg_5_0._heroMo, var_5_0)

	if var_5_2 then
		ViewMgr.instance:openView(ViewName.CharacterTalentUseLayoutView, {
			heroMo = arg_5_0._heroMo,
			code = var_5_0
		})
	elseif var_5_3 then
		GameFacade.showToast(var_5_3)
	else
		local var_5_4 = HeroResonaceModel.instance:getSpecialCn(arg_5_0._heroMo)

		ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeFailPastedUseLackCube, var_5_4)
	end
end

function var_0_0._btncleannameOnClick(arg_6_0)
	arg_6_0._inputsignature:SetText("")
	transformhelper.setLocalPosXY(arg_6_0._txttext.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_6_0._gocaret.transform, 0, 0)
end

function var_0_0._onInputNameEndEdit(arg_7_0)
	arg_7_0:_checkLimit()
end

function var_0_0._onInputNameValueChange(arg_8_0)
	arg_8_0:_checkLimit()
end

function var_0_0._onUseShareCode(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._checkLimit(arg_10_0)
	local var_10_0 = arg_10_0._inputsignature:GetText()
	local var_10_1 = CommonConfig.instance:getConstNum(ConstEnum.CharacterTalentLayoutCopyCodeLimit)
	local var_10_2 = GameUtil.utf8sub(var_10_0, 1, math.min(GameUtil.utf8len(var_10_0), var_10_1))

	if var_10_2 ~= var_10_0 then
		arg_10_0._inputsignature:SetText(var_10_2)
	end
end

return var_0_0

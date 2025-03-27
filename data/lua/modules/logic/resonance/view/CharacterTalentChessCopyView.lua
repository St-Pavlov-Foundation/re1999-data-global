module("modules.logic.resonance.view.CharacterTalentChessCopyView", package.seeall)

slot0 = class("CharacterTalentChessCopyView", RoomLayoutInputBaseView)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._txttip = gohelper.findChildText(slot0.viewGO, "tips/txt_tips")
	slot0._txttitlecn.text = luaLang("character_copy_talentLayout_title_cn")
	slot0._txtinputlang.text = luaLang("character_copy_talentLayout_title_cn")
	slot0._txttitleen.text = luaLang("character_copy_talentLayout_title_en")
	slot0._txttip.text = luaLang("character_copy_talentLayout_tip")
	slot0._gocaret = gohelper.findChild(slot0.viewGO, "message/#input_signature/textarea/Caret")
	slot2 = GameUtil.parseColor("#686664")
	slot0._txttip.color = slot2
	gohelper.findChildImage(slot0.viewGO, "tips/txt_tips/icon").color = slot2
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, slot0._onUseShareCode, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, slot0._onUseShareCode, slot0)
end

function slot0.onOpen(slot0)
	slot0._heroMo = slot0.viewParam.heroMo
end

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputsignature:GetText()) then
		ToastController.instance:showToast(ToastEnum.CharacterTalentCopyCodeNull, HeroResonaceModel.instance:getSpecialCn(slot0._heroMo))

		return
	end

	if not slot0._heroMo then
		slot0._heroMo = slot0.viewParam.heroMo
	end

	slot2, slot3 = HeroResonaceModel.instance:canUseLayoutShareCode(slot0._heroMo, slot1)

	if slot2 then
		ViewMgr.instance:openView(ViewName.CharacterTalentUseLayoutView, {
			heroMo = slot0._heroMo,
			code = slot1
		})
	elseif slot3 then
		GameFacade.showToast(slot3)
	else
		ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeFailPastedUseLackCube, HeroResonaceModel.instance:getSpecialCn(slot0._heroMo))
	end
end

function slot0._btncleannameOnClick(slot0)
	slot0._inputsignature:SetText("")
	transformhelper.setLocalPosXY(slot0._txttext.transform, 0, 0)
	transformhelper.setLocalPosXY(slot0._gocaret.transform, 0, 0)
end

function slot0._onInputNameEndEdit(slot0)
	slot0:_checkLimit()
end

function slot0._onInputNameValueChange(slot0)
	slot0:_checkLimit()
end

function slot0._onUseShareCode(slot0)
	slot0:closeThis()
end

function slot0._checkLimit(slot0)
	slot1 = slot0._inputsignature:GetText()

	if GameUtil.utf8sub(slot1, 1, math.min(GameUtil.utf8len(slot1), CommonConfig.instance:getConstNum(ConstEnum.CharacterTalentLayoutCopyCodeLimit))) ~= slot1 then
		slot0._inputsignature:SetText(slot3)
	end
end

return slot0

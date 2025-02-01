module("modules.logic.minors.view.DateOfBirthVerifyView", package.seeall)

slot0 = class("DateOfBirthVerifyView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagetop = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_top")
	slot0._simagebottom = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bottom")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "middlebg/#txt_time")
	slot0._txtage = gohelper.findChildText(slot0.viewGO, "middlebg/#txt_age")
	slot0._txtrestrict = gohelper.findChildText(slot0.viewGO, "middlebg/#txt_restrict")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn1/#btn_cancel")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn2/#btn_confirm")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

slot1 = {
	Kid = 3,
	Age18 = 1,
	Age16_18 = 2
}

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
end

function slot0._btnconfirmOnClick(slot0)
	slot1 = slot0.viewParam

	MinorsController.instance:confirmDateOfBirthVerify(slot1.year, slot1.month, slot1.day)
end

function slot0._editableInitView(slot0)
	slot0._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam
	slot2 = slot1.year
	slot3 = slot1.month
	slot4 = slot1.day

	if slot0:_checkMinorsState() == uv0.Age18 then
		slot0._txtage.text = luaLang("minors_18+")
		slot0._txtrestrict.text = luaLang("minors_18+_limit")
	elseif slot5 == uv0.Age16_18 then
		slot0._txtage.text = luaLang("minors_under_18")
		slot0._txtrestrict.text = luaLang("minors_under_18_limit")
	else
		slot0._txtage.text = luaLang("minors_under_16")
		slot0._txtrestrict.text = luaLang("minors_under_16_limit")
	end

	slot0._txttime.text = string.format(luaLang("minors_birth_format"), slot2, slot3, slot4)

	MinorsController.instance:registerCallback(MinorsEvent.PayLimitFlagUpdate, slot0._onPayLimitFlagUpdate, slot0)
end

function slot0._checkMinorsState(slot0)
	slot1 = slot0.viewParam
	slot5 = ServerTime.nowDate()
	slot7 = slot5.month - slot1.month
	slot8 = slot5.day - slot1.day

	if slot5.year - slot1.year > 18 then
		return uv0.Age18
	end

	if slot6 == 18 then
		if slot7 > 0 then
			return uv0.Age18
		end

		if slot7 == 0 and slot8 >= 0 then
			return uv0.Age18
		end
	end

	if slot6 > 16 then
		return uv0.Age16_18
	end

	if slot6 == 16 then
		if slot7 > 0 then
			return uv0.Age16_18
		end

		if slot7 == 0 and slot8 >= 0 then
			return uv0.Age16_18
		end
	end

	return uv0.Kid
end

function slot0.onClose(slot0)
	MinorsController.instance:unregisterCallback(MinorsEvent.PayLimitFlagUpdate, slot0._onPayLimitFlagUpdate, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetop:UnLoadImage()
	slot0._simagebottom:UnLoadImage()
end

function slot0._onPayLimitFlagUpdate(slot0)
	GameFacade.showToast(ToastEnum.MinorDateofBirthSettingSuc)
	slot0:closeThis()
end

return slot0

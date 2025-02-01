module("modules.logic.currency.view.CurrencyExchangeView", package.seeall)

slot0 = class("CurrencyExchangeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagehuawen1 = gohelper.findChildSingleImage(slot0.viewGO, "tipbg/#simage_huawen1")
	slot0._simagehuawen2 = gohelper.findChildSingleImage(slot0.viewGO, "tipbg/#simage_huawen2")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
end

slot1 = MsgBoxEnum.CloseType
slot2 = MsgBoxEnum.BoxType

function slot0._btnyesOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.Yes)
end

function slot0._btnnoOnClick(slot0)
	slot0:_closeInvokeCallback(uv0.No)
end

function slot0._closeInvokeCallback(slot0, slot1)
	slot2 = false

	if slot1 == uv0.Yes then
		if slot0.viewParam.isExchangeStep then
			slot2 = CurrencyController.instance:checkExchangeFreeDiamond(slot0.viewParam.needDiamond, slot0.viewParam.srcType, slot0.viewParam.callback, slot0.viewParam.callbackObj, slot0.viewParam.jumpCallBack, slot0.viewParam.jumpCallbackObj)
		else
			if slot0.viewParam.jumpCallBack then
				slot0.viewParam.jumpCallBack(slot0.viewParam.jumpCallbackObj)
			end

			StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
		end

		if slot0.viewParam.yesCallback then
			slot0.viewParam.yesCallback()
		end
	elseif slot0.viewParam.noCallback then
		slot0.viewParam.noCallback()
	end

	if not slot2 then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	slot0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))

	slot0._goNo = slot0._btnno.gameObject
	slot0._goYes = slot0._btnyes.gameObject

	gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onDestroyView(slot0)
	slot0._simagehuawen1:UnLoadImage()
	slot0._simagehuawen2:UnLoadImage()
end

function slot0.onOpen(slot0)
	if not string.nilorempty(slot0.viewParam.msg) and slot0.viewParam.extra and #slot0.viewParam.extra > 0 then
		slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(slot0.viewParam.msg, slot0.viewParam.extra)
	else
		slot0._txtdesc.text = slot0.viewParam.msg or ""
	end

	if slot0.viewParam.openCallback then
		slot0.viewParam.openCallback(slot0)
	end

	gohelper.setActive(slot0._goNo, true)
	recthelper.setAnchorX(slot0._goYes.transform, 248)
	recthelper.setAnchorX(slot0._goNo.transform, -248)
	NavigateMgr.instance:addEscape(ViewName.CurrencyExchangeView, slot0._onEscapeBtnClick, slot0)
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._goNo.gameObject.activeInHierarchy then
		slot0:_closeInvokeCallback(uv0.No)
	end
end

function slot0.onClose(slot0)
end

return slot0

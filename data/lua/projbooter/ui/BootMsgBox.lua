module("projbooter.ui.BootMsgBox", package.seeall)

slot0 = class("BootMsgBox")

function slot0.init(slot0)
	slot0._go = BootResMgr.instance:getMsgBoxGo()
	slot0._rootTr = slot0._go.transform
	slot1 = typeof(UnityEngine.UI.Text)
	slot0._txtTitle = slot0._rootTr:Find("txtTitle"):GetComponent(slot1)
	slot0._gotopTipEn = slot0._rootTr:Find("topTip/txtEn").gameObject
	slot0._txttopTipCn = slot0._rootTr:Find("topTip/txtCn"):GetComponent(slot1)
	slot0._txtContent = slot0._rootTr:Find("txtContent"):GetComponent(slot1)
	slot0._leftBtnGo = slot0._rootTr:Find("btnLeft").gameObject
	slot0._leftBtn = SLFramework.UGUI.ButtonWrap.Get(slot0._leftBtnGo)
	slot0._leftBtnTxt = slot0._rootTr:Find("btnLeft/Text"):GetComponent(slot1)
	slot0._leftBtnTxtEn = slot0._rootTr:Find("btnLeft/Text-EN"):GetComponent(slot1)
	slot0._rightBtnGo = slot0._rootTr:Find("btnRight").gameObject
	slot0._rightBtn = SLFramework.UGUI.ButtonWrap.Get(slot0._rightBtnGo)
	slot0._rightBtnTxt = slot0._rootTr:Find("btnRight/Text"):GetComponent(slot1)
	slot0._rightBtnTxtEn = slot0._rootTr:Find("btnRight/Text-EN"):GetComponent(slot1)

	slot0._leftBtn:AddClickListener(slot0._onClickLeftBtn, slot0)
	slot0._rightBtn:AddClickListener(slot0._onClickRightBtn, slot0)
	GamepadBooter.instance:setBootMsgBoxClick(slot0._onClickRightBtn, slot0, slot0._onClickLeftBtn, slot0)
end

function slot0.show(slot0, slot1)
	if slot0._isDisable then
		return
	end

	slot0.args = slot1
	slot3 = true

	if GameConfig:GetCurLangShortcut() ~= "zh" then
		slot3 = false

		SLFramework.UGUI.RectTrHelper.SetAnchorY(slot0._leftBtnTxt.transform, 15)
		SLFramework.UGUI.RectTrHelper.SetAnchorY(slot0._rightBtnTxt.transform, 15)
	end

	slot0._gotopTipEn:SetActive(slot3)
	slot0._leftBtnTxtEn.gameObject:SetActive(slot3)
	slot0._rightBtnTxtEn.gameObject:SetActive(slot3)

	slot0._txtTitle.text = slot1.title
	slot0._txtContent.text = slot1.content
	slot0._txttopTipCn.text = booterLang("notice")

	slot0._leftBtnGo:SetActive(slot1.leftMsg ~= nil)

	slot0._leftBtnTxt.text = slot1.leftMsg and slot1.leftMsg or ""
	slot0._leftCb = slot1.leftCb
	slot0._leftCbObj = slot1.leftCbObj

	slot0._rightBtnGo:SetActive(slot1.rightMsg ~= nil)

	slot0._rightBtnTxt.text = slot1.rightMsg and slot1.rightMsg or ""
	slot0._rightCb = slot1.rightCb
	slot0._rightCbObj = slot1.rightCbObj
	slot0._leftBtnTxtEn.text = slot1.leftMsgEn or "EXIT"
	slot0._rightBtnTxtEn.text = slot1.rightMsgEn or "DOWNLOAD"

	SLFramework.UGUI.RectTrHelper.SetAnchorY(slot0._txtTitle.transform, slot1.titleAnchorY or 55)

	if slot1.rightMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(slot0._leftBtnGo.transform, -247.1)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(slot0._leftBtnGo.transform, 0)
	end

	if slot1.leftMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(slot0._rightBtnGo.transform, 246.7)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(slot0._rightBtnGo.transform, 0)
	end

	slot0._go:SetActive(true)
end

function slot0.isShow(slot0)
	if slot0._go then
		return slot0._go.activeInHierarchy
	end
end

function slot0.hide(slot0)
	slot0._go:SetActive(false)
end

function slot0.dispose(slot0)
	for slot4, slot5 in pairs(slot0) do
		slot0[slot4] = nil
	end
end

function slot0._onClickLeftBtn(slot0)
	slot0:hide()

	if slot0._leftCb == nil then
		return
	end

	slot0._leftCb = nil
	slot0._leftCbObj = nil

	slot0._leftCb(slot0._leftCbObj)
end

function slot0._onClickRightBtn(slot0)
	slot0:hide()

	if slot0._rightCb == nil then
		return
	end

	slot0._rightCb = nil
	slot0._rightCbObj = nil

	slot0._rightCb(slot0._rightCbObj)
end

function slot0.dispose(slot0)
	GamepadBooter.instance:dispose()
	slot0._leftBtn:RemoveClickListener()
	slot0._rightBtn:RemoveClickListener()

	for slot4, slot5 in pairs(slot0) do
		if type(slot5) == "userdata" then
			rawset(slot0, slot4, nil)
			logNormal("key = " .. tostring(slot4) .. " value = " .. tostring(slot5))
		end
	end
end

function slot0.disable(slot0)
	slot0._isDisable = true
end

slot0.instance = slot0.New()

return slot0

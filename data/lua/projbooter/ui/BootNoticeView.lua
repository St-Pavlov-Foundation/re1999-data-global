module("projbooter.ui.BootNoticeView", package.seeall)

slot0 = class("BootNoticeView")

function slot0.init(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
	slot0._go = BootResMgr.instance:getNoticeViewGo()

	slot0._go:SetActive(true)

	slot0._rootTr = slot0._go.transform
	slot3 = typeof(UnityEngine.UI.Text)
	slot0._txtTitle = slot0._rootTr:Find("top/title"):GetComponent(slot3)
	slot0._txtContent = slot0._rootTr:Find("#scroll_desc/viewport/content/desc"):GetComponent(slot3)
	slot0._btnGo = slot0._rootTr:Find("btnOk").gameObject
	slot0._okBtn = SLFramework.UGUI.ButtonWrap.Get(slot0._btnGo)

	slot0._okBtn:AddClickListener(slot0._onClickOkBtn, slot0)
	slot0._go.transform:SetAsLastSibling()
	slot0:_setNotice()
end

function slot0._setNotice(slot0)
	slot0._txtTitle.text = NoticeModel.instance:getBeforeLoginNoticeTitle()
	slot0._txtContent.text = NoticeModel.instance:getBeforeLoginNoticeContent()
end

function slot0._onClickOkBtn(slot0)
	if slot0._callback == nil then
		return
	end

	slot0._callback(slot0._callbackObj)

	slot0._callback = nil
	slot0._callbackObj = nil

	slot0:dispose()
end

function slot0.dispose(slot0)
	if slot0._okBtn then
		slot0._okBtn:RemoveClickListener()
		UnityEngine.GameObject.Destroy(slot0._go)

		slot0._go = nil
	end

	for slot4, slot5 in pairs(slot0) do
		if type(slot5) == "userdata" then
			rawset(slot0, slot4, nil)
		end
	end
end

slot0.instance = slot0.New()

return slot0

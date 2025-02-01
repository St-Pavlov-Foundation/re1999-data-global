module("projbooter.ui.BootVersionView", package.seeall)

slot0 = class("BootVersionView")

function slot0.show(slot0)
	if not slot0._go then
		slot0._go = BootResMgr.instance:getVersionViewGo()
		slot0._rootTr = slot0._go.transform
		slot0._txtVersion = slot0._rootTr:Find("#txt_version"):GetComponent(typeof(UnityEngine.UI.Text))
	end

	if slot0._go then
		slot0._go:SetActive(true)

		slot0._txtVersion.text = string.format("V%s-%s-%s", UnityEngine.Application.version, SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr, tostring(BootNativeUtil.getAppVersion()))
	end
end

function slot0.hide(slot0)
	if slot0._go then
		slot0._go:SetActive(false)
	end
end

function slot0.dispose(slot0)
	slot0:hide()

	slot0._go = nil
	slot0._rootTr = nil
	slot0._txtVersion = nil
end

slot0.instance = slot0.New()

return slot0

module("modules.common.others.CommonViewFrame", package.seeall)

slot0 = class("CommonViewFrame", BaseView)
slot1 = typeof(ZProj.ViewFrame)

function slot0.onInitView(slot0)
	slot0._viewFrame = slot0.viewGO:GetComponent(uv0)

	if not slot0._viewFrame then
		slot0._viewFrame = slot0.viewGO:GetComponentInChildren(uv0, true)
	end

	if slot0._viewFrame then
		slot0._viewFrame:SetLoadCallback(slot0._onFrameLoaded, slot0)
	else
		logError(slot0.viewName .. " 没有挂通用弹框底板脚本 ViewFrame.cs")
	end
end

function slot0._onFrameLoaded(slot0, slot1)
	slot0._txtTitle = gohelper.findChildText(slot0._viewFrame.frameGO, "txt/titlecn")

	if slot0._txtTitle and not string.nilorempty(slot0._viewFrame.cnTitle) then
		slot0._txtTitle.text = luaLang(slot0._viewFrame.cnTitle)
	end

	slot0._txtTitleEn = gohelper.findChildText(slot2, "txt/titlecn/titleen")

	if slot0._txtTitleEn then
		slot0._txtTitleEn.text = slot0._viewFrame.enTitle
	end

	slot0._btnclose = gohelper.findChildButtonWithAudio(slot2, "#btn_close")

	if slot0._btnclose then
		slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	end

	if gohelper.findChild(slot2, "Mask") then
		slot0._clickMask = SLFramework.UGUI.UIClickListener.Get(slot3)

		slot0._clickMask:AddClickListener(slot0._btncloseOnClick, slot0)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	if slot0._btnclose then
		slot0._btnclose:RemoveClickListener()

		slot0._btnclose = nil
	end

	if slot0._clickMask then
		slot0._clickMask:RemoveClickListener()
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0

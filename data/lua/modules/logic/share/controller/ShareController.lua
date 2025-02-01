module("modules.logic.share.controller.ShareController", package.seeall)

slot0 = class("ShareController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	SDKMgr.instance:setSocialShareCallBack(slot0._onSocialShare, slot0)
	SDKMgr.instance:setScreenShotCallBack(slot0._onScreenShot, slot0)
end

function slot0.openShareEditorView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.ShareEditorView, slot1, slot2)
end

function slot0.openShareTipView(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.ShareTipView, slot1, slot2)
end

function slot0.CaptureScreenshot(slot0)
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, slot0._onReadScene, slot0)
end

function slot0._onReadScene(slot0, slot1)
	slot0:openShareTipView(slot1)
end

function slot0._onSocialShare(slot0, slot1, slot2)
	if slot1 == 200 or slot1 == -2 then
		ViewMgr.instance:closeView(ViewName.ShareEditorView)
	end

	slot3 = luaLang("datatrack_shareaction_success")

	if slot1 == -1 then
		slot3 = luaLang("datatrack_shareaction_failure")
	elseif slot1 == -2 then
		slot3 = luaLang("datatrack_shareaction_cancel")
	end

	StatController.instance:track(StatEnum.EventName.PlayerShare, {
		[StatEnum.EventProperties.ShareAction] = slot3
	})
end

function slot0._onScreenShot(slot0, slot1, slot2)
	if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		return false
	end

	if SDKNativeUtil.isShowShareButton() == false then
		return false
	end

	if not slot1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ShareEditorView) then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if SettingsModel.instance:getScreenshotSwitch() then
		slot0:CaptureScreenshot()
	end
end

slot0.instance = slot0.New()

return slot0

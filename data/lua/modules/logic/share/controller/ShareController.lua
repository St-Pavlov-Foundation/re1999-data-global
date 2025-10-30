module("modules.logic.share.controller.ShareController", package.seeall)

local var_0_0 = class("ShareController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	SDKMgr.instance:setSocialShareCallBack(arg_4_0._onSocialShare, arg_4_0)
	SDKMgr.instance:setScreenShotCallBack(arg_4_0._onScreenShot, arg_4_0)
end

function var_0_0.openShareEditorView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:openView(ViewName.ShareEditorView, arg_5_1, arg_5_2)
end

function var_0_0.openShareTipView(arg_6_0, arg_6_1, arg_6_2)
	ViewMgr.instance:openView(ViewName.ShareTipView, arg_6_1, arg_6_2)
end

function var_0_0.CaptureScreenshot(arg_7_0)
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, arg_7_0._onReadScene, arg_7_0)
end

function var_0_0._onReadScene(arg_8_0, arg_8_1)
	if not StoryModel.instance:isStoryPvPause() then
		arg_8_0:openShareTipView(arg_8_1)
	end
end

function var_0_0._onSocialShare(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == 200 or arg_9_1 == -2 then
		ViewMgr.instance:closeView(ViewName.ShareEditorView)
	end

	local var_9_0 = luaLang("datatrack_shareaction_success")

	if arg_9_1 == -1 then
		var_9_0 = luaLang("datatrack_shareaction_failure")
	elseif arg_9_1 == -2 then
		var_9_0 = luaLang("datatrack_shareaction_cancel")
	end

	StatController.instance:track(StatEnum.EventName.PlayerShare, {
		[StatEnum.EventProperties.ShareAction] = var_9_0
	})
end

function var_0_0._onScreenShot(arg_10_0, arg_10_1, arg_10_2)
	if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		return false
	end

	if SDKNativeUtil.isShowShareButton() == false then
		return false
	end

	if not arg_10_1 then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.ShareEditorView) then
		return
	end

	if not LoginModel.instance:isDoneLogin() then
		return
	end

	if SettingsModel.instance:getScreenshotSwitch() then
		arg_10_0:CaptureScreenshot()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

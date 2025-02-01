module("modules.logic.login.view.LoginBgView", package.seeall)

slot0 = class("LoginBgView", BaseView)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0._containerPath = slot1
end

function slot0.onInitView(slot0)
	slot0._goBgRoot = gohelper.findChild(slot0.viewGO, slot0._containerPath)
end

function slot0.onOpen(slot0)
	slot0._goSpine = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.LoginView).viewGO, "spine")

	slot0:_showBgType()
end

function slot0._showBgType(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_Login_interface_noise_1_9)
	gohelper.setActive(slot0._goSpine, false)

	if not slot0._goBg then
		slot0._goBg = slot0.viewContainer:getResInst(slot0.viewContainer._viewSetting.otherRes[1], slot0._goBgRoot, "bgview2")
		slot0._imgBg = gohelper.findChildSingleImage(slot0._goBg, "background")
	end

	slot0._imgBg:LoadImage(ResUrl.getLoginBg("bg_denglubeijing_b01"), slot0._bgHasLoaded, slot0)
end

function slot0._bgHasLoaded(slot0)
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginBgLoaded)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_Login_interface_noise_1_9)
end

function slot0.onDestroyView(slot0)
	if slot0._imgBg then
		slot0._imgBg:UnLoadImage()
	end
end

return slot0

module("modules.logic.login.view.LoginBgView", package.seeall)

local var_0_0 = class("LoginBgView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._containerPath = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._goBgRoot = gohelper.findChild(arg_2_0.viewGO, arg_2_0._containerPath)
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0._isShowVideo = LoginController.instance:isShowLoginVideo()
	arg_3_0._goSpine = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.LoginView).viewGO, "spine")

	arg_3_0:_showBgType()
end

function var_0_0._showBgType(arg_4_0)
	if arg_4_0._isShowVideo then
		AudioMgr.instance:trigger(AudioEnum3_0.Bgm.play_login_interface_music_3_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Play_Login_interface_nosie)
	end

	gohelper.setActive(arg_4_0._goSpine, false)

	if not arg_4_0._goBg then
		arg_4_0._goBg = arg_4_0.viewContainer:getResInst(arg_4_0.viewContainer._viewSetting.otherRes[1], arg_4_0._goBgRoot, "bgview2")
		arg_4_0._imgBg = gohelper.findChildSingleImage(arg_4_0._goBg, "background")
	end

	local var_4_0 = 0.1

	if arg_4_0._imgBg and arg_4_0.viewContainer._viewSetting.otherRes[2] then
		var_4_0 = 2

		arg_4_0._imgBg:LoadImage(arg_4_0.viewContainer._viewSetting.otherRes[2], arg_4_0._bgHasLoaded, arg_4_0)
	end

	TaskDispatcher.runDelay(arg_4_0._bgHasLoaded, arg_4_0, var_4_0)
end

function var_0_0._bgHasLoaded(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._bgHasLoaded, arg_5_0)
	LoginController.instance:dispatchEvent(LoginEvent.OnLoginBgLoaded)
end

function var_0_0.onClose(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Bgm.Stop_LeiMiTeBeiBgm)
	TaskDispatcher.cancelTask(arg_6_0._bgHasLoaded, arg_6_0)

	if arg_6_0._isShowVideo then
		AudioMgr.instance:trigger(AudioEnum.Bgm.stop_login_interface_music_3_0)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_Login_interface_noise)
	end
end

function var_0_0.onDestroyView(arg_7_0)
	if arg_7_0._imgBg then
		arg_7_0._imgBg:UnLoadImage()
	end
end

return var_0_0

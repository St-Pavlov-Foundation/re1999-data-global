module("modules.logic.login.view.LoginVideoView", package.seeall)

local var_0_0 = class("LoginVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBgRoot = gohelper.findChild(arg_1_0.viewGO, "#go_bg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._isShowVideo = LoginController.instance:isShowLoginVideo()
end

function var_0_0.onOpenFinish(arg_3_0)
	if arg_3_0._isShowVideo then
		LoginController.instance:dispatchEvent(LoginEvent.OnLoginBgLoaded)
	end

	if arg_3_0._isShowVideo and not arg_3_0._videoPlayer then
		arg_3_0._videoPlayer, arg_3_0._displayUGUI, arg_3_0._videoGo = AvProMgr.instance:getVideoPlayer(arg_3_0.viewGO, "voideplayer")

		gohelper.setSiblingAfter(arg_3_0._videoGo, arg_3_0._goBgRoot)
		arg_3_0:play()
		arg_3_0:addEventCb(arg_3_0.viewContainer, LoginEvent.OnLoginVideoSwitch, arg_3_0._playByPath, arg_3_0)

		local var_3_0 = arg_3_0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter))

		if var_3_0 then
			var_3_0.enabled = false
		end
	end
end

function var_0_0.onDestroyView(arg_4_0)
	if arg_4_0._videoPlayer then
		arg_4_0._videoPlayer:Stop()
		arg_4_0._videoPlayer:Clear()

		arg_4_0._videoPlayer = nil
		arg_4_0._videoGo = nil
	end
end

function var_0_0.play(arg_5_0)
	local var_5_0 = CommonConfig.instance:getConstStr(ConstEnum.LoginViewVideoPathId)

	arg_5_0:_playByPath(langVideoUrl(var_5_0))
end

function var_0_0._playByPath(arg_6_0, arg_6_1)
	if not arg_6_1 or string.nilorempty(arg_6_1) or arg_6_0._curPlayVideoPath == arg_6_1 then
		return
	end

	if arg_6_0._videoPlayer then
		arg_6_0._curPlayVideoPath = arg_6_1

		arg_6_0._videoPlayer:Play(arg_6_0._displayUGUI, arg_6_1, true, arg_6_0._videoStatusUpdate, arg_6_0)
	end
end

function var_0_0._videoStatusUpdate(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if (arg_7_2 == AvProEnum.PlayerStatus.Error or arg_7_3 ~= AvProEnum.ErrorCode.None) and not gohelper.isNil(arg_7_0._videoGo) then
		gohelper.setActive(arg_7_0._videoGo, false)
	end
end

return var_0_0

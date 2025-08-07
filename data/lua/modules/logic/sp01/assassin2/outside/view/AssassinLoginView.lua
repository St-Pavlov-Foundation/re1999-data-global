module("modules.logic.sp01.assassin2.outside.view.AssassinLoginView", package.seeall)

local var_0_0 = class("AssassinLoginView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/simage_fullbg", AudioEnum2_9.StealthGame.play_ui_cikeshang_start)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._onClick(arg_4_0)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, true)
	arg_4_0._animatorPlayer:Play(UIAnimationName.Close, arg_4_0._onCloseAnimDone, arg_4_0)
end

function var_0_0._onCloseAnimDone(arg_5_0)
	AssassinController.instance:realOpenAssassinMapView(arg_5_0.viewParam)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, false)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_6_0.viewGO)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_shadow)
end

function var_0_0.onClose(arg_9_0)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.ClosingLoginView, false)
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

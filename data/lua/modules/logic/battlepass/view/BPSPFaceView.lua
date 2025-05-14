module("modules.logic.battlepass.view.BPSPFaceView", package.seeall)

local var_0_0 = class("BPSPFaceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnSkin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skin")
	arg_1_0._btnGet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_get")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnSkin:AddClickListener(arg_2_0._openSkinPreview, arg_2_0)
	arg_2_0._btnGet:AddClickListener(arg_2_0._openSpView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnSkin:RemoveClickListener()
	arg_3_0._btnGet:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onViewClose, arg_3_0)
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2BPSP.play_ui_youyu_liuxing_give)
end

function var_0_0._openSkinPreview(arg_6_0)
	ViewMgr.instance:openView(ViewName.BpBonusSelectView)
end

function var_0_0._openSpView(arg_7_0)
	BpModel.instance.firstShowSp = false

	BpRpc.instance:sendBpMarkFirstShowRequest(true)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_7_0._onViewClose, arg_7_0)
	BpController.instance:openBattlePassView(true, {
		isFirst = true
	})
end

function var_0_0._onViewClose(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.BpSPView then
		arg_8_0:closeThis()
	end
end

return var_0_0

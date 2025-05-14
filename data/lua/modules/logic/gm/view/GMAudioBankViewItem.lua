module("modules.logic.gm.view.GMAudioBankViewItem", package.seeall)

local var_0_0 = class("GMAudioBankViewItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._guideCO = nil
	arg_1_0._txtAudioId = gohelper.findChildText(arg_1_1, "txtAudioID")
	arg_1_0._txtEventName = gohelper.findChildText(arg_1_1, "txtEventName")
	arg_1_0._btnShow = gohelper.findChildButtonWithAudio(arg_1_1, "btnShow")

	arg_1_0._btnShow:AddClickListener(arg_1_0._onClickShow, arg_1_0)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._audioCO = arg_2_1
	arg_2_0._configId = arg_2_1.id
	arg_2_0._txtAudioId.text = arg_2_0._configId
	arg_2_0._txtEventName.text = arg_2_0._audioCO.eventName
end

function var_0_0._onClickShow(arg_3_0)
	AudioMgr.instance:trigger(3000031)
	AudioMgr.instance:trigger(arg_3_0._configId)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._btnShow:RemoveClickListener()
end

return var_0_0

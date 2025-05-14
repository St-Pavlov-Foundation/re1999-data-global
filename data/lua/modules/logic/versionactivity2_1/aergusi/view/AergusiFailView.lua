module("modules.logic.versionactivity2_1.aergusi.view.AergusiFailView", package.seeall)

local var_0_0 = class("AergusiFailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	return
end

function var_0_0._btnquitgameOnClick(arg_5_0)
	arg_5_0:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
end

function var_0_0._btnrestartOnClick(arg_6_0)
	arg_6_0:closeThis()
	ViewMgr.instance:closeView(ViewName.AergusiDialogView)
	AergusiController.instance:dispatchEvent(AergusiEvent.RestartEvidence)
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)
	arg_8_0:refreshTips()
end

function var_0_0.refreshTips(arg_9_0)
	local var_9_0 = AergusiConfig.instance:getEpisodeConfig(nil, arg_9_0.viewParam.episodeId)
	local var_9_1 = AergusiModel.instance:getEpisodeIndex(arg_9_0.viewParam.episodeId)

	arg_9_0._txtclassnum.text = string.format("STAGE %02d", var_9_1)
	arg_9_0._txtclassname.text = var_9_0.name
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._realRestart, arg_11_0)
end

return var_0_0

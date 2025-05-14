module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveSettleView", package.seeall)

local var_0_0 = class("AutoChessPveSettleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSuccess = gohelper.findChild(arg_1_0.viewGO, "#go_Success")
	arg_1_0._goFail = gohelper.findChild(arg_1_0.viewGO, "#go_Fail")
	arg_1_0._btnRestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_Restart")
	arg_1_0._btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_Exit")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRestart:AddClickListener(arg_2_0._btnRestartOnClick, arg_2_0)
	arg_2_0._btnExit:AddClickListener(arg_2_0._btnExitOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRestart:RemoveClickListener()
	arg_3_0._btnExit:RemoveClickListener()
end

function var_0_0._onEscBtnClick(arg_4_0)
	return
end

function var_0_0._btnRestartOnClick(arg_5_0)
	arg_5_0.restart = true

	arg_5_0:closeThis()
end

function var_0_0._btnExitOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	NavigateMgr.instance:addEscape(ViewName.AutoChessPveSettleView, arg_7_0._onEscBtnClick, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = AutoChessModel.instance.settleData

	if var_9_0 then
		gohelper.setActive(arg_9_0._goSuccess, tonumber(var_9_0.remainingHp) ~= 0)
		gohelper.setActive(arg_9_0._goFail, tonumber(var_9_0.remainingHp) == 0)
	end
end

function var_0_0.onClose(arg_10_0)
	local var_10_0 = AutoChessModel.instance.episodeId

	AutoChessController.instance:onSettleViewClose()

	if arg_10_0.restart then
		local var_10_1 = AutoChessEnum.ModuleId.PVE
		local var_10_2 = lua_auto_chess_episode.configDict[var_10_0].masterId

		AutoChessRpc.instance:sendAutoChessEnterSceneRequest(var_10_1, var_10_0, var_10_2)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0

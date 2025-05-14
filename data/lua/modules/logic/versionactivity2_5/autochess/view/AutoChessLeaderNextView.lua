module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderNextView", package.seeall)

local var_0_0 = class("AutoChessLeaderNextView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLeaderRoot = gohelper.findChild(arg_1_0.viewGO, "#go_LeaderRoot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if arg_7_0.viewParam and arg_7_0.viewParam.leaderId then
		local var_7_0 = arg_7_0:getResInst(AutoChessEnum.LeaderItemPath, arg_7_0._goLeaderRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, AutoChessLeaderItem):setData(arg_7_0.viewParam.leaderId)
		TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, 2)
	end
end

function var_0_0.onClose(arg_8_0)
	AutoChessRpc.instance:sendAutoChessEnterSceneRequest(arg_8_0.viewParam.moduleId, arg_8_0.viewParam.episodeId, arg_8_0.viewParam.leaderId)
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

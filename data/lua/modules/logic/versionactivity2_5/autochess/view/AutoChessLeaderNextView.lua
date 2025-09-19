module("modules.logic.versionactivity2_5.autochess.view.AutoChessLeaderNextView", package.seeall)

local var_0_0 = class("AutoChessLeaderNextView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goLeaderRoot = gohelper.findChild(arg_1_0.viewGO, "#go_LeaderRoot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.onClickModalMask(arg_2_0)
	return
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_qishou_confirm)

	if arg_3_0.viewParam and arg_3_0.viewParam.leaderId then
		local var_3_0 = arg_3_0:getResInst(AutoChessStrEnum.ResPath.LeaderItem, arg_3_0._goLeaderRoot)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, AutoChessLeaderItem):setData(arg_3_0.viewParam.leaderId)
		TaskDispatcher.runDelay(arg_3_0.closeThis, arg_3_0, 2)
	end
end

function var_0_0.onClose(arg_4_0)
	local var_4_0 = arg_4_0.viewParam.actId or Activity182Model.instance:getCurActId()

	AutoChessRpc.instance:sendAutoChessEnterSceneRequest(var_4_0, arg_4_0.viewParam.moduleId, arg_4_0.viewParam.episodeId, arg_4_0.viewParam.leaderId, true)
end

return var_0_0

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryFailView", package.seeall)

local var_0_0 = class("V3A1_RoleStoryFailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnExit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_quitgame")
	arg_1_0.btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#btn_restart")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnExit, arg_2_0.onClickBtnExit, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnReplay, arg_2_0.onClickBtnReplay, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnExit)
	arg_3_0:removeClickCb(arg_3_0.btnReplay)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickModalMask(arg_5_0)
	return
end

function var_0_0.onClickBtnExit(arg_6_0)
	local var_6_0 = arg_6_0.roleStoryId

	NecrologistStoryModel.instance:getGameMO(var_6_0):setIsExitGame(true)
	NecrologistStoryController.instance:closeGameView(arg_6_0.roleStoryId)
	arg_6_0:closeThis()
end

function var_0_0.onClickBtnReplay(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.roleStoryId = arg_8_0.viewParam.roleStoryId

	arg_8_0:resetProgress()
end

function var_0_0.resetProgress(arg_9_0)
	local var_9_0 = arg_9_0.roleStoryId

	NecrologistStoryModel.instance:getGameMO(var_9_0):resetProgressByFail()
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0

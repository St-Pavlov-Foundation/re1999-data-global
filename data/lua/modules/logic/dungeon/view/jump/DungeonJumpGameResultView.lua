module("modules.logic.dungeon.view.jump.DungeonJumpGameResultView", package.seeall)

local var_0_0 = class("DungeonJumpGameResultView", BaseViewExtended)
local var_0_1 = DungeonJumpGameController.instance

function var_0_0.onInitView(arg_1_0)
	arg_1_0._closeBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_successClick")
	arg_1_0._exitBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_quitgame")
	arg_1_0._restartBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_restart")
	arg_1_0._goSuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._goFail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._goBtn = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._goClose = gohelper.findChild(arg_1_0.viewGO, "#btn_successClick")
	arg_1_0._txtStage = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_stage")
	arg_1_0._txtName = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_name")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._closeBtn:AddClickListener(arg_2_0._onClickCloseBtn, arg_2_0)
	arg_2_0._restartBtn:AddClickListener(arg_2_0._onClickRestartBtn, arg_2_0)
	arg_2_0._exitBtn:AddClickListener(arg_2_0._onClickExitBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._closeBtn:RemoveClickListener()
	arg_3_0._restartBtn:RemoveClickListener()
	arg_3_0._exitBtn:RemoveClickListener()
end

function var_0_0._onClickCloseBtn(arg_4_0)
	DungeonJumpGameController.instance:ClearProgress()
	var_0_1:dispatchEvent(DungeonJumpGameEvent.JumpGameCompleted)
	arg_4_0:closeThis()
end

function var_0_0._onClickExitBtn(arg_5_0)
	DungeonJumpGameController.instance:ClearProgress()
	var_0_1:dispatchEvent(DungeonJumpGameEvent.JumpGameExit)
	arg_5_0:closeThis()
end

function var_0_0._onClickRestartBtn(arg_6_0)
	var_0_1:dispatchEvent(DungeonJumpGameEvent.JumpGameReStart)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = arg_9_0.viewParam
	local var_9_1 = var_9_0.isWin
	local var_9_2 = var_9_0.elementId
	local var_9_3 = DungeonConfig.instance:getEpisodeByElement(var_9_2)
	local var_9_4 = DungeonConfig.instance:getEpisodeCO(var_9_3)

	gohelper.setActive(arg_9_0._goSuccess, var_9_1)
	gohelper.setActive(arg_9_0._goFail, not var_9_1)
	gohelper.setActive(arg_9_0._goBtn, not var_9_1)
	gohelper.setActive(arg_9_0._goClose, var_9_1)

	arg_9_0._txtName.text = string.format("%s", var_9_4.name)

	if not var_9_1 then
		AudioMgr.instance:trigger(AudioEnum2_8.DungeonGame.play_ui_fuleyuan_tiaoyitiao_fail)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0

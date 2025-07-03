module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6GameResult", package.seeall)

local var_0_0 = class("LengZhou6GameResult", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "#go_top")
	arg_1_0._txtstage = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_stage")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_top/#txt_name")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._txttaskdesc = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_targetitem/#txt_taskdesc")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_finish")
	arg_1_0._gounfinish = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem/result/#go_unfinish")
	arg_1_0._gobtn = gohelper.findChild(arg_1_0.viewGO, "#go_btn")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btn/#btn_restart")
	arg_1_0._btnsuccessClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_successClick")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnsuccessClick:AddClickListener(arg_2_0._btnsuccessClickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnsuccessClick:RemoveClickListener()
end

function var_0_0._btnquitgameOnClick(arg_4_0)
	arg_4_0:close()
end

function var_0_0._btnrestartOnClick(arg_5_0)
	arg_5_0._isCloseGameView = false

	arg_5_0:close()
	LengZhou6Controller.instance:restartGame()
end

function var_0_0._btnsuccessClickOnClick(arg_6_0)
	arg_6_0:close()
end

function var_0_0.close(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._isCloseGameView = true

	arg_10_0:initInfo()
	arg_10_0:initResult()
	LengZhou6StatHelper.instance:sendGameExit()
end

function var_0_0.initInfo(arg_11_0)
	local var_11_0 = LengZhou6GameModel.instance:getEpisodeConfig()

	arg_11_0._txtname.text = var_11_0.name
	arg_11_0._txtstage.text = string.format("STAGE %s", var_11_0.episodeId - 1270200)
end

function var_0_0.initResult(arg_12_0)
	local var_12_0 = LengZhou6GameModel.instance:playerIsWin()

	gohelper.setActive(arg_12_0._gofail, not var_12_0)
	gohelper.setActive(arg_12_0._gosuccess, var_12_0)
	gohelper.setActive(arg_12_0._gobtn, not var_12_0)

	local var_12_1 = var_12_0 and AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_success or AudioEnum2_7.LengZhou6.play_ui_yuzhou_lzl_fail

	AudioMgr.instance:trigger(var_12_1)

	local var_12_2 = var_12_0 and LengZhou6Enum.GameResult.win or LengZhou6Enum.GameResult.lose

	LengZhou6StatHelper.instance:setGameResult(var_12_2)
end

function var_0_0.onClose(arg_13_0)
	LengZhou6GameController.instance:levelGame(arg_13_0._isCloseGameView)
end

return var_0_0

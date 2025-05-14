module("modules.logic.activity.view.chessmap.ActivityChessGameResultView", package.seeall)

local var_0_0 = class("ActivityChessGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargets = gohelper.findChild(arg_1_0.viewGO, "#go_targets")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "#go_targets/#go_targetitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_success/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	arg_4_0._openTime = Time.time
	arg_4_0._taskItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
end

function var_0_0.onOpen(arg_6_0)
	if arg_6_0.viewParam.result then
		arg_6_0:refreshWin()
	else
		arg_6_0:refreshLose()
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshWin(arg_8_0)
	gohelper.setActive(arg_8_0._gosuccess, true)
	gohelper.setActive(arg_8_0._gofail, false)
	arg_8_0:refreshTaskConditions()
	gohelper.setActive(arg_8_0._btnquitgame.gameObject, false)
	gohelper.setActive(arg_8_0._btnrestart.gameObject, false)
end

function var_0_0.refreshLose(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(arg_9_0._gosuccess, false)
	gohelper.setActive(arg_9_0._gofail, true)
	arg_9_0:refreshTaskConditions()
end

function var_0_0.refreshTaskConditions(arg_10_0)
	local var_10_0 = Activity109ChessModel.instance:getActId()
	local var_10_1 = Activity109ChessModel.instance:getEpisodeId()

	if not var_10_0 or not var_10_1 then
		return
	end

	local var_10_2 = Activity109Config.instance:getEpisodeCo(var_10_0, var_10_1)
	local var_10_3 = var_10_2.extStarCondition
	local var_10_4 = string.split(var_10_3, "|")
	local var_10_5 = string.split(var_10_2.conditionStr, "|")
	local var_10_6 = #var_10_4 + 1

	for iter_10_0 = 1, var_10_6 do
		local var_10_7 = arg_10_0:getOrCreateTaskItem(iter_10_0)

		if iter_10_0 == 1 then
			arg_10_0:refreshTaskItem(var_10_7, nil, var_10_5[iter_10_0])
		else
			arg_10_0:refreshTaskItem(var_10_7, var_10_4[iter_10_0 - 1], var_10_5[iter_10_0])
		end
	end
end

function var_0_0.refreshTaskItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	gohelper.setActive(arg_11_1.go, true)

	local var_11_0 = Activity109ChessModel.instance:getActId()
	local var_11_1 = Activity109ChessModel.instance:getEpisodeId()
	local var_11_2
	local var_11_3 = false

	if not string.nilorempty(arg_11_2) then
		local var_11_4 = string.splitToNumber(arg_11_2, "#")

		var_11_2 = arg_11_3 or ActivityChessMapUtils.getClearConditionDesc(var_11_4, var_11_0)
		var_11_3 = ActivityChessMapUtils.isClearConditionFinish(var_11_4, var_11_0)
	else
		var_11_2 = arg_11_3 or luaLang("chessgame_clear_normal")
		var_11_3 = ActivityChessGameModel.instance:getResult() == true
	end

	arg_11_1.txtTaskDesc.text = var_11_2

	gohelper.setActive(arg_11_1.goFinish, var_11_3)
	gohelper.setActive(arg_11_1.goUnFinish, not var_11_3)
end

function var_0_0.getOrCreateTaskItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._taskItems[arg_12_1]

	if not var_12_0 then
		var_12_0 = arg_12_0:getUserDataTb_()
		var_12_0.go = gohelper.cloneInPlace(arg_12_0._gotargetitem, "taskitem_" .. tostring(arg_12_1))
		var_12_0.txtTaskDesc = gohelper.findChildText(var_12_0.go, "txt_taskdesc")
		var_12_0.goFinish = gohelper.findChild(var_12_0.go, "result/go_finish")
		var_12_0.goUnFinish = gohelper.findChild(var_12_0.go, "result/go_unfinish")
		arg_12_0._taskItems[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0.handleResetCompleted(arg_13_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.ResetGameByResultView)
end

function var_0_0._btnquitgameOnClick(arg_14_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameResultQuit)

	local var_14_0 = Activity109ChessModel.instance:getActId()

	Activity109Rpc.instance:sendGetAct109InfoRequest(var_14_0)
	arg_14_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_15_0)
	local var_15_0 = Activity109ChessModel.instance:getEpisodeId()

	if var_15_0 then
		Activity109ChessController.instance:startNewEpisode(var_15_0, arg_15_0.handleResetCompleted, arg_15_0)
	end

	arg_15_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_16_0)
	if Time.time - (arg_16_0._openTime or 0) >= 1 then
		arg_16_0:_btnquitgameOnClick()
	end
end

return var_0_0

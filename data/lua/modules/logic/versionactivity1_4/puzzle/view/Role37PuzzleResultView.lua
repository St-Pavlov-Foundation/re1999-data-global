module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultView", package.seeall)

local var_0_0 = class("Role37PuzzleResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_return")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
	arg_2_0._btnreturn:AddClickListener(arg_2_0._btnreturnOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnreturn:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_btnquitgameOnClick()
end

function var_0_0._btnquitgameOnClick(arg_5_0)
	arg_5_0:closeThis()
	ViewMgr.instance:closeView(ViewName.Role37PuzzleView)
end

function var_0_0._btnrestartOnClick(arg_6_0)
	StatActivity130Controller.instance:statStart()
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
	arg_6_0:closeThis()
	Role37PuzzleModel.instance:reset()
end

function var_0_0._btnreturnOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	arg_8_0._taskItems = {}

	NavigateMgr.instance:addEscape(arg_8_0.viewName, arg_8_0._btncloseOnClick, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = Role37PuzzleModel.instance:getResult()
	local var_12_1 = Activity130Model.instance:getCurEpisodeId()
	local var_12_2 = Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, var_12_1)

	if var_12_2 then
		arg_12_0._txtclassnum.text = var_12_2.episodetag
		arg_12_0._txtclassname.text = var_12_2.name

		local var_12_3 = arg_12_0:getOrCreateTaskItem(1)

		var_12_3.txtTaskDesc.text = var_12_2.conditionStr

		gohelper.setActive(var_12_3.goFinish, var_12_0)
		gohelper.setActive(var_12_3.goUnFinish, not var_12_0)
	end

	if var_12_0 then
		arg_12_0:refreshWin()
	else
		arg_12_0:refreshLose()
	end
end

function var_0_0.refreshWin(arg_13_0)
	gohelper.setActive(arg_13_0._gosuccess, true)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_role_cover_open_1)
	gohelper.setActive(arg_13_0._gofail, false)
	gohelper.setActive(arg_13_0._btnquitgame, false)
	gohelper.setActive(arg_13_0._btnrestart, false)
	gohelper.setActive(arg_13_0._btnreturn, false)
end

function var_0_0.refreshLose(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(arg_14_0._gosuccess, false)
	gohelper.setActive(arg_14_0._gofail, true)
	gohelper.setActive(arg_14_0._btnclose, false)
	gohelper.setActive(arg_14_0._btnreturn, false)
end

function var_0_0.getOrCreateTaskItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._taskItems[arg_15_1]

	if not var_15_0 then
		var_15_0 = arg_15_0:getUserDataTb_()
		var_15_0.go = gohelper.cloneInPlace(arg_15_0._gotargetitem, "taskitem_" .. tostring(arg_15_1))
		var_15_0.txtTaskDesc = gohelper.findChildText(var_15_0.go, "txt_taskdesc")
		var_15_0.goFinish = gohelper.findChild(var_15_0.go, "result/go_finish")
		var_15_0.goUnFinish = gohelper.findChild(var_15_0.go, "result/go_unfinish")
		var_15_0.goResult = gohelper.findChild(var_15_0.go, "result")

		gohelper.setActive(var_15_0.go, true)

		arg_15_0._taskItems[arg_15_1] = var_15_0
	end

	return var_15_0
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagebg1:UnLoadImage()
end

return var_0_0

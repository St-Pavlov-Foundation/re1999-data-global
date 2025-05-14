module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaGameResultView", package.seeall)

local var_0_0 = class("JiaLaBoNaGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._gotargetmian = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem0")
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
	arg_4_0:exitGame()
end

function var_0_0._btnquitgameOnClick(arg_5_0)
	arg_5_0:exitGame()
end

function var_0_0.exitGame(arg_6_0)
	local var_6_0 = Va3ChessModel.instance:getEpisodeId()

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)

	if Va3ChessGameModel.instance:getResult() and not JiaLaBoNaController.instance:isEnterBforeClear() then
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.ClearNewEpisode, var_6_0)
	end

	local var_6_1 = Va3ChessModel.instance:getActId()

	Activity120Rpc.instance:sendGetActInfoRequest(var_6_1)
	arg_6_0:closeThis()
end

function var_0_0._onEscape(arg_7_0)
	arg_7_0:exitGame()
end

function var_0_0._btnrestartOnClick(arg_8_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameLoadingMapStateUpdate, Va3ChessEvent.LoadingMapState.Start, true)
	TaskDispatcher.runDelay(var_0_0.resetStartGame, nil, JiaLaBoNaEnum.AnimatorTime.SwithSceneOpen)
	arg_8_0:closeThis()
end

function var_0_0.resetStartGame()
	JiaLaBoNaController.instance:resetStartGame()
end

function var_0_0.returnPointGame()
	JiaLaBoNaController.instance:returnPointGame(true)
end

function var_0_0._btnreturnOnClick(arg_11_0)
	Stat1_3Controller.instance:jiaLaBoNaStatStart()
	Stat1_3Controller.instance:jiaLaBoNaMarkUseRead()
	var_0_0.returnPointGame()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	arg_12_0._simageFailtitle = gohelper.findChildSingleImage(arg_12_0.viewGO, "#go_fail/titlecn")
	arg_12_0._failtitle = gohelper.findChildText(arg_12_0.viewGO, "#go_fail/txt_titlecn")
	arg_12_0._failtitle1 = gohelper.findChildText(arg_12_0.viewGO, "#go_fail/txt_titlecn1")

	gohelper.setActive(arg_12_0._gotargetitem, false)
	gohelper.setActive(arg_12_0._gotargetmian, false)

	arg_12_0._taskItems = {}

	NavigateMgr.instance:addEscape(arg_12_0.viewName, arg_12_0._onEscape, arg_12_0)
end

function var_0_0._onHandleResetCompleted(arg_13_0)
	return
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._isWin = arg_15_0.viewParam.result
	arg_15_0._episodeCfg = arg_15_0:_getEpisodeCfg()

	arg_15_0:refreshUI()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.refreshUI(arg_17_0)
	if arg_17_0._episodeCfg then
		arg_17_0._txtclassname.text = arg_17_0._episodeCfg.name
		arg_17_0._txtclassnum.text = arg_17_0._episodeCfg.orderId

		if arg_17_0._isWin then
			arg_17_0:refreshWin()
		else
			arg_17_0:refreshLose()
		end
	end
end

function var_0_0.refreshWin(arg_18_0)
	gohelper.setActive(arg_18_0._gosuccess, true)
	gohelper.setActive(arg_18_0._gofail, false)
	arg_18_0:refreshTaskConditions()
	gohelper.setActive(arg_18_0._btnquitgame, false)
	gohelper.setActive(arg_18_0._btnrestart, false)
	gohelper.setActive(arg_18_0._btnreturn, false)
end

function var_0_0.refreshLose(arg_19_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(arg_19_0._gosuccess, false)
	gohelper.setActive(arg_19_0._gofail, true)
	gohelper.setActive(arg_19_0._btnclose, false)
	gohelper.setActive(arg_19_0._btnreturn, true)

	local var_19_0 = Va3ChessGameModel.instance:getFailReason()
	local var_19_1 = luaLang(JiaLaBoNaEnum.FailResultLangTxtId[var_19_0] or JiaLaBoNaEnum.FailResultLangTxtId[0])

	arg_19_0._failtitle.text = var_19_1
	arg_19_0._failtitle1.text = var_19_1
end

function var_0_0._getEpisodeCfg(arg_20_0)
	local var_20_0 = Va3ChessModel.instance:getActId()
	local var_20_1 = Va3ChessModel.instance:getEpisodeId()

	if var_20_0 ~= nil and var_20_1 ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(var_20_0, var_20_1)
	end
end

function var_0_0.refreshTaskConditions(arg_21_0)
	local var_21_0 = arg_21_0._episodeCfg

	if not var_21_0 then
		return
	end

	local var_21_1 = Va3ChessModel.instance:getActId()
	local var_21_2 = var_21_0.mainConfition
	local var_21_3 = string.split(var_21_2, "|")
	local var_21_4 = string.split(var_21_0.mainConditionStr, "|")
	local var_21_5 = #var_21_3
	local var_21_6 = string.splitToNumber(var_21_3[var_21_5], "#")
	local var_21_7 = Va3ChessMapUtils.isClearConditionFinish(var_21_6, var_21_1)
	local var_21_8 = arg_21_0:getOrCreateTaskItem(1, arg_21_0._gotargetmian)

	arg_21_0:refreshTaskItem(var_21_8, var_21_4[var_21_5], var_21_7, true)

	if not string.nilorempty(var_21_0.extStarCondition) then
		local var_21_9 = arg_21_0:_checkExtStarConditionFinish(var_21_0.extStarCondition, var_21_1)

		arg_21_0:refreshTaskItem(arg_21_0:getOrCreateTaskItem(2, arg_21_0._gotargetitem), var_21_0.conditionStr, var_21_9, true)
	end
end

function var_0_0._checkExtStarConditionFinish(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = GameUtil.splitString2(arg_22_1, true, "|", "#")

	if var_22_0 then
		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			if not Va3ChessMapUtils.isClearConditionFinish(iter_22_1, arg_22_2) then
				return false
			end
		end
	end

	return true
end

function var_0_0.refreshTaskItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	gohelper.setActive(arg_23_1.go, true)

	arg_23_1.txtTaskDesc.text = arg_23_2

	gohelper.setActive(arg_23_1.goResult, arg_23_4)

	if arg_23_4 then
		gohelper.setActive(arg_23_1.goFinish, arg_23_3)
		gohelper.setActive(arg_23_1.goUnFinish, not arg_23_3)
	end
end

function var_0_0.getOrCreateTaskItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0._taskItems[arg_24_1]

	if not var_24_0 then
		var_24_0 = arg_24_0:getUserDataTb_()
		var_24_0.go = arg_24_2
		var_24_0.txtTaskDesc = gohelper.findChildText(var_24_0.go, "txt_taskdesc")
		var_24_0.goFinish = gohelper.findChild(var_24_0.go, "result/go_finish")
		var_24_0.goUnFinish = gohelper.findChild(var_24_0.go, "result/go_unfinish")
		var_24_0.goResult = gohelper.findChild(var_24_0.go, "result")
		arg_24_0._taskItems[arg_24_1] = var_24_0
	end

	return var_24_0
end

function var_0_0.onDestroyView(arg_25_0)
	arg_25_0._simagebg1:UnLoadImage()
	arg_25_0._simageFailtitle:UnLoadImage()
	NavigateMgr.instance:removeEscape(arg_25_0.viewName, arg_25_0._onEscape, arg_25_0)
end

return var_0_0

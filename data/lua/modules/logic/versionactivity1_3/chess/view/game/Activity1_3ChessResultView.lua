module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultView", package.seeall)

local var_0_0 = class("Activity1_3ChessResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._txtclassnameen = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname/#txt_classnameen")
	arg_1_0._goMainTargetItem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem0")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")
	arg_1_0._btnreturn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_return")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

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
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreturn:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_btnquitgameOnClick()
end

function var_0_0._onEscape(arg_5_0)
	arg_5_0:_btnquitgameOnClick()
end

function var_0_0._btnquitgameOnClick(arg_6_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)

	local var_6_0 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessGameModel.instance:getResult() and not Activity1_3ChessController.instance:isEnterPassedEpisode() then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.FinishNewEpisode, var_6_0)
	end

	local var_6_1 = Va3ChessModel.instance:getActId()

	Activity122Rpc.instance:sendGetActInfoRequest(var_6_1)
	arg_6_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_7_0)
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickReset)
	arg_7_0:closeThis()
end

function var_0_0._btnreturnOnClick(arg_8_0)
	Stat1_3Controller.instance:bristleStatStart()
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickRead)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	gohelper.setActive(arg_9_0._gotargetitem, false)
	gohelper.setActive(arg_9_0._goMainTargetItem, false)

	arg_9_0._taskItems = {}

	NavigateMgr.instance:addEscape(arg_9_0.viewName, arg_9_0._onEscape, arg_9_0)
end

function var_0_0._onHandleResetCompleted(arg_10_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ResetGameByResultView)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._isWin = arg_12_0.viewParam.result
	arg_12_0._episodeCfg = arg_12_0:_getEpisodeCfg()

	arg_12_0:refreshUI()
end

function var_0_0.refreshUI(arg_13_0)
	if arg_13_0._episodeCfg then
		arg_13_0._txtclassname.text = arg_13_0._episodeCfg.name
		arg_13_0._txtclassnum.text = arg_13_0._episodeCfg.orderId

		if arg_13_0._isWin then
			arg_13_0:refreshWin()
		else
			arg_13_0:refreshLose()
		end
	end
end

function var_0_0.refreshWin(arg_14_0)
	gohelper.setActive(arg_14_0._gosuccess, true)
	gohelper.setActive(arg_14_0._gofail, false)
	arg_14_0:refreshTaskConditions()
	gohelper.setActive(arg_14_0._btnquitgame.gameObject, false)
	gohelper.setActive(arg_14_0._btnrestart.gameObject, false)
	gohelper.setActive(arg_14_0._btnreturn.gameObject, false)
end

function var_0_0.refreshLose(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(arg_15_0._gosuccess, false)
	gohelper.setActive(arg_15_0._gofail, true)
	gohelper.setActive(arg_15_0._btnclose, false)
end

function var_0_0._getEpisodeCfg(arg_16_0)
	local var_16_0 = Va3ChessModel.instance:getActId()
	local var_16_1 = Va3ChessModel.instance:getEpisodeId()

	if var_16_0 ~= nil and var_16_1 ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(var_16_0, var_16_1)
	end
end

function var_0_0.refreshTaskConditions(arg_17_0)
	local var_17_0 = arg_17_0._episodeCfg

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.starCondition
	local var_17_2 = string.split(var_17_1, "|")
	local var_17_3 = string.split(var_17_0.conditionStr, "|")
	local var_17_4 = #var_17_2
	local var_17_5 = arg_17_0:getOrCreateTaskItem(var_17_4, true)

	arg_17_0:refreshTaskItem(var_17_5, var_17_2[var_17_4], var_17_3[var_17_4], true, true)

	if not string.nilorempty(var_17_0.extStarCondition) then
		arg_17_0:refreshTaskItem(arg_17_0:getOrCreateTaskItem(var_17_4 + 1), var_17_0.extStarCondition, var_17_0.extConditionStr, true)
	end
end

function var_0_0.refreshTaskItem(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5)
	gohelper.setActive(arg_18_1.go, true)

	local var_18_0 = Va3ChessModel.instance:getActId()
	local var_18_1 = Va3ChessModel.instance:getEpisodeId()
	local var_18_2
	local var_18_3 = false
	local var_18_4 = string.split(arg_18_2, "|")

	if #var_18_4 > 1 then
		local var_18_5 = 0

		for iter_18_0 = 1, #var_18_4 do
			local var_18_6 = string.splitToNumber(var_18_4[iter_18_0], "#")

			var_18_3 = Va3ChessMapUtils.isClearConditionFinish(var_18_6, var_18_0)

			if var_18_3 then
				var_18_5 = var_18_5 + 1
			end

			var_18_3 = var_18_5 == #var_18_4
		end

		var_18_2 = string.format("%s (%s/%s)", arg_18_3, var_18_5, #var_18_4)
	elseif not string.nilorempty(arg_18_2) then
		local var_18_7 = string.splitToNumber(arg_18_2, "#")

		var_18_2 = arg_18_3 or Va3ChessMapUtils.getClearConditionDesc(var_18_7, var_18_0)
		var_18_3 = Va3ChessMapUtils.isClearConditionFinish(var_18_7, var_18_0)
	else
		var_18_2 = arg_18_3 or luaLang("chessgame_clear_normal")
		var_18_3 = Va3ChessGameModel.instance:getResult() == true
	end

	arg_18_1.txtTaskDesc.text = var_18_2

	gohelper.setActive(arg_18_1.goResult, arg_18_4)

	if arg_18_4 then
		if arg_18_5 then
			var_18_3 = true
		end

		gohelper.setActive(arg_18_1.goFinish, var_18_3)
		gohelper.setActive(arg_18_1.goUnFinish, not var_18_3)
	end
end

function var_0_0.getOrCreateTaskItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._taskItems[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.go = gohelper.cloneInPlace(arg_19_2 and arg_19_0._goMainTargetItem or arg_19_0._gotargetitem, "taskitem_" .. tostring(arg_19_1))
		var_19_0.txtTaskDesc = gohelper.findChildText(var_19_0.go, "txt_taskdesc")
		var_19_0.goFinish = gohelper.findChild(var_19_0.go, "result/go_finish")
		var_19_0.goUnFinish = gohelper.findChild(var_19_0.go, "result/go_unfinish")
		var_19_0.goResult = gohelper.findChild(var_19_0.go, "result")
		arg_19_0._taskItems[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg1:UnLoadImage()
	NavigateMgr.instance:removeEscape(arg_21_0.viewName, arg_21_0._onEscape, arg_21_0)
end

return var_0_0

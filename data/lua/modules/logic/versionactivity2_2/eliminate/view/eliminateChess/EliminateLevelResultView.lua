module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelResultView", package.seeall)

local var_0_0 = class("EliminateLevelResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtclassnum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtclassname = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._gotargets = gohelper.findChild(arg_1_0.viewGO, "#go_targets")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "#go_targets/#go_targetitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")
	arg_1_0._enText1 = gohelper.findChild(arg_1_0.viewGO, "btn/#btn_quitgame/txt/txten")
	arg_1_0._enText2 = gohelper.findChild(arg_1_0.viewGO, "btn/#btn_restart/txt/txten")
	arg_1_0._enText3 = gohelper.findChild(arg_1_0.viewGO, "#go_success/titleen")
	arg_1_0._enText4 = gohelper.findChild(arg_1_0.viewGO, "#go_fail/titleen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	EliminateLevelController.instance:closeLevel()
end

function var_0_0._btnquitgameOnClick(arg_5_0)
	EliminateLevelController.instance:closeLevel()
end

function var_0_0._btnrestartOnClick(arg_6_0)
	EliminateTeamSelectionModel.instance:setRestart(true)
	EliminateLevelController.instance:closeLevel()
end

function var_0_0._editableInitView(arg_7_0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
	gohelper.setActive(arg_7_0._enText1, LangSettings.instance:isZh())
	gohelper.setActive(arg_7_0._enText2, LangSettings.instance:isZh())
	gohelper.setActive(arg_7_0._enText3, LangSettings.instance:isZh())
	gohelper.setActive(arg_7_0._enText4, LangSettings.instance:isZh())
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._resultData = EliminateTeamChessModel.instance:getWarFightResult()
	arg_9_0._isWin = arg_9_0._resultData.resultCode == EliminateTeamChessEnum.FightResult.win
	arg_9_0._isLose = arg_9_0._resultData.resultCode == EliminateTeamChessEnum.FightResult.lose

	gohelper.setActive(arg_9_0._gosuccess, arg_9_0._isWin)
	gohelper.setActive(arg_9_0._gofail, arg_9_0._isLose)
	gohelper.setActive(arg_9_0._gotargets, arg_9_0._isWin)
	gohelper.setActive(arg_9_0._btnclose, arg_9_0._isWin)
	gohelper.setActive(arg_9_0._btnquitgame, arg_9_0._isLose)
	gohelper.setActive(arg_9_0._btnrestart, arg_9_0._isLose)

	if arg_9_0._isWin then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_endpoint_arrival)
		arg_9_0:refreshWinInfo()
	end

	if arg_9_0._isLose then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_challenge_fail)
		arg_9_0:refreshLoseInfo()
	end

	EliminateLevelModel.instance:sendStatData(arg_9_0._isWin and EliminateLevelEnum.resultStatUse.win or EliminateLevelEnum.resultStatUse.lose)
	arg_9_0:refreshBaseInfo()
end

function var_0_0.refreshBaseInfo(arg_10_0)
	local var_10_0 = EliminateLevelModel.instance:getLevelId()
	local var_10_1 = EliminateConfig.instance:getEliminateEpisodeConfig(var_10_0)

	arg_10_0._txtclassname.text = var_10_1 and var_10_1.name or ""

	local var_10_2 = var_10_1.chapterId
	local var_10_3 = arg_10_0:getLevelIndex(var_10_2, var_10_0)

	arg_10_0._txtclassnum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", var_10_2, var_10_3)
end

function var_0_0.getLevelIndex(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_eliminate_episode.configList) do
		if iter_11_1.chapterId == arg_11_1 then
			table.insert(var_11_0, iter_11_1.id)

			if iter_11_1.id == arg_11_2 then
				return #var_11_0
			end
		end
	end

	return 1
end

function var_0_0.refreshWinInfo(arg_12_0)
	local var_12_0 = arg_12_0._resultData:getStar()
	local var_12_1 = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

	arg_12_0._taskItem = arg_12_0:getUserDataTb_()

	if not string.nilorempty(var_12_1.winCondition) then
		local var_12_2 = gohelper.clone(arg_12_0._gotargetitem, arg_12_0._gotargets.gameObject, "taskItem")
		local var_12_3 = gohelper.findChildText(var_12_2, "txt_taskdesc")
		local var_12_4 = gohelper.findChild(var_12_2, "result/go_finish")
		local var_12_5 = gohelper.findChild(var_12_2, "result/go_unfinish")

		var_12_3.text = EliminateLevelModel.instance.formatString(var_12_1.winConditionDesc)

		local var_12_6 = var_12_0 >= 1

		gohelper.setActive(var_12_4, var_12_6)
		gohelper.setActive(var_12_5, not var_12_6)
		gohelper.setActive(var_12_2, true)
		table.insert(arg_12_0._taskItem, var_12_2)
	end

	if not string.nilorempty(var_12_1.extraWinCondition) then
		local var_12_7 = gohelper.clone(arg_12_0._gotargetitem, arg_12_0._gotargets.gameObject, "taskItem")
		local var_12_8 = gohelper.findChildText(var_12_7, "txt_taskdesc")
		local var_12_9 = gohelper.findChild(var_12_7, "result/go_finish")
		local var_12_10 = gohelper.findChild(var_12_7, "result/go_unfinish")

		var_12_8.text = EliminateLevelModel.instance.formatString(var_12_1.extraWinConditionDesc)

		local var_12_11 = var_12_0 >= 2

		gohelper.setActive(var_12_9, var_12_11)
		gohelper.setActive(var_12_10, not var_12_11)
		gohelper.setActive(var_12_7, true)
		table.insert(arg_12_0._taskItem, var_12_7)
	end
end

function var_0_0.refreshLoseInfo(arg_13_0)
	return
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

return var_0_0

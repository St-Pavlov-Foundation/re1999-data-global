module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameResultView", package.seeall)

local var_0_0 = class("YaXianGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simageSuccTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_success/#simage_title")
	arg_1_0._simageFailTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_fail/#simage_title")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._gotargetitem = gohelper.findChild(arg_1_0.viewGO, "targets/#go_targetitem")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btn/#btn_restart")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0._btnquitgameOnClick, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._btnrestartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0.btnCloseOnClick(arg_4_0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	arg_4_0:closeThis()
end

function var_0_0._btnquitgameOnClick(arg_5_0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	arg_5_0:closeThis()
end

function var_0_0._btnrestartOnClick(arg_6_0)
	YaXianGameController.instance:enterChessGame(arg_6_0.episodeConfig.id)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	arg_7_0._simageSuccTitleTxt = gohelper.findChildText(arg_7_0.viewGO, "#go_success/#simage_title/txt")
	arg_7_0._simageFailTitleTxt = gohelper.findChildText(arg_7_0.viewGO, "#go_fail/#simage_title/txt")
	arg_7_0.txtEpisodeIndex = gohelper.findChildText(arg_7_0.viewGO, "txtFbName/#txt_classnum")
	arg_7_0.txtEpisodeName = gohelper.findChildText(arg_7_0.viewGO, "txtFbName/#txt_classname")
	arg_7_0._btnclose = gohelper.findChildClick(arg_7_0.viewGO, "#btn_close")

	arg_7_0._btnclose:AddClickListener(arg_7_0.btnCloseOnClick, arg_7_0)
	gohelper.setActive(arg_7_0._gotargetitem, false)
	NavigateMgr.instance:addEscape(arg_7_0.viewName, arg_7_0.btnCloseOnClick, arg_7_0)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.initData(arg_9_0)
	arg_9_0.isWin = arg_9_0.viewParam.result
	arg_9_0.episodeConfig = arg_9_0.viewParam.episodeConfig
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:initData()
	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	gohelper.setActive(arg_11_0._gosuccess, arg_11_0.isWin)
	gohelper.setActive(arg_11_0._gofail, not arg_11_0.isWin)
	arg_11_0:showBtn(not arg_11_0.isWin)

	if arg_11_0.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		arg_11_0._simageSuccTitleTxt.text = luaLang("p_versionactivity1_2dungeonview_1")
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)

		local var_11_0 = YaXianGameController.instance:getPlayerInteractItem()

		if var_11_0 and var_11_0:isDelete() then
			arg_11_0._simageFailTitleTxt.text = luaLang("p_fightfailview_fightfail")
		elseif YaXianGameModel.instance:isRoundUseUp() then
			arg_11_0._simageFailTitleTxt.text = luaLang("p_versionactivity1_2dungeonview_2")
		else
			arg_11_0._simageFailTitleTxt.text = luaLang("p_fightfailview_fightfail")
		end
	end

	arg_11_0:refreshEpisodeInfo()
	arg_11_0:refreshConditions()
end

function var_0_0.showBtn(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._btnquitgame.gameObject, arg_12_1)
	gohelper.setActive(arg_12_0._btnrestart.gameObject, arg_12_1)
	gohelper.setActive(arg_12_0._btnclose.gameObject, not arg_12_1)
end

function var_0_0.refreshEpisodeInfo(arg_13_0)
	arg_13_0.txtEpisodeIndex.text = arg_13_0.episodeConfig.index
	arg_13_0.txtEpisodeName.text = arg_13_0.episodeConfig.name
end

function var_0_0.refreshConditions(arg_14_0)
	local var_14_0 = YaXianConfig.instance:getConditionList(arg_14_0.episodeConfig)
	local var_14_1 = string.split(arg_14_0.episodeConfig.conditionStr, "|")

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_2 = arg_14_0:createConditionItem()

		gohelper.setActive(var_14_2.go, true)

		local var_14_3 = YaXianGameModel.instance:checkFinishCondition(iter_14_1[1], iter_14_1[2])

		gohelper.setActive(var_14_2.goFinish, var_14_3)
		gohelper.setActive(var_14_2.goUnFinish, not var_14_3)

		var_14_2.txtDesc.text = var_14_1[iter_14_0]
	end
end

function var_0_0.createConditionItem(arg_15_0)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = gohelper.cloneInPlace(arg_15_0._gotargetitem)
	var_15_0.txtDesc = gohelper.findChildText(var_15_0.go, "txt_taskdesc")
	var_15_0.goFinish = gohelper.findChild(var_15_0.go, "result/go_finish")
	var_15_0.goUnFinish = gohelper.findChild(var_15_0.go, "result/go_unfinish")

	return var_15_0
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg1:UnLoadImage()
	arg_17_0._btnclose:RemoveClickListener()
end

return var_0_0

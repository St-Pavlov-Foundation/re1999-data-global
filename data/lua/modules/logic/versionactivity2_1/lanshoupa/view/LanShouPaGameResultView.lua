module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaGameResultView", package.seeall)

slot0 = class("LanShouPaGameResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "targets")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._gobtn = gohelper.findChild(slot0.viewGO, "btn")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_return")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnreturn:AddClickListener(slot0._btnreturnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnreturn:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:exitGame()
end

function slot0._btnquitgameOnClick(slot0)
	slot0:exitGame()
end

function slot0.exitGame(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameResultQuit)

	if ChessGameModel.instance:getGameState() == ChessGameEnum.GameState.Win then
		ChessGameController.instance:exitGame()
		Activity164Model.instance:markEpisodeFinish(slot0._episodeCfg.id)
	end

	Activity164Model.instance.currChessGameEpisodeId = 0

	slot0:closeThis()
end

function slot0._onEscape(slot0)
	slot0:exitGame()
end

function slot0._btnrestartOnClick(slot0)
	TaskDispatcher.runDelay(uv0.resetStartGame, nil, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
	slot0:closeThis()
end

function slot0.resetStartGame(slot0)
	LanShouPaController.instance:resetStartGame()
end

function slot0.returnPointGame(slot0)
	LanShouPaController.instance:returnPointGame(ChessGameEnum.RollBack.CheckPoint)
end

function slot0._btnreturnOnClick(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.GameLoadingMapStateUpdate, ChessGameEvent.LoadingMapState.Start, true)
	TaskDispatcher.runDelay(uv0.returnPointGame, nil, LanShouPaEnum.AnimatorTime.SwithSceneOpen)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	slot0._simageFailtitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_fail/titlecn")

	gohelper.setActive(slot0._gotargetitem, false)

	slot0._taskItems = {}

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscape, slot0)
end

function slot0._onHandleResetCompleted(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isWin = slot0.viewParam
	slot0._episodeCfg = slot0:_getEpisodeCfg()

	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	if slot0._episodeCfg then
		slot0._txtclassname.text = slot0._episodeCfg.name
		slot0._txtclassnum.text = "STAGE " .. Activity164Config.instance:getEpisodeIndex(ChessModel.instance:getActId(), ChessModel.instance:getEpisodeId())

		gohelper.setActive(slot0._gotarget, slot0._isWin)
		recthelper.setAnchorY(slot0._gobtn.transform, slot0._isWin and -400 or -200)

		if slot0._isWin then
			slot0:refreshWin()
		else
			slot0:refreshLose()
		end
	end
end

function slot0.refreshWin(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)
	gohelper.setActive(slot0._gosuccess, true)
	gohelper.setActive(slot0._gofail, false)
	slot0:refreshTaskConditions()
	gohelper.setActive(slot0._btnquitgame, false)
	gohelper.setActive(slot0._btnrestart, false)
	gohelper.setActive(slot0._btnreturn, false)
end

function slot0.refreshLose(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._gofail, true)
	gohelper.setActive(slot0._btnclose, false)
	gohelper.setActive(slot0._btnreturn, true)
	slot0:refreshTaskConditions()
end

function slot0._getEpisodeCfg(slot0)
	slot2 = ChessModel.instance:getEpisodeId()

	if ChessModel.instance:getActId() ~= nil and slot2 ~= nil then
		return ChessConfig.instance:getEpisodeCo(slot1, slot2)
	end
end

function slot0.refreshTaskConditions(slot0)
	if not slot0._episodeCfg then
		return
	end

	slot0:refreshTaskItem(slot0:getOrCreateTaskItem(1, slot0._gotargetitem), string.split(slot1.mainConditionStr, "|")[#string.split(slot1.mainConditionStr, "|")], true, true)
end

function slot0._checkExtStarConditionFinish(slot0, slot1, slot2)
	if GameUtil.splitString2(slot1, true, "|", "#") then
		for slot7, slot8 in ipairs(slot3) do
			if not ChessGameHelper.isClearConditionFinish(slot8, slot2) then
				return false
			end
		end
	end

	return true
end

function slot0.refreshTaskItem(slot0, slot1, slot2, slot3, slot4)
	gohelper.setActive(slot1.go, true)

	slot1.txtTaskDesc.text = slot2

	gohelper.setActive(slot1.goResult, slot4)

	if slot4 then
		gohelper.setActive(slot1.goFinish, slot3)
		gohelper.setActive(slot1.goUnFinish, not slot3)
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1, slot2)
	if not slot0._taskItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = slot2
		slot3.txtTaskDesc = gohelper.findChildText(slot3.go, "txt_taskdesc")
		slot3.goFinish = gohelper.findChild(slot3.go, "result/go_finish")
		slot3.goUnFinish = gohelper.findChild(slot3.go, "result/go_unfinish")
		slot3.goResult = gohelper.findChild(slot3.go, "result")
		slot0._taskItems[slot1] = slot3
	end

	return slot3
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simageFailtitle:UnLoadImage()
	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onEscape, slot0)
end

return slot0

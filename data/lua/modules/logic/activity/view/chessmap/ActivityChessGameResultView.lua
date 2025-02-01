module("modules.logic.activity.view.chessmap.ActivityChessGameResultView", package.seeall)

slot0 = class("ActivityChessGameResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._gotargets = gohelper.findChild(slot0.viewGO, "#go_targets")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "#go_targets/#go_targetitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_success/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	slot0._openTime = Time.time
	slot0._taskItems = {}
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
end

function slot0.onOpen(slot0)
	if slot0.viewParam.result then
		slot0:refreshWin()
	else
		slot0:refreshLose()
	end
end

function slot0.onClose(slot0)
end

function slot0.refreshWin(slot0)
	gohelper.setActive(slot0._gosuccess, true)
	gohelper.setActive(slot0._gofail, false)
	slot0:refreshTaskConditions()
	gohelper.setActive(slot0._btnquitgame.gameObject, false)
	gohelper.setActive(slot0._btnrestart.gameObject, false)
end

function slot0.refreshLose(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._gofail, true)
	slot0:refreshTaskConditions()
end

function slot0.refreshTaskConditions(slot0)
	slot2 = Activity109ChessModel.instance:getEpisodeId()

	if not Activity109ChessModel.instance:getActId() or not slot2 then
		return
	end

	slot3 = Activity109Config.instance:getEpisodeCo(slot1, slot2)

	for slot11 = 1, #string.split(slot3.extStarCondition, "|") + 1 do
		if slot11 == 1 then
			slot0:refreshTaskItem(slot0:getOrCreateTaskItem(slot11), nil, string.split(slot3.conditionStr, "|")[slot11])
		else
			slot0:refreshTaskItem(slot12, slot5[slot11 - 1], slot6[slot11])
		end
	end
end

function slot0.refreshTaskItem(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot4 = Activity109ChessModel.instance:getActId()
	slot5 = Activity109ChessModel.instance:getEpisodeId()
	slot6 = nil
	slot7 = false

	if not string.nilorempty(slot2) then
		slot8 = string.splitToNumber(slot2, "#")
		slot6 = slot3 or ActivityChessMapUtils.getClearConditionDesc(slot8, slot4)
		slot7 = ActivityChessMapUtils.isClearConditionFinish(slot8, slot4)
	else
		slot6 = slot3 or luaLang("chessgame_clear_normal")
		slot7 = ActivityChessGameModel.instance:getResult() == true
	end

	slot1.txtTaskDesc.text = slot6

	gohelper.setActive(slot1.goFinish, slot7)
	gohelper.setActive(slot1.goUnFinish, not slot7)
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gotargetitem, "taskitem_" .. tostring(slot1))
		slot2.txtTaskDesc = gohelper.findChildText(slot2.go, "txt_taskdesc")
		slot2.goFinish = gohelper.findChild(slot2.go, "result/go_finish")
		slot2.goUnFinish = gohelper.findChild(slot2.go, "result/go_unfinish")
		slot0._taskItems[slot1] = slot2
	end

	return slot2
end

function slot0.handleResetCompleted(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.ResetGameByResultView)
end

function slot0._btnquitgameOnClick(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.GameResultQuit)
	Activity109Rpc.instance:sendGetAct109InfoRequest(Activity109ChessModel.instance:getActId())
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	if Activity109ChessModel.instance:getEpisodeId() then
		Activity109ChessController.instance:startNewEpisode(slot1, slot0.handleResetCompleted, slot0)
	end

	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	if Time.time - (slot0._openTime or 0) >= 1 then
		slot0:_btnquitgameOnClick()
	end
end

return slot0

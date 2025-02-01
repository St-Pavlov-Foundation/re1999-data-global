module("modules.logic.versionactivity1_3.chess.view.game.Activity1_3ChessResultView", package.seeall)

slot0 = class("Activity1_3ChessResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._txtclassnameen = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname/#txt_classnameen")
	slot0._goMainTargetItem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem0")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")
	slot0._btnreturn = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_return")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

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
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnreturn:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:_btnquitgameOnClick()
end

function slot0._onEscape(slot0)
	slot0:_btnquitgameOnClick()
end

function slot0._btnquitgameOnClick(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)

	if Va3ChessGameModel.instance:getResult() and not Activity1_3ChessController.instance:isEnterPassedEpisode() then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.FinishNewEpisode, Va3ChessModel.instance:getEpisodeId())
	end

	Activity122Rpc.instance:sendGetActInfoRequest(Va3ChessModel.instance:getActId())
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickReset)
	slot0:closeThis()
end

function slot0._btnreturnOnClick(slot0)
	Stat1_3Controller.instance:bristleStatStart()
	Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickRead)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	gohelper.setActive(slot0._gotargetitem, false)
	gohelper.setActive(slot0._goMainTargetItem, false)

	slot0._taskItems = {}

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscape, slot0)
end

function slot0._onHandleResetCompleted(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ResetGameByResultView)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._isWin = slot0.viewParam.result
	slot0._episodeCfg = slot0:_getEpisodeCfg()

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if slot0._episodeCfg then
		slot0._txtclassname.text = slot0._episodeCfg.name
		slot0._txtclassnum.text = slot0._episodeCfg.orderId

		if slot0._isWin then
			slot0:refreshWin()
		else
			slot0:refreshLose()
		end
	end
end

function slot0.refreshWin(slot0)
	gohelper.setActive(slot0._gosuccess, true)
	gohelper.setActive(slot0._gofail, false)
	slot0:refreshTaskConditions()
	gohelper.setActive(slot0._btnquitgame.gameObject, false)
	gohelper.setActive(slot0._btnrestart.gameObject, false)
	gohelper.setActive(slot0._btnreturn.gameObject, false)
end

function slot0.refreshLose(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._gofail, true)
	gohelper.setActive(slot0._btnclose, false)
end

function slot0._getEpisodeCfg(slot0)
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() ~= nil and slot2 ~= nil then
		return Va3ChessConfig.instance:getEpisodeCo(slot1, slot2)
	end
end

function slot0.refreshTaskConditions(slot0)
	if not slot0._episodeCfg then
		return
	end

	slot3 = string.split(slot1.starCondition, "|")
	slot5 = #slot3

	slot0:refreshTaskItem(slot0:getOrCreateTaskItem(slot5, true), slot3[slot5], string.split(slot1.conditionStr, "|")[slot5], true, true)

	if not string.nilorempty(slot1.extStarCondition) then
		slot0:refreshTaskItem(slot0:getOrCreateTaskItem(slot5 + 1), slot1.extStarCondition, slot1.extConditionStr, true)
	end
end

function slot0.refreshTaskItem(slot0, slot1, slot2, slot3, slot4, slot5)
	gohelper.setActive(slot1.go, true)

	slot6 = Va3ChessModel.instance:getActId()
	slot7 = Va3ChessModel.instance:getEpisodeId()
	slot8 = nil
	slot9 = false

	if #string.split(slot2, "|") > 1 then
		for slot15 = 1, #slot10 do
			if Va3ChessMapUtils.isClearConditionFinish(string.splitToNumber(slot10[slot15], "#"), slot6) then
				slot11 = 0 + 1
			end

			slot9 = slot11 == #slot10
		end

		slot8 = string.format("%s (%s/%s)", slot3, slot11, #slot10)
	elseif not string.nilorempty(slot2) then
		slot11 = string.splitToNumber(slot2, "#")
		slot8 = slot3 or Va3ChessMapUtils.getClearConditionDesc(slot11, slot6)
		slot9 = Va3ChessMapUtils.isClearConditionFinish(slot11, slot6)
	else
		slot8 = slot3 or luaLang("chessgame_clear_normal")
		slot9 = Va3ChessGameModel.instance:getResult() == true
	end

	slot1.txtTaskDesc.text = slot8

	gohelper.setActive(slot1.goResult, slot4)

	if slot4 then
		if slot5 then
			slot9 = true
		end

		gohelper.setActive(slot1.goFinish, slot9)
		gohelper.setActive(slot1.goUnFinish, not slot9)
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1, slot2)
	if not slot0._taskItems[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.cloneInPlace(slot2 and slot0._goMainTargetItem or slot0._gotargetitem, "taskitem_" .. tostring(slot1))
		slot3.txtTaskDesc = gohelper.findChildText(slot3.go, "txt_taskdesc")
		slot3.goFinish = gohelper.findChild(slot3.go, "result/go_finish")
		slot3.goUnFinish = gohelper.findChild(slot3.go, "result/go_unfinish")
		slot3.goResult = gohelper.findChild(slot3.go, "result")
		slot0._taskItems[slot1] = slot3
	end

	return slot3
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onEscape, slot0)
end

return slot0

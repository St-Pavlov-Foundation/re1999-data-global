module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultView", package.seeall)

slot0 = class("Role37PuzzleResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
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
	slot0:_btnquitgameOnClick()
end

function slot0._btnquitgameOnClick(slot0)
	slot0:closeThis()
	ViewMgr.instance:closeView(ViewName.Role37PuzzleView)
end

function slot0._btnrestartOnClick(slot0)
	StatActivity130Controller.instance:statStart()
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
	slot0:closeThis()
	Role37PuzzleModel.instance:reset()
end

function slot0._btnreturnOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	slot0._taskItems = {}

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = Role37PuzzleModel.instance:getResult()

	if Activity130Config.instance:getActivity130EpisodeCo(Activity130Enum.ActivityId.Act130, Activity130Model.instance:getCurEpisodeId()) then
		slot0._txtclassnum.text = slot3.episodetag
		slot0._txtclassname.text = slot3.name
		slot4 = slot0:getOrCreateTaskItem(1)
		slot4.txtTaskDesc.text = slot3.conditionStr

		gohelper.setActive(slot4.goFinish, slot1)
		gohelper.setActive(slot4.goUnFinish, not slot1)
	end

	if slot1 then
		slot0:refreshWin()
	else
		slot0:refreshLose()
	end
end

function slot0.refreshWin(slot0)
	gohelper.setActive(slot0._gosuccess, true)
	AudioEffectMgr.instance:playAudio(AudioEnum.UI.play_ui_role_cover_open_1)
	gohelper.setActive(slot0._gofail, false)
	gohelper.setActive(slot0._btnquitgame, false)
	gohelper.setActive(slot0._btnrestart, false)
	gohelper.setActive(slot0._btnreturn, false)
end

function slot0.refreshLose(slot0)
	AudioMgr.instance:trigger(AudioEnum.ChessGame.ChallengeFailed)
	gohelper.setActive(slot0._gosuccess, false)
	gohelper.setActive(slot0._gofail, true)
	gohelper.setActive(slot0._btnclose, false)
	gohelper.setActive(slot0._btnreturn, false)
end

function slot0.getOrCreateTaskItem(slot0, slot1)
	if not slot0._taskItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gotargetitem, "taskitem_" .. tostring(slot1))
		slot2.txtTaskDesc = gohelper.findChildText(slot2.go, "txt_taskdesc")
		slot2.goFinish = gohelper.findChild(slot2.go, "result/go_finish")
		slot2.goUnFinish = gohelper.findChild(slot2.go, "result/go_unfinish")
		slot2.goResult = gohelper.findChild(slot2.go, "result")

		gohelper.setActive(slot2.go, true)

		slot0._taskItems[slot1] = slot2
	end

	return slot2
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
end

return slot0

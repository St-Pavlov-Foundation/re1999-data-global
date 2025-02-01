module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelResultView", package.seeall)

slot0 = class("EliminateLevelResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._gotargets = gohelper.findChild(slot0.viewGO, "#go_targets")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "#go_targets/#go_targetitem")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")
	slot0._enText1 = gohelper.findChild(slot0.viewGO, "btn/#btn_quitgame/txt/txten")
	slot0._enText2 = gohelper.findChild(slot0.viewGO, "btn/#btn_restart/txt/txten")
	slot0._enText3 = gohelper.findChild(slot0.viewGO, "#go_success/titleen")
	slot0._enText4 = gohelper.findChild(slot0.viewGO, "#go_fail/titleen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	EliminateLevelController.instance:closeLevel()
end

function slot0._btnquitgameOnClick(slot0)
	EliminateLevelController.instance:closeLevel()
end

function slot0._btnrestartOnClick(slot0)
	EliminateTeamSelectionModel.instance:setRestart(true)
	EliminateLevelController.instance:closeLevel()
end

function slot0._editableInitView(slot0)
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
	gohelper.setActive(slot0._enText1, LangSettings.instance:isZh())
	gohelper.setActive(slot0._enText2, LangSettings.instance:isZh())
	gohelper.setActive(slot0._enText3, LangSettings.instance:isZh())
	gohelper.setActive(slot0._enText4, LangSettings.instance:isZh())
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._resultData = EliminateTeamChessModel.instance:getWarFightResult()
	slot0._isWin = slot0._resultData.resultCode == EliminateTeamChessEnum.FightResult.win
	slot0._isLose = slot0._resultData.resultCode == EliminateTeamChessEnum.FightResult.lose

	gohelper.setActive(slot0._gosuccess, slot0._isWin)
	gohelper.setActive(slot0._gofail, slot0._isLose)
	gohelper.setActive(slot0._gotargets, slot0._isWin)
	gohelper.setActive(slot0._btnclose, slot0._isWin)
	gohelper.setActive(slot0._btnquitgame, slot0._isLose)
	gohelper.setActive(slot0._btnrestart, slot0._isLose)

	if slot0._isWin then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_endpoint_arrival)
		slot0:refreshWinInfo()
	end

	if slot0._isLose then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_pkls_challenge_fail)
		slot0:refreshLoseInfo()
	end

	EliminateLevelModel.instance:sendStatData(slot0._isWin and EliminateLevelEnum.resultStatUse.win or EliminateLevelEnum.resultStatUse.lose)
	slot0:refreshBaseInfo()
end

function slot0.refreshBaseInfo(slot0)
	slot0._txtclassname.text = EliminateConfig.instance:getEliminateEpisodeConfig(EliminateLevelModel.instance:getLevelId()) and slot2.name or ""
	slot3 = slot2.chapterId
	slot0._txtclassnum.text = string.format("STAGE <color=#FFC67C>%s-%s</color>", slot3, slot0:getLevelIndex(slot3, slot1))
end

function slot0.getLevelIndex(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(lua_eliminate_episode.configList) do
		if slot8.chapterId == slot1 then
			table.insert(slot3, slot8.id)

			if slot8.id == slot2 then
				return #slot3
			end
		end
	end

	return 1
end

function slot0.refreshWinInfo(slot0)
	slot0._taskItem = slot0:getUserDataTb_()

	if not string.nilorempty(EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig().winCondition) then
		slot3 = gohelper.clone(slot0._gotargetitem, slot0._gotargets.gameObject, "taskItem")
		gohelper.findChildText(slot3, "txt_taskdesc").text = EliminateLevelModel.instance.formatString(slot2.winConditionDesc)
		slot7 = slot0._resultData:getStar() >= 1

		gohelper.setActive(gohelper.findChild(slot3, "result/go_finish"), slot7)
		gohelper.setActive(gohelper.findChild(slot3, "result/go_unfinish"), not slot7)
		gohelper.setActive(slot3, true)
		table.insert(slot0._taskItem, slot3)
	end

	if not string.nilorempty(slot2.extraWinCondition) then
		slot3 = gohelper.clone(slot0._gotargetitem, slot0._gotargets.gameObject, "taskItem")
		gohelper.findChildText(slot3, "txt_taskdesc").text = EliminateLevelModel.instance.formatString(slot2.extraWinConditionDesc)
		slot7 = slot1 >= 2

		gohelper.setActive(gohelper.findChild(slot3, "result/go_finish"), slot7)
		gohelper.setActive(gohelper.findChild(slot3, "result/go_unfinish"), not slot7)
		gohelper.setActive(slot3, true)
		table.insert(slot0._taskItem, slot3)
	end
end

function slot0.refreshLoseInfo(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

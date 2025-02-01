module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameResultView", package.seeall)

slot0 = class("YaXianGameResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simageSuccTitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_success/#simage_title")
	slot0._simageFailTitle = gohelper.findChildSingleImage(slot0.viewGO, "#go_fail/#simage_title")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._btnquitgame = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_quitgame")
	slot0._btnrestart = gohelper.findChildButtonWithAudio(slot0.viewGO, "btn/#btn_restart")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquitgame:AddClickListener(slot0._btnquitgameOnClick, slot0)
	slot0._btnrestart:AddClickListener(slot0._btnrestartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquitgame:RemoveClickListener()
	slot0._btnrestart:RemoveClickListener()
end

function slot0.btnCloseOnClick(slot0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	slot0:closeThis()
end

function slot0._btnquitgameOnClick(slot0)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.QuitGame)
	slot0:closeThis()
end

function slot0._btnrestartOnClick(slot0)
	YaXianGameController.instance:enterChessGame(slot0.episodeConfig.id)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))

	slot0._simageSuccTitleTxt = gohelper.findChildText(slot0.viewGO, "#go_success/#simage_title/txt")
	slot0._simageFailTitleTxt = gohelper.findChildText(slot0.viewGO, "#go_fail/#simage_title/txt")
	slot0.txtEpisodeIndex = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0.txtEpisodeName = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._btnclose = gohelper.findChildClick(slot0.viewGO, "#btn_close")

	slot0._btnclose:AddClickListener(slot0.btnCloseOnClick, slot0)
	gohelper.setActive(slot0._gotargetitem, false)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.btnCloseOnClick, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.initData(slot0)
	slot0.isWin = slot0.viewParam.result
	slot0.episodeConfig = slot0.viewParam.episodeConfig
end

function slot0.onOpen(slot0)
	slot0:initData()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._gosuccess, slot0.isWin)
	gohelper.setActive(slot0._gofail, not slot0.isWin)
	slot0:showBtn(not slot0.isWin)

	if slot0.isWin then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_win)

		slot0._simageSuccTitleTxt.text = luaLang("p_versionactivity1_2dungeonview_1")
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_settleaccounts_lose)

		if YaXianGameController.instance:getPlayerInteractItem() and slot1:isDelete() then
			slot0._simageFailTitleTxt.text = luaLang("p_fightfailview_fightfail")
		elseif YaXianGameModel.instance:isRoundUseUp() then
			slot0._simageFailTitleTxt.text = luaLang("p_versionactivity1_2dungeonview_2")
		else
			slot0._simageFailTitleTxt.text = luaLang("p_fightfailview_fightfail")
		end
	end

	slot0:refreshEpisodeInfo()
	slot0:refreshConditions()
end

function slot0.showBtn(slot0, slot1)
	gohelper.setActive(slot0._btnquitgame.gameObject, slot1)
	gohelper.setActive(slot0._btnrestart.gameObject, slot1)
	gohelper.setActive(slot0._btnclose.gameObject, not slot1)
end

function slot0.refreshEpisodeInfo(slot0)
	slot0.txtEpisodeIndex.text = slot0.episodeConfig.index
	slot0.txtEpisodeName.text = slot0.episodeConfig.name
end

function slot0.refreshConditions(slot0)
	for slot6, slot7 in ipairs(YaXianConfig.instance:getConditionList(slot0.episodeConfig)) do
		slot8 = slot0:createConditionItem()

		gohelper.setActive(slot8.go, true)

		slot9 = YaXianGameModel.instance:checkFinishCondition(slot7[1], slot7[2])

		gohelper.setActive(slot8.goFinish, slot9)
		gohelper.setActive(slot8.goUnFinish, not slot9)

		slot8.txtDesc.text = string.split(slot0.episodeConfig.conditionStr, "|")[slot6]
	end
end

function slot0.createConditionItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gotargetitem)
	slot1.txtDesc = gohelper.findChildText(slot1.go, "txt_taskdesc")
	slot1.goFinish = gohelper.findChild(slot1.go, "result/go_finish")
	slot1.goUnFinish = gohelper.findChild(slot1.go, "result/go_unfinish")

	return slot1
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._btnclose:RemoveClickListener()
end

return slot0

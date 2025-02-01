module("modules.logic.seasonver.act123.view2_1.Season123_2_1EpisodeLoadingView", package.seeall)

slot0 = class("Season123_2_1EpisodeLoadingView", BaseView)

function slot0.onInitView(slot0)
	slot0._gostageitem = gohelper.findChild(slot0.viewGO, "#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._stageItems = {}
end

function slot0.onDestroyView(slot0)
	if slot0._stageItems then
		for slot4, slot5 in pairs(slot0._stageItems) do
			slot5.simagechaptericon:UnLoadImage()
		end

		slot0._stageItems = nil
	end

	Season123EpisodeLoadingController.instance:onCloseView()
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0.handleDelayAnimTransition, slot0)
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam.actId
	slot2 = slot0.viewParam.stage

	logNormal(string.format("Season123_2_1EpisodeLoadingView actId=%s, stage=%s", slot1, slot2))
	Season123EpisodeLoadingController.instance:onOpenView(slot1, slot2, slot0.viewParam.layer)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_jinye_film_slide)
	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.handleDelayAnimTransition, slot0, 3)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshStageList()
end

function slot0.refreshStageList(slot0)
	slot2 = {
		[slot8] = true
	}

	for slot6, slot7 in ipairs(Season123EpisodeLoadingModel.instance:getList()) do
		slot0:refreshSingleItem(slot6, slot0:getOrCreateStageItem(slot6), slot7)
	end

	for slot6, slot7 in pairs(slot0._stageItems) do
		gohelper.setActive(slot7.go, slot2[slot7])
	end
end

function slot0.getOrCreateStageItem(slot0, slot1)
	if not slot0._stageItems[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._gostageitem, "stage_item")
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.txtName = gohelper.findChildText(slot3, "#txt_name")
		slot2.imageicon = gohelper.findChildImage(slot3, "#simage_chapterIcon")
		slot2.simagechaptericon = gohelper.findChildSingleImage(slot3, "#simage_chapterIcon")
		slot2.gofinish = gohelper.findChild(slot3, "#go_done")
		slot2.gounfinish = gohelper.findChild(slot3, "#go_unfinished")
		slot2.txtPassRound = gohelper.findChildText(slot3, "#go_done/#txt_num")
		slot2.golock = gohelper.findChild(slot3, "#go_locked")
		slot2.gounlocklight = gohelper.findChild(slot3, "#go_chpt/light")
		slot2.goEnemyList = gohelper.findChild(slot3, "enemyList")
		slot2.goEnemyItem = gohelper.findChild(slot3, "enemyList/#go_enemyteam/enemyList/go_enemyitem")
		slot2.txtchapter = gohelper.findChildText(slot3, "#go_chpt/#txt_chpt")
		slot2.goselected = gohelper.findChild(slot3, "selectframe")

		gohelper.setActive(slot2.go, true)

		slot0._stageItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshSingleItem(slot0, slot1, slot2, slot3)
	if slot3.emptyIndex then
		slot2.txtchapter.text = ""
	else
		slot2.txtchapter.text = string.format("%02d", slot3.cfg.layer)

		slot2.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(Season123Model.instance:getSingleBgFolder(), slot3.cfg.stagePicture))
	end

	slot0:refreshSingleItemLock(slot1, slot2, slot3)
	slot0:refreshSingleItemFinished(slot1, slot2, slot3)

	if slot3.emptyIndex then
		UISpriteSetMgr.instance:setSeason123Sprite(slot2.imageicon, Season123ProgressUtils.getEmptyLayerName(slot3.emptyIndex))
	end
end

function slot0.refreshSingleItemLock(slot0, slot1, slot2, slot3)
	if slot3.emptyIndex then
		gohelper.setActive(slot2.golock, false)
	else
		slot4 = not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(slot3.cfg.layer)

		gohelper.setActive(slot2.golock, slot4)
		gohelper.setActive(slot2.gounlocklight, not slot2.gounlocklight)
		SLFramework.UGUI.GuiHelper.SetColor(slot2.txtchapter, slot4 and "#FFFFFF" or "#FFFFFF")
	end
end

function slot0.refreshSingleItemFinished(slot0, slot1, slot2, slot3)
	if slot3.emptyIndex then
		gohelper.setActive(slot2.gofinish, false)
		gohelper.setActive(slot2.txtPassRound, false)
		gohelper.setActive(slot2.gounfinish, false)

		slot2.txtPassRound.text = ""
	else
		slot4 = slot3.isFinished

		gohelper.setActive(slot2.gofinish, slot4)
		gohelper.setActive(slot2.txtPassRound, slot4)
		gohelper.setActive(slot2.gounfinish, not slot4 and not not Season123EpisodeLoadingModel.instance:isEpisodeUnlock(slot3.cfg.layer))

		if slot4 then
			slot2.txtPassRound.text = tostring(slot3.round)
		end
	end
end

function slot0.handleDelayAnimTransition(slot0)
	Season123EpisodeLoadingController.instance:openEpisodeDetailView()
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 1.5)
end

return slot0

module("modules.logic.seasonver.act123.view2_1.Season123_2_1ResetView", package.seeall)

slot0 = class("Season123_2_1ResetView", BaseView)

function slot0.onInitView(slot0)
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "Bottom/#scroll_herolist/Viewport/Content/#go_heroitem")
	slot0._goepisodeitem = gohelper.findChild(slot0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	slot0._goareaitem = gohelper.findChild(slot0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_areaitem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "Bottom/#btn_reset")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "Bottom/#txt_level")
	slot0._goempty3 = gohelper.findChild(slot0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	slot0._goempty4 = gohelper.findChild(slot0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")
	slot0._txtreset = gohelper.findChildText(slot0.viewGO, "Bottom/#btn_reset/Text")
	slot0._imagereset = gohelper.findChildImage(slot0.viewGO, "Bottom/#btn_reset")
	slot0._goheroexist = gohelper.findChild(slot0.viewGO, "Bottom/#scroll_herolist")
	slot0._goheroempty = gohelper.findChild(slot0.viewGO, "Bottom/#go_heroempty")
	slot0._goscrollchapter = gohelper.findChild(slot0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._heroItems = {}
	slot0._episodeItems = {}
	slot0._scrollchapter = gohelper.findChildScrollRect(slot0._goscrollchapter, "")

	slot0:createStageItem()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_mln_day_night)
end

function slot0.onDestroyView(slot0)
	slot4 = slot0

	TaskDispatcher.cancelTask(slot0.delayInitScrollAudio, slot4)

	for slot4, slot5 in pairs(slot0._heroItems) do
		if slot5.icon then
			slot5.icon:removeClickListener()
			slot5.icon:onDestroy()
		end
	end

	if slot0._episodeItems then
		for slot4, slot5 in pairs(slot0._episodeItems) do
			slot5.btnself:RemoveClickListener()
			slot5.simagechaptericon:UnLoadImage()
		end

		slot0._episodeItems = nil
	end

	if slot0._stageItem then
		slot0._stageItem.btnself:RemoveClickListener()
		slot0._stageItem.simageicon:UnLoadImage()

		slot0._stageItem = nil
	end

	if slot0._drag then
		slot0._drag:RemoveDragBeginListener()
		slot0._drag:RemoveDragEndListener()

		slot0._drag = nil
	end

	if slot0._touch then
		slot0._touch:RemoveClickDownListener()

		slot0._touch = nil
	end

	Season123ResetController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.RefreshResetView, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OnResetSucc, slot0.closeThis, slot0)
	Season123ResetController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.stage, slot0.viewParam.layer)

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot1:isOpen() or slot1:isExpired() then
		return
	end

	slot0:refreshUI()
	TaskDispatcher.runDelay(slot0.delayInitScrollAudio, slot0, 0.1)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshStatus()
	slot0:refreshStage()
	slot0:refreshEpisodeItems()
	slot0:refreshHeroItems()
end

function slot0.refreshStatus(slot0)
	slot2 = "#ffffff"
	slot3 = "#b1b1b1"

	if not Season123ResetModel.instance.layer then
		slot0._txtlevel.text = luaLang("season123_reset_stage_level")
	elseif Season123ResetModel.EmptySelect ~= slot1 then
		slot0._txtlevel.text = string.format("EP.%02d", Season123ResetModel.instance:getSelectLayerCO().layer)
	else
		slot0._txtlevel.text = "---"
		slot2 = "#808080"
		slot3 = "#808080"
	end

	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagereset, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtreset, slot3)
end

function slot0.refreshStage(slot0)
	if Season123ResetModel.instance:getStageCO() then
		slot0._stageItem.txtname.text = slot2.name
	end

	if Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId) then
		slot1.txtnum.text = tostring(slot3:getTotalRound(Season123ResetModel.instance.stage))
	else
		slot1.txtnum.text = "--"
	end

	slot1.simageicon:LoadImage(ResUrl.getSeason123ResetStageIcon(Season123Model.instance:getSingleBgFolder(), Season123ResetModel.instance.stage))
	gohelper.setActive(slot1.goselected, Season123ResetModel.instance.layer == nil)
end

function slot0.refreshEpisodeItems(slot0)
	for slot5 = 1, #Season123ResetModel.instance:getList() do
		slot0:refreshEpisodeItem(slot5, slot1[slot5])
	end

	for slot5 = #slot1 + 1, #slot0._episodeItems do
		gohelper.setActive(slot0._episodeItems[slot5].go, false)
	end

	gohelper.setAsLastSibling(slot0._goempty3)
	gohelper.setAsLastSibling(slot0._goempty4)
end

function slot0.refreshEpisodeItem(slot0, slot1, slot2)
	slot3 = slot0:getOrCreateEpisodeItem(slot1)

	gohelper.setActive(slot3.go, true)

	slot3.txtchapter.text = string.format("%02d", slot2.cfg.layer)

	slot3.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(Season123Model.instance:getSingleBgFolder(), slot2.cfg.stagePicture))
	gohelper.setActive(slot3.goselected, slot2.cfg.layer == Season123ResetModel.instance.layer)
	slot0:refreshSingleItemFinished(slot1, slot3, slot2)
end

function slot0.refreshSingleItemFinished(slot0, slot1, slot2, slot3)
	slot5 = slot3.isFinished

	gohelper.setActive(slot2.godone, slot5)
	gohelper.setActive(slot2.txttime, slot5)
	gohelper.setActive(slot2.gounfinish, not (not Season123ResetModel.instance:isEpisodeUnlock(slot3.cfg.layer) or not slot5))

	if slot5 then
		slot2.txttime.text = string.format(Season123Controller.instance:isReduceRound(slot0.viewParam.actId, slot0.viewParam.stage, slot3.cfg.layer) and "<color=#eecd8c>%s</color>" or "%s", tostring(slot3.round))
	end

	ZProj.UGUIHelper.SetGrayscale(slot2.simagechaptericon.gameObject, slot6)
	SLFramework.UGUI.GuiHelper.SetColor(slot2.imagechaptericon, slot6 and "#808080" or "#ffffff")
end

function slot0.refreshHeroItems(slot0)
	if Season123ResetModel.instance.layer == Season123ResetModel.EmptySelect or Season123ResetModel.instance.layer == nil then
		gohelper.setActive(slot0._goheroexist, false)
		gohelper.setActive(slot0._goheroempty, true)
	else
		gohelper.setActive(slot0._goheroexist, true)
		gohelper.setActive(slot0._goheroempty, false)

		for slot5 = 1, Activity123Enum.PickHeroCount do
			slot6 = slot0:getOrCreateHeroItem(slot5)
			slot7 = Season123ResetModel.instance:getHeroList()[slot5]

			slot0:refreshHero(slot6, slot7)
			slot0:refreshHeroHp(slot6, slot7)
		end
	end
end

function slot0.refreshHero(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.goempty, true)
		gohelper.setActive(slot1.gohero, false)
	else
		gohelper.setActive(slot1.goempty, false)
		gohelper.setActive(slot1.gohero, true)
		slot1.icon:onUpdateMO(slot2.heroMO)
	end
end

function slot0.refreshHeroHp(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.godead, false)
		gohelper.setActive(slot1.sliderhp, false)
	else
		gohelper.setActive(slot1.sliderhp, true)
		slot1.sliderhp:SetValue(Mathf.Clamp(math.floor(slot2.hpRate / 10) / 100, 0, 1))

		if slot2.hpRate <= 0 then
			gohelper.setActive(slot1.godead, true)
		else
			gohelper.setActive(slot1.godead, false)
		end

		Season123HeroGroupUtils.setHpBar(slot1.imagehp, slot4)
	end
end

function slot0.createStageItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.godone = gohelper.findChild(slot0._goareaitem, "#go_done")
	slot1.goselected = gohelper.findChild(slot0._goareaitem, "selectframe")
	slot1.txtname = gohelper.findChildText(slot0._goareaitem, "#txt_areaname")
	slot1.simageicon = gohelper.findChildSingleImage(slot0._goareaitem, "#simage_areaIcon")
	slot1.btnself = gohelper.findChildButtonWithAudio(slot0._goareaitem, "#btn_self")
	slot1.txtnum = gohelper.findChildText(slot0._goareaitem, "#txt_num")

	slot1.btnself:AddClickListener(slot0.onClickStageItem, slot0)

	slot0._stageItem = slot1
end

function slot0.getOrCreateEpisodeItem(slot0, slot1)
	if not slot0._episodeItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goepisodeitem, "episode" .. tostring(slot1))
		slot2.simagechaptericon = gohelper.findChildSingleImage(slot2.go, "#simage_chapterIcon")
		slot2.imagechaptericon = gohelper.findChildImage(slot2.go, "#simage_chapterIcon")
		slot2.gounfinish = gohelper.findChild(slot2.go, "#go_unfinished")
		slot2.godone = gohelper.findChild(slot2.go, "#go_done")
		slot2.txttime = gohelper.findChildText(slot2.go, "#go_done/#txt_num")
		slot2.txtchapter = gohelper.findChildText(slot2.go, "#go_chpt/#txt_chpt")
		slot2.goselected = gohelper.findChild(slot2.go, "selectframe")
		slot2.btnself = gohelper.findChildButtonWithAudio(slot2.go, "#btn_self")

		slot2.btnself:AddClickListener(slot0.onClickEpisodeItem, slot0, slot1)

		slot0._episodeItems[slot1] = slot2
	end

	return slot2
end

function slot0.getOrCreateHeroItem(slot0, slot1)
	if not slot0._heroItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goheroitem, "hero" .. tostring(slot1))
		slot2.goempty = gohelper.findChild(slot2.go, "empty")
		slot2.gohero = gohelper.findChild(slot2.go, "hero")
		slot2.godead = gohelper.findChild(slot2.go, "#dead")
		slot2.sliderhp = gohelper.findChildSlider(slot2.go, "#slider_hp")
		slot2.imagehp = gohelper.findChildImage(slot2.go, "#slider_hp/Fill Area/Fill")
		slot2.icon = IconMgr.instance:getCommonHeroIconNew(slot2.gohero)

		slot2.icon:isShowRare(false)
		gohelper.setActive(slot2.go, true)

		slot0._heroItems[slot1] = slot2
	end

	return slot2
end

function slot0.delayInitScrollAudio(slot0)
	slot0._audioScroll = MonoHelper.addLuaComOnceToGo(slot0._goscrollchapter, Season123_2_1ResetViewAudio, slot0._scrollchapter)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goscrollchapter)

	slot0._drag:AddDragBeginListener(slot0.onDragAudioBegin, slot0)
	slot0._drag:AddDragEndListener(slot0.onDragAudioEnd, slot0)

	slot0._touch = SLFramework.UGUI.UIClickListener.Get(slot0._goscrollchapter)

	slot0._touch:AddClickDownListener(slot0.onClickAudioDown, slot0)
end

function slot0.onDragAudioBegin(slot0)
	slot0._audioScroll:onDragBegin()
end

function slot0.onDragAudioEnd(slot0)
	slot0._audioScroll:onDragEnd()
end

function slot0.onClickAudioDown(slot0)
	slot0._audioScroll:onClickDown()
end

function slot0.onClickStageItem(slot0)
	logNormal("onClickStageItem")

	if Season123ResetController.instance:selectLayer(nil) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function slot0.onClickEpisodeItem(slot0, slot1)
	logNormal("onClickEpisodeItem : " .. tostring(slot1))

	if Season123ResetController.instance:selectLayer(slot1) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function slot0._btnresetOnClick(slot0)
	Season123ResetController.instance:tryReset()
end

return slot0

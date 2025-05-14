module("modules.logic.seasonver.act123.view.Season123ResetView", package.seeall)

local var_0_0 = class("Season123ResetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "Bottom/#scroll_herolist/Viewport/Content/#go_heroitem")
	arg_1_0._goepisodeitem = gohelper.findChild(arg_1_0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_stageitem")
	arg_1_0._goareaitem = gohelper.findChild(arg_1_0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/#go_areaitem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_reset")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#txt_level")
	arg_1_0._goempty3 = gohelper.findChild(arg_1_0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty3")
	arg_1_0._goempty4 = gohelper.findChild(arg_1_0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter/Viewport/Content/empty4")
	arg_1_0._txtreset = gohelper.findChildText(arg_1_0.viewGO, "Bottom/#btn_reset/Text")
	arg_1_0._imagereset = gohelper.findChildImage(arg_1_0.viewGO, "Bottom/#btn_reset")
	arg_1_0._goheroexist = gohelper.findChild(arg_1_0.viewGO, "Bottom/#scroll_herolist")
	arg_1_0._goheroempty = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_heroempty")
	arg_1_0._goscrollchapter = gohelper.findChild(arg_1_0.viewGO, "Top/#go_story/chapterlist/#scroll_chapter")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._heroItems = {}
	arg_4_0._episodeItems = {}
	arg_4_0._scrollchapter = gohelper.findChildScrollRect(arg_4_0._goscrollchapter, "")

	arg_4_0:createStageItem()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_mln_day_night)
end

function var_0_0.onDestroyView(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.delayInitScrollAudio, arg_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._heroItems) do
		if iter_5_1.icon then
			iter_5_1.icon:removeClickListener()
			iter_5_1.icon:onDestroy()
		end
	end

	if arg_5_0._episodeItems then
		for iter_5_2, iter_5_3 in pairs(arg_5_0._episodeItems) do
			iter_5_3.btnself:RemoveClickListener()
			iter_5_3.simagechaptericon:UnLoadImage()
		end

		arg_5_0._episodeItems = nil
	end

	if arg_5_0._stageItem then
		arg_5_0._stageItem.btnself:RemoveClickListener()
		arg_5_0._stageItem.simageicon:UnLoadImage()

		arg_5_0._stageItem = nil
	end

	if arg_5_0._drag then
		arg_5_0._drag:RemoveDragBeginListener()
		arg_5_0._drag:RemoveDragEndListener()

		arg_5_0._drag = nil
	end

	if arg_5_0._touch then
		arg_5_0._touch:RemoveClickDownListener()

		arg_5_0._touch = nil
	end

	Season123ResetController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.RefreshResetView, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.OnResetSucc, arg_6_0.closeThis, arg_6_0)
	Season123ResetController.instance:onOpenView(arg_6_0.viewParam.actId, arg_6_0.viewParam.stage, arg_6_0.viewParam.layer)

	local var_6_0 = ActivityModel.instance:getActMO(arg_6_0.viewParam.actId)

	if not var_6_0 or not var_6_0:isOpen() or var_6_0:isExpired() then
		return
	end

	arg_6_0:refreshUI()
	TaskDispatcher.runDelay(arg_6_0.delayInitScrollAudio, arg_6_0, 0.1)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshStatus()
	arg_8_0:refreshStage()
	arg_8_0:refreshEpisodeItems()
	arg_8_0:refreshHeroItems()
end

function var_0_0.refreshStatus(arg_9_0)
	local var_9_0 = Season123ResetModel.instance.layer
	local var_9_1 = "#ffffff"
	local var_9_2 = "#b1b1b1"

	if not var_9_0 then
		arg_9_0._txtlevel.text = luaLang("season123_reset_stage_level")
	elseif Season123ResetModel.EmptySelect ~= var_9_0 then
		local var_9_3 = Season123ResetModel.instance:getSelectLayerCO()

		arg_9_0._txtlevel.text = string.format("EP.%02d", var_9_3.layer)
	else
		arg_9_0._txtlevel.text = "---"
		var_9_1 = "#808080"
		var_9_2 = "#808080"
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._imagereset, var_9_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._txtreset, var_9_2)
end

function var_0_0.refreshStage(arg_10_0)
	local var_10_0 = arg_10_0._stageItem
	local var_10_1 = Season123ResetModel.instance:getStageCO()

	if var_10_1 then
		var_10_0.txtname.text = var_10_1.name
	end

	local var_10_2 = Season123Model.instance:getActInfo(Season123ResetModel.instance.activityId)

	if var_10_2 then
		local var_10_3 = var_10_2:getTotalRound(Season123ResetModel.instance.stage)

		var_10_0.txtnum.text = tostring(var_10_3)
	else
		var_10_0.txtnum.text = "--"
	end

	local var_10_4 = Season123Model.instance:getSingleBgFolder()

	var_10_0.simageicon:LoadImage(ResUrl.getSeason123ResetStageIcon(var_10_4, Season123ResetModel.instance.stage))
	gohelper.setActive(var_10_0.goselected, Season123ResetModel.instance.layer == nil)
end

function var_0_0.refreshEpisodeItems(arg_11_0)
	local var_11_0 = Season123ResetModel.instance:getList()

	for iter_11_0 = 1, #var_11_0 do
		arg_11_0:refreshEpisodeItem(iter_11_0, var_11_0[iter_11_0])
	end

	for iter_11_1 = #var_11_0 + 1, #arg_11_0._episodeItems do
		gohelper.setActive(arg_11_0._episodeItems[iter_11_1].go, false)
	end

	gohelper.setAsLastSibling(arg_11_0._goempty3)
	gohelper.setAsLastSibling(arg_11_0._goempty4)
end

function var_0_0.refreshEpisodeItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getOrCreateEpisodeItem(arg_12_1)

	gohelper.setActive(var_12_0.go, true)

	var_12_0.txtchapter.text = string.format("%02d", arg_12_2.cfg.layer)

	local var_12_1 = Season123Model.instance:getSingleBgFolder()

	var_12_0.simagechaptericon:LoadImage(ResUrl.getSeason123EpisodeIcon(var_12_1, arg_12_2.cfg.stagePicture))
	gohelper.setActive(var_12_0.goselected, arg_12_2.cfg.layer == Season123ResetModel.instance.layer)
	arg_12_0:refreshSingleItemFinished(arg_12_1, var_12_0, arg_12_2)
end

function var_0_0.refreshSingleItemFinished(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Season123ResetModel.instance:isEpisodeUnlock(arg_13_3.cfg.layer)
	local var_13_1 = arg_13_3.isFinished
	local var_13_2 = not var_13_0 or not var_13_1

	gohelper.setActive(arg_13_2.godone, var_13_1)
	gohelper.setActive(arg_13_2.txttime, var_13_1)
	gohelper.setActive(arg_13_2.gounfinish, not var_13_2)

	if var_13_1 then
		arg_13_2.txttime.text = tostring(arg_13_3.round)
	end

	ZProj.UGUIHelper.SetGrayscale(arg_13_2.simagechaptericon.gameObject, var_13_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_13_2.imagechaptericon, var_13_2 and "#808080" or "#ffffff")
end

function var_0_0.refreshHeroItems(arg_14_0)
	if Season123ResetModel.instance.layer == Season123ResetModel.EmptySelect or Season123ResetModel.instance.layer == nil then
		gohelper.setActive(arg_14_0._goheroexist, false)
		gohelper.setActive(arg_14_0._goheroempty, true)
	else
		gohelper.setActive(arg_14_0._goheroexist, true)
		gohelper.setActive(arg_14_0._goheroempty, false)

		local var_14_0 = Season123ResetModel.instance:getHeroList()

		for iter_14_0 = 1, Activity123Enum.PickHeroCount do
			local var_14_1 = arg_14_0:getOrCreateHeroItem(iter_14_0)
			local var_14_2 = var_14_0[iter_14_0]

			arg_14_0:refreshHero(var_14_1, var_14_2)
			arg_14_0:refreshHeroHp(var_14_1, var_14_2)
		end
	end
end

function var_0_0.refreshHero(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_2 then
		gohelper.setActive(arg_15_1.goempty, true)
		gohelper.setActive(arg_15_1.gohero, false)
	else
		gohelper.setActive(arg_15_1.goempty, false)
		gohelper.setActive(arg_15_1.gohero, true)
		arg_15_1.icon:onUpdateMO(arg_15_2.heroMO)
	end
end

function var_0_0.refreshHeroHp(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_2 then
		gohelper.setActive(arg_16_1.godead, false)
		gohelper.setActive(arg_16_1.sliderhp, false)
	else
		gohelper.setActive(arg_16_1.sliderhp, true)

		local var_16_0 = math.floor(arg_16_2.hpRate / 10)
		local var_16_1 = Mathf.Clamp(var_16_0 / 100, 0, 1)

		arg_16_1.sliderhp:SetValue(var_16_1)

		if arg_16_2.hpRate <= 0 then
			gohelper.setActive(arg_16_1.godead, true)
		else
			gohelper.setActive(arg_16_1.godead, false)
		end

		Season123HeroGroupUtils.setHpBar(arg_16_1.imagehp, var_16_1)
	end
end

function var_0_0.createStageItem(arg_17_0)
	local var_17_0 = arg_17_0:getUserDataTb_()

	var_17_0.godone = gohelper.findChild(arg_17_0._goareaitem, "#go_done")
	var_17_0.goselected = gohelper.findChild(arg_17_0._goareaitem, "selectframe")
	var_17_0.txtname = gohelper.findChildText(arg_17_0._goareaitem, "#txt_areaname")
	var_17_0.simageicon = gohelper.findChildSingleImage(arg_17_0._goareaitem, "#simage_areaIcon")
	var_17_0.btnself = gohelper.findChildButtonWithAudio(arg_17_0._goareaitem, "#btn_self")
	var_17_0.txtnum = gohelper.findChildText(arg_17_0._goareaitem, "#txt_num")

	var_17_0.btnself:AddClickListener(arg_17_0.onClickStageItem, arg_17_0)

	arg_17_0._stageItem = var_17_0
end

function var_0_0.getOrCreateEpisodeItem(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._episodeItems[arg_18_1]

	if not var_18_0 then
		var_18_0 = arg_18_0:getUserDataTb_()
		var_18_0.go = gohelper.cloneInPlace(arg_18_0._goepisodeitem, "episode" .. tostring(arg_18_1))
		var_18_0.simagechaptericon = gohelper.findChildSingleImage(var_18_0.go, "#simage_chapterIcon")
		var_18_0.imagechaptericon = gohelper.findChildImage(var_18_0.go, "#simage_chapterIcon")
		var_18_0.gounfinish = gohelper.findChild(var_18_0.go, "#go_unfinished")
		var_18_0.godone = gohelper.findChild(var_18_0.go, "#go_done")
		var_18_0.txttime = gohelper.findChildText(var_18_0.go, "#go_done/#txt_num")
		var_18_0.txtchapter = gohelper.findChildText(var_18_0.go, "#go_chpt/#txt_chpt")
		var_18_0.goselected = gohelper.findChild(var_18_0.go, "selectframe")
		var_18_0.btnself = gohelper.findChildButtonWithAudio(var_18_0.go, "#btn_self")

		var_18_0.btnself:AddClickListener(arg_18_0.onClickEpisodeItem, arg_18_0, arg_18_1)

		arg_18_0._episodeItems[arg_18_1] = var_18_0
	end

	return var_18_0
end

function var_0_0.getOrCreateHeroItem(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._heroItems[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.go = gohelper.cloneInPlace(arg_19_0._goheroitem, "hero" .. tostring(arg_19_1))
		var_19_0.goempty = gohelper.findChild(var_19_0.go, "empty")
		var_19_0.gohero = gohelper.findChild(var_19_0.go, "hero")
		var_19_0.godead = gohelper.findChild(var_19_0.go, "#dead")
		var_19_0.sliderhp = gohelper.findChildSlider(var_19_0.go, "#slider_hp")
		var_19_0.imagehp = gohelper.findChildImage(var_19_0.go, "#slider_hp/Fill Area/Fill")
		var_19_0.icon = IconMgr.instance:getCommonHeroIconNew(var_19_0.gohero)

		var_19_0.icon:isShowRare(false)
		gohelper.setActive(var_19_0.go, true)

		arg_19_0._heroItems[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.delayInitScrollAudio(arg_20_0)
	arg_20_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_20_0._goscrollchapter, Season123ResetViewAudio, arg_20_0._scrollchapter)
	arg_20_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_20_0._goscrollchapter)

	arg_20_0._drag:AddDragBeginListener(arg_20_0.onDragAudioBegin, arg_20_0)
	arg_20_0._drag:AddDragEndListener(arg_20_0.onDragAudioEnd, arg_20_0)

	arg_20_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_20_0._goscrollchapter)

	arg_20_0._touch:AddClickDownListener(arg_20_0.onClickAudioDown, arg_20_0)
end

function var_0_0.onDragAudioBegin(arg_21_0)
	arg_21_0._audioScroll:onDragBegin()
end

function var_0_0.onDragAudioEnd(arg_22_0)
	arg_22_0._audioScroll:onDragEnd()
end

function var_0_0.onClickAudioDown(arg_23_0)
	arg_23_0._audioScroll:onClickDown()
end

function var_0_0.onClickStageItem(arg_24_0)
	logNormal("onClickStageItem")

	if Season123ResetController.instance:selectLayer(nil) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function var_0_0.onClickEpisodeItem(arg_25_0, arg_25_1)
	logNormal("onClickEpisodeItem : " .. tostring(arg_25_1))

	if Season123ResetController.instance:selectLayer(arg_25_1) then
		AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_activity_reward_ending)
	end
end

function var_0_0._btnresetOnClick(arg_26_0)
	Season123ResetController.instance:tryReset()
end

return var_0_0

module("modules.logic.dungeon.view.DungeonSectionItem", package.seeall)

local var_0_0 = class("DungeonSectionItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagechapterIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_chapterIcon")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "anim/#go_tip")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#go_tip/#btn_tip")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_play")
	arg_1_0._goplayFinished = gohelper.findChild(arg_1_0.viewGO, "anim/#btn_play/played")
	arg_1_0._goplayNotFinished = gohelper.findChild(arg_1_0.viewGO, "anim/#btn_play/unplay")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "anim/#go_arrow")
	arg_1_0._golight = gohelper.findChild(arg_1_0.viewGO, "anim/light")
	arg_1_0._txttipnameen = gohelper.findChildText(arg_1_0.viewGO, "anim/#go_tip/#txt_tipname_en")
	arg_1_0._txttipname = gohelper.findChildText(arg_1_0.viewGO, "anim/#go_tip/#txt_tipname")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "anim/#txt_name_en")
	arg_1_0._btncommandstation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_commandstation")
	arg_1_0._gostorytrace = gohelper.findChild(arg_1_0.viewGO, "anim/#go_trace")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
	arg_2_0._btncommandstation:AddClickListener(arg_2_0._btncommandstationOnClick, arg_2_0)
	arg_2_0:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_2_0._refreshTraced, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
	arg_3_0._btncommandstation:RemoveClickListener()
	arg_3_0:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnRefreshTraced, arg_3_0._refreshTraced, arg_3_0)
end

function var_0_0._btncommandstationOnClick(arg_4_0)
	CommandStationController.instance:openCommandStationEnterView({
		fromDungeonSectionItem = true
	})
end

function var_0_0.setTipVisible(arg_5_0, arg_5_1)
	arg_5_0._showTip = arg_5_1

	gohelper.setActive(arg_5_0._gotip, arg_5_1)
end

function var_0_0._btnplayOnClick(arg_6_0)
	StoryController.instance:playStory(arg_6_0._mo.storyId, {
		mark = true,
		isVersionActivityPV = true
	}, arg_6_0._updatePreviouslyOnStatus, arg_6_0)
end

function var_0_0.externalClickTip(arg_7_0)
	arg_7_0:_btntipOnClick()
end

function var_0_0._btntipOnClick(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	DungeonMainStoryModel.instance:setSectionSelected(not arg_8_0._isSelected and arg_8_0._mo.sectionId or nil, true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._btncategoryOnClick(arg_9_0)
	if arg_9_0._isSelected then
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_open)
	end

	DungeonMainStoryModel.instance:setSectionSelected(not arg_9_0._isSelected and arg_9_0._mo.sectionId or nil, true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._editableInitView(arg_10_0)
	gohelper.addUIClickAudio(arg_10_0._btntip.gameObject, 0)

	arg_10_0._click = SLFramework.UGUI.UIClickListener.Get(arg_10_0.viewGO)

	local var_10_0 = gohelper.findChild(arg_10_0.viewGO, "anim")

	arg_10_0._anim = SLFramework.AnimatorPlayer.Get(var_10_0)
	arg_10_0._simagechapterIcon0 = gohelper.findChildSingleImage(arg_10_0.viewGO, "anim/#simage_chapterIcon/font")
	arg_10_0._simagebg = gohelper.findChildSingleImage(arg_10_0.viewGO, "anim/#simage_chapterIcon/bg")
	arg_10_0._simagelight = gohelper.findChildSingleImage(arg_10_0.viewGO, "anim/#simage_chapterIcon/#simage_light")

	gohelper.setActive(arg_10_0._btnplay, false)
	gohelper.setActive(arg_10_0._btncommandstation, false)
end

function var_0_0.playOpenAnim(arg_11_0)
	if arg_11_0._hasPlayOpenAnim then
		return
	end

	arg_11_0._hasPlayOpenAnim = true

	arg_11_0:playAnimName("open")
end

function var_0_0.playAnimName(arg_12_0, arg_12_1)
	arg_12_0._anim:Play(arg_12_1, arg_12_0._animDone, arg_12_0)
end

function var_0_0._animDone(arg_13_0)
	return
end

function var_0_0._editableAddEvents(arg_14_0)
	arg_14_0._click:AddClickListener(arg_14_0._btncategoryOnClick, arg_14_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_14_0._onStart, arg_14_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_14_0._onFinish, arg_14_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_14_0._newFuncUnlock, arg_14_0)
end

function var_0_0._editableRemoveEvents(arg_15_0)
	arg_15_0._click:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_15_0._onStart, arg_15_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_15_0._onFinish, arg_15_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_15_0._newFuncUnlock, arg_15_0)
end

function var_0_0._onStart(arg_16_0, arg_16_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_16_0._simagechapterIcon0:UnLoadImage()
		arg_16_0._simagebg:UnLoadImage()
		arg_16_0._simagelight:UnLoadImage()
	end
end

function var_0_0._onFinish(arg_17_0, arg_17_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_17_0:_loadImgs()
	end
end

function var_0_0._newFuncUnlock(arg_18_0)
	arg_18_0:_updateCommandStationStatus()
end

function var_0_0._loadImgs(arg_19_0)
	arg_19_0._simagechapterIcon0:LoadImage(arg_19_0._mo.resPage)
	arg_19_0._simagebg:LoadImage(string.format("singlebg/dungeon/pic_section_backbg_%s.png", arg_19_0._mo.sectionId))
	arg_19_0._simagelight:LoadImage(string.format("singlebg/dungeon/pic_section_light_%s.png", arg_19_0._mo.sectionId))
end

function var_0_0.onUpdateMO(arg_20_0, arg_20_1)
	arg_20_0._mo = arg_20_1
	arg_20_0._isSelected = DungeonMainStoryModel.instance:sectionIsSelected(arg_20_0._mo.sectionId)
	arg_20_0._txtname.text = arg_20_0._mo.name
	arg_20_0._txttipname.text = arg_20_0._mo.name
	arg_20_0._txtnameen.text = arg_20_0._mo.nameEn
	arg_20_0._txttipnameen.text = arg_20_0._mo.nameEn

	gohelper.setActive(arg_20_0._txtname, not arg_20_0._isSelected)

	if LangSettings.instance:isCn() then
		gohelper.setActive(arg_20_0._txtnameen, not arg_20_0._isSelected)
	else
		gohelper.setActive(arg_20_0._txtnameen, false)
	end

	arg_20_0._showTip = arg_20_0._isSelected

	gohelper.setActive(arg_20_0._gotip, false)

	if not arg_20_0._isSetIcon then
		arg_20_0._isSetIcon = true

		arg_20_0:_loadImgs()
	end

	if arg_20_0._isSelected then
		arg_20_0:_calcTipLineWidth()
	end

	arg_20_0:_updatePreviouslyOnStatus()
	arg_20_0:_updateCommandStationStatus()
	gohelper.setActive(arg_20_0._goarrow, arg_20_0._isSelected)
	gohelper.setActive(arg_20_0._simagelight, not arg_20_0._isSelected)
	TaskDispatcher.cancelTask(arg_20_0._delayShowTip, arg_20_0)

	if arg_20_0._showTip then
		TaskDispatcher.runDelay(arg_20_0._delayShowTip, arg_20_0, 0.1)
	end

	arg_20_0:_initLight()
	arg_20_0:_refreshTraced()
end

function var_0_0._initLight(arg_21_0)
	local var_21_0 = arg_21_0._golight.transform
	local var_21_1 = var_21_0.childCount

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = var_21_0:GetChild(iter_21_0 - 1)

		gohelper.setActive(var_21_2.gameObject, iter_21_0 == arg_21_0._mo.sectionId)
	end
end

function var_0_0._delayShowTip(arg_22_0)
	arg_22_0:setTipVisible(arg_22_0._showTip)
end

function var_0_0._updatePreviouslyOnStatus(arg_23_0)
	local var_23_0 = arg_23_0._mo.storyId ~= 0 and DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1)

	gohelper.setActive(arg_23_0._btnplay, var_23_0)

	if not var_23_0 then
		return
	end

	local var_23_1 = StoryModel.instance:isStoryFinished(arg_23_0._mo.storyId)

	gohelper.setActive(arg_23_0._goplayNotFinished, not var_23_1)
	gohelper.setActive(arg_23_0._goplayFinished, var_23_1)
end

function var_0_0._updateCommandStationStatus(arg_24_0)
	local var_24_0 = arg_24_0._mo.sectionId == 3 and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation)

	gohelper.setActive(arg_24_0._btncommandstation, var_24_0)
end

function var_0_0._addChapterIcon(arg_25_0)
	if arg_25_0._hasAddChapterIcon then
		return
	end

	arg_25_0._hasAddChapterIcon = true
	arg_25_0._simagechapterIcon1 = gohelper.findChildSingleImage(arg_25_0.viewGO, "anim/#simage_chapterIcon/1")
	arg_25_0._simagechapterIcon2 = gohelper.findChildSingleImage(arg_25_0.viewGO, "anim/#simage_chapterIcon/2")
	arg_25_0._simagechapterIcon3 = gohelper.findChildSingleImage(arg_25_0.viewGO, "anim/#simage_chapterIcon/3")

	local var_25_0 = DungeonMainStoryModel.instance:getChapterList(arg_25_0._mo.sectionId)
	local var_25_1 = 1

	for iter_25_0 = #var_25_0, 1, -1 do
		local var_25_2 = var_25_0[iter_25_0]

		if not DungeonModel.instance:isSpecialMainPlot(var_25_2.id) then
			local var_25_3 = arg_25_0["_simagechapterIcon" .. var_25_1]

			if var_25_3 then
				var_25_3:LoadImage(ResUrl.getDungeonIcon(var_25_2.chapterpic))

				var_25_1 = var_25_1 + 1
			else
				break
			end
		end
	end

	for iter_25_1 = var_25_1, 3 do
		if arg_25_0["_simagechapterIcon" .. var_25_1] then
			-- block empty
		else
			break
		end
	end
end

function var_0_0._calcTipLineWidth(arg_26_0)
	local var_26_0 = arg_26_0._mo.sectionId
	local var_26_1 = DungeonMainStoryModel.instance:getChapterList(var_26_0)
	local var_26_2 = DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.ChapterStartPosX + DungeonMainStoryEnum.TipLineWidthOffsetX

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		var_26_2 = var_26_2 + (DungeonModel.instance:isSpecialMainPlot(iter_26_1.id) and DungeonMainStoryEnum.ChapterWidth.Special or DungeonMainStoryEnum.ChapterWidth.Normal)
	end

	recthelper.setWidth(arg_26_0._btntip.transform, var_26_2)

	arg_26_0._lineWidth = var_26_2
end

function var_0_0.getLineWidth(arg_27_0)
	return arg_27_0._lineWidth
end

function var_0_0.getSectionId(arg_28_0)
	return arg_28_0._mo.sectionId
end

function var_0_0.getSectionName(arg_29_0)
	return arg_29_0._mo.name
end

function var_0_0.getSectionNameEn(arg_30_0)
	return arg_30_0._mo.nameEn
end

function var_0_0.setPosX(arg_31_0, arg_31_1)
	arg_31_0._posX = arg_31_1
end

function var_0_0.getPosX(arg_32_0)
	return arg_32_0._posX
end

function var_0_0.setUnFoldPosX(arg_33_0, arg_33_1)
	arg_33_0._unfoldPosX = arg_33_1
end

function var_0_0.getUnFoldPosX(arg_34_0)
	return arg_34_0._unfoldPosX
end

function var_0_0.moveToUnFoldPosX(arg_35_0)
	arg_35_0:_clearTween()

	if recthelper.getAnchorX(arg_35_0.viewGO.transform.parent) ~= arg_35_0._unfoldPosX then
		arg_35_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_35_0.viewGO.transform.parent, arg_35_0._unfoldPosX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function var_0_0.moveToPosX(arg_36_0)
	arg_36_0:_clearTween()

	if recthelper.getAnchorX(arg_36_0.viewGO.transform.parent) ~= arg_36_0._posX then
		arg_36_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_36_0.viewGO.transform.parent, arg_36_0._posX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function var_0_0._clearTween(arg_37_0)
	if arg_37_0._tweenPosX then
		ZProj.TweenHelper.KillById(arg_37_0._tweenPosX)

		arg_37_0._tweenPosX = nil
	end
end

function var_0_0.onSelect(arg_38_0, arg_38_1)
	return
end

function var_0_0.onDestroyView(arg_39_0)
	arg_39_0:_clearTween()
	TaskDispatcher.cancelTask(arg_39_0._delayShowTip, arg_39_0)
end

function var_0_0._refreshTraced(arg_40_0)
	arg_40_0:_refreshTracedIcon()
end

function var_0_0._refreshTracedIcon(arg_41_0)
	if not arg_41_0._mo then
		return
	end

	local var_41_0 = CharacterRecommedModel.instance:isTradeSection(arg_41_0._mo.sectionId)

	if var_41_0 then
		local var_41_1 = CharacterRecommedController.instance:getTradeIcon()

		if not var_41_1 then
			return
		end

		if not arg_41_0._tracedIcon then
			arg_41_0._tracedIcon = gohelper.clone(var_41_1, arg_41_0._gostorytrace)
		end
	end

	if arg_41_0._tracedIcon then
		gohelper.setActive(arg_41_0._tracedIcon, var_41_0)
	end
end

return var_0_0

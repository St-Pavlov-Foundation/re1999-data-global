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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntip:AddClickListener(arg_2_0._btntipOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0.setTipVisible(arg_4_0, arg_4_1)
	arg_4_0._showTip = arg_4_1

	gohelper.setActive(arg_4_0._gotip, arg_4_1)
end

function var_0_0._btnplayOnClick(arg_5_0)
	StoryController.instance:playStory(arg_5_0._mo.storyId, {
		mark = true,
		isVersionActivityPV = true
	}, arg_5_0._updatePreviouslyOnStatus, arg_5_0)
end

function var_0_0.externalClickTip(arg_6_0)
	arg_6_0:_btntipOnClick()
end

function var_0_0._btntipOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	DungeonMainStoryModel.instance:setSectionSelected(not arg_7_0._isSelected and arg_7_0._mo.sectionId or nil, true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._btncategoryOnClick(arg_8_0)
	if arg_8_0._isSelected then
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_close)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.MainStory.play_ui_player_interface_open)
	end

	DungeonMainStoryModel.instance:setSectionSelected(not arg_8_0._isSelected and arg_8_0._mo.sectionId or nil, true)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.addUIClickAudio(arg_9_0._btntip.gameObject, 0)

	arg_9_0._click = SLFramework.UGUI.UIClickListener.Get(arg_9_0.viewGO)

	local var_9_0 = gohelper.findChild(arg_9_0.viewGO, "anim")

	arg_9_0._anim = SLFramework.AnimatorPlayer.Get(var_9_0)
	arg_9_0._simagechapterIcon0 = gohelper.findChildSingleImage(arg_9_0.viewGO, "anim/#simage_chapterIcon/font")
	arg_9_0._simagebg = gohelper.findChildSingleImage(arg_9_0.viewGO, "anim/#simage_chapterIcon/bg")
	arg_9_0._simagelight = gohelper.findChildSingleImage(arg_9_0.viewGO, "anim/#simage_chapterIcon/#simage_light")

	gohelper.setActive(arg_9_0._btnplay, false)
end

function var_0_0.playOpenAnim(arg_10_0)
	if arg_10_0._hasPlayOpenAnim then
		return
	end

	arg_10_0._hasPlayOpenAnim = true

	arg_10_0:playAnimName("open")
end

function var_0_0.playAnimName(arg_11_0, arg_11_1)
	arg_11_0._anim:Play(arg_11_1, arg_11_0._animDone, arg_11_0)
end

function var_0_0._animDone(arg_12_0)
	return
end

function var_0_0._editableAddEvents(arg_13_0)
	arg_13_0._click:AddClickListener(arg_13_0._btncategoryOnClick, arg_13_0)
	StoryController.instance:registerCallback(StoryEvent.Start, arg_13_0._onStart, arg_13_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_13_0._onFinish, arg_13_0)
end

function var_0_0._editableRemoveEvents(arg_14_0)
	arg_14_0._click:RemoveClickListener()
	StoryController.instance:unregisterCallback(StoryEvent.Start, arg_14_0._onStart, arg_14_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_14_0._onFinish, arg_14_0)
end

function var_0_0._onStart(arg_15_0, arg_15_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_15_0._simagechapterIcon0:UnLoadImage()
		arg_15_0._simagebg:UnLoadImage()
		arg_15_0._simagelight:UnLoadImage()
	end
end

function var_0_0._onFinish(arg_16_0, arg_16_1)
	if ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		arg_16_0:_loadImgs()
	end
end

function var_0_0._loadImgs(arg_17_0)
	arg_17_0._simagechapterIcon0:LoadImage(arg_17_0._mo.resPage)
	arg_17_0._simagebg:LoadImage(string.format("singlebg/dungeon/pic_section_backbg_%s.png", arg_17_0._mo.sectionId))
	arg_17_0._simagelight:LoadImage(string.format("singlebg/dungeon/pic_section_light_%s.png", arg_17_0._mo.sectionId))
end

function var_0_0.onUpdateMO(arg_18_0, arg_18_1)
	arg_18_0._mo = arg_18_1
	arg_18_0._isSelected = DungeonMainStoryModel.instance:sectionIsSelected(arg_18_0._mo.sectionId)
	arg_18_0._txtname.text = arg_18_0._mo.name
	arg_18_0._txttipname.text = arg_18_0._mo.name
	arg_18_0._txtnameen.text = arg_18_0._mo.nameEn
	arg_18_0._txttipnameen.text = arg_18_0._mo.nameEn

	gohelper.setActive(arg_18_0._txtname, not arg_18_0._isSelected)

	if LangSettings.instance:isCn() then
		gohelper.setActive(arg_18_0._txtnameen, not arg_18_0._isSelected)
	else
		gohelper.setActive(arg_18_0._txtnameen, false)
	end

	arg_18_0._showTip = arg_18_0._isSelected

	gohelper.setActive(arg_18_0._gotip, false)

	if not arg_18_0._isSetIcon then
		arg_18_0._isSetIcon = true

		arg_18_0:_loadImgs()
	end

	if arg_18_0._isSelected then
		arg_18_0:_calcTipLineWidth()
	end

	arg_18_0:_updatePreviouslyOnStatus()
	gohelper.setActive(arg_18_0._goarrow, arg_18_0._isSelected)
	gohelper.setActive(arg_18_0._simagelight, not arg_18_0._isSelected)
	TaskDispatcher.cancelTask(arg_18_0._delayShowTip, arg_18_0)

	if arg_18_0._showTip then
		TaskDispatcher.runDelay(arg_18_0._delayShowTip, arg_18_0, 0.1)
	end

	arg_18_0:_initLight()
end

function var_0_0._initLight(arg_19_0)
	local var_19_0 = arg_19_0._golight.transform
	local var_19_1 = var_19_0.childCount

	for iter_19_0 = 1, var_19_1 do
		local var_19_2 = var_19_0:GetChild(iter_19_0 - 1)

		gohelper.setActive(var_19_2.gameObject, iter_19_0 == arg_19_0._mo.sectionId)
	end
end

function var_0_0._delayShowTip(arg_20_0)
	arg_20_0:setTipVisible(arg_20_0._showTip)
end

function var_0_0._updatePreviouslyOnStatus(arg_21_0)
	local var_21_0 = arg_21_0._mo.storyId ~= 0 and DungeonModel.instance:chapterIsPass(DungeonEnum.ChapterId.Main1_1)

	gohelper.setActive(arg_21_0._btnplay, var_21_0)

	if not var_21_0 then
		return
	end

	local var_21_1 = StoryModel.instance:isStoryFinished(arg_21_0._mo.storyId)

	gohelper.setActive(arg_21_0._goplayNotFinished, not var_21_1)
	gohelper.setActive(arg_21_0._goplayFinished, var_21_1)
end

function var_0_0._addChapterIcon(arg_22_0)
	if arg_22_0._hasAddChapterIcon then
		return
	end

	arg_22_0._hasAddChapterIcon = true
	arg_22_0._simagechapterIcon1 = gohelper.findChildSingleImage(arg_22_0.viewGO, "anim/#simage_chapterIcon/1")
	arg_22_0._simagechapterIcon2 = gohelper.findChildSingleImage(arg_22_0.viewGO, "anim/#simage_chapterIcon/2")
	arg_22_0._simagechapterIcon3 = gohelper.findChildSingleImage(arg_22_0.viewGO, "anim/#simage_chapterIcon/3")

	local var_22_0 = DungeonMainStoryModel.instance:getChapterList(arg_22_0._mo.sectionId)
	local var_22_1 = 1

	for iter_22_0 = #var_22_0, 1, -1 do
		local var_22_2 = var_22_0[iter_22_0]

		if not DungeonModel.instance:isSpecialMainPlot(var_22_2.id) then
			local var_22_3 = arg_22_0["_simagechapterIcon" .. var_22_1]

			if var_22_3 then
				var_22_3:LoadImage(ResUrl.getDungeonIcon(var_22_2.chapterpic))

				var_22_1 = var_22_1 + 1
			else
				break
			end
		end
	end

	for iter_22_1 = var_22_1, 3 do
		if arg_22_0["_simagechapterIcon" .. var_22_1] then
			-- block empty
		else
			break
		end
	end
end

function var_0_0._calcTipLineWidth(arg_23_0)
	local var_23_0 = arg_23_0._mo.sectionId
	local var_23_1 = DungeonMainStoryModel.instance:getChapterList(var_23_0)
	local var_23_2 = DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.ChapterStartPosX + DungeonMainStoryEnum.TipLineWidthOffsetX

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		var_23_2 = var_23_2 + (DungeonModel.instance:isSpecialMainPlot(iter_23_1.id) and DungeonMainStoryEnum.ChapterWidth.Special or DungeonMainStoryEnum.ChapterWidth.Normal)
	end

	recthelper.setWidth(arg_23_0._btntip.transform, var_23_2)

	arg_23_0._lineWidth = var_23_2
end

function var_0_0.getLineWidth(arg_24_0)
	return arg_24_0._lineWidth
end

function var_0_0.getSectionId(arg_25_0)
	return arg_25_0._mo.sectionId
end

function var_0_0.getSectionName(arg_26_0)
	return arg_26_0._mo.name
end

function var_0_0.getSectionNameEn(arg_27_0)
	return arg_27_0._mo.nameEn
end

function var_0_0.setPosX(arg_28_0, arg_28_1)
	arg_28_0._posX = arg_28_1
end

function var_0_0.getPosX(arg_29_0)
	return arg_29_0._posX
end

function var_0_0.setUnFoldPosX(arg_30_0, arg_30_1)
	arg_30_0._unfoldPosX = arg_30_1
end

function var_0_0.getUnFoldPosX(arg_31_0)
	return arg_31_0._unfoldPosX
end

function var_0_0.moveToUnFoldPosX(arg_32_0)
	arg_32_0:_clearTween()

	if recthelper.getAnchorX(arg_32_0.viewGO.transform.parent) ~= arg_32_0._unfoldPosX then
		arg_32_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_32_0.viewGO.transform.parent, arg_32_0._unfoldPosX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function var_0_0.moveToPosX(arg_33_0)
	arg_33_0:_clearTween()

	if recthelper.getAnchorX(arg_33_0.viewGO.transform.parent) ~= arg_33_0._posX then
		arg_33_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_33_0.viewGO.transform.parent, arg_33_0._posX, DungeonMainStoryEnum.SectionAnimTime)
	end
end

function var_0_0._clearTween(arg_34_0)
	if arg_34_0._tweenPosX then
		ZProj.TweenHelper.KillById(arg_34_0._tweenPosX)

		arg_34_0._tweenPosX = nil
	end
end

function var_0_0.onSelect(arg_35_0, arg_35_1)
	return
end

function var_0_0.onDestroyView(arg_36_0)
	arg_36_0:_clearTween()
	TaskDispatcher.cancelTask(arg_36_0._delayShowTip, arg_36_0)
end

return var_0_0

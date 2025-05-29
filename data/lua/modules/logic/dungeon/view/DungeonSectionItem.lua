module("modules.logic.dungeon.view.DungeonSectionItem", package.seeall)

local var_0_0 = class("DungeonSectionItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagechapterIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "anim/#simage_chapterIcon")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "anim/#go_tip")
	arg_1_0._btntip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#go_tip/#btn_tip")
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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntip:RemoveClickListener()
end

function var_0_0.setTipVisible(arg_4_0, arg_4_1)
	arg_4_0._gotip:SetActive(arg_4_1)
end

function var_0_0.externalClickTip(arg_5_0)
	arg_5_0:_btntipOnClick()
end

function var_0_0._btntipOnClick(arg_6_0)
	DungeonMainStoryModel.instance:setSectionSelected(not arg_6_0._isSelected and arg_6_0._mo.sectionId or nil)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._btncategoryOnClick(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonMainStoryModel.instance:setSectionSelected(not arg_7_0._isSelected and arg_7_0._mo.sectionId or nil)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.addUIClickAudio(arg_8_0._btntip.gameObject, AudioEnum.UI.Play_UI_Copies)

	arg_8_0._click = SLFramework.UGUI.UIClickListener.Get(arg_8_0.viewGO)

	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "anim")

	arg_8_0._anim = SLFramework.AnimatorPlayer.Get(var_8_0)
	arg_8_0._simagechapterIcon0 = gohelper.findChildSingleImage(arg_8_0.viewGO, "anim/#simage_chapterIcon/font")
	arg_8_0._simagechapterIcon1 = gohelper.findChildSingleImage(arg_8_0.viewGO, "anim/#simage_chapterIcon/1")
	arg_8_0._simagechapterIcon2 = gohelper.findChildSingleImage(arg_8_0.viewGO, "anim/#simage_chapterIcon/2")
	arg_8_0._simagechapterIcon3 = gohelper.findChildSingleImage(arg_8_0.viewGO, "anim/#simage_chapterIcon/3")
end

function var_0_0.playOpenAnim(arg_9_0)
	if arg_9_0._hasPlayOpenAnim then
		return
	end

	arg_9_0._hasPlayOpenAnim = true

	arg_9_0:playAnimName("open")
end

function var_0_0.playAnimName(arg_10_0, arg_10_1)
	arg_10_0._anim:Play(arg_10_1, arg_10_0._animDone, arg_10_0)
end

function var_0_0._animDone(arg_11_0)
	return
end

function var_0_0._editableAddEvents(arg_12_0)
	arg_12_0._click:AddClickListener(arg_12_0._btncategoryOnClick, arg_12_0)
end

function var_0_0._editableRemoveEvents(arg_13_0)
	arg_13_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0._mo = arg_14_1
	arg_14_0._isSelected = DungeonMainStoryModel.instance:sectionIsSelected(arg_14_0._mo.sectionId)
	arg_14_0._txtname.text = arg_14_0._mo.name
	arg_14_0._txttipname.text = arg_14_0._mo.name
	arg_14_0._txtnameen.text = arg_14_0._mo.nameEn
	arg_14_0._txttipnameen.text = arg_14_0._mo.nameEn

	gohelper.setActive(arg_14_0._txtname, not arg_14_0._isSelected)
	gohelper.setActive(arg_14_0._txtnameen, not arg_14_0._isSelected)
	gohelper.setActive(arg_14_0._gotip, arg_14_0._isSelected)

	if not arg_14_0._isSetIcon then
		arg_14_0._isSetIcon = true

		arg_14_0._simagechapterIcon0:LoadImage(arg_14_0._mo.resPage)
	end

	if arg_14_0._isSelected then
		arg_14_0:_calcTipLineWidth()
	end

	arg_14_0:_addChapterIcon()
end

function var_0_0._addChapterIcon(arg_15_0)
	if arg_15_0._hasAddChapterIcon then
		return
	end

	arg_15_0._hasAddChapterIcon = true

	local var_15_0 = DungeonMainStoryModel.instance:getChapterList(arg_15_0._mo.sectionId)
	local var_15_1 = 1

	for iter_15_0 = #var_15_0, 1, -1 do
		local var_15_2 = var_15_0[iter_15_0]

		if not DungeonModel.instance:isSpecialMainPlot(var_15_2.id) then
			local var_15_3 = arg_15_0["_simagechapterIcon" .. var_15_1]

			if var_15_3 then
				var_15_3:LoadImage(ResUrl.getDungeonIcon(var_15_2.chapterpic))

				var_15_1 = var_15_1 + 1
			else
				break
			end
		end
	end

	for iter_15_1 = var_15_1, 3 do
		if arg_15_0["_simagechapterIcon" .. var_15_1] then
			-- block empty
		else
			break
		end
	end
end

function var_0_0._calcTipLineWidth(arg_16_0)
	local var_16_0 = arg_16_0._mo.sectionId
	local var_16_1 = DungeonMainStoryModel.instance:getChapterList(var_16_0)
	local var_16_2 = DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.ChapterStartPosX + DungeonMainStoryEnum.TipLineWidthOffsetX

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		var_16_2 = var_16_2 + (DungeonModel.instance:isSpecialMainPlot(iter_16_1.id) and DungeonMainStoryEnum.ChapterWidth.Special or DungeonMainStoryEnum.ChapterWidth.Normal)
	end

	recthelper.setWidth(arg_16_0._btntip.transform, var_16_2)

	arg_16_0._lineWidth = var_16_2
end

function var_0_0.getLineWidth(arg_17_0)
	return arg_17_0._lineWidth
end

function var_0_0.getSectionName(arg_18_0)
	return arg_18_0._mo.name
end

function var_0_0.getSectionNameEn(arg_19_0)
	return arg_19_0._mo.nameEn
end

function var_0_0.setPosX(arg_20_0, arg_20_1)
	arg_20_0._posX = arg_20_1
end

function var_0_0.getPosX(arg_21_0)
	return arg_21_0._posX
end

function var_0_0.setUnFoldPosX(arg_22_0, arg_22_1)
	arg_22_0._unfoldPosX = arg_22_1
end

function var_0_0.getUnFoldPosX(arg_23_0)
	return arg_23_0._unfoldPosX
end

function var_0_0.moveToUnFoldPosX(arg_24_0)
	arg_24_0:_clearTween()

	arg_24_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_24_0.viewGO.transform.parent, arg_24_0._unfoldPosX, DungeonMainStoryEnum.SectionAnimTime)
end

function var_0_0.moveToPosX(arg_25_0)
	arg_25_0:_clearTween()

	arg_25_0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(arg_25_0.viewGO.transform.parent, arg_25_0._posX, DungeonMainStoryEnum.SectionAnimTime)
end

function var_0_0._clearTween(arg_26_0)
	if arg_26_0._tweenPosX then
		ZProj.TweenHelper.KillById(arg_26_0._tweenPosX)

		arg_26_0._tweenPosX = nil
	end
end

function var_0_0.onSelect(arg_27_0, arg_27_1)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0:_clearTween()
end

return var_0_0

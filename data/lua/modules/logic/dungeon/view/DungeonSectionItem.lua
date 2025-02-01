module("modules.logic.dungeon.view.DungeonSectionItem", package.seeall)

slot0 = class("DungeonSectionItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagechapterIcon = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "anim/#go_tip")
	slot0._btntip = gohelper.findChildButtonWithAudio(slot0.viewGO, "anim/#go_tip/#btn_tip")
	slot0._txttipnameen = gohelper.findChildText(slot0.viewGO, "anim/#go_tip/#txt_tipname_en")
	slot0._txttipname = gohelper.findChildText(slot0.viewGO, "anim/#go_tip/#txt_tipname")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "anim/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "anim/#txt_name_en")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntip:AddClickListener(slot0._btntipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntip:RemoveClickListener()
end

function slot0.setTipVisible(slot0, slot1)
	slot0._gotip:SetActive(slot1)
end

function slot0.externalClickTip(slot0)
	slot0:_btntipOnClick()
end

function slot0._btntipOnClick(slot0)
	DungeonMainStoryModel.instance:setSectionSelected(not slot0._isSelected and slot0._mo.sectionId or nil)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function slot0._btncategoryOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	DungeonMainStoryModel.instance:setSectionSelected(not slot0._isSelected and slot0._mo.sectionId or nil)
	DungeonController.instance:dispatchEvent(DungeonEvent.SelectMainStorySection)
end

function slot0._editableInitView(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)
	slot0._anim = SLFramework.AnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "anim"))
	slot0._simagechapterIcon0 = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon/font")
	slot0._simagechapterIcon1 = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon/1")
	slot0._simagechapterIcon2 = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon/2")
	slot0._simagechapterIcon3 = gohelper.findChildSingleImage(slot0.viewGO, "anim/#simage_chapterIcon/3")
end

function slot0.playOpenAnim(slot0)
	if slot0._hasPlayOpenAnim then
		return
	end

	slot0._hasPlayOpenAnim = true

	slot0:playAnimName("open")
end

function slot0.playAnimName(slot0, slot1)
	slot0._anim:Play(slot1, slot0._animDone, slot0)
end

function slot0._animDone(slot0)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._btncategoryOnClick, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._isSelected = DungeonMainStoryModel.instance:sectionIsSelected(slot0._mo.sectionId)
	slot0._txtname.text = slot0._mo.name
	slot0._txttipname.text = slot0._mo.name
	slot0._txtnameen.text = slot0._mo.nameEn
	slot0._txttipnameen.text = slot0._mo.nameEn

	gohelper.setActive(slot0._txtname, not slot0._isSelected)
	gohelper.setActive(slot0._txtnameen, not slot0._isSelected)
	gohelper.setActive(slot0._gotip, slot0._isSelected)

	if not slot0._isSetIcon then
		slot0._isSetIcon = true

		slot0._simagechapterIcon0:LoadImage(slot0._mo.resPage)
	end

	if slot0._isSelected then
		slot0:_calcTipLineWidth()
	end

	slot0:_addChapterIcon()
end

function slot0._addChapterIcon(slot0)
	if slot0._hasAddChapterIcon then
		return
	end

	slot0._hasAddChapterIcon = true
	slot2 = 1

	for slot6 = #DungeonMainStoryModel.instance:getChapterList(slot0._mo.sectionId), 1, -1 do
		if not DungeonModel.instance:isSpecialMainPlot(slot1[slot6].id) then
			if slot0["_simagechapterIcon" .. slot2] then
				slot9:LoadImage(ResUrl.getDungeonIcon(slot7.chapterpic))

				slot2 = slot2 + 1
			else
				break
			end
		end
	end

	for slot6 = slot2, 3 do
		if not slot0["_simagechapterIcon" .. slot2] then
			break
		end
	end
end

function slot0._calcTipLineWidth(slot0)
	for slot7, slot8 in ipairs(DungeonMainStoryModel.instance:getChapterList(slot0._mo.sectionId)) do
		slot3 = DungeonMainStoryEnum.ChapterWidth.Section + DungeonMainStoryEnum.ChapterStartPosX + DungeonMainStoryEnum.TipLineWidthOffsetX + (DungeonModel.instance:isSpecialMainPlot(slot8.id) and DungeonMainStoryEnum.ChapterWidth.Special or DungeonMainStoryEnum.ChapterWidth.Normal)
	end

	recthelper.setWidth(slot0._btntip.transform, slot3)

	slot0._lineWidth = slot3
end

function slot0.getLineWidth(slot0)
	return slot0._lineWidth
end

function slot0.getSectionName(slot0)
	return slot0._mo.name
end

function slot0.getSectionNameEn(slot0)
	return slot0._mo.nameEn
end

function slot0.setPosX(slot0, slot1)
	slot0._posX = slot1
end

function slot0.getPosX(slot0)
	return slot0._posX
end

function slot0.setUnFoldPosX(slot0, slot1)
	slot0._unfoldPosX = slot1
end

function slot0.getUnFoldPosX(slot0)
	return slot0._unfoldPosX
end

function slot0.moveToUnFoldPosX(slot0)
	slot0:_clearTween()

	slot0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(slot0.viewGO.transform.parent, slot0._unfoldPosX, DungeonMainStoryEnum.SectionAnimTime)
end

function slot0.moveToPosX(slot0)
	slot0:_clearTween()

	slot0._tweenPosX = ZProj.TweenHelper.DOAnchorPosX(slot0.viewGO.transform.parent, slot0._posX, DungeonMainStoryEnum.SectionAnimTime)
end

function slot0._clearTween(slot0)
	if slot0._tweenPosX then
		ZProj.TweenHelper.KillById(slot0._tweenPosX)

		slot0._tweenPosX = nil
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0:_clearTween()
end

return slot0

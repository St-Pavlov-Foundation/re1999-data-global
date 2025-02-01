module("modules.logic.story.view.StoryActivityChapterOpen2_0", package.seeall)

slot0 = class("StoryActivityChapterOpen2_0", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a0/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#maskBg")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simageSection = gohelper.findChildSingleImage(slot0._goBg, "#simage_Section")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0._goBg, "#simage_Title")
	slot0._simageTitleBg = gohelper.findChildSingleImage(slot0._goBg, "#simage_titleBg")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._simageBg = gohelper.findChildSingleImage(slot0._goBg, "image_BG")
end

function slot0.onUpdateView(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0.play, slot0, 2)
end

function slot0.play(slot0)
	gohelper.setActive(slot0.viewGO, true)

	slot3 = string.splitToNumber(slot0.data.navigateChapterEn, "#")[1] or 1
	slot5 = slot0:getVideoName(slot2[2] or 1)

	if not slot0._videoItem then
		slot0._videoItem = StoryActivityVideoItem.New(slot0._goVideo)
	end

	slot0._videoItem:playVideo(slot5, {
		loop = false,
		audioNoStopByFinish = true,
		audioId = slot0:getAudioId(slot4)
	})
	gohelper.setActive(slot0._goMaskBg, true)

	slot8 = StoryConfig.instance:getActivityOpenConfig(slot3, slot4)

	slot0._simageSection:LoadImage(slot0:getLangResBg(string.format("section_%s", slot8.labelRes)), slot0.onSectionLoaded, slot0)
	slot0._simageTitle:LoadImage(slot0:getLangResBg(string.format("title_%s", slot4)), slot0.onTitleLoaded, slot0)
	slot0._simageBg:LoadImage(slot8.storyBg, slot0.onBgLoaded, slot0)
	slot0._simageTitleBg:LoadImage(slot0:getLangResBg(GameUtil.utf8len(slot8.title) > 3 and "xj_0d" or "xj_0d2"))

	if slot4 == 1 then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("open1", 0, 0)
	end
end

function slot0.onSectionLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Section") then
		slot1:SetNativeSize()
	end
end

function slot0.onTitleLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Title") then
		slot1:SetNativeSize()
	end
end

function slot0.onBgLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "image_BG") then
		slot1:SetNativeSize()
	end
end

function slot0.getLangResBg(slot0, slot1)
	return string.format("singlebg_lang/txt_v2a0_opening_singlebg/%s.png", slot1)
end

function slot0.getVideoName(slot0, slot1)
	return slot1 == 1 and "2_0_opening_1"
end

function slot0.getAudioId(slot0, slot1)
	return slot1 == 1 and AudioEnum.Story.play_ui_feichi_open_plot or AudioEnum.Story.play_ui_feichi_stanzas
end

function slot0.onHide(slot0)
	if slot0._videoItem then
		slot0._videoItem:onVideoOut()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
end

function slot0.onDestory(slot0)
	if slot0._videoItem then
		slot0._videoItem:onDestroy()

		slot0._videoItem = nil
	end

	if slot0._simageTitle then
		slot0._simageTitle:UnLoadImage()
	end

	if slot0._simageName then
		slot0._simageName:UnLoadImage()
	end

	if slot0._simageTitleBg then
		slot0._simageTitleBg:UnLoadImage()
	end

	if slot0._simageBg then
		slot0._simageBg:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
	uv0.super.onDestory(slot0)
end

return slot0

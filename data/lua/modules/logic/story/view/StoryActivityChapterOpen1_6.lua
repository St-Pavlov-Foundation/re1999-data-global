module("modules.logic.story.view.StoryActivityChapterOpen1_6", package.seeall)

slot0 = class("StoryActivityChapterOpen1_6", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v1a6/storyactivitychapteropen.prefab"
end

function slot0.onInitView(slot0)
	slot0._goVideo = gohelper.findChild(slot0.viewGO, "#go_video")
	slot0._goMaskBg = gohelper.findChild(slot0.viewGO, "#maskBg")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_bg")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0._goBg, "#simage_Title")
	slot0._simageName = gohelper.findChildSingleImage(slot0._goBg, "#simage_Name")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._simageBg = gohelper.findChildSingleImage(slot0.viewGO, "bg")
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
	slot0._simageTitle:LoadImage(slot0:getLangResBg(string.format("title_%s", slot4)), slot0.onTitleLoaded, slot0)
	slot0._simageName:LoadImage(slot0:getLangResBg(string.format("titleen_%s", tonumber(StoryConfig.instance:getActivityOpenConfig(slot3, slot4) and slot8.labelRes or 1))), slot0.onNameLoaded, slot0)
	slot0._simageBg:LoadImage(slot8.storyBg, slot0.onBgLoaded, slot0)

	if slot4 == 1 then
		slot0._anim:Play("open", 0, 0)
	else
		slot0._anim:Play("open1", 0, 0)
	end
end

function slot0.onTitleLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Title") then
		slot1:SetNativeSize()
	end
end

function slot0.onNameLoaded(slot0)
	if gohelper.findChildImage(slot0._goBg, "#simage_Name") then
		slot1:SetNativeSize()
	end
end

function slot0.onBgLoaded(slot0)
	if gohelper.findChildImage(slot0.viewGO, "bg") then
		slot1:SetNativeSize()
	end
end

function slot0.getLangResBg(slot0, slot1)
	return string.format("singlebg_lang/txt_v1a6_storyactivityopenclose/%s.png", slot1)
end

function slot0.getVideoName(slot0, slot1)
	return slot1 == 1 and "1_6_kaimu"
end

function slot0.getAudioId(slot0, slot1)
	return slot1 == 1 and AudioEnum.Story.play_activitysfx_shuori_chapter_open or AudioEnum.Story.play_activitysfx_shuori_subsection_open
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

	if slot0._simageBg then
		slot0._simageBg:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0.play, slot0)
	uv0.super.onDestory(slot0)
end

return slot0

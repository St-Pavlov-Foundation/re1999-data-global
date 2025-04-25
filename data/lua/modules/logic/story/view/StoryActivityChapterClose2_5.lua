module("modules.logic.story.view.StoryActivityChapterClose2_5", package.seeall)

slot0 = class("StoryActivityChapterClose2_5", StoryActivityChapterBase)

function slot0.onCtor(slot0)
	slot0.assetPath = "ui/viewres/story/v2a5/storyactivitychapterclose.prefab"
end

function slot0.onInitView(slot0)
	slot0.goEnd = gohelper.findChild(slot0.viewGO, "#simage_FullBG/end")
	slot0.goContinued = gohelper.findChild(slot0.viewGO, "#simage_FullBG/continue")
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG/simagebg")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateView(slot0)
	slot2 = tonumber(slot0.data) == 3
	slot3 = tonumber(slot0.data) == 4

	if tonumber(slot0.data) == 2 then
		slot0._anim:Play("close1", 0, 0)
	elseif slot2 then
		slot0._anim:Play("close2", 0, 0)
	elseif slot3 then
		slot0._anim:Play("close3", 0, 0)
	else
		slot0._anim:Play("close", 0, 0)
	end

	gohelper.setActive(slot0.goEnd, slot1 or slot3)
	gohelper.setActive(slot0.goContinued, not slot1 and not slot2)

	slot0._audioId = slot0:getAudioId(tonumber(slot0.data))

	slot0.simageBg:LoadImage(string.format("singlebg/v2a5_opening_singlebg/.jpg", slot1 and "end_bg" or "continued_bg"))
	slot0:_playAudio()
end

function slot0.getAudioId(slot0, slot1)
	if slot1 == 3 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_special_close
	end

	if slot1 == 1 then
		return AudioEnum.Story.play_activitysfx_tangren_chapter_small_close
	end
end

function slot0._playAudio(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:playAudio(slot0._audioId)
	end
end

function slot0.onHide(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end
end

function slot0.onDestory(slot0)
	if slot0._audioId then
		AudioEffectMgr.instance:stopAudio(slot0._audioId)

		slot0._audioId = nil
	end

	slot0.simageBg:UnLoadImage()
	uv0.super.onDestory(slot0)
end

return slot0

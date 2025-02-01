module("modules.logic.versionactivity1_7.enter.view.subview.VersionActivitySubAnimatorComp", package.seeall)

slot0 = class("VersionActivitySubAnimatorComp", UserDataDispose)

function slot0.get(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
end

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0.animatorGo = slot1
	slot0.animator = slot0.animatorGo:GetComponent(typeof(UnityEngine.Animator))
	slot0.view = slot2
	slot0.viewContainer = slot2.viewContainer
end

function slot0.playOpenAnim(slot0)
	if slot0.view.viewParam.skipOpenAnim then
		slot0.animator:Play(UIAnimationName.Open, 0, 1)

		slot0.view.viewParam.skipOpenAnim = false

		slot0.viewContainer:markPlayedSubViewAnim()

		return
	end

	if slot0.viewContainer:getIsFirstPlaySubViewAnim() then
		if slot0.view.viewParam.playVideo then
			slot0.viewContainer:markPlayedSubViewAnim()
			slot0.animator:Play(UIAnimationName.Open, 0, 0)

			slot0.animator.speed = 0

			slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
			slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)
		else
			slot0.animator:Play(UIAnimationName.Open, 0, 0)

			slot0.animator.speed = 1
		end
	else
		slot0.animator:Play(UIAnimationName.Open, 0, 0)

		slot0.animator.speed = 1
	end
end

function slot0.onPlayVideoDone(slot0)
	slot0.animator.speed = 1

	slot0.animator:Play(UIAnimationName.Open, 0, 0)
	slot0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
	slot0:removeEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)
end

function slot0.destroy(slot0)
	slot0:__onDispose()
end

return slot0

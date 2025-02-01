module("modules.logic.versionactivity2_2.enter.view.subview.VersionActivity2_2SubAnimatorComp", package.seeall)

slot0 = class("VersionActivity2_2SubAnimatorComp", VersionActivitySubAnimatorComp)

function slot0.get(slot0, slot1)
	slot2 = uv0.New()

	slot2:init(slot0, slot1)

	return slot2
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
			slot0.animator:Play("open1", 0, 0)

			slot0.animator.speed = 0

			slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayFinished, slot0.onPlayVideoDone, slot0)
			slot0:addEventCb(VideoController.instance, VideoEvent.OnVideoPlayOverTime, slot0.onPlayVideoDone, slot0)
		else
			slot0.viewContainer:markPlayedSubViewAnim()
			slot0.animator:Play("open1", 0, 0)

			slot0.animator.speed = 1
		end
	else
		slot0.animator:Play(UIAnimationName.Open, 0, 0)

		slot0.animator.speed = 1
	end
end

return slot0

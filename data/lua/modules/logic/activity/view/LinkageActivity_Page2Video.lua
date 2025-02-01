module("modules.logic.activity.view.LinkageActivity_Page2Video", package.seeall)

slot1 = class("LinkageActivity_Page2Video", LinkageActivity_Page2VideoBase)

function slot1.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
end

function slot1.removeEvents(slot0)
end

function slot1.ctor(slot0, ...)
	uv0.ctor(slot0, ...)
end

function slot1.onDestroyView(slot0)
	if slot0._mo and slot1.videoAudioStopId then
		AudioMgr.instance:trigger(slot1.videoAudioStopId)
	end

	uv0.onDestroyView(slot0)
end

function slot1._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:setIsNeedLoadingCover(false)
	slot0:createVideoPlayer(gohelper.findChild(slot0.viewGO, "Video"))
end

function slot1.onUpdateMO(slot0, slot1)
	uv0.onUpdateMO(slot0, slot1)
	slot0:loadVideo(langVideoUrl(slot1.videoName))
	slot0:run()
end

function slot1.run(slot0)
	if not slot0:_isPlaying() then
		slot0:play()
	end
end

function slot1.play(slot0)
	uv0.play(slot0, slot0._mo.videoAudioId, true)
end

function slot1.stop(slot0)
	uv0.stop(slot0, slot0._mo.videoAudioStopId)
end

function slot1.setEnabled(slot0, slot1)
	if slot1 then
		slot0:play()
	else
		slot0:stop()
	end
end

return slot1

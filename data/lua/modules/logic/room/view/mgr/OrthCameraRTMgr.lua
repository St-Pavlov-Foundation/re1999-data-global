module("modules.logic.room.view.mgr.OrthCameraRTMgr", package.seeall)

slot0 = class("OrthCameraRTMgr")

function slot0.ctor(slot0)
	slot0._rtIndex = 0
end

function slot0.initRT(slot0)
	if slot0._renderTexture then
		return
	end

	if not CameraMgr.instance:getOrthCamera() then
		return
	end

	slot0._orthCamera = slot1
	slot5 = 512
	slot0._renderTexture = UnityEngine.RenderTexture.GetTemporary(768, slot5, 0, UnityEngine.RenderTextureFormat.ARGB32)
	slot0._originalTargetTexture = slot0._orthCamera.targetTexture
	slot0._orthographicSize = slot0._orthCamera.orthographicSize
	slot0._orthCamera.targetTexture = slot0._renderTexture
	slot0._orthCamera.orthographicSize = 2
	slot0._uvRects = {}

	for slot5 = 1, 24 do
		slot6 = slot5 - 1

		table.insert(slot0._uvRects, UnityEngine.Rect.New(math.floor(slot6 % 6) * 128 / 768, math.floor(slot6 / 6) * 168 / 512, 0.16666666666666666, 0.328125))
	end

	slot0._rtIndex = slot0._rtIndex or 0
end

function slot0.getNewIndex(slot0)
	slot0._rtIndex = slot0._rtIndex + 1

	return slot0._rtIndex
end

function slot0.setRawImageUvRect(slot0, slot1, slot2)
	if not slot0._renderTexture then
		return nil
	end

	slot1.texture = slot0._renderTexture
	slot1.uvRect = slot0._uvRects[slot2] or UnityEngine.Rect.New(0, 0, 1, 1)
end

function slot0.destroyRT(slot0)
	if slot0._orthCamera then
		slot0._orthCamera.targetTexture = slot0._originalTargetTexture
		slot0._orthCamera.orthographicSize = slot0._orthographicSize
		slot0._orthCamera = nil
		slot0._originalTargetTexture = nil
	end

	if slot0._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(slot0._renderTexture)

		slot0._renderTexture = nil
		slot0._moreSprite = nil
		slot0._sprites = nil
		slot0._rtIndex = 0
	end
end

slot0.instance = slot0.New()

return slot0

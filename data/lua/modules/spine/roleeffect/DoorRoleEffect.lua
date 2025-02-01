module("modules.spine.roleeffect.DoorRoleEffect", package.seeall)

slot0 = class("DoorRoleEffect", BaseSpineRoleEffect)

function slot0.init(slot0, slot1)
	slot0._roleEffectConfig = slot1
	slot0._spineGo = slot0._spine._spineGo
	slot0._idle2Camera = gohelper.findChild(slot0._spineGo, "mountroot/mountweapon/roleeffect_b_idle2/zhujue_camera") and slot2:GetComponent(typeof(UnityEngine.Camera))
	slot0._effectGo = gohelper.findChild(slot0._spineGo, "mountroot/mountweapon")
	slot0._videoList = {}
end

function slot0.showBodyEffect(slot0, slot1)
	slot0:_setIdle2CameraEnabled(false)
	slot0:_stopVideo()

	for slot7 = 1, slot0._effectGo.transform.childCount do
		slot9 = slot2:GetChild(slot7 - 1).name == "roleeffect_" .. slot1

		gohelper.setActive(slot8.gameObject, slot9)
		slot0:_playBodyEffect(slot9, slot8, slot1)
	end
end

function slot0._playBodyEffect(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if slot3 == "b_idle2" then
		slot0:_setIdle2CameraEnabled(true)

		if slot0._spine:isInMainView() then
			slot0:_setLightEnvColor()

			return
		end
	end

	slot0:_playVideo(slot2, slot3)
end

function slot0._setIdle2CameraEnabled(slot0, slot1)
	if gohelper.isNil(slot0._idle2Camera) then
		return
	end

	slot0._idle2Camera.enabled = slot1
end

function slot0._setLightEnvColor(slot0)
	if not WeatherController.instance.reportLightMode then
		return
	end

	if not slot0:_getLightMat() then
		return
	end

	slot3 = WeatherEnum.DoorLightColor[slot1]
	slot0._lightColor = slot0._lightColor or Color.New()
	slot0._lightColor.r = slot3[1] / 255
	slot0._lightColor.g = slot3[2] / 255
	slot0._lightColor.b = slot3[3] / 255
	slot0._lightColor.a = slot3[4] / 255

	MaterialUtil.setMainColor(slot2, slot0._lightColor)
end

function slot0._getLightMat(slot0)
	if slot0._material then
		return slot0._material
	end

	slot0._material = gohelper.findChild(slot0._spine._spineGo, "mountroot/mountweapon/roleeffect_b_idle2/504301_banshen_light"):GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	return slot0._material
end

function slot0._playVideo(slot0, slot1, slot2)
	if slot1:GetComponent(typeof(RenderHeads.Media.AVProVideo.MediaPlayer)) then
		slot4 = slot1:GetComponent(typeof(ZProj.AvProUGUIPlayer))
		slot5 = gohelper.onceAddComponent(slot1.gameObject, typeof(ZProj.AvProUGUIPlayer))

		slot1:GetComponent(typeof(UnityEngine.ParticleSystem)):Stop()

		slot7 = ""

		if slot2 == "b_idle4" then
			slot7 = "door_idle4"
		elseif slot2 == "b_idle5" then
			slot7 = "door_idle5"
		elseif slot2 == "b_biaoyan" then
			slot7 = "door_idle6"
		elseif slot2 == "b_bowen" then
			slot7 = "door_bowen"
		end

		slot5:SetEventListener(slot0._videoStatusUpdate, slot0)
		slot5:LoadMedia(langVideoUrl(slot7))

		if slot1.gameObject:GetComponent(typeof(UnityEngine.AudioSource)) then
			slot8.enabled = false
		end

		slot0._mediaPlayer = slot3
		slot0._avProVideoPlayer = slot5
		slot0._particleSystem = slot6
		slot0._videoList[slot5] = slot3
	end
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FirstFrameReady then
		if slot0._mediaPlayer then
			slot0._mediaPlayer:OpenMedia(true)
		end

		if slot0._particleSystem then
			slot0._particleSystem:Play()
		end
	end
end

function slot0._stopVideo(slot0)
	if slot0._mediaPlayer then
		slot0._mediaPlayer:CloseMedia()

		slot0._mediaPlayer = nil

		slot0._avProVideoPlayer:Stop()

		slot0._avProVideoPlayer = nil
		slot0._particleSystem = nil
	end
end

function slot0._clearVideos(slot0)
	slot0:_setIdle2CameraEnabled(false)

	for slot4, slot5 in pairs(slot0._videoList) do
		if not gohelper.isNil(slot4) then
			if not BootNativeUtil.isIOS() then
				slot4:Stop()
			end

			slot4:Clear()
		end
	end

	slot0._videoList = {}
	slot0._mediaPlayer = nil
	slot0._avProVideoPlayer = nil
	slot0._particleSystem = nil
	slot0._idle2Camera = nil
	slot0._spineGo = nil
end

function slot0.onDestroy(slot0)
	slot0:_clearVideos()
end

return slot0

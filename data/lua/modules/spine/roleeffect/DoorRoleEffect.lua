module("modules.spine.roleeffect.DoorRoleEffect", package.seeall)

local var_0_0 = class("DoorRoleEffect", BaseSpineRoleEffect)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._roleEffectConfig = arg_1_1
	arg_1_0._spineGo = arg_1_0._spine._spineGo

	local var_1_0 = gohelper.findChild(arg_1_0._spineGo, "mountroot/mountweapon/roleeffect_b_idle2/zhujue_camera")

	arg_1_0._idle2Camera = var_1_0 and var_1_0:GetComponent(typeof(UnityEngine.Camera))

	local var_1_1 = "mountroot/mountweapon"

	arg_1_0._effectGo = gohelper.findChild(arg_1_0._spineGo, var_1_1)
	arg_1_0._videoList = {}
end

function var_0_0.showBodyEffect(arg_2_0, arg_2_1)
	arg_2_0:_setIdle2CameraEnabled(false)
	arg_2_0:_stopVideo()

	local var_2_0 = arg_2_0._effectGo.transform
	local var_2_1 = var_2_0.childCount

	for iter_2_0 = 1, var_2_1 do
		local var_2_2 = var_2_0:GetChild(iter_2_0 - 1)
		local var_2_3 = var_2_2.name == "roleeffect_" .. arg_2_1

		gohelper.setActive(var_2_2.gameObject, var_2_3)
		arg_2_0:_playBodyEffect(var_2_3, var_2_2, arg_2_1)
	end
end

function var_0_0._playBodyEffect(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 then
		return
	end

	if arg_3_3 == "b_idle2" then
		arg_3_0:_setIdle2CameraEnabled(true)

		if arg_3_0._spine:isInMainView() then
			arg_3_0:_setLightEnvColor()

			return
		end
	end

	arg_3_0:_playVideo(arg_3_2, arg_3_3)
end

function var_0_0._setIdle2CameraEnabled(arg_4_0, arg_4_1)
	if gohelper.isNil(arg_4_0._idle2Camera) then
		return
	end

	arg_4_0._idle2Camera.enabled = arg_4_1
end

function var_0_0._setLightEnvColor(arg_5_0)
	local var_5_0 = WeatherController.instance.reportLightMode

	if not var_5_0 then
		return
	end

	local var_5_1 = arg_5_0:_getLightMat()

	if not var_5_1 then
		return
	end

	local var_5_2 = WeatherEnum.DoorLightColor[var_5_0]

	arg_5_0._lightColor = arg_5_0._lightColor or Color.New()
	arg_5_0._lightColor.r = var_5_2[1] / 255
	arg_5_0._lightColor.g = var_5_2[2] / 255
	arg_5_0._lightColor.b = var_5_2[3] / 255
	arg_5_0._lightColor.a = var_5_2[4] / 255

	MaterialUtil.setMainColor(var_5_1, arg_5_0._lightColor)
end

function var_0_0._getLightMat(arg_6_0)
	if arg_6_0._material then
		return arg_6_0._material
	end

	local var_6_0 = "mountroot/mountweapon/roleeffect_b_idle2/504301_banshen_light"

	arg_6_0._material = gohelper.findChild(arg_6_0._spine._spineGo, var_6_0):GetComponent(typeof(UnityEngine.MeshRenderer)).sharedMaterial

	return arg_6_0._material
end

function var_0_0._playVideo(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:GetComponent(typeof(RenderHeads.Media.AVProVideo.MediaPlayer))

	if var_7_0 then
		local var_7_1 = arg_7_1:GetComponent(typeof(ZProj.AvProUGUIPlayer))
		local var_7_2 = gohelper.onceAddComponent(arg_7_1.gameObject, typeof(ZProj.AvProUGUIPlayer))
		local var_7_3 = arg_7_1:GetComponent(typeof(UnityEngine.ParticleSystem))

		var_7_3:Stop()

		local var_7_4 = ""

		if arg_7_2 == "b_idle4" then
			var_7_4 = "door_idle4"
		elseif arg_7_2 == "b_idle5" then
			var_7_4 = "door_idle5"
		elseif arg_7_2 == "b_biaoyan" then
			var_7_4 = "door_idle6"
		elseif arg_7_2 == "b_bowen" then
			var_7_4 = "door_bowen"
		end

		var_7_2:SetEventListener(arg_7_0._videoStatusUpdate, arg_7_0)
		var_7_2:LoadMedia(langVideoUrl(var_7_4))

		local var_7_5 = arg_7_1.gameObject:GetComponent(typeof(UnityEngine.AudioSource))

		if var_7_5 then
			var_7_5.enabled = false
		end

		arg_7_0._mediaPlayer = var_7_0
		arg_7_0._avProVideoPlayer = var_7_2
		arg_7_0._particleSystem = var_7_3
		arg_7_0._videoList[var_7_2] = var_7_0
	end
end

function var_0_0._videoStatusUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_2 == AvProEnum.PlayerStatus.FirstFrameReady then
		if arg_8_0._mediaPlayer then
			arg_8_0._mediaPlayer:OpenMedia(true)
		end

		if arg_8_0._particleSystem then
			arg_8_0._particleSystem:Play()
		end
	end
end

function var_0_0._stopVideo(arg_9_0)
	if arg_9_0._mediaPlayer then
		arg_9_0._mediaPlayer:CloseMedia()

		arg_9_0._mediaPlayer = nil

		arg_9_0._avProVideoPlayer:Stop()

		arg_9_0._avProVideoPlayer = nil
		arg_9_0._particleSystem = nil
	end
end

function var_0_0._clearVideos(arg_10_0)
	arg_10_0:_setIdle2CameraEnabled(false)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._videoList) do
		if not gohelper.isNil(iter_10_0) then
			if not BootNativeUtil.isIOS() then
				iter_10_0:Stop()
			end

			iter_10_0:Clear()
		end
	end

	arg_10_0._videoList = {}
	arg_10_0._mediaPlayer = nil
	arg_10_0._avProVideoPlayer = nil
	arg_10_0._particleSystem = nil
	arg_10_0._idle2Camera = nil
	arg_10_0._spineGo = nil
end

function var_0_0.onDestroy(arg_11_0)
	arg_11_0:_clearVideos()
end

return var_0_0

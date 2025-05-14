module("modules.logic.room.view.mgr.OrthCameraRTMgr", package.seeall)

local var_0_0 = class("OrthCameraRTMgr")

function var_0_0.ctor(arg_1_0)
	arg_1_0._rtIndex = 0
end

function var_0_0.initRT(arg_2_0)
	if arg_2_0._renderTexture then
		return
	end

	local var_2_0 = CameraMgr.instance:getOrthCamera()

	if not var_2_0 then
		return
	end

	arg_2_0._orthCamera = var_2_0
	arg_2_0._renderTexture = UnityEngine.RenderTexture.GetTemporary(768, 512, 0, UnityEngine.RenderTextureFormat.ARGB32)
	arg_2_0._originalTargetTexture = arg_2_0._orthCamera.targetTexture
	arg_2_0._orthographicSize = arg_2_0._orthCamera.orthographicSize
	arg_2_0._orthCamera.targetTexture = arg_2_0._renderTexture
	arg_2_0._orthCamera.orthographicSize = 2
	arg_2_0._uvRects = {}

	for iter_2_0 = 1, 24 do
		local var_2_1 = iter_2_0 - 1
		local var_2_2 = math.floor(var_2_1 % 6)
		local var_2_3 = math.floor(var_2_1 / 6)
		local var_2_4 = UnityEngine.Rect.New(var_2_2 * 128 / 768, var_2_3 * 168 / 512, 0.16666666666666666, 0.328125)

		table.insert(arg_2_0._uvRects, var_2_4)
	end

	arg_2_0._rtIndex = arg_2_0._rtIndex or 0
end

function var_0_0.getNewIndex(arg_3_0)
	arg_3_0._rtIndex = arg_3_0._rtIndex + 1

	return arg_3_0._rtIndex
end

function var_0_0.setRawImageUvRect(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._renderTexture then
		return nil
	end

	arg_4_1.texture = arg_4_0._renderTexture
	arg_4_1.uvRect = arg_4_0._uvRects[arg_4_2] or UnityEngine.Rect.New(0, 0, 1, 1)
end

function var_0_0.destroyRT(arg_5_0)
	if arg_5_0._orthCamera then
		arg_5_0._orthCamera.targetTexture = arg_5_0._originalTargetTexture
		arg_5_0._orthCamera.orthographicSize = arg_5_0._orthographicSize
		arg_5_0._orthCamera = nil
		arg_5_0._originalTargetTexture = nil
	end

	if arg_5_0._renderTexture then
		UnityEngine.RenderTexture.ReleaseTemporary(arg_5_0._renderTexture)

		arg_5_0._renderTexture = nil
		arg_5_0._moreSprite = nil
		arg_5_0._sprites = nil
		arg_5_0._rtIndex = 0
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

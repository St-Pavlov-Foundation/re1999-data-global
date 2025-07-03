module("modules.live2d.controller.Live2dRTShareController", package.seeall)

local var_0_0 = class("Live2dRTShareController", BaseController)
local var_0_1 = UnityEngine.SystemInfo

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearAll()
end

function var_0_0._clearAll(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._checkRT, arg_3_0)

	arg_3_0._minType = CharacterVoiceEnum.RTShareType.Normal
	arg_3_0._maxType = CharacterVoiceEnum.RTShareType.FullScreen
	arg_3_0._debugLog = false
	arg_3_0._clearTime = nil

	if arg_3_0._typeInfoList and arg_3_0._typeRTList then
		arg_3_0:clearAllRT()
	end

	arg_3_0._typeInfoList = {}
	arg_3_0._typeRTList = {}
end

function var_0_0.addConstEvents(arg_4_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.ExitScene, arg_4_0._onExistScene, arg_4_0)
end

function var_0_0._onExistScene(arg_5_0)
	arg_5_0:_clearAll()
end

function var_0_0.clearAllRT(arg_6_0)
	for iter_6_0 = arg_6_0._maxType, arg_6_0._minType, -1 do
		local var_6_0 = arg_6_0:_getRTInfoList(iter_6_0)

		if var_6_0.rt then
			UnityEngine.RenderTexture.ReleaseTemporary(var_6_0.rt)
			arg_6_0:_replaceRT(iter_6_0)

			var_6_0.rt = nil

			if arg_6_0._debugLog then
				logError(string.format("Live2dRTShareController:clearAllRT shareType:%s", iter_6_0))
			end
		end

		var_6_0.orthographicSize = nil
	end
end

function var_0_0._replaceRT(arg_7_0, arg_7_1)
	arg_7_0._defaultRT = arg_7_0._defaultRT or UnityEngine.RenderTexture.GetTemporary(8, 8, 0, UnityEngine.RenderTextureFormat.ARGB32)

	local var_7_0 = arg_7_0:_getTypeInfoList(arg_7_1)

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if not gohelper.isNil(iter_7_1.camera) then
			iter_7_1.camera.targetTexture = arg_7_0._defaultRT

			if not gohelper.isNil(iter_7_1.image) then
				iter_7_1.image.texture = nil

				recthelper.setSize(iter_7_1.image.rectTransform, 0, 0)
			end
		end
	end
end

function var_0_0._getRT(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_0:_getRTInfoList(arg_8_3)

	if var_8_0.orthographicSize ~= arg_8_2 then
		arg_8_0:clearAllRT()

		var_8_0.orthographicSize = arg_8_2

		if arg_8_3 == CharacterVoiceEnum.RTShareType.FullScreen then
			var_8_0.rt = arg_8_1.targetTexture

			if arg_8_0._debugLog then
				logError(string.format("Live2dRTShareController:_reuseRT orthographicSize:%s shareType:%s", arg_8_2, arg_8_3))
			end
		else
			var_8_0.rt = arg_8_0:_createRT(arg_8_2, arg_8_3, arg_8_4, arg_8_5)
		end
	end

	return var_8_0.rt
end

function var_0_0._getTextureSizeByCameraSize(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = GuiLive2d.GetScaleByDevice()

	return GuiLive2d.getTextureSizeByCameraSize(arg_9_1) * var_9_1 * var_9_0
end

function var_0_0._getTextureSize(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0:_isBloomType(arg_10_2) then
		local var_10_0 = CharacterVoiceEnum.BloomCameraSize[arg_10_3]

		if var_10_0 then
			return arg_10_0:_getTextureSizeByCameraSize(var_10_0)
		end
	end

	return arg_10_0:_getTextureSizeByCameraSize(arg_10_1)
end

function var_0_0._createRT(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_0 = arg_11_0:_getTextureSize(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	local var_11_1 = var_0_1.maxTextureSize

	if var_11_1 < var_11_0 then
		var_11_0 = var_11_1
	end

	if arg_11_0._debugLog then
		logError(string.format("Live2dRTShareController:_createRT orthographicSize:%s textureSize:%s shareType:%s", arg_11_1, var_11_0, arg_11_2))
	end

	if arg_11_2 == CharacterVoiceEnum.RTShareType.BloomOpen then
		return UnityEngine.RenderTexture.GetTemporary(var_11_0, var_11_0, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
	end

	return UnityEngine.RenderTexture.GetTemporary(var_11_0, var_11_0, 0, UnityEngine.RenderTextureFormat.ARGB32)
end

function var_0_0._getRTInfoList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0._typeRTList[arg_12_1]

	if not var_12_0 then
		var_12_0 = {}
		arg_12_0._typeRTList[arg_12_1] = var_12_0
	end

	return var_12_0
end

function var_0_0._getTypeInfoList(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._typeInfoList[arg_13_1]

	if not var_13_0 then
		var_13_0 = {}
		arg_13_0._typeInfoList[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0.addShareInfo(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	if not arg_14_1 or not arg_14_2 or not arg_14_3 or not arg_14_4 or not arg_14_5 then
		logError(string.format("addShareInfo error camera:%s image:%s shareType:%s heroId:%s skinId:%s", arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5))

		return
	end

	if not (arg_14_3 >= arg_14_0._minType) or not (arg_14_3 <= arg_14_0._maxType) then
		logError(string.format("addShareInfo error shareType:%s", arg_14_3))

		return
	end

	arg_14_6 = arg_14_6 or 0

	local var_14_0 = arg_14_0:_getTypeInfoList(arg_14_3)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1.camera == arg_14_1 and iter_14_1.image == arg_14_2 then
			logError(string.format("addShareInfo error same camera:%s image:%s shareType:%s", arg_14_1, arg_14_2, arg_14_3))

			return
		end
	end

	table.insert(var_14_0, {
		camera = arg_14_1,
		orthographicSize = arg_14_1.orthographicSize,
		textureSize = arg_14_0:_getTextureSizeByCameraSize(arg_14_1.orthographicSize),
		image = arg_14_2,
		shareType = arg_14_3,
		heroId = arg_14_4,
		skinId = arg_14_5,
		priority = arg_14_6
	})

	if arg_14_3 == CharacterVoiceEnum.RTShareType.Normal then
		arg_14_0:_sortNormalList(var_14_0)
	end

	if arg_14_0._debugLog then
		logError(string.format("addShareInfo camera:%s orthographicSize:%s image:%s shareType:%s num:%s priority:%s", arg_14_1, arg_14_1.orthographicSize, arg_14_2, arg_14_3, #var_14_0, arg_14_6))
	end

	arg_14_0._clearTime = nil

	arg_14_0:_checkRT()
	TaskDispatcher.cancelTask(arg_14_0._checkRT, arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0._checkRT, arg_14_0, 0)
end

function var_0_0._sortNormalList(arg_15_0, arg_15_1)
	local var_15_0 = 0
	local var_15_1 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if var_15_0 <= iter_15_1.priority then
			var_15_0 = iter_15_1.priority
			var_15_1 = iter_15_0
		end
	end

	if var_15_0 > 0 then
		local var_15_2 = arg_15_1[var_15_1]

		table.remove(arg_15_1, var_15_1)
		table.insert(arg_15_1, var_15_2)
	end
end

function var_0_0._getTopInfoList(arg_16_0)
	for iter_16_0 = arg_16_0._maxType, arg_16_0._minType, -1 do
		local var_16_0 = arg_16_0:_getTypeInfoList(iter_16_0)

		if #var_16_0 > 0 then
			return var_16_0, iter_16_0
		end
	end

	return arg_16_0:_getTypeInfoList(arg_16_0._minType), arg_16_0._minType
end

function var_0_0._isBloomType(arg_17_0, arg_17_1)
	return arg_17_1 == CharacterVoiceEnum.RTShareType.BloomClose or arg_17_1 == CharacterVoiceEnum.RTShareType.BloomOpen
end

function var_0_0._checkRT(arg_18_0)
	local var_18_0, var_18_1 = arg_18_0:_getTopInfoList()

	if #var_18_0 == 0 then
		arg_18_0._clearTime = arg_18_0._clearTime or Time.time

		if Time.time - arg_18_0._clearTime > 1 then
			TaskDispatcher.cancelTask(arg_18_0._checkRT, arg_18_0)

			arg_18_0._clearTime = nil

			arg_18_0:clearAllRT()
		end

		return
	end

	local var_18_2

	for iter_18_0 = #var_18_0, 1, -1 do
		local var_18_3 = var_18_0[iter_18_0]

		if gohelper.isNil(var_18_3.camera) or gohelper.isNil(var_18_3.image) then
			table.remove(var_18_0, iter_18_0)

			var_18_3 = nil

			if arg_18_0._debugLog then
				logError(string.format("Live2dRTShareController:_checkRT remove frame:%s index:%s shareType:%s remain:%s", Time.frameCount, iter_18_0, var_18_1, #var_18_0))
			end
		end

		if var_18_3 and var_18_1 == CharacterVoiceEnum.RTShareType.Normal then
			local var_18_4 = arg_18_0:_getRT(var_18_3.camera, var_18_3.orthographicSize, var_18_3.shareType, var_18_3.heroId, var_18_3.skinId)

			var_18_3.camera.targetTexture = var_18_4
			var_18_3.image.texture = var_18_4

			var_18_3.image:SetNativeSize()

			var_18_2 = var_18_3

			break
		elseif var_18_3 and var_18_3.image.gameObject.activeInHierarchy then
			local var_18_5 = arg_18_0:_getRT(var_18_3.camera, var_18_3.orthographicSize, var_18_3.shareType, var_18_3.heroId, var_18_3.skinId)

			var_18_3.camera.targetTexture = var_18_5
			var_18_3.image.texture = var_18_5

			local var_18_6 = var_18_5.width
			local var_18_7 = var_18_5.height

			if arg_18_0:_isBloomType(var_18_1) then
				local var_18_8 = var_18_3.textureSize

				var_18_6 = var_18_8
				var_18_7 = var_18_8
			end

			recthelper.setSize(var_18_3.image.rectTransform, var_18_6, var_18_7)

			var_18_2 = var_18_3

			break
		end
	end

	for iter_18_1, iter_18_2 in ipairs(var_18_0) do
		local var_18_9 = iter_18_2 == var_18_2

		if not gohelper.isNil(iter_18_2.camera) then
			iter_18_2.camera.enabled = var_18_9
		end
	end

	arg_18_0._clearTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0

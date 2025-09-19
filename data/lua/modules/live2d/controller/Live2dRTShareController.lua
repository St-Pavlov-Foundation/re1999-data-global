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
	local var_9_2 = GuiLive2d.getTextureSizeByCameraSize(arg_9_1) * var_9_1 * var_9_0

	return math.floor(var_9_2)
end

function var_0_0._getTextureSize(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_0:_isBloomType(arg_10_2) then
		local var_10_0 = CharacterVoiceEnum.BloomCameraSize[arg_10_3]

		if var_10_0 then
			return arg_10_0:_getTextureSizeByCameraSize(var_10_0)
		end
	end

	if arg_10_2 == CharacterVoiceEnum.RTShareType.Normal then
		local var_10_1 = CharacterVoiceEnum.NormalTypeCameraSize

		if var_10_1 then
			return arg_10_0:_getTextureSizeByCameraSize(var_10_1)
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
		viewName = arg_14_6
	})

	if arg_14_3 == CharacterVoiceEnum.RTShareType.Normal then
		arg_14_0:_sortNormalList(var_14_0)
	end

	if arg_14_0._debugLog then
		logError(string.format("addShareInfo camera:%s orthographicSize:%s image:%s shareType:%s num:%s viewName:%s", arg_14_1, arg_14_1.orthographicSize, arg_14_2, arg_14_3, #var_14_0, arg_14_6))
	end

	arg_14_0._clearTime = nil

	arg_14_0:_checkRT()
	TaskDispatcher.cancelTask(arg_14_0._checkRT, arg_14_0)
	TaskDispatcher.runRepeat(arg_14_0._checkRT, arg_14_0, 0)
end

function var_0_0._sortNormalList(arg_15_0, arg_15_1)
	local var_15_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		iter_15_1.priority = tabletool.indexOf(var_15_0, iter_15_1.viewName) or 0
	end

	table.sort(arg_15_1, function(arg_16_0, arg_16_1)
		return arg_16_0.priority < arg_16_1.priority
	end)
end

function var_0_0._getTopInfoList(arg_17_0)
	for iter_17_0 = arg_17_0._maxType, arg_17_0._minType, -1 do
		local var_17_0 = arg_17_0:_getTypeInfoList(iter_17_0)

		if #var_17_0 > 0 then
			return var_17_0, iter_17_0
		end
	end

	return arg_17_0:_getTypeInfoList(arg_17_0._minType), arg_17_0._minType
end

function var_0_0._isBloomType(arg_18_0, arg_18_1)
	return arg_18_1 == CharacterVoiceEnum.RTShareType.BloomClose or arg_18_1 == CharacterVoiceEnum.RTShareType.BloomOpen
end

function var_0_0._checkRT(arg_19_0)
	local var_19_0, var_19_1 = arg_19_0:_getTopInfoList()

	if #var_19_0 == 0 then
		arg_19_0._clearTime = arg_19_0._clearTime or Time.time

		if Time.time - arg_19_0._clearTime > 1 then
			TaskDispatcher.cancelTask(arg_19_0._checkRT, arg_19_0)

			arg_19_0._clearTime = nil

			arg_19_0:clearAllRT()
		end

		return
	end

	local var_19_2

	for iter_19_0 = #var_19_0, 1, -1 do
		local var_19_3 = var_19_0[iter_19_0]

		if gohelper.isNil(var_19_3.camera) or gohelper.isNil(var_19_3.image) then
			table.remove(var_19_0, iter_19_0)

			var_19_3 = nil

			if arg_19_0._debugLog then
				logError(string.format("Live2dRTShareController:_checkRT remove frame:%s index:%s shareType:%s remain:%s", Time.frameCount, iter_19_0, var_19_1, #var_19_0))
			end
		end

		if var_19_3 and var_19_1 == CharacterVoiceEnum.RTShareType.Normal then
			local var_19_4 = arg_19_0:_getRT(var_19_3.camera, var_19_3.orthographicSize, var_19_3.shareType, var_19_3.heroId, var_19_3.skinId)

			var_19_3.camera.targetTexture = var_19_4
			var_19_3.image.texture = var_19_4

			local var_19_5 = var_19_3.textureSize
			local var_19_6 = var_19_5
			local var_19_7 = var_19_5

			recthelper.setSize(var_19_3.image.rectTransform, var_19_6, var_19_7)

			var_19_2 = var_19_3

			break
		elseif var_19_3 and var_19_3.image.gameObject.activeInHierarchy then
			local var_19_8 = arg_19_0:_getRT(var_19_3.camera, var_19_3.orthographicSize, var_19_3.shareType, var_19_3.heroId, var_19_3.skinId)

			var_19_3.camera.targetTexture = var_19_8
			var_19_3.image.texture = var_19_8

			local var_19_9 = var_19_8.width
			local var_19_10 = var_19_8.height

			if arg_19_0:_isBloomType(var_19_1) then
				local var_19_11 = var_19_3.textureSize

				var_19_9 = var_19_11
				var_19_10 = var_19_11
			end

			recthelper.setSize(var_19_3.image.rectTransform, var_19_9, var_19_10)

			var_19_2 = var_19_3

			break
		end
	end

	for iter_19_1, iter_19_2 in ipairs(var_19_0) do
		local var_19_12 = iter_19_2 == var_19_2

		if not gohelper.isNil(iter_19_2.camera) then
			iter_19_2.camera.enabled = var_19_12
		end
	end

	arg_19_0._clearTime = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0

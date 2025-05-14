module("modules.logic.weather.controller.WeatherSceneEffectComp", package.seeall)

local var_0_0 = class("WeatherSceneEffectComp")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onSceneHide(arg_2_0)
	return
end

function var_0_0.onSceneShow(arg_3_0)
	return
end

function var_0_0.onInit(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._isMainScene = arg_4_2
	arg_4_0._sceneId = arg_4_1
end

function var_0_0._initSettings(arg_5_0)
	arg_5_0._settingsList = {}

	local var_5_0 = lua_scene_effect_settings.configDict[arg_5_0._sceneId]

	if var_5_0 then
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if string.nilorempty(iter_5_1.tag) then
				local var_5_1 = arg_5_0:getSceneNode(iter_5_1.path)

				if not gohelper.isNil(var_5_1) then
					local var_5_2 = var_5_1:GetComponent(typeof(UnityEngine.Renderer))
					local var_5_3 = UnityEngine.Material.Instantiate(var_5_2.sharedMaterial)

					var_5_2.material = var_5_3

					table.insert(arg_5_0._settingsList, {
						go = var_5_1,
						mat = var_5_3,
						config = iter_5_1
					})
				else
					logError("WeatherSceneEffectComp can not find go by path:" .. iter_5_1.path)
				end
			end
		end
	end
end

function var_0_0.getSceneNode(arg_6_0, arg_6_1)
	return gohelper.findChild(arg_6_0._sceneGo, arg_6_1)
end

function var_0_0.initSceneGo(arg_7_0, arg_7_1)
	arg_7_0._sceneGo = arg_7_1

	arg_7_0:_initSettings()
end

function var_0_0._getColor(arg_8_0, arg_8_1)
	local var_8_0 = Color.New()

	var_8_0.r = arg_8_1[1] / 255
	var_8_0.g = arg_8_1[2] / 255
	var_8_0.b = arg_8_1[3] / 255
	var_8_0.a = arg_8_1[4] / 255

	return var_8_0
end

function var_0_0.onRoleBlend(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_0._settingsList then
		return
	end

	if not arg_9_0._blendParams then
		local var_9_0 = arg_9_1:getCurLightMode()
		local var_9_1 = arg_9_1:getPrevLightMode() or var_9_0

		if not var_9_0 then
			return
		end

		arg_9_0._blendParams = {}

		for iter_9_0, iter_9_1 in ipairs(arg_9_0._settingsList) do
			table.insert(arg_9_0._blendParams, {
				mat = iter_9_1.mat,
				srcColor = arg_9_0:_getColor(iter_9_1.config["lightColor" .. var_9_1]),
				targetColor = arg_9_0:_getColor(iter_9_1.config["lightColor" .. var_9_0]),
				colorKey = UnityEngine.Shader.PropertyToID(iter_9_1.config.colorKey)
			})
		end
	end

	for iter_9_2, iter_9_3 in ipairs(arg_9_0._blendParams) do
		iter_9_3.mat:SetColor(iter_9_3.colorKey, arg_9_1:lerpColorRGBA(iter_9_3.srcColor, iter_9_3.targetColor, arg_9_2))
	end

	if arg_9_3 then
		arg_9_0._blendParams = nil
	end
end

function var_0_0.onSceneClose(arg_10_0)
	arg_10_0._settingsList = nil
end

return var_0_0

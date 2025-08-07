module("modules.logic.weather.controller.WeatherFrameComp", package.seeall)

local var_0_0 = class("WeatherFrameComp")

function var_0_0.ctor(arg_1_0)
	arg_1_0._TintColorId = UnityEngine.Shader.PropertyToID("_TintColor")
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0._sceneId = arg_2_1
end

function var_0_0.getSceneNode(arg_3_0, arg_3_1)
	return gohelper.findChild(arg_3_0._sceneGo, arg_3_1)
end

function var_0_0.initSceneGo(arg_4_0, arg_4_1)
	arg_4_0._sceneGo = arg_4_1

	arg_4_0:_initFrame()
	arg_4_0:loadPhotoFrameBg()
end

function var_0_0._initFrame(arg_5_0)
	arg_5_0._frameBg = nil
	arg_5_0._frameSpineNode = nil
	arg_5_0._frameBg = arg_5_0:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not arg_5_0._frameBg then
		logError("_initFrame no frameBg")
	end

	gohelper.setActive(arg_5_0._frameBg, false)

	local var_5_0 = arg_5_0._frameBg:GetComponent(typeof(UnityEngine.Renderer))

	arg_5_0._frameBgMaterial = UnityEngine.Material.Instantiate(var_5_0.sharedMaterial)
	var_5_0.material = arg_5_0._frameBgMaterial
end

function var_0_0.getFramePath(arg_6_0)
	local var_6_0 = 0
	local var_6_1 = lua_scene_switch.configDict[arg_6_0].resName

	return (string.format("scenes/dynamic/%s/lightmaps/%s_back_a_%s.tga", var_6_1, string.gsub(var_6_1, "_zjm_a", ""), var_6_0))
end

function var_0_0.loadPhotoFrameBg(arg_7_0)
	local var_7_0 = MultiAbLoader.New()

	arg_7_0._photoFrameBgLoader = var_7_0

	local var_7_1 = var_0_0.getFramePath(arg_7_0._sceneId)

	var_7_0:addPath(var_7_1)
	var_7_0:startLoad(function()
		local var_8_0 = var_7_0:getAssetItem(var_7_1):GetResource(var_7_1)

		arg_7_0._frameBgMaterial:SetTexture("_MainTex", var_8_0)
		gohelper.setActive(arg_7_0._frameBg, true)
	end)
end

function var_0_0.getFrameColor(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1 = MainSceneSwitchConfig.instance:getSceneEffect(arg_9_0, WeatherEnum.EffectTag.Frame)

	if var_9_1 then
		local var_9_2 = var_9_1["lightColor" .. arg_9_1]

		var_9_0 = {
			var_9_2[1] / 255,
			var_9_2[2] / 255,
			var_9_2[3] / 255,
			var_9_2[4] / 255
		}
	end

	var_9_0 = var_9_0 or WeatherEnum.FrameTintColor[arg_9_1]

	return Color.New(var_9_0[1], var_9_0[2], var_9_0[3], var_9_0[4])
end

function var_0_0.onRoleBlend(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_0._targetFrameTintColor then
		local var_10_0 = arg_10_1:getCurLightMode()
		local var_10_1 = arg_10_1:getPrevLightMode() or var_10_0

		if not var_10_0 then
			return
		end

		arg_10_0._targetFrameTintColor = var_0_0.getFrameColor(arg_10_0._sceneId, var_10_0)
		arg_10_0._srcFrameTintColor = var_0_0.getFrameColor(arg_10_0._sceneId, var_10_1)

		arg_10_0._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	arg_10_0._frameBgMaterial:SetColor(arg_10_0._TintColorId, arg_10_1:lerpColorRGBA(arg_10_0._srcFrameTintColor, arg_10_0._targetFrameTintColor, arg_10_2))

	if arg_10_3 then
		arg_10_0._targetFrameTintColor = nil

		if arg_10_1:getCurLightMode() == 1 then
			arg_10_0._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function var_0_0.onSceneClose(arg_11_0)
	if arg_11_0._photoFrameBgLoader then
		arg_11_0._photoFrameBgLoader:dispose()

		arg_11_0._photoFrameBgLoader = nil
	end
end

return var_0_0

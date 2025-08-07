module("modules.logic.weather.controller.behaviour.WeatherDayNightChange", package.seeall)

local var_0_0 = class("WeatherDayNightChange", WeatherBaseBehaviour)

function var_0_0.onDestroy(arg_1_0)
	if arg_1_0._nightLightMapLoader then
		arg_1_0._nightLightMapLoader:dispose()

		arg_1_0._nightLightMapLoader = nil
	end
end

function var_0_0.setLightMats(arg_2_0, arg_2_1)
	arg_2_0._dayMats = {}
	arg_2_0._nightMats = {}

	for iter_2_0 = 0, arg_2_1.Length - 1 do
		local var_2_0 = arg_2_1[iter_2_0]

		if string.find(var_2_0.name, "_colorchange_day") then
			table.insert(arg_2_0._dayMats, var_2_0)
		elseif string.find(var_2_0.name, "_colorchange_night") then
			table.insert(arg_2_0._nightMats, var_2_0)
		end
	end

	arg_2_0:_loadNightLightMap()
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._sceneGo = arg_3_1
	arg_3_0._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
end

function var_0_0._loadNightLightMap(arg_4_0)
	if arg_4_0._nightLightMapLoader then
		return
	end

	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._nightMats) do
		local var_4_1 = arg_4_0._sceneConfig.resName
		local var_4_2 = string.format(arg_4_0._lightMapPath, var_4_1, WeatherHelper.getNightResourcePrefix(iter_4_1.name), WeatherEnum.LightModeNight - 1)

		table.insert(var_4_0, var_4_2)
	end

	arg_4_0._nightLightMapLoader = MultiAbLoader.New()

	arg_4_0._nightLightMapLoader:setPathList(var_4_0)
	arg_4_0._nightLightMapLoader:startLoad(arg_4_0._loadNightLightMapCallback, arg_4_0)
end

function var_0_0._loadNightLightMapCallback(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._nightMats) do
		local var_5_0 = arg_5_0._sceneConfig.resName
		local var_5_1 = string.format(arg_5_0._lightMapPath, var_5_0, WeatherHelper.getNightResourcePrefix(iter_5_1.name), WeatherEnum.LightModeNight - 1)
		local var_5_2 = arg_5_0._nightLightMapLoader:getAssetItem(var_5_1):GetResource(var_5_1)

		iter_5_1:SetTexture(ShaderPropertyId.MainTex, var_5_2)
	end
end

function var_0_0._setMatsAlpha(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		local var_6_0 = MaterialUtil.GetMainColor(iter_6_1)

		if var_6_0 then
			var_6_0.a = arg_6_2

			MaterialUtil.setMainColor(iter_6_1, var_6_0)
		end
	end
end

function var_0_0._onReportChange(arg_7_0)
	arg_7_0._curIsNight = arg_7_0._curReport.lightMode == WeatherEnum.LightModeNight
	arg_7_0._prevIsNight = arg_7_0._prevReport and arg_7_0._prevReport.lightMode == WeatherEnum.LightModeNight

	if not arg_7_0._prevReport and arg_7_0._curReport then
		if arg_7_0._curIsNight then
			arg_7_0:_setMatsAlpha(arg_7_0._nightMats, 1)
			arg_7_0:_setMatsAlpha(arg_7_0._dayMats, 0)
		else
			arg_7_0:_setMatsAlpha(arg_7_0._nightMats, 0)
			arg_7_0:_setMatsAlpha(arg_7_0._dayMats, 1)
		end
	end
end

function var_0_0.changeBlendValue(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_0._curIsNight and not arg_8_0._prevIsNight then
		return
	end

	if arg_8_0._curIsNight and arg_8_0._prevIsNight then
		return
	end

	if arg_8_3 then
		arg_8_1 = 1 - arg_8_1
	end

	if arg_8_0._curIsNight then
		arg_8_0:_setMatsAlpha(arg_8_0._nightMats, arg_8_1)
		arg_8_0:_setMatsAlpha(arg_8_0._dayMats, 1 - arg_8_1)
	else
		arg_8_0:_setMatsAlpha(arg_8_0._nightMats, 1 - arg_8_1)
		arg_8_0:_setMatsAlpha(arg_8_0._dayMats, arg_8_1)
	end
end

return var_0_0

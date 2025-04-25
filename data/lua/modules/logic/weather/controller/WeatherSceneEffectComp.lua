module("modules.logic.weather.controller.WeatherSceneEffectComp", package.seeall)

slot0 = class("WeatherSceneEffectComp")

function slot0.ctor(slot0)
end

function slot0.onSceneHide(slot0)
end

function slot0.onSceneShow(slot0)
end

function slot0.onInit(slot0, slot1, slot2)
	slot0._isMainScene = slot2
	slot0._sceneId = slot1
end

function slot0._initSettings(slot0)
	slot0._settingsList = {}

	if lua_scene_effect_settings.configDict[slot0._sceneId] then
		for slot5, slot6 in ipairs(slot1) do
			if string.nilorempty(slot6.tag) then
				if not gohelper.isNil(slot0:getSceneNode(slot6.path)) then
					slot8 = slot7:GetComponent(typeof(UnityEngine.Renderer))
					slot9 = UnityEngine.Material.Instantiate(slot8.sharedMaterial)
					slot8.material = slot9

					table.insert(slot0._settingsList, {
						go = slot7,
						mat = slot9,
						config = slot6
					})
				else
					logError("WeatherSceneEffectComp can not find go by path:" .. slot6.path)
				end
			end
		end
	end
end

function slot0.getSceneNode(slot0, slot1)
	return gohelper.findChild(slot0._sceneGo, slot1)
end

function slot0.initSceneGo(slot0, slot1)
	slot0._sceneGo = slot1

	slot0:_initSettings()
end

function slot0._getColor(slot0, slot1)
	slot2 = Color.New()
	slot2.r = slot1[1] / 255
	slot2.g = slot1[2] / 255
	slot2.b = slot1[3] / 255
	slot2.a = slot1[4] / 255

	return slot2
end

function slot0.onRoleBlend(slot0, slot1, slot2, slot3)
	if not slot0._settingsList then
		return
	end

	if not slot0._blendParams then
		slot4 = slot1:getCurLightMode()
		slot5 = slot1:getPrevLightMode() or slot4

		if not slot4 then
			return
		end

		slot0._blendParams = {}

		for slot9, slot10 in ipairs(slot0._settingsList) do
			table.insert(slot0._blendParams, {
				mat = slot10.mat,
				srcColor = slot0:_getColor(slot10.config["lightColor" .. slot5]),
				targetColor = slot0:_getColor(slot10.config["lightColor" .. slot4]),
				colorKey = UnityEngine.Shader.PropertyToID(slot10.config.colorKey)
			})
		end
	end

	for slot7, slot8 in ipairs(slot0._blendParams) do
		slot8.mat:SetColor(slot8.colorKey, slot1:lerpColorRGBA(slot8.srcColor, slot8.targetColor, slot2))
	end

	if slot3 then
		slot0._blendParams = nil
	end
end

function slot0.onSceneClose(slot0)
	slot0._settingsList = nil
end

return slot0

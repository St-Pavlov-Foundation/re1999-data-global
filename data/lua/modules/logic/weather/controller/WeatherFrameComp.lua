module("modules.logic.weather.controller.WeatherFrameComp", package.seeall)

slot0 = class("WeatherFrameComp")

function slot0.ctor(slot0)
	slot0._TintColorId = UnityEngine.Shader.PropertyToID("_TintColor")
end

function slot0.onInit(slot0, slot1)
	slot0._sceneId = slot1
end

function slot0.getSceneNode(slot0, slot1)
	return gohelper.findChild(slot0._sceneGo, slot1)
end

function slot0.initSceneGo(slot0, slot1)
	slot0._sceneGo = slot1

	slot0:_initFrame()
	slot0:loadPhotoFrameBg()
end

function slot0._initFrame(slot0)
	slot0._frameBg = nil
	slot0._frameSpineNode = nil
	slot0._frameBg = slot0:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	if not slot0._frameBg then
		logError("_initFrame no frameBg")
	end

	gohelper.setActive(slot0._frameBg, false)

	slot1 = slot0._frameBg:GetComponent(typeof(UnityEngine.Renderer))
	slot0._frameBgMaterial = UnityEngine.Material.Instantiate(slot1.sharedMaterial)
	slot1.material = slot0._frameBgMaterial
end

function slot0.loadPhotoFrameBg(slot0)
	slot1 = MultiAbLoader.New()
	slot0._photoFrameBgLoader = slot1

	slot1:addPath(string.format("scenes/dynamic/m_s01_zjm_a/lightmaps/m_s01_back_a_%s.tga", 0))
	slot1:startLoad(function ()
		uv2._frameBgMaterial:SetTexture("_MainTex", uv0:getAssetItem(uv1):GetResource(uv1))
		gohelper.setActive(uv2._frameBg, true)
	end)
end

function slot0.getFrameColor(slot0, slot1)
	slot2 = nil

	if MainSceneSwitchConfig.instance:getSceneEffect(slot0, WeatherEnum.EffectTag.Frame) then
		slot4 = slot3["lightColor" .. slot1]
		slot2 = {
			slot4[1] / 255,
			slot4[2] / 255,
			slot4[3] / 255,
			slot4[4] / 255
		}
	end

	slot2 = slot2 or WeatherEnum.FrameTintColor[slot1]

	return Color.New(slot2[1], slot2[2], slot2[3], slot2[4])
end

function slot0.onRoleBlend(slot0, slot1, slot2, slot3)
	if not slot0._targetFrameTintColor then
		slot4 = slot1:getCurLightMode()
		slot5 = slot1:getPrevLightMode() or slot4

		if not slot4 then
			return
		end

		slot0._targetFrameTintColor = uv0.getFrameColor(slot0._sceneId, slot4)
		slot0._srcFrameTintColor = uv0.getFrameColor(slot0._sceneId, slot5)

		slot0._frameBgMaterial:EnableKeyword("_COLORGRADING_ON")
	end

	slot0._frameBgMaterial:SetColor(slot0._TintColorId, slot1:lerpColorRGBA(slot0._srcFrameTintColor, slot0._targetFrameTintColor, slot2))

	if slot3 then
		slot0._targetFrameTintColor = nil

		if slot1:getCurLightMode() == 1 then
			slot0._frameBgMaterial:DisableKeyword("_COLORGRADING_ON")
		end
	end
end

function slot0.onSceneClose(slot0)
	if slot0._photoFrameBgLoader then
		slot0._photoFrameBgLoader:dispose()

		slot0._photoFrameBgLoader = nil
	end
end

return slot0

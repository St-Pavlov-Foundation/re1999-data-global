module("modules.logic.story.view.StoryHeroItem", package.seeall)

slot0 = class("StoryHeroItem")

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0._heroCo = nil
	slot0._heroGo = nil
	slot0._heroSpine = {}
	slot0._isLightSpine = false
	slot0._heroEffects = {}
	slot0._heroSkeletonGraphic = nil
end

function slot0.hideHero(slot0)
	slot0:_fadeOut()
end

function slot0.resetHero(slot0, slot1, slot2, slot3, slot4)
	if StoryModel.instance:getReplaceHeroPath(slot1.heroIndex) then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, slot1)
		gohelper.setActive(slot0._heroSpineGo, false)

		return
	end

	if slot2.name == "spine_ui_default" and slot0._initMat then
		slot2 = slot0._initMat
	end

	slot0._conAudioId = slot4

	if slot0._heroGo.activeSelf and (slot1.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] ~= "" or slot1.expressions[slot6] ~= "" or slot1.mouses[slot6] ~= "") and not string.find(slot1.mouses[slot6], "_auto") and slot1.anims[slot6] == slot0._heroCo.anims[slot6] and slot1.expressions[slot6] == slot0._heroCo.expressions[slot6] and slot1.mouses[slot6] == slot0._heroCo.mouses[slot6] then
		if not slot0._isLightSpine then
			slot0:_setHeroMat(slot2)
		end

		return
	end

	slot0._hasBottomEffect = slot3

	ZProj.TweenHelper.KillByObj(slot0._heroGo.transform)

	if not slot0._isLightSpine then
		slot0._heroCo = slot1

		slot0:_setHeroMat(slot2)

		if slot0._heroGo.activeSelf then
			if slot0._heroSpineGo then
				ZProj.TweenHelper.DOLocalMove(slot0._heroSpineGo.transform, slot0._heroCo.heroPos[1], slot0._heroCo.heroPos[2], 0, 0.4)
				ZProj.TweenHelper.DOScale(slot0._heroSpineGo.transform, slot0._heroCo.heroScale, slot0._heroCo.heroScale, 1, 0.1)
			end

			slot0:_playHeroVoice()
		else
			if slot0._heroSpineGo then
				transformhelper.setLocalPosXY(slot0._heroSpineGo.transform, slot0._heroCo.heroPos[1], slot0._heroCo.heroPos[2])
				transformhelper.setLocalScale(slot0._heroSpineGo.transform, slot0._heroCo.heroScale, slot0._heroCo.heroScale, 1)
			end

			slot0:_fadeIn()
			slot0:_playHeroVoice()
		end
	end

	gohelper.setActive(slot0._heroGo, true)
end

function slot0._fadeIn(slot0)
	if slot0._isLightSpine or not slot0._isLive2D and not slot0._heroSkeletonGraphic then
		gohelper.setActive(slot0._heroSpineGo, true)

		return
	end

	slot0:_checkMatKeyWord()

	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end

	slot0:_fadeInUpdate(0)

	slot0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0._fadeInUpdate, slot0._fadeInFinished, slot0, nil, EaseType.Linear)
end

function slot0._fadeInUpdate(slot0, slot1)
	if not slot0._heroSpine then
		return
	end

	if slot0._isLive2D then
		slot0._heroSpine:setAlpha(slot1)
	else
		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0._heroSpineGo.transform)

		transformhelper.setLocalPos(slot0._heroSpineGo.transform, slot2, slot3, 1 - slot1)
	end

	slot0:_setHeroFadeMat()
end

function slot0._setHeroFadeMat(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._bgGo.transform)
	slot3, slot4 = transformhelper.getLocalScale(slot0._bgGo.transform)
	slot5 = Vector4.New(slot3, slot4, slot1, slot2)

	if slot0._heroSpine and slot0._isLive2D then
		slot0._heroSpine:setSceneTexture(slot0._blitEff.capturedTexture)
	elseif slot0._heroSkeletonGraphic then
		slot0._heroSkeletonGraphic.materialForRendering:SetTexture("_SceneMask", slot6)
		slot0._heroSkeletonGraphic.materialForRendering:SetVector("_SceneMask_ST", slot5)
	end
end

function slot0._fadeInFinished(slot0)
	if slot0._heroSkeletonGraphic then
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if slot0._heroSpine and slot0._isLive2D then
		slot0._heroSpine:disableSceneAlpha()
	end

	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end
end

function slot0._setHeroMat(slot0, slot1)
	if slot0._isLightSpine then
		return
	end

	if not slot0._isLive2D and not slot0._heroSkeletonGraphic then
		return
	end

	if slot0._isLive2D and slot0._heroSpine then
		if slot1.name == "spine_ui_dark" then
			slot0._heroSpine:SetDark()
		else
			slot0._heroSpine:SetBright()
		end
	end

	if slot0._heroSpine and slot0._heroSkeletonGraphic then
		if slot0._heroSkeletonGraphic.material and slot0._heroSkeletonGraphic.material == slot1 then
			return
		end

		if slot0._initMat then
			if slot1.name == "spine_ui_default" then
				slot0._initMat:SetColor("_Color", Color.New(1, 1, 1, 1))
			else
				slot0._initMat:SetColor("_Color", Color.New(0.6, 0.6, 0.6, 1))
			end
		end

		slot0._heroSkeletonGraphic.material = slot1
	end
end

function slot0._checkMatKeyWord(slot0)
	if slot0._heroSpine and slot0._isLive2D then
		slot0._heroSpine:enableSceneAlpha()
	end

	if not slot0._heroSkeletonGraphic then
		gohelper.setActive(slot0._heroSpineGo, true)

		return
	end

	if slot0._hasBottomEffect then
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		slot0._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA2_ON")
	else
		slot0._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA_ON")
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	TaskDispatcher.runDelay(slot0._onDelay, slot0, 0.05)
end

function slot0._onDelay(slot0)
	if StoryModel.instance:getReplaceHeroPath(slot0._heroCo.heroIndex) then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, slot0._heroCo)
		gohelper.setActive(slot0._heroSpineGo, false)

		return
	end

	gohelper.setActive(slot0._heroSpineGo, true)
end

function slot0._fadeOut(slot0)
	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end

	if slot0._isLightSpine or not slot0._isLive2D and not slot0._heroSkeletonGraphic then
		slot0._heroSpine:stopVoice()
		gohelper.setActive(slot0._heroGo, false)

		return
	end

	slot0:_checkMatKeyWord()

	if slot0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeOutTweenId)

		slot0._fadeOutTweenId = nil
	end

	slot0._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, slot0._fadeOutUpdate, slot0._fadeOutFinished, slot0, nil, EaseType.Linear)
end

function slot0._fadeOutUpdate(slot0, slot1)
	if not slot0._heroSpine then
		return
	end

	if slot0._isLive2D then
		slot0._heroSpine:setAlpha(slot1)
	else
		slot2, slot3, slot4 = transformhelper.getLocalPos(slot0._heroSpineGo.transform)

		transformhelper.setLocalPos(slot0._heroSpineGo.transform, slot2, slot3, 1 - slot1)
	end

	slot0:_setHeroFadeMat()
end

function slot0._fadeOutFinished(slot0)
	gohelper.setActive(slot0._heroGo, false)
	slot0:_fadeOutUpdate(1)

	if slot0._heroSkeletonGraphic then
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if slot0._heroSpine and slot0._isLive2D then
		slot0._heroSpine:disableSceneAlpha()
	end

	slot0:onDestroy()
end

function slot0.buildHero(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._conAudioId = slot6
	slot0._heroCo = slot1
	slot0._heroGo = gohelper.create2d(slot0.viewGO, "rolespine")
	gohelper.onceAddComponent(slot0._heroGo, typeof(UnityEngine.Canvas)).overrideSorting = true
	slot8 = gohelper.getSibling(slot0._heroGo)
	slot0._blitEff = gohelper.findChild(slot0.viewGO.transform.parent.gameObject, "#go_rolebg"):GetComponent(typeof(UrpCustom.UIBlitEffect))
	slot0._bgGo = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO, "#go_upbg/#simage_bgimg")

	gohelper.setLayer(slot0._heroGo, UnityLayer.UISecond, true)

	if not StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(slot0._heroCo.heroIndex) then
		return
	end

	slot13 = string.split(slot11.type == 0 and string.format("rolesstory/%s", slot11.prefab) or string.format("live2d/roles/%s", slot11.live2dPrefab), "_")
	slot0._isLive2D = false
	slot0._isLightSpine = string.split(slot13[#slot13], ".")[1] == "light"

	if slot0._isLightSpine then
		slot0._heroSpine = LightSpine.Create(slot0._heroGo, true)

		slot0._heroSpine:setResPath(slot12, function ()
			uv0._heroSpineGo = uv0._heroSpine:getSpineGo()

			uv0:_playHeroVoice()
			uv0:_setHeroMat(uv1)

			if uv2 then
				uv2(uv3)
			end

			transformhelper.setLocalPos(uv0._heroSpineGo.transform, uv0._heroCo.heroPos[1], uv0._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(uv0._heroSpineGo.transform, uv0._heroCo.heroScale, uv0._heroCo.heroScale, 1)
		end)
	elseif slot11.type == 0 then
		slot0._heroSpine = GuiSpine.Create(slot0._heroGo, true)

		slot0._heroSpine:setResPath(slot12, function ()
			uv0._heroSkeletonGraphic = uv0._heroSpine:getSkeletonGraphic()
			uv0._heroSpineGo = uv0._heroSpine:getSpineGo()

			gohelper.setActive(uv0._heroSpineGo, false)

			uv1.sortingOrder = uv2 * 10

			if uv0._heroSkeletonGraphic and uv0._heroSkeletonGraphic.material.name ~= "spine_ui_default" then
				uv0._initMat = uv0._heroSkeletonGraphic.material
			end

			uv0:_setHeroMat(uv3)
			uv0:_fadeIn()
			uv0:_playHeroVoice()

			if uv4 then
				uv4(uv5)
			end

			transformhelper.setLocalPos(uv0._heroSpineGo.transform, uv0._heroCo.heroPos[1], uv0._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(uv0._heroSpineGo.transform, uv0._heroCo.heroScale, uv0._heroCo.heroScale, 1)
		end)
	else
		slot0._isLive2D = true
		slot0._heroSpine = GuiLive2d.Create(slot0._heroGo, true)

		slot0._heroSpine:cancelCamera()
		slot0._heroSpine:setResPath(slot12, function ()
			if not uv0._heroSpine then
				return
			end

			uv0._heroSpineGo = uv0._heroSpine:getSpineGo()

			if string.match(uv0._heroSpineGo.name, "306301_pikelesi") then
				gohelper.setActive(gohelper.findChild(uv0._heroSpineGo, "Drawables/ArtMesh188"), false)
			end

			gohelper.setActive(uv0._heroSpineGo, false)
			uv0._heroSpine:setSortingOrder(uv1 * 10)

			uv2.sortingOrder = uv1 * 10

			gohelper.setLayer(uv0._heroSpineGo, UnityLayer.UISecond, true)
			uv0:_setHeroMat(uv3)
			uv0:_fadeIn()
			uv0:_playHeroVoice()

			if uv4 then
				uv4(uv5)
			end

			transformhelper.setLocalPos(uv0._heroSpineGo.transform, uv0._heroCo.heroPos[1], uv0._heroCo.heroPos[2], 0)
			uv0._heroSpine:setLocalScale(uv0._heroCo.heroScale)
		end)
	end
end

function slot0._grayUpdate(slot0, slot1)
	if slot0._isLive2D then
		if not slot0._heroSpineGo then
			return
		end

		if slot0._heroSpineGo:GetComponent(typeof(ZProj.CubismController)) then
			for slot6 = 0, slot2.InstancedMaterials.Length - 1 do
				slot2.InstancedMaterials[slot6]:SetFloat("_LumFactor", slot1)
			end
		end
	elseif slot0._heroSkeletonGraphic and slot0._heroSkeletonGraphic.material then
		slot2:SetFloat("_LumFactor", slot1)
	end
end

function slot0._grayFinished(slot0)
	slot0:_grayUpdate(1)

	if slot0._grayTweenId then
		ZProj.TweenHelper.KillById(slot0._grayTweenId)

		slot0._grayTweenId = nil
	end
end

function slot0._playHeroVoice(slot0)
	if not slot0._heroSpineGo then
		TaskDispatcher.runRepeat(slot0._waitHeroSpineLoaded, slot0, 0.01)

		return
	end

	slot0:_waitHeroSpineLoaded()
end

function slot0._waitHeroSpineLoaded(slot0)
	if not slot0._heroSpineGo then
		return
	end

	if StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(slot0._heroCo.heroIndex).hideNodes ~= "" then
		for slot6, slot7 in pairs(string.split(slot1.hideNodes, "|")) do
			gohelper.setActive(gohelper.findChild(slot0._heroSpineGo, slot7), false)
		end
	end

	slot0:_grayUpdate(0)
	TaskDispatcher.cancelTask(slot0._waitHeroSpineLoaded, slot0)

	if not string.match(slot0._heroSpineGo.name, "305301_yaxian") or slot0._heroSpine._curBodyName ~= "b_idle2" then
		slot0._heroSpine:stopVoice()
	end

	slot3 = slot0._heroSpine:getSpineVoice()

	slot3:setDiffFaceBiYan(true)
	slot3:setInStory()
	slot0._heroSpine:playVoice({
		motion = slot0._heroCo.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		face = slot0._heroCo.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		mouth = slot0._heroCo.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		storyAudioId = slot0._conAudioId,
		storyHeroIndex = slot0._heroCo.heroIndex
	})

	if slot0._heroCo.effs[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] ~= "" then
		slot0:_playHeroEffect()
	end
end

function slot0._playHeroEffect(slot0)
	if slot0._grayTweenId then
		ZProj.TweenHelper.KillById(slot0._grayTweenId)

		slot0._grayTweenId = nil
	end

	if not slot0._heroCo.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or slot1 == "" then
		return
	end

	if not string.split(slot1, "#")[1] then
		return
	end

	if slot2[1] == StoryEnum.HeroEffect.Gray then
		if tonumber(slot2[2]) and tonumber(slot2[2]) > 0.1 then
			slot0._grayTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, tonumber(slot2[2]), slot0._grayUpdate, slot0._grayFinished, slot0, nil, EaseType.Linear)
		else
			slot0:_grayUpdate(1)
		end
	else
		if slot2[1] == StoryEnum.HeroEffect.StyDissolve then
			slot0._heroLoader = MultiAbLoader.New()

			slot0._heroLoader:addPath("ui/materials/dynamic/spine_ui_stydissolve.mat")
			slot0._heroLoader:addPath("ui/viewres/story/v1a9_role_stydissolve.prefab")
			slot0._heroLoader:startLoad(function ()
				uv0._styDissolveMat = uv0._heroLoader:getAssetItem(uv1):GetResource(uv1)
				uv0._styDissolvePrefab = uv0._heroLoader:getAssetItem(uv2):GetResource(uv2)

				if tonumber(uv3[2]) and tonumber(uv3[2]) > 0.1 then
					TaskDispatcher.runDelay(uv0._startStyDissolve, uv0, tonumber(uv3[2]))
				else
					uv0:_startStyDissolve()
				end
			end)

			return
		end

		slot3 = GameUtil.splitString2(slot1, false, "|", "#")

		if slot0._heroLoader then
			slot0._heroLoader:dispose()
		end

		slot0._heroLoader = MultiAbLoader.New()

		for slot7, slot8 in ipairs(slot3) do
			if string.find(slot8[2], "roomcritteremoji") then
				return
			end

			slot0._heroLoader:addPath(string.format("effects/prefabs/story/%s.prefab", slot8[2]))
		end

		slot0._heroLoader:startLoad(function ()
			for slot3, slot4 in ipairs(uv0) do
				slot5 = string.format("effects/prefabs/story/%s.prefab", slot4[2])
				slot8 = gohelper.clone(uv1._heroLoader:getAssetItem(slot5):GetResource(slot5), gohelper.findChild(uv1._heroSpineGo, string.format("root/%s", slot4[1])))
				slot9 = transformhelper.getLocalScale(slot8.transform)

				transformhelper.setLocalPos(slot8.transform, tonumber(slot4[3]), tonumber(slot4[4]), 0)
				transformhelper.setLocalScale(slot8.transform, slot9 * tonumber(slot4[5]), slot9 * tonumber(slot4[5]), 1)
			end
		end)
	end
end

function slot0._startStyDissolve(slot0)
	slot0._heroSkeletonGraphic.material = slot0._styDissolveMat

	gohelper.clone(slot0._styDissolvePrefab, slot0._heroSpineGo)
end

function slot0.stopVoice(slot0)
	if slot0._heroSpine then
		slot0._heroSpine:stopVoice()
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onDelay, slot0)
	slot0:_grayUpdate(0)

	if slot0._fadeInTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeInTweenId)

		slot0._fadeInTweenId = nil
	end

	if slot0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(slot0._fadeOutTweenId)

		slot0._fadeOutTweenId = nil
	end

	if slot0._grayTweenId then
		ZProj.TweenHelper.KillById(slot0._grayTweenId)

		slot0._grayTweenId = nil
	end

	if slot0._heroSpineGo then
		gohelper.destroy(slot0._heroSpineGo)

		slot0._heroSpineGo = nil
	end

	if slot0._heroGo then
		ZProj.TweenHelper.KillByObj(slot0._heroGo.transform)
		gohelper.destroy(slot0._heroGo)
	end

	if slot0._heroSkeletonGraphic then
		ZProj.TweenHelper.KillByObj(slot0._heroSkeletonGraphic)
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		slot0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if slot0._heroLoader then
		slot0._heroLoader:dispose()

		slot0._heroLoader = nil
	end

	if slot0._heroSpine then
		slot0._heroSpine:onDestroy()

		slot0._heroSpine = nil
	end
end

return slot0

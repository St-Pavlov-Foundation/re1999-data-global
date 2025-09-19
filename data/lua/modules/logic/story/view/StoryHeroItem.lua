module("modules.logic.story.view.StoryHeroItem", package.seeall)

local var_0_0 = class("StoryHeroItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._heroCo = nil
	arg_1_0._heroGo = nil
	arg_1_0._heroSpine = {}
	arg_1_0._isLightSpine = false
	arg_1_0._heroEffects = {}
	arg_1_0._heroSkeletonGraphic = nil
end

function var_0_0.hideHero(arg_2_0)
	arg_2_0:_fadeOut()
end

function var_0_0.resetHero(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if StoryModel.instance:getReplaceHeroPath(arg_3_1.heroIndex) then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, arg_3_1)
		gohelper.setActive(arg_3_0._heroSpineGo, false)

		return
	end

	arg_3_0._noChangeBody = false

	TaskDispatcher.cancelTask(arg_3_0._waitHeroSpineLoaded, arg_3_0)

	if arg_3_2.name == "spine_ui_default" and arg_3_0._initMat then
		arg_3_2 = arg_3_0._initMat
	end

	arg_3_0._conAudioId = arg_3_4

	if arg_3_0._heroGo.activeSelf then
		local var_3_0 = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
		local var_3_1 = arg_3_1.effs[var_3_0]

		arg_3_0._noChangeBody = arg_3_0._heroSpineGo and var_3_1 and string.split(var_3_1, "#")[1] and string.split(var_3_1, "#")[1] == StoryEnum.HeroEffect.KeepAction

		if (arg_3_1.anims[var_3_0] ~= "" or arg_3_1.expressions[var_3_0] ~= "" or arg_3_1.mouses[var_3_0] ~= "") and not string.find(arg_3_1.mouses[var_3_0], "_auto") and arg_3_1.anims[var_3_0] == arg_3_0._heroCo.anims[var_3_0] and arg_3_1.expressions[var_3_0] == arg_3_0._heroCo.expressions[var_3_0] and arg_3_1.mouses[var_3_0] == arg_3_0._heroCo.mouses[var_3_0] then
			if not arg_3_0._isLightSpine then
				arg_3_0:_setHeroMat(arg_3_2)
			end

			return
		end
	end

	arg_3_0._hasBottomEffect = arg_3_3

	ZProj.TweenHelper.KillByObj(arg_3_0._heroGo.transform)

	if not arg_3_0._isLightSpine then
		arg_3_0._heroCo = arg_3_1

		arg_3_0:_setHeroMat(arg_3_2)

		if arg_3_0._heroGo.activeSelf then
			if arg_3_0._heroSpineGo then
				ZProj.TweenHelper.DOLocalMove(arg_3_0._heroSpineGo.transform, arg_3_0._heroCo.heroPos[1], arg_3_0._heroCo.heroPos[2], 0, 0.4)
				ZProj.TweenHelper.DOScale(arg_3_0._heroSpineGo.transform, arg_3_0._heroCo.heroScale, arg_3_0._heroCo.heroScale, 1, 0.1)
			end

			arg_3_0:_playHeroVoice()
		else
			if arg_3_0._heroSpineGo then
				transformhelper.setLocalPosXY(arg_3_0._heroSpineGo.transform, arg_3_0._heroCo.heroPos[1], arg_3_0._heroCo.heroPos[2])
				transformhelper.setLocalScale(arg_3_0._heroSpineGo.transform, arg_3_0._heroCo.heroScale, arg_3_0._heroCo.heroScale, 1)
			end

			arg_3_0:_fadeIn()
			arg_3_0:_playHeroVoice()
		end
	end

	gohelper.setActive(arg_3_0._heroGo, true)
end

function var_0_0._fadeIn(arg_4_0)
	if arg_4_0._isLightSpine or not arg_4_0._isLive2D and not arg_4_0._heroSkeletonGraphic then
		gohelper.setActive(arg_4_0._heroSpineGo, true)

		return
	end

	arg_4_0:_checkMatKeyWord()

	if arg_4_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_4_0._fadeInTweenId)

		arg_4_0._fadeInTweenId = nil
	end

	arg_4_0:_fadeInUpdate(0)

	arg_4_0._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_4_0._fadeInUpdate, arg_4_0._fadeInFinished, arg_4_0, nil, EaseType.Linear)
end

function var_0_0._fadeInUpdate(arg_5_0, arg_5_1)
	if not arg_5_0._heroSpine then
		return
	end

	if not arg_5_0._heroSpineGo then
		return
	end

	if arg_5_0._isLive2D then
		arg_5_0._heroSpine:setAlpha(arg_5_1)
	else
		local var_5_0, var_5_1, var_5_2 = transformhelper.getLocalPos(arg_5_0._heroSpineGo.transform)

		transformhelper.setLocalPos(arg_5_0._heroSpineGo.transform, var_5_0, var_5_1, 1 - arg_5_1)
	end

	arg_5_0:_setHeroFadeMat()
end

function var_0_0._setHeroFadeMat(arg_6_0)
	local var_6_0, var_6_1 = transformhelper.getLocalPos(arg_6_0._bgGo.transform)
	local var_6_2, var_6_3 = transformhelper.getLocalScale(arg_6_0._bgGo.transform)
	local var_6_4 = Vector4.New(var_6_2, var_6_3, var_6_0, var_6_1)
	local var_6_5 = arg_6_0._blitEff.capturedTexture

	if arg_6_0._heroSpine and arg_6_0._isLive2D then
		arg_6_0._heroSpine:setSceneTexture(var_6_5)
	elseif arg_6_0._heroSkeletonGraphic then
		arg_6_0._heroSkeletonGraphic.materialForRendering:SetTexture("_SceneMask", var_6_5)
		arg_6_0._heroSkeletonGraphic.materialForRendering:SetVector("_SceneMask_ST", var_6_4)
	end
end

function var_0_0._fadeInFinished(arg_7_0)
	if arg_7_0._heroSkeletonGraphic then
		arg_7_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		arg_7_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if arg_7_0._heroSpine and arg_7_0._isLive2D then
		arg_7_0._heroSpine:disableSceneAlpha()
	end

	if arg_7_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._fadeInTweenId)

		arg_7_0._fadeInTweenId = nil
	end
end

function var_0_0._setHeroMat(arg_8_0, arg_8_1)
	if arg_8_0._isLightSpine then
		return
	end

	if not arg_8_0._isLive2D and not arg_8_0._heroSkeletonGraphic then
		return
	end

	if not arg_8_0._heroSpine then
		return
	end

	if arg_8_0._isLive2D then
		if arg_8_1.name == "spine_ui_dark" then
			arg_8_0._heroSpine:SetDark()
		else
			arg_8_0._heroSpine:SetBright()
		end
	end

	if arg_8_0._heroSkeletonGraphic then
		if arg_8_0._heroSkeletonGraphic.material and arg_8_0._heroSkeletonGraphic.material == arg_8_1 then
			return
		end

		if arg_8_0._initMat then
			if arg_8_1.name == "spine_ui_default" then
				arg_8_1 = arg_8_0._initMat

				local var_8_0 = Color.New(1, 1, 1, 1)

				arg_8_1:SetColor("_Color", var_8_0)
			else
				arg_8_1 = arg_8_0._initMat

				local var_8_1 = Color.New(0.6, 0.6, 0.6, 1)

				arg_8_1:SetColor("_Color", var_8_1)
			end
		end

		arg_8_0._heroSkeletonGraphic.material = arg_8_1
	end
end

function var_0_0._checkMatKeyWord(arg_9_0)
	if arg_9_0._heroSpine and arg_9_0._isLive2D then
		arg_9_0._heroSpine:enableSceneAlpha()
	end

	if not arg_9_0._heroSkeletonGraphic then
		gohelper.setActive(arg_9_0._heroSpineGo, true)

		return
	end

	if arg_9_0._hasBottomEffect then
		arg_9_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		arg_9_0._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA2_ON")
	else
		arg_9_0._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA_ON")
		arg_9_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	TaskDispatcher.runDelay(arg_9_0._onDelay, arg_9_0, 0.05)
end

function var_0_0._onDelay(arg_10_0)
	if StoryModel.instance:getReplaceHeroPath(arg_10_0._heroCo.heroIndex) then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, arg_10_0._heroCo)
		gohelper.setActive(arg_10_0._heroSpineGo, false)

		return
	end

	gohelper.setActive(arg_10_0._heroSpineGo, true)
end

function var_0_0._fadeOut(arg_11_0)
	if not arg_11_0._heroSpine then
		return
	end

	if arg_11_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._fadeInTweenId)

		arg_11_0._fadeInTweenId = nil
	end

	if arg_11_0._isLightSpine or not arg_11_0._isLive2D and not arg_11_0._heroSkeletonGraphic then
		arg_11_0._heroSpine:stopVoice()
		gohelper.setActive(arg_11_0._heroGo, false)

		return
	end

	arg_11_0:_checkMatKeyWord()

	if arg_11_0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(arg_11_0._fadeOutTweenId)

		arg_11_0._fadeOutTweenId = nil
	end

	arg_11_0._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, arg_11_0._fadeOutUpdate, arg_11_0._fadeOutFinished, arg_11_0, nil, EaseType.Linear)
end

function var_0_0._fadeOutUpdate(arg_12_0, arg_12_1)
	if not arg_12_0._heroSpine then
		return
	end

	if not arg_12_0._heroSpineGo then
		return
	end

	if arg_12_0._isLive2D then
		arg_12_0._heroSpine:setAlpha(arg_12_1)
	else
		local var_12_0, var_12_1, var_12_2 = transformhelper.getLocalPos(arg_12_0._heroSpineGo.transform)

		transformhelper.setLocalPos(arg_12_0._heroSpineGo.transform, var_12_0, var_12_1, 1 - arg_12_1)
	end

	arg_12_0:_setHeroFadeMat()
end

function var_0_0._fadeOutFinished(arg_13_0)
	if not arg_13_0._heroSpine then
		return
	end

	gohelper.setActive(arg_13_0._heroGo, false)
	arg_13_0:_fadeOutUpdate(1)

	if arg_13_0._heroSkeletonGraphic then
		arg_13_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		arg_13_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if arg_13_0._heroSpine and arg_13_0._isLive2D then
		arg_13_0._heroSpine:disableSceneAlpha()
	end

	arg_13_0:onDestroy()
end

function var_0_0.buildHero(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5, arg_14_6)
	arg_14_0._noChangeBody = false
	arg_14_0._conAudioId = arg_14_6
	arg_14_0._heroCo = arg_14_1
	arg_14_0._heroGo = gohelper.create2d(arg_14_0.viewGO, "rolespine")

	local var_14_0 = gohelper.onceAddComponent(arg_14_0._heroGo, typeof(UnityEngine.Canvas))

	var_14_0.overrideSorting = true

	local var_14_1 = gohelper.getSibling(arg_14_0._heroGo)

	arg_14_0._blitEff = gohelper.findChild(arg_14_0.viewGO.transform.parent.gameObject, "#go_rolebg"):GetComponent(typeof(UrpCustom.UIBlitEffect))

	local var_14_2 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_14_0._bgGo = gohelper.findChild(var_14_2, "#go_upbg/#simage_bgimg")

	gohelper.setLayer(arg_14_0._heroGo, UnityLayer.UISecond, true)

	local var_14_3 = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(arg_14_0._heroCo.heroIndex)

	if not var_14_3 then
		return
	end

	local var_14_4 = var_14_3.type == 0 and string.format("rolesstory/%s", var_14_3.prefab) or string.format("live2d/roles/%s", var_14_3.live2dPrefab)
	local var_14_5 = string.split(var_14_4, "_")

	arg_14_0._isLive2D = false
	arg_14_0._isLightSpine = string.split(var_14_5[#var_14_5], ".")[1] == "light"

	if arg_14_0._isLightSpine then
		arg_14_0._heroSpine = LightSpine.Create(arg_14_0._heroGo, true)

		arg_14_0._heroSpine:setResPath(var_14_4, function()
			arg_14_0._heroSpineGo = arg_14_0._heroSpine:getSpineGo()

			arg_14_0:_playHeroVoice()
			arg_14_0:_setHeroMat(arg_14_2)

			if arg_14_4 then
				arg_14_4(arg_14_5)
			end

			transformhelper.setLocalPos(arg_14_0._heroSpineGo.transform, arg_14_0._heroCo.heroPos[1], arg_14_0._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(arg_14_0._heroSpineGo.transform, arg_14_0._heroCo.heroScale, arg_14_0._heroCo.heroScale, 1)
		end)
	elseif var_14_3.type == 0 then
		arg_14_0._heroSpine = GuiSpine.Create(arg_14_0._heroGo, true)

		arg_14_0._heroSpine:setResPath(var_14_4, function()
			arg_14_0._heroSkeletonGraphic = arg_14_0._heroSpine:getSkeletonGraphic()
			arg_14_0._heroSpineGo = arg_14_0._heroSpine:getSpineGo()

			gohelper.setActive(arg_14_0._heroSpineGo, false)

			var_14_0.sortingOrder = (var_14_1 + 1) * 10

			if arg_14_0._heroSkeletonGraphic and arg_14_0._heroSkeletonGraphic.material.name ~= "spine_ui_default" then
				arg_14_0._initMat = arg_14_0._heroSkeletonGraphic.material
			end

			arg_14_0:_setHeroMat(arg_14_2)
			arg_14_0:_fadeIn()
			arg_14_0:_playHeroVoice()

			if arg_14_4 then
				arg_14_4(arg_14_5)
			end

			transformhelper.setLocalPos(arg_14_0._heroSpineGo.transform, arg_14_0._heroCo.heroPos[1], arg_14_0._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(arg_14_0._heroSpineGo.transform, arg_14_0._heroCo.heroScale, arg_14_0._heroCo.heroScale, 1)
		end)
	else
		arg_14_0._isLive2D = true
		arg_14_0._heroSpine = GuiLive2d.Create(arg_14_0._heroGo, true)

		arg_14_0._heroSpine:cancelCamera()
		arg_14_0._heroSpine:setResPath(var_14_4, function()
			if not arg_14_0._heroSpine then
				return
			end

			arg_14_0._heroSpineGo = arg_14_0._heroSpine:getSpineGo()

			if string.match(arg_14_0._heroSpineGo.name, "306301_pikelesi") then
				local var_17_0 = gohelper.findChild(arg_14_0._heroSpineGo, "Drawables/ArtMesh188")

				gohelper.setActive(var_17_0, false)
			end

			gohelper.setActive(arg_14_0._heroSpineGo, false)
			arg_14_0._heroSpine:setSortingOrder(var_14_1 * 10)

			var_14_0.sortingOrder = (var_14_1 + 1) * 10

			gohelper.setLayer(arg_14_0._heroSpineGo, UnityLayer.UISecond, true)
			arg_14_0:_setHeroMat(arg_14_2)
			arg_14_0:_fadeIn()
			arg_14_0:_playHeroVoice()

			if arg_14_4 then
				arg_14_4(arg_14_5)
			end

			transformhelper.setLocalPos(arg_14_0._heroSpineGo.transform, arg_14_0._heroCo.heroPos[1], arg_14_0._heroCo.heroPos[2], 0)
			arg_14_0._heroSpine:setLocalScale(arg_14_0._heroCo.heroScale)
		end)
	end
end

function var_0_0._grayUpdate(arg_18_0, arg_18_1)
	if arg_18_0._isLive2D then
		if not arg_18_0._heroSpineGo then
			return
		end

		local var_18_0 = arg_18_0._heroSpineGo:GetComponent(typeof(ZProj.CubismController))

		if var_18_0 then
			for iter_18_0 = 0, var_18_0.InstancedMaterials.Length - 1 do
				var_18_0.InstancedMaterials[iter_18_0]:SetFloat("_LumFactor", arg_18_1)
			end
		end
	elseif arg_18_0._heroSkeletonGraphic then
		local var_18_1 = arg_18_0._heroSkeletonGraphic.material

		if var_18_1 then
			var_18_1:SetFloat("_LumFactor", arg_18_1)
		end
	end
end

function var_0_0._grayFinished(arg_19_0)
	arg_19_0:_grayUpdate(1)

	if arg_19_0._grayTweenId then
		ZProj.TweenHelper.KillById(arg_19_0._grayTweenId)

		arg_19_0._grayTweenId = nil
	end
end

function var_0_0._playHeroVoice(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._waitHeroSpineLoaded, arg_20_0)

	if not arg_20_0._heroSpineGo then
		TaskDispatcher.runRepeat(arg_20_0._waitHeroSpineLoaded, arg_20_0, 0.01)

		return
	end

	arg_20_0:_waitHeroSpineLoaded()
end

function var_0_0._waitHeroSpineLoaded(arg_21_0)
	if not arg_21_0._heroSpine then
		return
	end

	if not arg_21_0._heroSpineGo then
		return
	end

	local var_21_0 = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(arg_21_0._heroCo.heroIndex)

	if var_21_0.hideNodes ~= "" then
		local var_21_1 = string.split(var_21_0.hideNodes, "|")

		for iter_21_0, iter_21_1 in pairs(var_21_1) do
			local var_21_2 = gohelper.findChild(arg_21_0._heroSpineGo, iter_21_1)

			gohelper.setActive(var_21_2, false)
		end
	end

	arg_21_0:_grayUpdate(0)
	TaskDispatcher.cancelTask(arg_21_0._waitHeroSpineLoaded, arg_21_0)

	local var_21_3 = arg_21_0._heroCo.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local var_21_4 = not string.match(arg_21_0._heroSpineGo.name, "305301_yaxian") or arg_21_0._heroSpine._curBodyName ~= "b_idle2"
	local var_21_5 = "flag_skipvoicestop|"

	if string.find(var_21_3, var_21_5) then
		var_21_4 = false
		var_21_3 = string.gsub(var_21_3, var_21_5, "")
	end

	if var_21_4 and not arg_21_0._noChangeBody then
		arg_21_0._heroSpine:stopVoice()
	end

	local var_21_6 = {
		motion = var_21_3,
		face = arg_21_0._heroCo.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		mouth = arg_21_0._heroCo.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		storyAudioId = arg_21_0._conAudioId,
		storyHeroIndex = arg_21_0._heroCo.heroIndex,
		noChangeBody = arg_21_0._noChangeBody
	}
	local var_21_7 = arg_21_0._heroSpine:getSpineVoice()

	var_21_7:setDiffFaceBiYan(true)
	var_21_7:setInStory()
	arg_21_0._heroSpine:playVoice(var_21_6)

	if arg_21_0._heroCo.effs[GameLanguageMgr.instance:getLanguageTypeStoryIndex()] ~= "" then
		arg_21_0:_playHeroEffect()
	end
end

function var_0_0._playHeroEffect(arg_22_0)
	if arg_22_0._grayTweenId then
		ZProj.TweenHelper.KillById(arg_22_0._grayTweenId)

		arg_22_0._grayTweenId = nil
	end

	local var_22_0 = arg_22_0._heroCo.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if not var_22_0 or var_22_0 == "" then
		return
	end

	local var_22_1 = string.split(var_22_0, "#")

	if not var_22_1[1] then
		return
	end

	if var_22_1[1] == StoryEnum.HeroEffect.Gray then
		if tonumber(var_22_1[2]) and tonumber(var_22_1[2]) > 0.1 then
			arg_22_0._grayTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, tonumber(var_22_1[2]), arg_22_0._grayUpdate, arg_22_0._grayFinished, arg_22_0, nil, EaseType.Linear)
		else
			arg_22_0:_grayUpdate(1)
		end
	elseif var_22_1[1] == StoryEnum.HeroEffect.StyDissolve then
		arg_22_0._heroLoader = MultiAbLoader.New()

		local var_22_2 = "ui/materials/dynamic/spine_ui_stydissolve.mat"
		local var_22_3 = "ui/viewres/story/v1a9_role_stydissolve.prefab"

		arg_22_0._heroLoader:addPath(var_22_2)
		arg_22_0._heroLoader:addPath(var_22_3)
		arg_22_0._heroLoader:startLoad(function()
			arg_22_0._styDissolveMat = arg_22_0._heroLoader:getAssetItem(var_22_2):GetResource(var_22_2)
			arg_22_0._styDissolvePrefab = arg_22_0._heroLoader:getAssetItem(var_22_3):GetResource(var_22_3)

			if tonumber(var_22_1[2]) and tonumber(var_22_1[2]) > 0.1 then
				TaskDispatcher.runDelay(arg_22_0._startStyDissolve, arg_22_0, tonumber(var_22_1[2]))
			else
				arg_22_0:_startStyDissolve()
			end
		end)
	elseif var_22_1[1] == StoryEnum.HeroEffect.KeepAction then
		-- block empty
	else
		if not arg_22_0._heroSpineGo then
			return
		end

		local var_22_4 = GameUtil.splitString2(var_22_0, false, "|", "#")

		if arg_22_0._heroLoader then
			arg_22_0._heroLoader:dispose()
		end

		arg_22_0._heroLoader = MultiAbLoader.New()

		for iter_22_0, iter_22_1 in ipairs(var_22_4) do
			if string.find(iter_22_1[2], "roomcritteremoji") then
				return
			end

			arg_22_0._heroLoader:addPath(string.format("effects/prefabs/story/%s.prefab", iter_22_1[2]))
		end

		arg_22_0._heroLoader:startLoad(function()
			for iter_24_0, iter_24_1 in ipairs(var_22_4) do
				local var_24_0 = string.format("effects/prefabs/story/%s.prefab", iter_24_1[2])
				local var_24_1 = arg_22_0._heroLoader:getAssetItem(var_24_0):GetResource(var_24_0)
				local var_24_2 = gohelper.findChild(arg_22_0._heroSpineGo, string.format("root/%s", iter_24_1[1]))
				local var_24_3 = gohelper.clone(var_24_1, var_24_2)
				local var_24_4 = transformhelper.getLocalScale(var_24_3.transform)

				transformhelper.setLocalPos(var_24_3.transform, tonumber(iter_24_1[3]), tonumber(iter_24_1[4]), 0)
				transformhelper.setLocalScale(var_24_3.transform, var_24_4 * tonumber(iter_24_1[5]), var_24_4 * tonumber(iter_24_1[5]), 1)
			end
		end)
	end
end

function var_0_0._startStyDissolve(arg_25_0)
	arg_25_0._heroSkeletonGraphic.material = arg_25_0._styDissolveMat

	gohelper.clone(arg_25_0._styDissolvePrefab, arg_25_0._heroSpineGo)
end

function var_0_0.stopVoice(arg_26_0)
	if arg_26_0._heroSpine then
		arg_26_0._heroSpine:stopVoice()
	end
end

function var_0_0.onDestroy(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._onDelay, arg_27_0)
	arg_27_0:_grayUpdate(0)

	if arg_27_0._fadeInTweenId then
		ZProj.TweenHelper.KillById(arg_27_0._fadeInTweenId)

		arg_27_0._fadeInTweenId = nil
	end

	if arg_27_0._fadeOutTweenId then
		ZProj.TweenHelper.KillById(arg_27_0._fadeOutTweenId)

		arg_27_0._fadeOutTweenId = nil
	end

	if arg_27_0._grayTweenId then
		ZProj.TweenHelper.KillById(arg_27_0._grayTweenId)

		arg_27_0._grayTweenId = nil
	end

	if arg_27_0._heroSpineGo then
		gohelper.destroy(arg_27_0._heroSpineGo)

		arg_27_0._heroSpineGo = nil
	end

	if arg_27_0._heroGo then
		ZProj.TweenHelper.KillByObj(arg_27_0._heroGo.transform)
		gohelper.destroy(arg_27_0._heroGo)
	end

	if arg_27_0._heroSkeletonGraphic then
		ZProj.TweenHelper.KillByObj(arg_27_0._heroSkeletonGraphic)
		arg_27_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		arg_27_0._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if arg_27_0._heroLoader then
		arg_27_0._heroLoader:dispose()

		arg_27_0._heroLoader = nil
	end

	if arg_27_0._heroSpine then
		arg_27_0._heroSpine:onDestroy()

		arg_27_0._heroSpine = nil
	end
end

return var_0_0

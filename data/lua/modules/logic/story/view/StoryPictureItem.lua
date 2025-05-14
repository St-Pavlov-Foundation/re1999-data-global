module("modules.logic.story.view.StoryPictureItem", package.seeall)

local var_0_0 = class("StoryPictureItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._picParentGo = gohelper.create2d(arg_1_0.viewGO, arg_1_2)
	arg_1_0._picName = arg_1_2
	arg_1_0._picCo = arg_1_3
	arg_1_0._picGo = nil
	arg_1_0._picImg = nil
	arg_1_0._picLoaded = false

	if arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_1_0._build, arg_1_0, arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_1_0:_build()
	end
end

function var_0_0._build(arg_2_0)
	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	TaskDispatcher.cancelTask(arg_2_0._realDestroy, arg_2_0)

	if arg_2_0._pictureLoader then
		arg_2_0._pictureLoader:dispose()

		arg_2_0._pictureLoader = nil
	end

	if arg_2_0:_isSpImg() then
		return
	end

	if arg_2_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		local var_2_0 = "ui/viewres/story/storyfullfocusitem.prefab"

		arg_2_0._pictureLoader = PrefabInstantiate.Create(arg_2_0._picParentGo)

		arg_2_0._pictureLoader:startLoad(var_2_0, arg_2_0._onFullFocusPictureLoaded, arg_2_0)
	else
		local var_2_1 = "ui/viewres/story/storynormalpicitem.prefab"

		arg_2_0._pictureLoader = PrefabInstantiate.Create(arg_2_0._picParentGo)

		arg_2_0._pictureLoader:startLoad(var_2_1, arg_2_0._onPicPrefabLoaded, arg_2_0)
	end
end

function var_0_0._onPicPrefabLoaded(arg_3_0)
	arg_3_0._picLoaded = true
	arg_3_0._picGo = arg_3_0._pictureLoader:getInstGO()
	arg_3_0._picAni = arg_3_0._picGo:GetComponent(typeof(UnityEngine.Animator))
	arg_3_0._picAni.enabled = false

	transformhelper.setLocalPosXY(arg_3_0._picGo.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

	arg_3_0._simg = gohelper.findChildSingleImage(arg_3_0._picGo, "result")
	arg_3_0._txtImg = gohelper.findChildText(arg_3_0._picGo, "txt")
	arg_3_0._txtEnImg = gohelper.findChildText(arg_3_0._picGo, "txten")

	transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, 0, 0)

	if arg_3_0._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(arg_3_0._simg.gameObject, false)

		local var_3_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local var_3_1 = GameLanguageMgr.instance:getShortCutByStoryIndex(var_3_0)
		local var_3_2 = string.split(arg_3_0._picCo.picture, "#")
		local var_3_3 = StoryConfig.instance:getStoryPicTxtConfig(tonumber(var_3_2[1]))
		local var_3_4 = var_3_1 == LangSettings.shortcutTab[LangSettings.zh] and var_3_3.fontType == 1

		gohelper.setActive(arg_3_0._txtImg.gameObject, var_3_4)
		gohelper.setActive(arg_3_0._txtEnImg.gameObject, not var_3_4)

		local var_3_5 = var_3_3[var_3_1]
		local var_3_6 = 0.1 * LuaUtil.getStrLen(var_3_5) * var_3_2[2]

		if var_3_4 then
			arg_3_0.tweenId = ZProj.TweenHelper.DOText(arg_3_0._txtImg, var_3_5, var_3_6, nil, nil, nil, EaseType.Linear)
		else
			arg_3_0.tweenId = ZProj.TweenHelper.DOText(arg_3_0._txtEnImg, var_3_5, var_3_6, nil, nil, nil, EaseType.Linear)
		end

		if arg_3_0._picCo.inType == StoryEnum.PictureInType.FadeIn then
			arg_3_0._txtImg.text = var_3_5

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_3_0._picGo, 0, 1, arg_3_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		else
			arg_3_0._txtImg.color.a = 1
			arg_3_0._txtEnImg.color.a = 1
		end

		if arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_3_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

			if arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_3_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_3_0._playShake, arg_3_0, arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

			if arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_3_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_3_0._playScale, arg_3_0, arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_3_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_3_0:_playFollowBg()
		end

		return
	end

	gohelper.setActive(arg_3_0._simg.gameObject, true)
	gohelper.setActive(arg_3_0._txtImg.gameObject, false)
	gohelper.setActive(arg_3_0._txtEnImg.gameObject, false)
	arg_3_0._simg:LoadImage(ResUrl.getStoryItem(arg_3_0._picCo.picture), arg_3_0._onPicImageLoaded, arg_3_0)
end

function var_0_0._onPicImageLoaded(arg_4_0)
	arg_4_0._picAni.enabled = false

	ZProj.UGUIHelper.SetImageSize(arg_4_0._simg.gameObject)

	arg_4_0._picImg = arg_4_0._simg.gameObject:GetComponent(gohelper.Type_Image)

	local var_4_0, var_4_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_4_0._picImg, 0, 0)

	if var_4_0 >= 1920 or var_4_1 > 1080 then
		gohelper.onceAddComponent(arg_4_0._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		transformhelper.setLocalScale(arg_4_0._simg.gameObject.transform, var_4_0 / 1920, var_4_1 / 1080, 1)
	end

	if arg_4_0._picCo.inType == StoryEnum.PictureInType.FadeIn then
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_4_0._picGo, 0, 1, arg_4_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	else
		arg_4_0._picImg.color.a = 1
	end

	if arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if arg_4_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_4_0:_playShake()
		else
			TaskDispatcher.runDelay(arg_4_0._playShake, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_4_0:_playScale()
		else
			TaskDispatcher.runDelay(arg_4_0._playScale, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		arg_4_0:_playFollowBg()
	end
end

function var_0_0._playShake(arg_5_0)
	arg_5_0._picAni.enabled = true

	local var_5_0 = {
		"low",
		"middle",
		"high"
	}

	arg_5_0._picAni:Play(var_5_0[arg_5_0._picCo.effDegree])

	arg_5_0._picAni.speed = arg_5_0._picCo.effRate

	TaskDispatcher.runDelay(arg_5_0._shakeStop, arg_5_0, arg_5_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_6_0)
	arg_6_0._picAni.speed = arg_6_0._picCo.effRate

	arg_6_0._picAni:SetBool("stoploop", true)
end

function var_0_0._playFollowBg(arg_7_0)
	local var_7_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_7_0._bgGo = gohelper.findChild(var_7_0, "#go_upbg")

	local var_7_1, var_7_2 = transformhelper.getLocalPos(arg_7_0._picGo.transform)

	arg_7_0._deltaPos = {
		var_7_1,
		var_7_2
	}

	TaskDispatcher.runRepeat(arg_7_0._followBg, arg_7_0, 0.02)
end

function var_0_0._followBg(arg_8_0)
	local var_8_0, var_8_1 = transformhelper.getLocalScale(arg_8_0._bgGo.transform)

	transformhelper.setLocalPosXY(arg_8_0._picGo.transform, var_8_0 * arg_8_0._deltaPos[1], var_8_1 * arg_8_0._deltaPos[2])
	transformhelper.setLocalScale(arg_8_0._picGo.transform, var_8_1, var_8_1, 1)
end

function var_0_0._playScale(arg_9_0)
	if arg_9_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		transformhelper.setLocalScale(arg_9_0._picGo.transform, arg_9_0._picCo.effRate, arg_9_0._picCo.effRate, 1)

		return
	end

	arg_9_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_9_0._picGo.transform, arg_9_0._picCo.effRate, arg_9_0._picCo.effRate, 1, arg_9_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0.resetStep(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._playShake, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._shakeStop, arg_10_0)
	ZProj.TweenHelper.KillByObj(arg_10_0._picGo)
end

function var_0_0.reset(arg_11_0, arg_11_1, arg_11_2)
	if not arg_11_0._picGo then
		return
	end

	arg_11_0.viewGO = arg_11_1
	arg_11_0._picCo = arg_11_2

	TaskDispatcher.cancelTask(arg_11_0._realDestroy, arg_11_0)

	if arg_11_0:_isSpImg() then
		return
	end

	if arg_11_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		arg_11_0:_setFullPicture()
	else
		arg_11_0._picAni.enabled = false

		arg_11_0:_setNormalPicture()

		if arg_11_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_11_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if arg_11_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_11_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_11_0._playShake, arg_11_0, arg_11_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_11_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if arg_11_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_11_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_11_0._playScale, arg_11_0, arg_11_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_11_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_11_0:_playFollowBg()
		end
	end
end

function var_0_0.isFloatType(arg_12_0)
	return arg_12_0._picCo.picType == StoryEnum.PictureType.Float
end

function var_0_0._setNormalPicture(arg_13_0)
	arg_13_0._simg:UnLoadImage()
	arg_13_0._simg:LoadImage(ResUrl.getStoryItem(arg_13_0._picCo.picture), arg_13_0._onPictureLoaded, arg_13_0)
end

function var_0_0._isSpImg(arg_14_0)
	local var_14_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP

	return string.match(arg_14_0._picCo.picture, "v2a5_liangyue_story") and not var_14_0
end

function var_0_0._setFullPicture(arg_15_0)
	if not arg_15_0._picParentGo then
		return
	end

	arg_15_0._picParentGo.transform:SetParent(arg_15_0.viewGO.transform)

	arg_15_0._picImg = gohelper.findChildImage(arg_15_0._picGo, "result")

	local var_15_0 = SLFramework.UGUI.GuiHelper.ParseColor(arg_15_0._picCo.picColor)

	arg_15_0._picImg.color = var_15_0

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_15_0._picGo, 0, var_15_0.a, arg_15_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	recthelper.setSize(arg_15_0._picGo.transform, 2 * arg_15_0._picCo.cirRadius, 2 * arg_15_0._picCo.cirRadius)
	transformhelper.setLocalPosXY(arg_15_0._picGo.transform, arg_15_0._picCo.pos[1], arg_15_0._picCo.pos[2])
	transformhelper.setLocalScale(arg_15_0._picGo.transform, 1, 1, 1)
	transformhelper.setLocalPosXY(arg_15_0._picImg.transform, -arg_15_0._picCo.pos[1], -arg_15_0._picCo.pos[2])
end

function var_0_0._onFullFocusPictureLoaded(arg_16_0)
	arg_16_0._picLoaded = true

	if not arg_16_0._pictureLoader then
		return
	end

	arg_16_0._picGo = arg_16_0._pictureLoader:getInstGO()
	arg_16_0._picGo.name = arg_16_0._picName

	arg_16_0:_setFullPicture()
end

function var_0_0.destroyPicture(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_0._picCo = arg_17_1
	arg_17_0._destroyKeepTime = arg_17_3 or 0

	if not arg_17_0._picCo then
		return
	end

	if arg_17_2 then
		arg_17_0:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(arg_17_0._playShake, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._realDestroy, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._startDestroy, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._checkDestroyItem, arg_17_0)

	if arg_17_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(arg_17_0._startDestroy, arg_17_0, 0.1 + arg_17_0._destroyKeepTime)
	elseif arg_17_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_17_0._startDestroy, arg_17_0, arg_17_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_17_0:_startDestroy()
	end
end

function var_0_0._startDestroy(arg_18_0)
	if arg_18_0._picCo.outType == StoryEnum.PictureOutType.Hard then
		arg_18_0:onDestroy()
	else
		if not arg_18_0._picGo then
			return
		end

		if not arg_18_0._picLoaded then
			return
		end

		ZProj.TweenHelper.KillByObj(arg_18_0._picImg)

		if arg_18_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			local var_18_0 = arg_18_0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_18_0._picGo, var_18_0, 0, arg_18_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, arg_18_0.onDestroy, arg_18_0, nil, EaseType.Linear)
		else
			arg_18_0:onDestroy()
		end
	end
end

function var_0_0.onDestroy(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._build, arg_19_0)

	if arg_19_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(arg_19_0._checkDestroyItem, arg_19_0, 0.1)
	else
		arg_19_0:_realDestroy()
	end
end

function var_0_0._checkDestroyItem(arg_20_0)
	if not arg_20_0._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(arg_20_0._checkDestroyItem, arg_20_0)
	arg_20_0:_realDestroy()
end

function var_0_0._realDestroy(arg_21_0)
	if not arg_21_0._picLoaded then
		return
	end

	if arg_21_0._pictureLoader and arg_21_0._pictureLoader:getAssetItem() then
		arg_21_0._pictureLoader:getAssetItem():Release()
		arg_21_0._pictureLoader:dispose()

		arg_21_0._pictureLoader = nil
	end

	TaskDispatcher.cancelTask(arg_21_0._playShake, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._followBg, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._realDestroy, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._checkDestroyItem, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._startDestroy, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._build, arg_21_0)
	ZProj.TweenHelper.KillByObj(arg_21_0._picGo)
	TaskDispatcher.cancelTask(arg_21_0._shakeStop, arg_21_0)

	if arg_21_0._simg then
		arg_21_0._simg:UnLoadImage()

		arg_21_0._simg = nil
	end

	gohelper.destroy(arg_21_0._picParentGo)
end

return var_0_0

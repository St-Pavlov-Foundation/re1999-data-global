module("modules.logic.story.view.StoryPictureItem", package.seeall)

local var_0_0 = class("StoryPictureItem")

function var_0_0._isSpImg(arg_1_0)
	local var_1_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP

	return string.match(arg_1_0._picCo.picture, "v2a5_liangyue_story") and not var_1_0
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.viewGO = arg_2_1
	arg_2_0._picParentGo = gohelper.create2d(arg_2_0.viewGO, arg_2_2)
	arg_2_0._picName = arg_2_2
	arg_2_0._picCo = arg_2_3
	arg_2_0._picGo = nil
	arg_2_0._picImg = nil
	arg_2_0._picLoaded = false

	if arg_2_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_2_0._build, arg_2_0, arg_2_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_2_0:_build()
	end
end

function var_0_0._build(arg_3_0)
	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	TaskDispatcher.cancelTask(arg_3_0._realDestroy, arg_3_0)

	if arg_3_0._pictureLoader then
		arg_3_0._pictureLoader:dispose()

		arg_3_0._pictureLoader = nil
	end

	if arg_3_0:_isSpImg() then
		return
	end

	if arg_3_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		local var_3_0 = "ui/viewres/story/storyfullfocusitem.prefab"

		arg_3_0._pictureLoader = PrefabInstantiate.Create(arg_3_0._picParentGo)

		arg_3_0._pictureLoader:startLoad(var_3_0, arg_3_0._onFullFocusPictureLoaded, arg_3_0)
	else
		local var_3_1 = "ui/viewres/story/storynormalpicitem.prefab"

		arg_3_0._pictureLoader = PrefabInstantiate.Create(arg_3_0._picParentGo)

		arg_3_0._pictureLoader:startLoad(var_3_1, arg_3_0._onPicPrefabLoaded, arg_3_0)
	end
end

function var_0_0._onPicPrefabLoaded(arg_4_0)
	arg_4_0._picLoaded = true
	arg_4_0._picGo = arg_4_0._pictureLoader:getInstGO()
	arg_4_0._picAni = arg_4_0._picGo:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._picAni.enabled = false

	transformhelper.setLocalPosXY(arg_4_0._picGo.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])

	arg_4_0._simg = gohelper.findChildSingleImage(arg_4_0._picGo, "result")
	arg_4_0._txtImg = gohelper.findChildText(arg_4_0._picGo, "txt")
	arg_4_0._txtEnImg = gohelper.findChildText(arg_4_0._picGo, "txten")
	arg_4_0._txtTmp = gohelper.findChildText(arg_4_0._picGo, "txt_tmp")

	transformhelper.setLocalPosXY(arg_4_0._txtEnImg.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_4_0._txtImg.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_4_0._txtTmp.transform, 0, 0)

	if arg_4_0._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(arg_4_0._simg.gameObject, false)

		local var_4_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local var_4_1 = GameLanguageMgr.instance:getShortCutByStoryIndex(var_4_0)
		local var_4_2 = string.splitToNumber(arg_4_0._picCo.picture, "#")
		local var_4_3 = StoryConfig.instance:getStoryPicTxtConfig(tonumber(var_4_2[1]))
		local var_4_4 = LuaUtil.containChinese(var_4_3[LangSettings.shortcutTab[LangSettings.zh]])

		gohelper.setActive(arg_4_0._txtEnImg.gameObject, var_4_3.fontType == 0)
		gohelper.setActive(arg_4_0._txtTmp.gameObject, var_4_4 and var_4_3.fontType ~= 0 and arg_4_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn)
		gohelper.setActive(arg_4_0._txtImg.gameObject, not arg_4_0._txtEnImg.gameObject.activeSelf and not arg_4_0._txtTmp.gameObject.activeSelf)

		local var_4_5 = var_4_3[var_4_1]
		local var_4_6 = 0.1 * LuaUtil.getStrLen(var_4_5) * var_4_2[2]

		if arg_4_0._picCo.inType ~= StoryEnum.PictureInType.TxtFadeIn then
			if var_4_3.fontType == 0 then
				arg_4_0.tweenId = ZProj.TweenHelper.DOText(arg_4_0._txtEnImg, var_4_5, var_4_6, nil, nil, nil, EaseType.Linear)
			else
				arg_4_0.tweenId = ZProj.TweenHelper.DOText(arg_4_0._txtImg, var_4_5, var_4_6, nil, nil, nil, EaseType.Linear)
			end
		end

		if arg_4_0._picCo.inType == StoryEnum.PictureInType.FadeIn or arg_4_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn then
			arg_4_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_4_0._txtTmp.gameObject):GetComponent(gohelper.Type_TextMesh)
			arg_4_0._conMark = gohelper.onceAddComponent(arg_4_0._txtTmp.gameObject, typeof(ZProj.TMPMark))

			arg_4_0._conMark:SetMarkTopGo(arg_4_0._txtmarktop.gameObject)
			arg_4_0._conMark:SetTopOffset(8, -2.4)

			local var_4_7 = StoryTool.filterMarkTop(var_4_5)

			arg_4_0._txtImg.text = var_4_7
			arg_4_0._txtEnImg.text = var_4_7
			arg_4_0._txtTmp.text = var_4_7

			arg_4_0._conMark:SetTopOffset(0, -0.5971)

			arg_4_0._txtmarktop.fontSize = 0.5 * arg_4_0._txtTmp.fontSize

			TaskDispatcher.runDelay(function()
				local var_5_0 = StoryTool.getMarkTopTextList(var_4_5)

				arg_4_0._conMark:SetMarksTop(var_5_0)
			end, nil, 0.01)
			ZProj.TweenHelper.DOFadeCanvasGroup(arg_4_0._picGo, 0, 1, arg_4_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		else
			arg_4_0._txtImg.color.a = 1
			arg_4_0._txtEnImg.color.a = 1
			arg_4_0._txtTmp.color.a = 1
		end

		if arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_4_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(arg_4_0._txtEnImg.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_4_0._txtImg.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_4_0._txtTmp.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])

			if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_4_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_4_0._playShake, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(arg_4_0._txtEnImg.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_4_0._txtImg.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_4_0._txtTmp.transform, arg_4_0._picCo.pos[1], arg_4_0._picCo.pos[2])

			if arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_4_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_4_0._playScale, arg_4_0, arg_4_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_4_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_4_0:_playFollowBg()
		end

		return
	end

	gohelper.setActive(arg_4_0._simg.gameObject, true)
	gohelper.setActive(arg_4_0._txtImg.gameObject, false)
	gohelper.setActive(arg_4_0._txtTmp.gameObject, false)
	gohelper.setActive(arg_4_0._txtEnImg.gameObject, false)
	arg_4_0._simg:LoadImage(ResUrl.getStoryItem(arg_4_0._picCo.picture), arg_4_0._onPicImageLoaded, arg_4_0)
end

function var_0_0._onPicImageLoaded(arg_6_0)
	arg_6_0._picAni.enabled = false

	ZProj.UGUIHelper.SetImageSize(arg_6_0._simg.gameObject)

	arg_6_0._picImg = arg_6_0._simg.gameObject:GetComponent(gohelper.Type_Image)

	local var_6_0, var_6_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_6_0._picImg, 0, 0)

	if var_6_0 >= 1920 or var_6_1 > 1080 then
		gohelper.onceAddComponent(arg_6_0._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		transformhelper.setLocalScale(arg_6_0._simg.gameObject.transform, var_6_0 / 1920, var_6_1 / 1080, 1)
	end

	local var_6_2 = SLFramework.UGUI.GuiHelper.ParseColor(arg_6_0._picCo.picColor)
	local var_6_3 = 1

	if arg_6_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		arg_6_0._picImg.color.a = var_6_3
	else
		arg_6_0._picImg.color = var_6_2
		var_6_3 = var_6_2.a
	end

	if arg_6_0._picCo.inType == StoryEnum.PictureInType.FadeIn then
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_6_0._picGo, 0, var_6_3, arg_6_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	end

	if arg_6_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if arg_6_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if arg_6_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_6_0:_playShake()
		else
			TaskDispatcher.runDelay(arg_6_0._playShake, arg_6_0, arg_6_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_6_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if arg_6_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_6_0:_playScale()
		else
			TaskDispatcher.runDelay(arg_6_0._playScale, arg_6_0, arg_6_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_6_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		arg_6_0:_playFollowBg()
	end
end

function var_0_0._playShake(arg_7_0)
	arg_7_0._picAni.enabled = true

	local var_7_0 = {
		"low",
		"middle",
		"high"
	}

	arg_7_0._picAni:Play(var_7_0[arg_7_0._picCo.effDegree])

	arg_7_0._picAni.speed = arg_7_0._picCo.effRate

	TaskDispatcher.runDelay(arg_7_0._shakeStop, arg_7_0, arg_7_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_8_0)
	arg_8_0._picAni.speed = arg_8_0._picCo.effRate

	arg_8_0._picAni:SetBool("stoploop", true)
end

function var_0_0._playFollowBg(arg_9_0)
	local var_9_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_9_0._bgGo = gohelper.findChild(var_9_0, "#go_upbg")

	local var_9_1, var_9_2 = transformhelper.getLocalPos(arg_9_0._picGo.transform)

	arg_9_0._deltaPos = {
		var_9_1,
		var_9_2
	}

	TaskDispatcher.runRepeat(arg_9_0._followBg, arg_9_0, 0.02)
end

function var_0_0._followBg(arg_10_0)
	local var_10_0, var_10_1 = transformhelper.getLocalScale(arg_10_0._bgGo.transform)

	transformhelper.setLocalPosXY(arg_10_0._picGo.transform, var_10_0 * arg_10_0._deltaPos[1], var_10_1 * arg_10_0._deltaPos[2])
	transformhelper.setLocalScale(arg_10_0._picGo.transform, var_10_1, var_10_1, 1)
end

function var_0_0._playScale(arg_11_0)
	if not arg_11_0._picCo or not arg_11_0._picImg then
		return
	end

	local var_11_0 = arg_11_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local var_11_1 = SLFramework.UGUI.GuiHelper.ParseColor(arg_11_0._picCo.picColor)

	if var_11_0 < 0.1 then
		transformhelper.setLocalScale(arg_11_0._picGo.transform, arg_11_0._picCo.effRate, arg_11_0._picCo.effRate, 1)
		transformhelper.setLocalPosXY(arg_11_0._picGo.transform, arg_11_0._picCo.pos[1], arg_11_0._picCo.pos[2])

		if arg_11_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
			return
		end

		arg_11_0._picImg.color = var_11_1

		return
	end

	arg_11_0._posTweenId = ZProj.TweenHelper.DOAnchorPos(arg_11_0._picGo.transform, arg_11_0._picCo.pos[1], arg_11_0._picCo.pos[2], var_11_0, nil, nil, nil, arg_11_0._picCo.effDegree)
	arg_11_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_11_0._picGo.transform, arg_11_0._picCo.effRate, arg_11_0._picCo.effRate, 1, var_11_0)

	if arg_11_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	arg_11_0._alphaTweenId = ZProj.TweenHelper.DoFade(arg_11_0._picImg, arg_11_0._picImg.color.a, var_11_1.a, var_11_0, nil, nil, nil, EaseType.Linear)
end

function var_0_0.resetStep(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._playShake, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._shakeStop, arg_12_0)
	ZProj.TweenHelper.KillByObj(arg_12_0._picGo)
end

function var_0_0._killTweenId(arg_13_0)
	if arg_13_0._posTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._posTweenId)

		arg_13_0._posTweenId = nil
	end

	if arg_13_0._scaleTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._scaleTweenId)

		arg_13_0._scaleTweenId = nil
	end

	if arg_13_0._alphaTweenId then
		ZProj.TweenHelper.KillById(arg_13_0._alphaTweenId)

		arg_13_0._alphaTweenId = nil
	end
end

function var_0_0.reset(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._picGo then
		return
	end

	arg_14_0.viewGO = arg_14_1
	arg_14_0._picCo = arg_14_2

	TaskDispatcher.cancelTask(arg_14_0._realDestroy, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._playScale, arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._playShake, arg_14_0)
	arg_14_0:_killTweenId()

	if arg_14_0:_isSpImg() then
		return
	end

	if arg_14_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		arg_14_0:_setFullPicture()
	else
		arg_14_0._picAni.enabled = false

		arg_14_0:_setNormalPicture()

		if arg_14_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_14_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if arg_14_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_14_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_14_0._playShake, arg_14_0, arg_14_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_14_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if arg_14_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_14_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_14_0._playScale, arg_14_0, arg_14_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_14_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_14_0:_playFollowBg()
		end
	end
end

function var_0_0.isFloatType(arg_15_0)
	return arg_15_0._picCo.picType == StoryEnum.PictureType.Float
end

function var_0_0._setNormalPicture(arg_16_0)
	arg_16_0._simg:UnLoadImage()
	arg_16_0._simg:LoadImage(ResUrl.getStoryItem(arg_16_0._picCo.picture), arg_16_0._onPictureLoaded, arg_16_0)

	if arg_16_0._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	if not arg_16_0._picImg then
		return
	end

	local var_16_0 = SLFramework.UGUI.GuiHelper.ParseColor(arg_16_0._picCo.picColor)

	arg_16_0._picImg.color = Color.New(var_16_0.r, var_16_0.g, var_16_0.b, arg_16_0._picImg.color.a)
end

function var_0_0._setFullPicture(arg_17_0)
	if not arg_17_0._picParentGo then
		return
	end

	arg_17_0._picParentGo.transform:SetParent(arg_17_0.viewGO.transform)

	local var_17_0 = arg_17_0._picGo:GetComponent(typeof(Coffee.UISoftMask.SoftMask))

	recthelper.setSize(arg_17_0._picGo.transform, 3000, 2000)

	var_17_0.enabled = false
	arg_17_0._picImg = arg_17_0._picGo:GetComponent(gohelper.Type_Image)
	arg_17_0._picImg.sprite = nil

	local var_17_1 = gohelper.findChild(arg_17_0._picGo, "result")

	gohelper.setActive(var_17_1, false)

	local var_17_2 = SLFramework.UGUI.GuiHelper.ParseColor(arg_17_0._picCo.picColor)

	arg_17_0._picImg.color = var_17_2

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_17_0._picGo, 0, var_17_2.a, arg_17_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
end

function var_0_0._onFullFocusPictureLoaded(arg_18_0)
	arg_18_0._picLoaded = true

	if not arg_18_0._pictureLoader then
		return
	end

	arg_18_0._picGo = arg_18_0._pictureLoader:getInstGO()
	arg_18_0._picGo.name = arg_18_0._picName

	arg_18_0:_setFullPicture()
end

function var_0_0.destroyPicture(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._picCo = arg_19_1
	arg_19_0._destroyKeepTime = arg_19_3 or 0

	if not arg_19_0._picCo or arg_19_2 then
		arg_19_0:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(arg_19_0._playShake, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._realDestroy, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._startDestroy, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._checkDestroyItem, arg_19_0)

	if arg_19_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(arg_19_0._startDestroy, arg_19_0, 0.1 + arg_19_0._destroyKeepTime)
	elseif arg_19_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_19_0._startDestroy, arg_19_0, arg_19_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_19_0:_startDestroy()
	end
end

function var_0_0._startDestroy(arg_20_0)
	if arg_20_0._picCo.outType == StoryEnum.PictureOutType.Hard then
		arg_20_0:onDestroy()
	else
		if not arg_20_0._picGo then
			arg_20_0:_releaseLoader()

			return
		end

		if not arg_20_0._picLoaded then
			arg_20_0:_releaseLoader()

			return
		end

		ZProj.TweenHelper.KillByObj(arg_20_0._picImg)

		if arg_20_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			local var_20_0 = arg_20_0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_20_0._picGo, var_20_0, 0, arg_20_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, arg_20_0.onDestroy, arg_20_0, nil, EaseType.Linear)
		else
			arg_20_0:onDestroy()
		end
	end
end

function var_0_0.onDestroy(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._build, arg_21_0)

	if arg_21_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(arg_21_0._checkDestroyItem, arg_21_0, 0.1)
	else
		arg_21_0:_realDestroy()
	end
end

function var_0_0._checkDestroyItem(arg_22_0)
	if not arg_22_0._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(arg_22_0._checkDestroyItem, arg_22_0)
	arg_22_0:_realDestroy()
end

function var_0_0._releaseLoader(arg_23_0)
	if arg_23_0._pictureLoader then
		if arg_23_0._pictureLoader:getAssetItem() then
			arg_23_0._pictureLoader:getAssetItem():Release()
		end

		arg_23_0._pictureLoader:dispose()

		arg_23_0._pictureLoader = nil
	end
end

function var_0_0._realDestroy(arg_24_0)
	arg_24_0:_killTweenId()

	if not arg_24_0._picLoaded then
		return
	end

	arg_24_0:_releaseLoader()
	TaskDispatcher.cancelTask(arg_24_0._playShake, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._followBg, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._realDestroy, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._checkDestroyItem, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._startDestroy, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._build, arg_24_0)
	ZProj.TweenHelper.KillByObj(arg_24_0._picGo)
	TaskDispatcher.cancelTask(arg_24_0._shakeStop, arg_24_0)

	if arg_24_0._simg then
		arg_24_0._simg:UnLoadImage()

		arg_24_0._simg = nil
	end

	gohelper.destroy(arg_24_0._picParentGo)
end

return var_0_0

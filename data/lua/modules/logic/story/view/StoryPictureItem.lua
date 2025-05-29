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
	arg_3_0._txtTmp = gohelper.findChildText(arg_3_0._picGo, "txt_tmp")

	transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, 0, 0)
	transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, 0, 0)

	if arg_3_0._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(arg_3_0._simg.gameObject, false)

		local var_3_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local var_3_1 = GameLanguageMgr.instance:getShortCutByStoryIndex(var_3_0)
		local var_3_2 = string.splitToNumber(arg_3_0._picCo.picture, "#")
		local var_3_3 = StoryConfig.instance:getStoryPicTxtConfig(tonumber(var_3_2[1]))
		local var_3_4 = var_3_3.fontType == 1

		gohelper.setActive(arg_3_0._txtEnImg.gameObject, not var_3_4)
		gohelper.setActive(arg_3_0._txtImg.gameObject, var_3_4 and arg_3_0._picCo.inType ~= StoryEnum.PictureInType.TxtFadeIn)
		gohelper.setActive(arg_3_0._txtTmp.gameObject, var_3_4 and arg_3_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn)

		local var_3_5 = var_3_3[var_3_1]
		local var_3_6 = 0.1 * LuaUtil.getStrLen(var_3_5) * var_3_2[2]

		if arg_3_0._picCo.inType ~= StoryEnum.PictureInType.TxtFadeIn then
			if var_3_4 then
				arg_3_0.tweenId = ZProj.TweenHelper.DOText(arg_3_0._txtImg, var_3_5, var_3_6, nil, nil, nil, EaseType.Linear)
			else
				arg_3_0.tweenId = ZProj.TweenHelper.DOText(arg_3_0._txtEnImg, var_3_5, var_3_6, nil, nil, nil, EaseType.Linear)
			end
		end

		if arg_3_0._picCo.inType == StoryEnum.PictureInType.FadeIn or arg_3_0._picCo.inType == StoryEnum.PictureInType.TxtFadeIn then
			arg_3_0._txtmarktop = IconMgr.instance:getCommonTextMarkTop(arg_3_0._txtTmp.gameObject):GetComponent(gohelper.Type_TextMesh)
			arg_3_0._conMark = gohelper.onceAddComponent(arg_3_0._txtTmp.gameObject, typeof(ZProj.TMPMark))

			arg_3_0._conMark:SetMarkTopGo(arg_3_0._txtmarktop.gameObject)
			arg_3_0._conMark:SetTopOffset(8, -2.4)

			local var_3_7 = StoryTool.filterMarkTop(var_3_5)

			arg_3_0._txtImg.text = var_3_7
			arg_3_0._txtEnImg.text = var_3_7
			arg_3_0._txtTmp.text = var_3_7

			arg_3_0._conMark:SetTopOffset(0, -0.5971)

			arg_3_0._txtmarktop.fontSize = 0.5 * arg_3_0._txtTmp.fontSize

			TaskDispatcher.runDelay(function()
				local var_4_0 = StoryTool.getMarkTopTextList(var_3_5)

				arg_3_0._conMark:SetMarksTop(var_4_0)
			end, nil, 0.01)
			ZProj.TweenHelper.DOFadeCanvasGroup(arg_3_0._picGo, 0, 1, arg_3_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		else
			arg_3_0._txtImg.color.a = 1
			arg_3_0._txtEnImg.color.a = 1
			arg_3_0._txtTmp.color.a = 1
		end

		if arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_3_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

			if arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_3_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_3_0._playShake, arg_3_0, arg_3_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_3_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(arg_3_0._txtEnImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtImg.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])
			transformhelper.setLocalPosXY(arg_3_0._txtTmp.transform, arg_3_0._picCo.pos[1], arg_3_0._picCo.pos[2])

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
	gohelper.setActive(arg_3_0._txtTmp.gameObject, false)
	gohelper.setActive(arg_3_0._txtEnImg.gameObject, false)
	arg_3_0._simg:LoadImage(ResUrl.getStoryItem(arg_3_0._picCo.picture), arg_3_0._onPicImageLoaded, arg_3_0)
end

function var_0_0._onPicImageLoaded(arg_5_0)
	arg_5_0._picAni.enabled = false

	ZProj.UGUIHelper.SetImageSize(arg_5_0._simg.gameObject)

	arg_5_0._picImg = arg_5_0._simg.gameObject:GetComponent(gohelper.Type_Image)

	local var_5_0, var_5_1 = ZProj.UGUIHelper.GetImageSpriteSize(arg_5_0._picImg, 0, 0)

	if var_5_0 >= 1920 or var_5_1 > 1080 then
		gohelper.onceAddComponent(arg_5_0._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		transformhelper.setLocalScale(arg_5_0._simg.gameObject.transform, var_5_0 / 1920, var_5_1 / 1080, 1)
	end

	if arg_5_0._picCo.inType == StoryEnum.PictureInType.FadeIn then
		ZProj.TweenHelper.DOFadeCanvasGroup(arg_5_0._picGo, 0, 1, arg_5_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	else
		arg_5_0._picImg.color.a = 1
	end

	if arg_5_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if arg_5_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if arg_5_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_5_0:_playShake()
		else
			TaskDispatcher.runDelay(arg_5_0._playShake, arg_5_0, arg_5_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_5_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if arg_5_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			arg_5_0:_playScale()
		else
			TaskDispatcher.runDelay(arg_5_0._playScale, arg_5_0, arg_5_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif arg_5_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		arg_5_0:_playFollowBg()
	end
end

function var_0_0._playShake(arg_6_0)
	arg_6_0._picAni.enabled = true

	local var_6_0 = {
		"low",
		"middle",
		"high"
	}

	arg_6_0._picAni:Play(var_6_0[arg_6_0._picCo.effDegree])

	arg_6_0._picAni.speed = arg_6_0._picCo.effRate

	TaskDispatcher.runDelay(arg_6_0._shakeStop, arg_6_0, arg_6_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._shakeStop(arg_7_0)
	arg_7_0._picAni.speed = arg_7_0._picCo.effRate

	arg_7_0._picAni:SetBool("stoploop", true)
end

function var_0_0._playFollowBg(arg_8_0)
	local var_8_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_8_0._bgGo = gohelper.findChild(var_8_0, "#go_upbg")

	local var_8_1, var_8_2 = transformhelper.getLocalPos(arg_8_0._picGo.transform)

	arg_8_0._deltaPos = {
		var_8_1,
		var_8_2
	}

	TaskDispatcher.runRepeat(arg_8_0._followBg, arg_8_0, 0.02)
end

function var_0_0._followBg(arg_9_0)
	local var_9_0, var_9_1 = transformhelper.getLocalScale(arg_9_0._bgGo.transform)

	transformhelper.setLocalPosXY(arg_9_0._picGo.transform, var_9_0 * arg_9_0._deltaPos[1], var_9_1 * arg_9_0._deltaPos[2])
	transformhelper.setLocalScale(arg_9_0._picGo.transform, var_9_1, var_9_1, 1)
end

function var_0_0._playScale(arg_10_0)
	if arg_10_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		transformhelper.setLocalScale(arg_10_0._picGo.transform, arg_10_0._picCo.effRate, arg_10_0._picCo.effRate, 1)

		return
	end

	arg_10_0._scaleTweenId = ZProj.TweenHelper.DOScale(arg_10_0._picGo.transform, arg_10_0._picCo.effRate, arg_10_0._picCo.effRate, 1, arg_10_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0.resetStep(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._playShake, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._shakeStop, arg_11_0)
	ZProj.TweenHelper.KillByObj(arg_11_0._picGo)
end

function var_0_0.reset(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_0._picGo then
		return
	end

	arg_12_0.viewGO = arg_12_1
	arg_12_0._picCo = arg_12_2

	TaskDispatcher.cancelTask(arg_12_0._realDestroy, arg_12_0)

	if arg_12_0:_isSpImg() then
		return
	end

	if arg_12_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		arg_12_0:_setFullPicture()
	else
		arg_12_0._picAni.enabled = false

		arg_12_0:_setNormalPicture()

		if arg_12_0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if arg_12_0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_12_0:_playShake()
			else
				TaskDispatcher.runDelay(arg_12_0._playShake, arg_12_0, arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_12_0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				arg_12_0:_playScale()
			else
				TaskDispatcher.runDelay(arg_12_0._playScale, arg_12_0, arg_12_0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif arg_12_0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			arg_12_0:_playFollowBg()
		end
	end
end

function var_0_0.isFloatType(arg_13_0)
	return arg_13_0._picCo.picType == StoryEnum.PictureType.Float
end

function var_0_0._setNormalPicture(arg_14_0)
	arg_14_0._simg:UnLoadImage()
	arg_14_0._simg:LoadImage(ResUrl.getStoryItem(arg_14_0._picCo.picture), arg_14_0._onPictureLoaded, arg_14_0)
end

function var_0_0._isSpImg(arg_15_0)
	local var_15_0 = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP

	return string.match(arg_15_0._picCo.picture, "v2a5_liangyue_story") and not var_15_0
end

function var_0_0._setFullPicture(arg_16_0)
	if not arg_16_0._picParentGo then
		return
	end

	arg_16_0._picParentGo.transform:SetParent(arg_16_0.viewGO.transform)

	arg_16_0._picImg = gohelper.findChildImage(arg_16_0._picGo, "result")

	local var_16_0 = SLFramework.UGUI.GuiHelper.ParseColor(arg_16_0._picCo.picColor)

	arg_16_0._picImg.color = var_16_0

	ZProj.TweenHelper.DOFadeCanvasGroup(arg_16_0._picGo, 0, var_16_0.a, arg_16_0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
	recthelper.setSize(arg_16_0._picGo.transform, 2 * arg_16_0._picCo.cirRadius, 2 * arg_16_0._picCo.cirRadius)
	transformhelper.setLocalPosXY(arg_16_0._picGo.transform, arg_16_0._picCo.pos[1], arg_16_0._picCo.pos[2])
	transformhelper.setLocalScale(arg_16_0._picGo.transform, 1, 1, 1)
	transformhelper.setLocalPosXY(arg_16_0._picImg.transform, -arg_16_0._picCo.pos[1], -arg_16_0._picCo.pos[2])
end

function var_0_0._onFullFocusPictureLoaded(arg_17_0)
	arg_17_0._picLoaded = true

	if not arg_17_0._pictureLoader then
		return
	end

	arg_17_0._picGo = arg_17_0._pictureLoader:getInstGO()
	arg_17_0._picGo.name = arg_17_0._picName

	arg_17_0:_setFullPicture()
end

function var_0_0.destroyPicture(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._picCo = arg_18_1
	arg_18_0._destroyKeepTime = arg_18_3 or 0

	if not arg_18_0._picCo then
		return
	end

	if arg_18_2 then
		arg_18_0:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(arg_18_0._playShake, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._realDestroy, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._startDestroy, arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._checkDestroyItem, arg_18_0)

	if arg_18_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(arg_18_0._startDestroy, arg_18_0, 0.1 + arg_18_0._destroyKeepTime)
	elseif arg_18_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_18_0._startDestroy, arg_18_0, arg_18_0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_18_0:_startDestroy()
	end
end

function var_0_0._startDestroy(arg_19_0)
	if arg_19_0._picCo.outType == StoryEnum.PictureOutType.Hard then
		arg_19_0:onDestroy()
	else
		if not arg_19_0._picGo then
			return
		end

		if not arg_19_0._picLoaded then
			return
		end

		ZProj.TweenHelper.KillByObj(arg_19_0._picImg)

		if arg_19_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			local var_19_0 = arg_19_0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

			ZProj.TweenHelper.DOFadeCanvasGroup(arg_19_0._picGo, var_19_0, 0, arg_19_0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, arg_19_0.onDestroy, arg_19_0, nil, EaseType.Linear)
		else
			arg_19_0:onDestroy()
		end
	end
end

function var_0_0.onDestroy(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._build, arg_20_0)

	if arg_20_0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(arg_20_0._checkDestroyItem, arg_20_0, 0.1)
	else
		arg_20_0:_realDestroy()
	end
end

function var_0_0._checkDestroyItem(arg_21_0)
	if not arg_21_0._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(arg_21_0._checkDestroyItem, arg_21_0)
	arg_21_0:_realDestroy()
end

function var_0_0._realDestroy(arg_22_0)
	if not arg_22_0._picLoaded then
		return
	end

	if arg_22_0._pictureLoader and arg_22_0._pictureLoader:getAssetItem() then
		arg_22_0._pictureLoader:getAssetItem():Release()
		arg_22_0._pictureLoader:dispose()

		arg_22_0._pictureLoader = nil
	end

	TaskDispatcher.cancelTask(arg_22_0._playShake, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._followBg, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._realDestroy, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._checkDestroyItem, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._startDestroy, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._build, arg_22_0)
	ZProj.TweenHelper.KillByObj(arg_22_0._picGo)
	TaskDispatcher.cancelTask(arg_22_0._shakeStop, arg_22_0)

	if arg_22_0._simg then
		arg_22_0._simg:UnLoadImage()

		arg_22_0._simg = nil
	end

	gohelper.destroy(arg_22_0._picParentGo)
end

return var_0_0

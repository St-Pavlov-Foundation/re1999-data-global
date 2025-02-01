module("modules.logic.story.view.StoryPictureItem", package.seeall)

slot0 = class("StoryPictureItem")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.viewGO = slot1
	slot0._picParentGo = gohelper.create2d(slot0.viewGO, slot2)
	slot0._picName = slot2
	slot0._picCo = slot3
	slot0._picGo = nil
	slot0._picImg = nil
	slot0._picLoaded = false

	if slot3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(slot0._build, slot0, slot3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		slot0:_build()
	end
end

function slot0._build(slot0)
	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)

	if slot0._pictureLoader then
		slot0._pictureLoader:dispose()

		slot0._pictureLoader = nil
	end

	if slot0._picCo.picType == StoryEnum.PictureType.FullScreen then
		slot0._pictureLoader = PrefabInstantiate.Create(slot0._picParentGo)

		slot0._pictureLoader:startLoad("ui/viewres/story/storyfullfocusitem.prefab", slot0._onFullFocusPictureLoaded, slot0)
	else
		slot0._pictureLoader = PrefabInstantiate.Create(slot0._picParentGo)

		slot0._pictureLoader:startLoad("ui/viewres/story/storynormalpicitem.prefab", slot0._onPicPrefabLoaded, slot0)
	end
end

function slot0._onPicPrefabLoaded(slot0)
	slot0._picLoaded = true
	slot0._picGo = slot0._pictureLoader:getInstGO()
	slot0._picAni = slot0._picGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._picAni.enabled = false

	transformhelper.setLocalPosXY(slot0._picGo.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])

	slot0._simg = gohelper.findChildSingleImage(slot0._picGo, "result")
	slot0._txtImg = gohelper.findChildText(slot0._picGo, "txt")
	slot0._txtEnImg = gohelper.findChildText(slot0._picGo, "txten")

	transformhelper.setLocalPosXY(slot0._txtEnImg.transform, 0, 0)
	transformhelper.setLocalPosXY(slot0._txtImg.transform, 0, 0)

	if slot0._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(slot0._simg.gameObject, false)

		slot4 = StoryConfig.instance:getStoryPicTxtConfig(tonumber(string.split(slot0._picCo.picture, "#")[1]))
		slot5 = GameLanguageMgr.instance:getShortCutByStoryIndex(GameLanguageMgr.instance:getLanguageTypeStoryIndex()) == LangSettings.shortcutTab[LangSettings.zh] and slot4.fontType == 1

		gohelper.setActive(slot0._txtImg.gameObject, slot5)
		gohelper.setActive(slot0._txtEnImg.gameObject, not slot5)

		if slot5 then
			slot0.tweenId = ZProj.TweenHelper.DOText(slot0._txtImg, slot6, 0.1 * LuaUtil.getStrLen(slot4[slot2]) * slot3[2], nil, , , EaseType.Linear)
		else
			slot0.tweenId = ZProj.TweenHelper.DOText(slot0._txtEnImg, slot6, slot7, nil, , , EaseType.Linear)
		end

		if slot0._picCo.inType == StoryEnum.PictureInType.FadeIn then
			slot0._txtImg.text = slot6

			ZProj.TweenHelper.DOFadeCanvasGroup(slot0._picGo, 0, 1, slot0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, , , EaseType.Linear)
		else
			slot0._txtImg.color.a = 1
			slot0._txtEnImg.color.a = 1
		end

		if slot0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(slot0._txtEnImg.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])
			transformhelper.setLocalPosXY(slot0._txtImg.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])

			if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				slot0:_playShake()
			else
				TaskDispatcher.runDelay(slot0._playShake, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif slot0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(slot0._txtEnImg.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])
			transformhelper.setLocalPosXY(slot0._txtImg.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])

			if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				slot0:_playScale()
			else
				TaskDispatcher.runDelay(slot0._playScale, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif slot0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			slot0:_playFollowBg()
		end

		return
	end

	gohelper.setActive(slot0._simg.gameObject, true)
	gohelper.setActive(slot0._txtImg.gameObject, false)
	gohelper.setActive(slot0._txtEnImg.gameObject, false)
	slot0._simg:LoadImage(ResUrl.getStoryItem(slot0._picCo.picture), slot0._onPicImageLoaded, slot0)
end

function slot0._onPicImageLoaded(slot0)
	slot0._picAni.enabled = false

	ZProj.UGUIHelper.SetImageSize(slot0._simg.gameObject)

	slot0._picImg = slot0._simg.gameObject:GetComponent(gohelper.Type_Image)
	slot1, slot2 = ZProj.UGUIHelper.GetImageSpriteSize(slot0._picImg, 0, 0)

	if slot1 >= 1920 or slot2 > 1080 then
		gohelper.onceAddComponent(slot0._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		transformhelper.setLocalScale(slot0._simg.gameObject.transform, slot1 / 1920, slot2 / 1080, 1)
	end

	if slot0._picCo.inType == StoryEnum.PictureInType.FadeIn then
		ZProj.TweenHelper.DOFadeCanvasGroup(slot0._picGo, 0, 1, slot0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, , , EaseType.Linear)
	else
		slot0._picImg.color.a = 1
	end

	if slot0._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			slot0:_playShake()
		else
			TaskDispatcher.runDelay(slot0._playShake, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif slot0._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			slot0:_playScale()
		else
			TaskDispatcher.runDelay(slot0._playScale, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif slot0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		slot0:_playFollowBg()
	end
end

function slot0._playShake(slot0)
	slot0._picAni.enabled = true

	slot0._picAni:Play(({
		"low",
		"middle",
		"high"
	})[slot0._picCo.effDegree])

	slot0._picAni.speed = slot0._picCo.effRate

	TaskDispatcher.runDelay(slot0._shakeStop, slot0, slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._shakeStop(slot0)
	slot0._picAni.speed = slot0._picCo.effRate

	slot0._picAni:SetBool("stoploop", true)
end

function slot0._playFollowBg(slot0)
	slot0._bgGo = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO, "#go_upbg")
	slot2, slot3 = transformhelper.getLocalPos(slot0._picGo.transform)
	slot0._deltaPos = {
		slot2,
		slot3
	}

	TaskDispatcher.runRepeat(slot0._followBg, slot0, 0.02)
end

function slot0._followBg(slot0)
	slot1, slot2 = transformhelper.getLocalScale(slot0._bgGo.transform)

	transformhelper.setLocalPosXY(slot0._picGo.transform, slot1 * slot0._deltaPos[1], slot2 * slot0._deltaPos[2])
	transformhelper.setLocalScale(slot0._picGo.transform, slot2, slot2, 1)
end

function slot0._playScale(slot0)
	if slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		transformhelper.setLocalScale(slot0._picGo.transform, slot0._picCo.effRate, slot0._picCo.effRate, 1)

		return
	end

	slot0._scaleTweenId = ZProj.TweenHelper.DOScale(slot0._picGo.transform, slot0._picCo.effRate, slot0._picCo.effRate, 1, slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0.resetStep(slot0)
	TaskDispatcher.cancelTask(slot0._playShake, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	ZProj.TweenHelper.KillByObj(slot0._picGo)
end

function slot0.reset(slot0, slot1, slot2)
	if not slot0._picGo then
		return
	end

	slot0.viewGO = slot1
	slot0._picCo = slot2

	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)

	if slot0._picCo.picType == StoryEnum.PictureType.FullScreen then
		slot0:_setFullPicture()
	else
		slot0._picAni.enabled = false

		slot0:_setNormalPicture()

		if slot0._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if slot0._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				slot0:_playShake()
			else
				TaskDispatcher.runDelay(slot0._playShake, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif slot0._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				slot0:_playScale()
			else
				TaskDispatcher.runDelay(slot0._playScale, slot0, slot0._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif slot0._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			slot0:_playFollowBg()
		end
	end
end

function slot0.isFloatType(slot0)
	return slot0._picCo.picType == StoryEnum.PictureType.Float
end

function slot0._setNormalPicture(slot0)
	slot0._simg:UnLoadImage()
	slot0._simg:LoadImage(ResUrl.getStoryItem(slot0._picCo.picture), slot0._onPictureLoaded, slot0)
end

function slot0._setFullPicture(slot0)
	if not slot0._picParentGo then
		return
	end

	slot0._picParentGo.transform:SetParent(slot0.viewGO.transform)

	slot0._picImg = gohelper.findChildImage(slot0._picGo, "result")
	slot1 = SLFramework.UGUI.GuiHelper.ParseColor(slot0._picCo.picColor)
	slot0._picImg.color = slot1

	ZProj.TweenHelper.DOFadeCanvasGroup(slot0._picGo, 0, slot1.a, slot0._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, , , EaseType.Linear)
	recthelper.setSize(slot0._picGo.transform, 2 * slot0._picCo.cirRadius, 2 * slot0._picCo.cirRadius)
	transformhelper.setLocalPosXY(slot0._picGo.transform, slot0._picCo.pos[1], slot0._picCo.pos[2])
	transformhelper.setLocalScale(slot0._picGo.transform, 1, 1, 1)
	transformhelper.setLocalPosXY(slot0._picImg.transform, -slot0._picCo.pos[1], -slot0._picCo.pos[2])
end

function slot0._onFullFocusPictureLoaded(slot0)
	slot0._picLoaded = true

	if not slot0._pictureLoader then
		return
	end

	slot0._picGo = slot0._pictureLoader:getInstGO()
	slot0._picGo.name = slot0._picName

	slot0:_setFullPicture()
end

function slot0.destroyPicture(slot0, slot1, slot2, slot3)
	slot0._picCo = slot1
	slot0._destroyKeepTime = slot3 or 0

	if not slot0._picCo then
		return
	end

	if slot2 then
		slot0:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(slot0._playShake, slot0)
	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)
	TaskDispatcher.cancelTask(slot0._startDestroy, slot0)
	TaskDispatcher.cancelTask(slot0._checkDestroyItem, slot0)

	if slot0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(slot0._startDestroy, slot0, 0.1 + slot0._destroyKeepTime)
	elseif slot0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(slot0._startDestroy, slot0, slot0._picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		slot0:_startDestroy()
	end
end

function slot0._startDestroy(slot0)
	if slot0._picCo.outType == StoryEnum.PictureOutType.Hard then
		slot0:onDestroy()
	else
		if not slot0._picGo then
			return
		end

		if not slot0._picLoaded then
			return
		end

		ZProj.TweenHelper.KillByObj(slot0._picImg)

		if slot0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			ZProj.TweenHelper.DOFadeCanvasGroup(slot0._picGo, slot0._picGo:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha, 0, slot0._picCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, slot0.onDestroy, slot0, nil, EaseType.Linear)
		else
			slot0:onDestroy()
		end
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._build, slot0)

	if slot0._picCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(slot0._checkDestroyItem, slot0, 0.1)
	else
		slot0:_realDestroy()
	end
end

function slot0._checkDestroyItem(slot0)
	if not slot0._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(slot0._checkDestroyItem, slot0)
	slot0:_realDestroy()
end

function slot0._realDestroy(slot0)
	if not slot0._picLoaded then
		return
	end

	if slot0._pictureLoader and slot0._pictureLoader:getAssetItem() then
		slot0._pictureLoader:getAssetItem():Release()
		slot0._pictureLoader:dispose()

		slot0._pictureLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._playShake, slot0)
	TaskDispatcher.cancelTask(slot0._followBg, slot0)
	TaskDispatcher.cancelTask(slot0._realDestroy, slot0)
	TaskDispatcher.cancelTask(slot0._checkDestroyItem, slot0)
	TaskDispatcher.cancelTask(slot0._startDestroy, slot0)
	TaskDispatcher.cancelTask(slot0._build, slot0)
	ZProj.TweenHelper.KillByObj(slot0._picGo)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)

	if slot0._simg then
		slot0._simg:UnLoadImage()

		slot0._simg = nil
	end

	gohelper.destroy(slot0._picParentGo)
end

return slot0

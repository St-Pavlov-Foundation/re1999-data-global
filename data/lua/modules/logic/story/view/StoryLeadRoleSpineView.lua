module("modules.logic.story.view.StoryLeadRoleSpineView", package.seeall)

slot0 = class("StoryLeadRoleSpineView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorolebg = gohelper.findChild(slot0.viewGO, "#go_rolebg")
	slot0._gospineroot = gohelper.findChild(slot0.viewGO, "#go_spineroot")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_spineroot/mask/#go_spine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._blitEff = slot0._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	slot0._heroSpines = {}
	slot0._goSpines = {}
	slot0._heroSkeletonGraphics = {}
	slot0._heroSpineGos = {}

	for slot5 = 1, #StoryConfig.instance:getStoryLeadHeroSpine() do
		if not slot0._goSpines[slot5] then
			slot0._goSpines[slot5] = gohelper.create2d(slot0._gospine, "spine" .. slot5)
			slot0._heroSpines[slot5] = GuiSpine.Create(slot0._goSpines[slot5], true)
		end

		slot0._heroSpines[slot5]:setResPath("rolesstory/" .. slot1[slot5].spine, slot0["_onHeroSpineLoaded" .. slot5], slot0)
	end

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gospineroot, false)
end

function slot0._onHeroSpineLoaded1(slot0)
	slot0._heroSkeletonGraphics[1] = slot0._heroSpines[1]:getSkeletonGraphic()
	slot0._heroSpineGos[1] = slot0._heroSpines[1]:getSpineGo()
end

function slot0._onHeroSpineLoaded2(slot0)
	slot0._heroSkeletonGraphics[2] = slot0._heroSpines[2]:getSkeletonGraphic()
	slot0._heroSpineGos[2] = slot0._heroSpines[2]:getSpineGo()
end

function slot0._onHeroSpineLoaded3(slot0)
	slot0._heroSkeletonGraphics[3] = slot0._heroSpines[3]:getSkeletonGraphic()
	slot0._heroSpineGos[3] = slot0._heroSpines[3]:getSpineGo()
end

function slot0._onHeroSpineLoaded4(slot0)
	slot0._heroSkeletonGraphics[4] = slot0._heroSpines[4]:getSkeletonGraphic()
	slot0._heroSpineGos[4] = slot0._heroSpines[3]:getSpineGo()
end

function slot0._onHeroSpineLoaded5(slot0)
	slot0._heroSkeletonGraphics[5] = slot0._heroSpines[5]:getSkeletonGraphic()
	slot0._heroSpineGos[5] = slot0._heroSpines[5]:getSpineGo()
end

function slot0.onUpdateParam(slot0)
end

function slot0._showView(slot0, slot1)
	gohelper.setActive(slot0.viewGO, slot1)
end

function slot0._keepSpineAni(slot0, slot1)
	if not slot0._gospineroot.activeSelf then
		return false
	end

	if not slot0._goSpines[slot1].activeSelf then
		return false
	end

	if slot0._mainheroco and (slot0._mainheroco.motion ~= "" or slot0._mainheroco.face ~= "" or slot0._mainheroco.mouth ~= "") and slot0._mainheroco.motion == slot0._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and slot0._mainheroco.face == slot0._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and slot0._mainheroco.mouth == slot0._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] then
		return true
	end

	return false
end

function slot0._isSpineKeepShow(slot0, slot1)
	if not slot0._gospineroot.activeSelf then
		return false
	end

	if not slot0._goSpines[slot1].activeSelf then
		return false
	end

	return true
end

function slot0._showLeadHero(slot0, slot1, slot2, slot3, slot4)
	slot0._stepCo = slot1
	slot5 = string.split(slot0._stepCo.conversation.heroIcon, ".")[1]

	if not slot0._roleType then
		slot0._roleType = 1
	end

	if slot0._stepCo.conversation.iconShow then
		for slot10, slot11 in ipairs(StoryConfig.instance:getStoryLeadHeroSpine()) do
			if slot5 == slot11.icon then
				slot0._roleType = slot10
			end
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0:_keepSpineAni(slot0._roleType) then
		return
	end

	if not slot2 then
		slot0._mainheroco = nil

		slot0._animator:Play(UIAnimationName.Idle)

		slot0._animator.enabled = false

		gohelper.setActive(slot0._gospineroot, false)

		for slot9, slot10 in pairs(slot0._goSpines) do
			gohelper.setActive(slot10, false)
		end

		return
	end

	gohelper.setActive(slot0._gospineroot, true)
	slot0:_playHeroLeadSpineVoice(slot0._roleType)

	if not (slot3 and not slot0:_isSpineKeepShow(slot0._roleType)) and not (slot4 and not slot0:_isSpineKeepShow(slot0._roleType)) then
		slot0:_fadeUpdate(1)
	end

	if slot3 then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, slot0._fadeUpdate, slot0._fadeInFinished, slot0, nil, EaseType.Linear)
	end

	if slot4 then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, slot0._fadeUpdate, slot0._fadeOutFinished, slot0, nil, EaseType.Linear)
	end
end

function slot0._playHeroLeadSpineVoice(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._goSpines) do
		gohelper.setActive(slot6, slot1 == slot5)
	end

	if slot0._stepCo.conversation.heroIcon == "" or not slot0._stepCo.conversation.iconShow then
		return
	end

	slot0._mainheroco = {
		motion = slot0._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()],
		face = slot0._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	}
	slot4 = GameLanguageMgr.instance
	slot5 = slot4
	slot0._mainheroco.mouth = slot0._stepCo.mainRole.mouses[slot4.getVoiceTypeStoryIndex(slot5)]

	for slot5, slot6 in ipairs(slot0._heroSpines) do
		slot6:stopVoice()

		if slot5 == slot1 then
			slot6:playVoice(slot0._mainheroco)
		end
	end
end

function slot0._fadeUpdate(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._heroSpineGos) do
		slot7, slot8, slot9 = transformhelper.getLocalPos(slot6.transform)

		transformhelper.setLocalPos(slot6.transform, slot7, slot8, 1 - slot1)
	end

	slot0:_setHeroFadeMat()
end

function slot0._fadeInFinished(slot0)
end

function slot0._fadeOutFinished(slot0)
	slot0:_fadeUpdate(0)
end

function slot0._actShake(slot0, slot1, slot2, slot3, slot4)
	slot0._stepCo = slot1

	if slot0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot2 = false
	end

	if not slot2 then
		slot0._animator.speed = slot0._stepCo.conversation.effRate

		if slot4 then
			slot0._animator:Play(UIAnimationName.Idle)

			slot0._animator.enabled = false
		else
			slot0._animator:SetBool("stoploop", true)
		end

		return
	end

	slot0._animator.enabled = true

	slot0._animator:SetBool("stoploop", false)
	slot0._animator:Play(({
		"low",
		"middle",
		"high"
	})[slot3])

	slot0._animator.speed = slot0._stepCo.conversation.effRate
end

function slot0._setHeroFadeMat(slot0)
	slot0._bgGo = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO, "#go_upbg/#simage_bgimg")
	slot2, slot3 = transformhelper.getLocalPos(slot0._bgGo.transform)
	slot4, slot5 = transformhelper.getLocalScale(slot0._bgGo.transform)

	for slot11, slot12 in ipairs(slot0._heroSkeletonGraphics) do
		slot12.materialForRendering:SetTexture("_SceneMask", slot0._blitEff.capturedTexture)
		slot12.materialForRendering:SetVector("_SceneMask_ST", Vector4.New(slot4, slot5, slot2, slot3))
	end
end

function slot0.onOpen(slot0)
	StoryController.instance:registerCallback(StoryEvent.ShowLeadRole, slot0._showLeadHero, slot0)
	StoryController.instance:registerCallback(StoryEvent.LeadRoleViewShow, slot0._showView, slot0)
	StoryController.instance:registerCallback(StoryEvent.ConversationShake, slot0._actShake, slot0)
end

function slot0.onClose(slot0)
	StoryController.instance:unregisterCallback(StoryEvent.ShowLeadRole, slot0._showLeadHero, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.LeadRoleViewShow, slot0._showView, slot0)
	StoryController.instance:unregisterCallback(StoryEvent.ConversationShake, slot0._actShake, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0

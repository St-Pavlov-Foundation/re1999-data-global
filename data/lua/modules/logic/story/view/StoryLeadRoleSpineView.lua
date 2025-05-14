module("modules.logic.story.view.StoryLeadRoleSpineView", package.seeall)

local var_0_0 = class("StoryLeadRoleSpineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorolebg = gohelper.findChild(arg_1_0.viewGO, "#go_rolebg")
	arg_1_0._gospineroot = gohelper.findChild(arg_1_0.viewGO, "#go_spineroot")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spineroot/mask/#go_spine")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._blitEff = arg_4_0._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	arg_4_0._heroSpines = {}
	arg_4_0._goSpines = {}
	arg_4_0._heroSkeletonGraphics = {}
	arg_4_0._heroSpineGos = {}

	local var_4_0 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_4_0 = 1, #var_4_0 do
		if not arg_4_0._goSpines[iter_4_0] then
			arg_4_0._goSpines[iter_4_0] = gohelper.create2d(arg_4_0._gospine, "spine" .. iter_4_0)
			arg_4_0._heroSpines[iter_4_0] = GuiSpine.Create(arg_4_0._goSpines[iter_4_0], true)
		end

		local var_4_1 = "rolesstory/" .. var_4_0[iter_4_0].spine

		arg_4_0._heroSpines[iter_4_0]:setResPath(var_4_1, arg_4_0["_onHeroSpineLoaded" .. iter_4_0], arg_4_0)
	end

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_4_0._gospineroot, false)
end

function var_0_0._onHeroSpineLoaded1(arg_5_0)
	arg_5_0._heroSkeletonGraphics[1] = arg_5_0._heroSpines[1]:getSkeletonGraphic()
	arg_5_0._heroSpineGos[1] = arg_5_0._heroSpines[1]:getSpineGo()
end

function var_0_0._onHeroSpineLoaded2(arg_6_0)
	arg_6_0._heroSkeletonGraphics[2] = arg_6_0._heroSpines[2]:getSkeletonGraphic()
	arg_6_0._heroSpineGos[2] = arg_6_0._heroSpines[2]:getSpineGo()
end

function var_0_0._onHeroSpineLoaded3(arg_7_0)
	arg_7_0._heroSkeletonGraphics[3] = arg_7_0._heroSpines[3]:getSkeletonGraphic()
	arg_7_0._heroSpineGos[3] = arg_7_0._heroSpines[3]:getSpineGo()
end

function var_0_0._onHeroSpineLoaded4(arg_8_0)
	arg_8_0._heroSkeletonGraphics[4] = arg_8_0._heroSpines[4]:getSkeletonGraphic()
	arg_8_0._heroSpineGos[4] = arg_8_0._heroSpines[3]:getSpineGo()
end

function var_0_0._onHeroSpineLoaded5(arg_9_0)
	arg_9_0._heroSkeletonGraphics[5] = arg_9_0._heroSpines[5]:getSkeletonGraphic()
	arg_9_0._heroSpineGos[5] = arg_9_0._heroSpines[5]:getSpineGo()
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0._showView(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0.viewGO, arg_11_1)
end

function var_0_0._keepSpineAni(arg_12_0, arg_12_1)
	if not arg_12_0._gospineroot.activeSelf then
		return false
	end

	if not arg_12_0._goSpines[arg_12_1].activeSelf then
		return false
	end

	if arg_12_0._mainheroco and (arg_12_0._mainheroco.motion ~= "" or arg_12_0._mainheroco.face ~= "" or arg_12_0._mainheroco.mouth ~= "") and arg_12_0._mainheroco.motion == arg_12_0._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and arg_12_0._mainheroco.face == arg_12_0._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and arg_12_0._mainheroco.mouth == arg_12_0._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] then
		return true
	end

	return false
end

function var_0_0._isSpineKeepShow(arg_13_0, arg_13_1)
	if not arg_13_0._gospineroot.activeSelf then
		return false
	end

	if not arg_13_0._goSpines[arg_13_1].activeSelf then
		return false
	end

	return true
end

function var_0_0._showLeadHero(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	arg_14_0._stepCo = arg_14_1

	local var_14_0 = string.split(arg_14_0._stepCo.conversation.heroIcon, ".")[1]

	if not arg_14_0._roleType then
		arg_14_0._roleType = 1
	end

	if arg_14_0._stepCo.conversation.iconShow then
		local var_14_1 = StoryConfig.instance:getStoryLeadHeroSpine()

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			if var_14_0 == iter_14_1.icon then
				arg_14_0._roleType = iter_14_0
			end
		end
	end

	if arg_14_0._tweenId then
		ZProj.TweenHelper.KillById(arg_14_0._tweenId)

		arg_14_0._tweenId = nil
	end

	if arg_14_0:_keepSpineAni(arg_14_0._roleType) then
		return
	end

	if not arg_14_2 then
		arg_14_0._mainheroco = nil

		arg_14_0._animator:Play(UIAnimationName.Idle)

		arg_14_0._animator.enabled = false

		gohelper.setActive(arg_14_0._gospineroot, false)

		for iter_14_2, iter_14_3 in pairs(arg_14_0._goSpines) do
			gohelper.setActive(iter_14_3, false)
		end

		return
	end

	gohelper.setActive(arg_14_0._gospineroot, true)
	arg_14_0:_playHeroLeadSpineVoice(arg_14_0._roleType)

	arg_14_3 = arg_14_3 and not arg_14_0:_isSpineKeepShow(arg_14_0._roleType)
	arg_14_4 = arg_14_4 and not arg_14_0:_isSpineKeepShow(arg_14_0._roleType)

	if not arg_14_3 and not arg_14_4 then
		arg_14_0:_fadeUpdate(1)
	end

	if arg_14_3 then
		arg_14_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_14_0._fadeUpdate, arg_14_0._fadeInFinished, arg_14_0, nil, EaseType.Linear)
	end

	if arg_14_4 then
		arg_14_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, arg_14_0._fadeUpdate, arg_14_0._fadeOutFinished, arg_14_0, nil, EaseType.Linear)
	end
end

function var_0_0._playHeroLeadSpineVoice(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._goSpines) do
		gohelper.setActive(iter_15_1, arg_15_1 == iter_15_0)
	end

	if arg_15_0._stepCo.conversation.heroIcon == "" or not arg_15_0._stepCo.conversation.iconShow then
		return
	end

	arg_15_0._mainheroco = {}
	arg_15_0._mainheroco.motion = arg_15_0._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	arg_15_0._mainheroco.face = arg_15_0._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	arg_15_0._mainheroco.mouth = arg_15_0._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	for iter_15_2, iter_15_3 in ipairs(arg_15_0._heroSpines) do
		iter_15_3:stopVoice()

		if iter_15_2 == arg_15_1 then
			iter_15_3:playVoice(arg_15_0._mainheroco)
		end
	end
end

function var_0_0._fadeUpdate(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0._heroSpineGos) do
		local var_16_0, var_16_1, var_16_2 = transformhelper.getLocalPos(iter_16_1.transform)

		transformhelper.setLocalPos(iter_16_1.transform, var_16_0, var_16_1, 1 - arg_16_1)
	end

	arg_16_0:_setHeroFadeMat()
end

function var_0_0._fadeInFinished(arg_17_0)
	return
end

function var_0_0._fadeOutFinished(arg_18_0)
	arg_18_0:_fadeUpdate(0)
end

function var_0_0._actShake(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0._stepCo = arg_19_1

	if arg_19_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_19_2 = false
	end

	if not arg_19_2 then
		arg_19_0._animator.speed = arg_19_0._stepCo.conversation.effRate

		if arg_19_4 then
			arg_19_0._animator:Play(UIAnimationName.Idle)

			arg_19_0._animator.enabled = false
		else
			arg_19_0._animator:SetBool("stoploop", true)
		end

		return
	end

	arg_19_0._animator.enabled = true

	arg_19_0._animator:SetBool("stoploop", false)

	local var_19_0 = {
		"low",
		"middle",
		"high"
	}

	arg_19_0._animator:Play(var_19_0[arg_19_3])

	arg_19_0._animator.speed = arg_19_0._stepCo.conversation.effRate
end

function var_0_0._setHeroFadeMat(arg_20_0)
	local var_20_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_20_0._bgGo = gohelper.findChild(var_20_0, "#go_upbg/#simage_bgimg")

	local var_20_1, var_20_2 = transformhelper.getLocalPos(arg_20_0._bgGo.transform)
	local var_20_3, var_20_4 = transformhelper.getLocalScale(arg_20_0._bgGo.transform)
	local var_20_5 = Vector4.New(var_20_3, var_20_4, var_20_1, var_20_2)
	local var_20_6 = arg_20_0._blitEff.capturedTexture

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroSkeletonGraphics) do
		iter_20_1.materialForRendering:SetTexture("_SceneMask", var_20_6)
		iter_20_1.materialForRendering:SetVector("_SceneMask_ST", var_20_5)
	end
end

function var_0_0.onOpen(arg_21_0)
	StoryController.instance:registerCallback(StoryEvent.ShowLeadRole, arg_21_0._showLeadHero, arg_21_0)
	StoryController.instance:registerCallback(StoryEvent.LeadRoleViewShow, arg_21_0._showView, arg_21_0)
	StoryController.instance:registerCallback(StoryEvent.ConversationShake, arg_21_0._actShake, arg_21_0)
end

function var_0_0.onClose(arg_22_0)
	StoryController.instance:unregisterCallback(StoryEvent.ShowLeadRole, arg_22_0._showLeadHero, arg_22_0)
	StoryController.instance:unregisterCallback(StoryEvent.LeadRoleViewShow, arg_22_0._showView, arg_22_0)
	StoryController.instance:unregisterCallback(StoryEvent.ConversationShake, arg_22_0._actShake, arg_22_0)
end

function var_0_0.onDestroyView(arg_23_0)
	return
end

return var_0_0

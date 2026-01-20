-- chunkname: @modules/logic/story/view/StoryLeadRoleSpineView.lua

module("modules.logic.story.view.StoryLeadRoleSpineView", package.seeall)

local StoryLeadRoleSpineView = class("StoryLeadRoleSpineView", BaseView)

function StoryLeadRoleSpineView:onInitView()
	self._gorolebg = gohelper.findChild(self.viewGO, "#go_rolebg")
	self._gospineroot = gohelper.findChild(self.viewGO, "#go_spineroot")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spineroot/mask/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryLeadRoleSpineView:addEvents()
	return
end

function StoryLeadRoleSpineView:removeEvents()
	return
end

function StoryLeadRoleSpineView:_editableInitView()
	self._blitEff = self._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	self._heroSpines = {}
	self._goSpines = {}
	self._heroSkeletonGraphics = {}
	self._heroSpineGos = {}

	local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

	for i = 1, #leadHeroSpineCos do
		if leadHeroSpineCos[i].resType == StoryEnum.IconResType.Spine then
			if not self._goSpines[i] then
				self._goSpines[i] = gohelper.create2d(self._gospine, "spine" .. i)
				self._heroSpines[i] = GuiSpine.Create(self._goSpines[i], true)
			end

			local path = "rolesstory/" .. leadHeroSpineCos[i].path

			self._heroSpines[i]:setResPath(path, self["_onHeroSpineLoaded" .. i], self)
		end
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gospineroot, false)
end

function StoryLeadRoleSpineView:_onHeroSpineLoaded1()
	self._heroSkeletonGraphics[1] = self._heroSpines[1]:getSkeletonGraphic()
	self._heroSpineGos[1] = self._heroSpines[1]:getSpineGo()
end

function StoryLeadRoleSpineView:_onHeroSpineLoaded2()
	self._heroSkeletonGraphics[2] = self._heroSpines[2]:getSkeletonGraphic()
	self._heroSpineGos[2] = self._heroSpines[2]:getSpineGo()
end

function StoryLeadRoleSpineView:_onHeroSpineLoaded3()
	self._heroSkeletonGraphics[3] = self._heroSpines[3]:getSkeletonGraphic()
	self._heroSpineGos[3] = self._heroSpines[3]:getSpineGo()
end

function StoryLeadRoleSpineView:_onHeroSpineLoaded4()
	self._heroSkeletonGraphics[4] = self._heroSpines[4]:getSkeletonGraphic()
	self._heroSpineGos[4] = self._heroSpines[3]:getSpineGo()
end

function StoryLeadRoleSpineView:_onHeroSpineLoaded5()
	self._heroSkeletonGraphics[5] = self._heroSpines[5]:getSkeletonGraphic()
	self._heroSpineGos[5] = self._heroSpines[5]:getSpineGo()
end

function StoryLeadRoleSpineView:onUpdateParam()
	return
end

function StoryLeadRoleSpineView:_showView(show, heroIcon)
	gohelper.setActive(self.viewGO, show)

	if heroIcon then
		gohelper.setActive(self._gospineroot, true)

		local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

		for roleType, spineCo in ipairs(leadHeroSpineCos) do
			if heroIcon == spineCo.icon then
				for spineIndex, gospine in ipairs(self._goSpines) do
					gohelper.setActive(gospine, roleType == spineIndex)
				end

				return
			end
		end
	end
end

function StoryLeadRoleSpineView:_keepSpineAni(roleType)
	if not self._gospineroot.activeSelf then
		return false
	end

	if not self._goSpines[roleType].activeSelf then
		return false
	end

	if self._mainheroco and (self._mainheroco.motion ~= "" or self._mainheroco.face ~= "" or self._mainheroco.mouth ~= "") and self._mainheroco.motion == self._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and self._mainheroco.face == self._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and self._mainheroco.mouth == self._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] then
		return true
	end

	return false
end

function StoryLeadRoleSpineView:_isSpineKeepShow(roleType)
	if not self._gospineroot.activeSelf then
		return false
	end

	if not self._goSpines[roleType].activeSelf then
		return false
	end

	return true
end

function StoryLeadRoleSpineView:_showLeadHero(co, show, fadeIn, fadeOut)
	self._stepCo = co

	local heroIcon = string.split(self._stepCo.conversation.heroIcon, ".")[1]

	if not self._roleType then
		self._roleType = 1
	end

	if self._stepCo.conversation.iconShow then
		local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

		for index, v in ipairs(leadHeroSpineCos) do
			if heroIcon == v.icon then
				self._roleType = index
			end
		end
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self:_keepSpineAni(self._roleType) then
		return
	end

	if not show then
		self._mainheroco = nil

		self._animator:Play(UIAnimationName.Idle)

		self._animator.enabled = false

		gohelper.setActive(self._gospineroot, false)

		for _, v in pairs(self._goSpines) do
			gohelper.setActive(v, false)
		end

		return
	end

	gohelper.setActive(self._gospineroot, true)
	self:_playHeroLeadSpineVoice(self._roleType)

	fadeIn = fadeIn and not self:_isSpineKeepShow(self._roleType)
	fadeOut = fadeOut and not self:_isSpineKeepShow(self._roleType)

	if not fadeIn and not fadeOut then
		self:_fadeUpdate(1)
	end

	if fadeIn then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._fadeUpdate, self._fadeInFinished, self, nil, EaseType.Linear)
	end

	if fadeOut then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, self._fadeUpdate, self._fadeOutFinished, self, nil, EaseType.Linear)
	end
end

function StoryLeadRoleSpineView:_playHeroLeadSpineVoice(roleType)
	for index, v in ipairs(self._goSpines) do
		gohelper.setActive(v, roleType == index)
	end

	if self._stepCo.conversation.heroIcon == "" or not self._stepCo.conversation.iconShow then
		return
	end

	self._mainheroco = {}
	self._mainheroco.motion = self._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	self._mainheroco.face = self._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	self._mainheroco.mouth = self._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	for index, v in ipairs(self._heroSpines) do
		v:stopVoice()

		if index == roleType then
			v:playVoice(self._mainheroco)
		end
	end
end

function StoryLeadRoleSpineView:_fadeUpdate(value)
	for _, v in ipairs(self._heroSpineGos) do
		local x, y, _ = transformhelper.getLocalPos(v.transform)

		transformhelper.setLocalPos(v.transform, x, y, 1 - value)
	end

	self:_setHeroFadeMat()
end

function StoryLeadRoleSpineView:_fadeInFinished()
	return
end

function StoryLeadRoleSpineView:_fadeOutFinished()
	self:_fadeUpdate(0)
end

function StoryLeadRoleSpineView:_actShake(co, shake, level, immediate)
	self._stepCo = co

	if self._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		shake = false
	end

	if not shake then
		self._animator.speed = self._stepCo.conversation.effRate

		if immediate then
			self._animator:Play(UIAnimationName.Idle)

			self._animator.enabled = false
		else
			self._animator:SetBool("stoploop", true)
		end

		return
	end

	self._animator.enabled = true

	self._animator:SetBool("stoploop", false)

	local aniName = {
		"low",
		"middle",
		"high"
	}

	self._animator:Play(aniName[level])

	self._animator.speed = self._stepCo.conversation.effRate
end

function StoryLeadRoleSpineView:_setHeroFadeMat()
	local bgRootGo = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	self._bgGo = gohelper.findChild(bgRootGo, "#go_upbg/#simage_bgimg")

	local posx, posy = transformhelper.getLocalPos(self._bgGo.transform)
	local scalex, scaley = transformhelper.getLocalScale(self._bgGo.transform)
	local vec4 = Vector4.New(scalex, scaley, posx, posy)
	local texture = self._blitEff.capturedTexture

	for _, v in ipairs(self._heroSkeletonGraphics) do
		v.materialForRendering:SetTexture("_SceneMask", texture)
		v.materialForRendering:SetVector("_SceneMask_ST", vec4)
	end
end

function StoryLeadRoleSpineView:onOpen()
	StoryController.instance:registerCallback(StoryEvent.ShowLeadRole, self._showLeadHero, self)
	StoryController.instance:registerCallback(StoryEvent.LeadRoleViewShow, self._showView, self)
	StoryController.instance:registerCallback(StoryEvent.ConversationShake, self._actShake, self)
end

function StoryLeadRoleSpineView:onClose()
	StoryController.instance:unregisterCallback(StoryEvent.ShowLeadRole, self._showLeadHero, self)
	StoryController.instance:unregisterCallback(StoryEvent.LeadRoleViewShow, self._showView, self)
	StoryController.instance:unregisterCallback(StoryEvent.ConversationShake, self._actShake, self)
end

function StoryLeadRoleSpineView:onDestroyView()
	return
end

return StoryLeadRoleSpineView

-- chunkname: @modules/logic/story/view/StoryHeroView.lua

module("modules.logic.story.view.StoryHeroView", package.seeall)

local StoryHeroView = class("StoryHeroView", BaseView)

function StoryHeroView:onInitView()
	self._gorolebg = gohelper.findChild(self.viewGO, "#go_rolebg")
	self._goroles = gohelper.findChild(self.viewGO, "#go_roles")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryHeroView:addEvents()
	return
end

function StoryHeroView:removeEvents()
	return
end

function StoryHeroView:_addEvent()
	self:addEventCb(StoryController.instance, StoryEvent.RefreshHero, self._onUpdateHero, self)
	self:addEventCb(StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self:addEventCb(StoryController.instance, StoryEvent.Finish, self._clearItems, self)
end

function StoryHeroView:_removeEvent()
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshHero, self._onUpdateHero, self)
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Finish, self._clearItems, self)
end

function StoryHeroView:_editableInitView()
	self._blitEff = self._gorolebg:GetComponent(typeof(UrpCustom.UIBlitEffect))
	self._heros = {}

	self:_loadRes()
end

local normalMatPath = "spine/spine_ui_default.mat"
local darkMatPath = "spine/spine_ui_dark.mat"

function StoryHeroView:_loadRes()
	self._matLoader = MultiAbLoader.New()

	self._matLoader:addPath(normalMatPath)
	self._matLoader:addPath(darkMatPath)
	self._matLoader:startLoad(self._onResLoaded, self)
end

function StoryHeroView:_onResLoaded()
	local norMat = self._matLoader:getAssetItem(normalMatPath)

	if norMat then
		self._normalMat = norMat:GetResource(normalMatPath)
	else
		logError("Resource is not found at path : " .. normalMatPath)
	end

	local darkMat = self._matLoader:getAssetItem(darkMatPath)

	if darkMat then
		self._darkMat = darkMat:GetResource(darkMatPath)
	else
		logError("Resource is not found at path : " .. darkMatPath)
	end

	self:_resetHeroMat()
end

function StoryHeroView:_resetHeroMat()
	if not self._heroCo then
		return
	end

	for k, v in pairs(self._heroCo) do
		local mat = self:_isHeroDark(k) and self._darkMat or self._normalMat

		if self._heros[v.heroIndex] then
			local hasBottomEffect = StoryModel.instance:hasBottomEffect()

			self._heros[v.heroIndex]:setHeroMat(mat, hasBottomEffect)
		end
	end
end

function StoryHeroView:_isHeroDark(key)
	for _, v in pairs(self._stepCo.conversation.showList) do
		if v == key - 1 then
			return false
		end
	end

	return true
end

function StoryHeroView:onUpdateParam()
	return
end

function StoryHeroView:onOpen()
	self:_addEvent()
end

function StoryHeroView:onClose()
	self:_removeEvent()
end

function StoryHeroView:_onUpdateHero(param)
	if #param.branches > 0 then
		StoryController.instance:openStoryBranchView(param.branches)
	end

	if param.stepType ~= StoryEnum.StepType.Normal then
		for _, v in pairs(self._heros) do
			v:stopVoice()
		end

		return
	end

	self._stepCo = StoryStepModel.instance:getStepListById(param.stepId)

	if self._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and self._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		self:_updateHeroList(self._stepCo.heroList)
	end
end

function StoryHeroView:_refreshView()
	TaskDispatcher.cancelTask(self._playShowHero, self)
	self:_updateHeroList(self._stepCo.heroList)
end

function StoryHeroView:_storyFinished()
	if not StoryController.instance._hideStartAndEndDark then
		return
	end

	self:_updateHeroList({})
end

function StoryHeroView:_updateHeroList(param)
	local needFadeOut = false
	local needFadeIn = false
	local hasHeroLeave = false

	self._blitEff:SetKeepCapture(true)

	if self._heroCo then
		if #self._heroCo == 0 and #param == 0 then
			needFadeIn = false
			needFadeOut = false
		else
			local hasSame = false

			for _, v in pairs(param) do
				for _, hero in pairs(self._heroCo) do
					if hero.heroIndex == v.heroIndex then
						hasSame = true

						break
					end
				end
			end

			if hasSame then
				needFadeIn = false
				needFadeOut = false
			else
				needFadeIn = true
				needFadeOut = true
			end
		end
	else
		needFadeOut = false
		needFadeIn = true
		self._heroCo = {}
	end

	if self._preStepTransBg then
		self._preStepTransBg = false
		needFadeOut = true
		needFadeIn = true
	else
		local preStepIds = StoryModel.instance:getPreSteps(self._stepCo.id)

		if preStepIds and #preStepIds > 0 then
			local preStepMo = StoryStepModel.instance:getStepListById(preStepIds[1])
			local preStepBg = preStepMo and preStepMo.bg
			local bgCo = self._stepCo.bg

			if preStepBg and bgCo and (bgCo.offset[1] ~= preStepBg.offset[1] or bgCo.offset[2] ~= preStepBg.offset[2]) then
				self._preStepTransBg = true
			end
		end
	end

	for _, curV in pairs(self._heroCo) do
		local has = true

		for _, lastV in pairs(param) do
			if lastV.heroIndex == curV.heroIndex then
				has = false

				break
			end
		end

		if has then
			hasHeroLeave = true
		end
	end

	self._heroCo = param

	local del = {}

	for index, hero in pairs(self._heros) do
		local show = false

		for _, co in pairs(self._heroCo) do
			if co.heroIndex == index then
				show = true
			end
		end

		if not show then
			hero:hideHero()
			table.insert(del, index)
		end
	end

	for _, v in pairs(del) do
		self._heros[v] = nil
	end

	if needFadeOut then
		StoryModel.instance:enableClick(false)

		if hasHeroLeave then
			TaskDispatcher.runDelay(self._playShowHero, self, 1)
		else
			TaskDispatcher.runDelay(self._playShowHero, self, 0.5)
		end
	elseif hasHeroLeave then
		StoryModel.instance:enableClick(false)
		TaskDispatcher.runDelay(self._playShowHero, self, 0.5)
	else
		self:_playShowHero()
	end

	StoryModel.instance:setNeedFadeIn(needFadeIn)
	StoryModel.instance:setNeedFadeOut(needFadeOut)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshConversation)
end

function StoryHeroView:_playShowHero()
	local hasNewHero = false
	local conAudioId = self._stepCo.conversation.audios[1] or 0

	for k, v in pairs(self._heroCo) do
		local mat = self:_isHeroDark(k) and self._darkMat or self._normalMat
		local hasBottomEffect = StoryModel.instance:hasBottomEffect()

		if not self._heros[v.heroIndex] then
			hasNewHero = true

			local heroItem = StoryHeroItem.New()

			self._heros[v.heroIndex] = heroItem

			heroItem:init(self._goroles, v)
			heroItem:buildHero(v, mat, hasBottomEffect, self._onEnableClick, self, conAudioId)
		else
			self._heros[v.heroIndex]:resetHero(v, mat, hasBottomEffect, conAudioId)
		end
	end

	if not hasNewHero then
		local stepId = StoryModel.instance:getCurStepId()
		local stepCo = StoryStepModel.instance:getStepListById(stepId)

		if stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
			StoryModel.instance:enableClick(true)
		end
	end

	StoryController.instance:dispatchEvent(StoryEvent.OnHeroShowed)
end

function StoryHeroView:_onEnableClick()
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function StoryHeroView:_clearItems()
	for _, v in pairs(self._heros) do
		v:onDestroy()
	end

	self._heros = {}
end

function StoryHeroView:onDestroyView()
	TaskDispatcher.cancelTask(self._playShowHero, self)
	ViewMgr.instance:closeView(ViewName.StoryView, true)
	ViewMgr.instance:closeView(ViewName.StoryLeadRoleSpineView, true)
	self:_clearItems()
	self._blitEff:SetKeepCapture(false)

	if self._matLoader then
		self._matLoader:dispose()

		self._matLoader = nil
	end
end

return StoryHeroView

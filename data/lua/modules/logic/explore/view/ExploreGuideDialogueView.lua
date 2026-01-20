-- chunkname: @modules/logic/explore/view/ExploreGuideDialogueView.lua

module("modules.logic.explore.view.ExploreGuideDialogueView", package.seeall)

local ExploreGuideDialogueView = class("ExploreGuideDialogueView", BaseView)

function ExploreGuideDialogueView:onClose()
	GameUtil.onDestroyViewMember(self, "_hasIconDialogItem")
end

function ExploreGuideDialogueView:onInitView()
	self._btnfullscreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._gochoicelist = gohelper.findChild(self.viewGO, "#go_choicelist")
	self._gochoiceitem = gohelper.findChild(self.viewGO, "#go_choicelist/#go_choiceitem")
	self._txttalkinfo = gohelper.findChildText(self.viewGO, "go_normalcontent/txt_contentcn")
	self._txttalker = gohelper.findChildText(self.viewGO, "#txt_talker")

	gohelper.setActive(self._gochoicelist, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreGuideDialogueView:addEvents()
	self._btnfullscreen:AddClickListener(self.onClickFull, self)
	GuideController.instance:registerCallback(GuideEvent.OnClickSpace, self.onClickFull, self)
	GuideController.instance:registerCallback(GuideEvent.OneKeyFinishGuides, self.closeThis, self)
end

function ExploreGuideDialogueView:removeEvents()
	GuideController.instance:unregisterCallback(GuideEvent.OnClickSpace, self.onClickFull, self)
	GuideController.instance:unregisterCallback(GuideEvent.OneKeyFinishGuides, self.closeThis, self)
	self._btnfullscreen:RemoveClickListener()
end

function ExploreGuideDialogueView:onClickFull()
	if self._hasIconDialogItem:isPlaying() then
		self._hasIconDialogItem:conFinished()

		return
	end

	local closeCallback = self.viewParam.closeCallBack
	local callbackParam = self.viewParam.guideKey

	if not self.viewParam.noClose then
		self:closeThis()
	end

	closeCallback(callbackParam)
end

function ExploreGuideDialogueView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_course_open)
	self:_refreshView()
end

function ExploreGuideDialogueView:onUpdateParam()
	self:_refreshView()
end

function ExploreGuideDialogueView:_refreshView()
	local content = string.gsub(self.viewParam.tipsContent, " ", " ")

	if LangSettings.instance:isEn() then
		content = self.viewParam.tipsContent
	end

	if not self._hasIconDialogItem then
		self._hasIconDialogItem = MonoHelper.addLuaComOnceToGo(self.viewGO, TMPFadeIn)

		self._hasIconDialogItem:setTopOffset(0, -4.5)
		self._hasIconDialogItem:setLineSpacing(20)
	end

	self._hasIconDialogItem:playNormalText(content)

	self._txttalker.text = self.viewParam.tipsTalker
end

return ExploreGuideDialogueView

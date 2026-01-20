-- chunkname: @modules/logic/dialogue/view/items/DialogueNormalItem.lua

module("modules.logic.dialogue.view.items.DialogueNormalItem", package.seeall)

local DialogueNormalItem = class("DialogueNormalItem", DialogueItem)

function DialogueNormalItem:_showContent(content)
	TaskDispatcher.cancelTask(self._delayShowContent, self)

	content = content or ""
	self._markTopList = StoryTool.getMarkTopTextList(content)
	self._contentStr = StoryTool.filterMarkTop(content)

	self:_setLineSpacing(self:_getLineSpacing())

	self.txtContent.text = self._contentStr

	TaskDispatcher.runDelay(self._delayShowContent, self, 0.01)
end

function DialogueNormalItem:_delayShowContent()
	self._conMark:SetMarksTop(self._markTopList)
end

function DialogueNormalItem:_getLineSpacing()
	return #self._markTopList > 0 and self._lineSpacing or self._originalLineSpacing
end

function DialogueNormalItem:_setLineSpacing(lineSpacing)
	self.txtContent.lineSpacing = lineSpacing or 0
end

function DialogueNormalItem:initView()
	self.simageAvatar = gohelper.findChildSingleImage(self.go, "rolebg/#image_avatar")
	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtContent = gohelper.findChildText(self.go, "content_bg/#txt_content")
	self.goLoading = gohelper.findChild(self.go, "content_bg/#go_loading")
	self.contentBgRectTr = gohelper.findChildComponent(self.go, "content_bg", gohelper.Type_RectTransform)
	self.txtRectTr = self.txtContent:GetComponent(gohelper.Type_RectTransform)
	self._txtmarktop = IconMgr.instance:getCommonTextMarkTop(self.txtContent.gameObject):GetComponent(gohelper.Type_TextMesh)
	self._conMark = gohelper.onceAddComponent(self.txtContent.gameObject, typeof(ZProj.TMPMark))

	self._conMark:SetMarkTopGo(self._txtmarktop.gameObject)
	self._conMark:SetTopOffset(8, -2.4)

	self._originalLineSpacing = self.txtContent.lineSpacing
	self._lineSpacing = 26
end

function DialogueNormalItem:refresh()
	self.simageAvatar:LoadImage(ResUrl.getHeadIconSmall(self.stepCo.avatar))

	self.txtName.text = self.stepCo.name

	self:_showContent(self.stepCo.content)
	AudioMgr.instance:trigger(AudioEnum.Dialogue.play_ui_wulu_duihua)
end

function DialogueNormalItem:calculateHeight()
	local width = self.txtContent.preferredWidth

	if width <= DialogueEnum.MessageTxtMaxWidth then
		local contentBgHeight = DialogueEnum.MessageTxtOneLineHeight + DialogueEnum.MessageBgOffsetHeight

		recthelper.setSize(self.contentBgRectTr, width + DialogueEnum.MessageBgOffsetWidth, contentBgHeight)
		recthelper.setSize(self.txtRectTr, width, DialogueEnum.MessageTxtOneLineHeight)

		self.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], contentBgHeight + DialogueEnum.MessageNameHeight)

		return
	end

	width = DialogueEnum.MessageTxtMaxWidth

	local height = self.txtContent.preferredHeight
	local contentBgHeight = height + DialogueEnum.MessageBgOffsetHeight

	recthelper.setSize(self.contentBgRectTr, DialogueEnum.MessageTxtMaxWidth + DialogueEnum.MessageBgOffsetWidth, contentBgHeight)
	recthelper.setSize(self.txtRectTr, width, height)

	self.height = Mathf.Max(DialogueEnum.MinHeight[DialogueEnum.Type.LeftMessage], contentBgHeight + DialogueEnum.MessageNameHeight)
end

function DialogueNormalItem:logHeight()
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.preferredHeight)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.preferredWidth)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.renderedWidth)
	logError(string.format("【%s】", self.stepCo.id) .. " : " .. self.txtContent.renderedHeight)
end

function DialogueNormalItem:onDestroy()
	TaskDispatcher.cancelTask(self._delayShowContent, self)
	self.simageAvatar:UnLoadImage()
end

return DialogueNormalItem

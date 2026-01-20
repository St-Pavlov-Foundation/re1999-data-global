-- chunkname: @modules/logic/help/view/LawDescriptionView.lua

module("modules.logic.help.view.LawDescriptionView", package.seeall)

local LawDescriptionView = class("LawDescriptionView", BaseView)

function LawDescriptionView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._txttext = gohelper.findChildText(self.viewGO, "scroll/viewport/#txt_text")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LawDescriptionView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function LawDescriptionView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function LawDescriptionView:_btncloseOnClick()
	self:closeThis()
end

function LawDescriptionView:onClickModalMask()
	self:closeThis()
end

function LawDescriptionView:_editableInitView()
	self._simagetop:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simagebottom:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function LawDescriptionView:onUpdateParam()
	return
end

function LawDescriptionView:onOpen()
	local id = self.viewParam.id
	local helpPageCO = HelpConfig.instance:getHelpPageCo(id)

	self._txttitle.text = helpPageCO.title
	self._txttext.text = helpPageCO.text
end

function LawDescriptionView:onClose()
	return
end

function LawDescriptionView:onDestroyView()
	self._simagetop:UnLoadImage()
	self._simagebottom:UnLoadImage()
end

return LawDescriptionView

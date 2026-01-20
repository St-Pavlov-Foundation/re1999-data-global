-- chunkname: @modules/logic/rouge/view/RougeEndingThreeView.lua

module("modules.logic.rouge.view.RougeEndingThreeView", package.seeall)

local RougeEndingThreeView = class("RougeEndingThreeView", BaseView)

function RougeEndingThreeView:onInitView()
	self._btnnext = gohelper.findChildButton(self.viewGO, "Content/#btn_next")
	self._txtcontent = gohelper.findChildText(self.viewGO, "Content/#go_success/txt_success")
	self._txttitle = gohelper.findChildText(self.viewGO, "Content/Title/#txt_Title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeEndingThreeView:addEvents()
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function RougeEndingThreeView:removeEvents()
	self._btnnext:RemoveClickListener()
end

function RougeEndingThreeView:_btnnextOnClick()
	self:closeThis()
	RougeController.instance:openRougeResultView()
end

function RougeEndingThreeView:_editableInitView()
	local titleConstCo = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeTitle]
	local title = titleConstCo and titleConstCo.value2
	local contentConstCo = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeContent]
	local content = contentConstCo and contentConstCo.value2

	self._txttitle.text = title
	self._txtcontent.text = content
end

function RougeEndingThreeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenEndingThreeView)
end

return RougeEndingThreeView

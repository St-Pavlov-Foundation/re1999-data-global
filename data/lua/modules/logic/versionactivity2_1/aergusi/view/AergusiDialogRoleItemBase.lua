-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogRoleItemBase.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogRoleItemBase", package.seeall)

local AergusiDialogRoleItemBase = class("AergusiDialogRoleItemBase", LuaCompBase)
local kType_TMPMark = typeof(ZProj.TMPMark)

function AergusiDialogRoleItemBase:ctor(...)
	self:__onInit()

	self.__txtCmpList = self:getUserDataTb_()
	self.__txtmarktopList = self:getUserDataTb_()
	self.__txtmarktopGoList = self:getUserDataTb_()
	self.__txtConMarkList = self:getUserDataTb_()
	self.__txtmarktopIndex = 0
	self.__fTimerList = {}
	self.__lineSpacing = {}
	self.__originalLineSpacing = {}
	self.__markTopListList = {}
end

function AergusiDialogRoleItemBase:setTopOffset(index, offsetX, offsetY)
	local txtConMark = self.__txtConMarkList[index]

	if not txtConMark then
		return
	end

	txtConMark:SetTopOffset(offsetX or 0, offsetY or 0)
end

function AergusiDialogRoleItemBase:createMarktopCmp(textCmp)
	local index = self.__txtmarktopIndex + 1

	self.__txtmarktopIndex = index

	local textGo = textCmp.gameObject
	local txtmarktopGo = IconMgr.instance:getCommonTextMarkTop(textGo)
	local txtmarktop = txtmarktopGo:GetComponent(gohelper.Type_TextMesh)
	local txtConMark = gohelper.onceAddComponent(textGo, kType_TMPMark)

	self.__txtCmpList[index] = textCmp
	self.__txtmarktopGoList[index] = txtmarktopGo
	self.__txtmarktopList[index] = txtmarktop
	self.__txtConMarkList[index] = txtConMark
	self.__originalLineSpacing[index] = textCmp.lineSpacing

	txtConMark:SetMarkTopGo(txtmarktopGo)

	return index
end

function AergusiDialogRoleItemBase:setTextWithMarktopByIndex(index, str)
	self.__markTopListList[index] = StoryTool.getMarkTopTextList(str)

	self:_setText(index, StoryTool.filterMarkTop(str))
	self:_unregftimer(index)

	local fTimer = FrameTimerController.instance:register(function()
		local txtmarktop = self.__txtmarktopList[index]
		local txtmarktopGo = self.__txtmarktopGoList[index]
		local txtConMark = self.__txtConMarkList[index]
		local markTopList = self.__markTopListList[index]

		if markTopList and txtmarktop and txtConMark and not gohelper.isNil(txtmarktopGo) then
			txtConMark:SetMarksTop(markTopList)
		end
	end, nil, 1)

	self.__fTimerList[index] = fTimer

	fTimer:Start()
end

function AergusiDialogRoleItemBase:_setText(index, str)
	local textCmp = self.__txtCmpList[index]

	if not textCmp then
		return
	end

	textCmp.lineSpacing = self:getLineSpacing(index)
	textCmp.text = str
end

function AergusiDialogRoleItemBase:setLineSpacing(index, lineSpacing)
	self.__lineSpacing[index] = lineSpacing or 0
end

function AergusiDialogRoleItemBase:getLineSpacing(index)
	local markTopList = self.__markTopListList[index]
	local lineSpacing = self.__lineSpacing[index]
	local original = self.__originalLineSpacing[index]

	return markTopList and #markTopList > 0 and lineSpacing or original or 0
end

function AergusiDialogRoleItemBase:_unregftimer(index)
	local fTimer = self.__fTimerList[index]

	if not fTimer then
		return
	end

	FrameTimerController.instance:unregister(fTimer)

	self.__fTimerList[index] = nil
end

function AergusiDialogRoleItemBase:destroy()
	for index, _ in pairs(self.__fTimerList) do
		self:_unregftimer(index)
	end

	self:__onDispose()
end

return AergusiDialogRoleItemBase

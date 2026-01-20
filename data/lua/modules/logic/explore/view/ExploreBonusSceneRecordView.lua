-- chunkname: @modules/logic/explore/view/ExploreBonusSceneRecordView.lua

module("modules.logic.explore.view.ExploreBonusSceneRecordView", package.seeall)

local ExploreBonusSceneRecordView = class("ExploreBonusSceneRecordView", BaseView)
local kMarkTopPaddingTopOffset = 8

function ExploreBonusSceneRecordView:_setContentPaddingTop(value)
	self._vLayoutGroup.padding.top = value
end

function ExploreBonusSceneRecordView:_updateContentPaddingTop(isContainsMarkTop)
	local value = self._originalPaddingTop

	if isContainsMarkTop then
		value = value + kMarkTopPaddingTopOffset
	end

	self:_setContentPaddingTop(value)
end

function ExploreBonusSceneRecordView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._item = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content/#go_chatitem")
	self._itemContent = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._vLayoutGroup = self._itemContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))
	self._originalPaddingTop = self._vLayoutGroup.padding.top
	self._tmpMarkTopTextList = {}
	self._tmpMarkTopTextListList = {}
end

function ExploreBonusSceneRecordView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function ExploreBonusSceneRecordView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ExploreBonusSceneRecordView:onOpen()
	local chapterId = self.viewParam.chapterId
	local chapterBonusSceneDict = ExploreSimpleModel.instance:getChapterMo(chapterId).bonusScene
	local id, options = next(chapterBonusSceneDict)
	local cfgs = ExploreConfig.instance:getDialogueConfig(id)
	local showDatas = {}
	local icon

	for index, select in ipairs(options) do
		local co = cfgs[index]

		if co then
			local data = {
				desc = co.desc
			}

			if not string.nilorempty(co.bonusButton) then
				local arr = string.split(co.bonusButton, "|")

				data.options = arr
				data.index = select
			end

			table.insert(showDatas, data)

			if not string.nilorempty(co.picture) then
				icon = co.picture
			end
		end
	end

	if not string.nilorempty(icon) then
		self._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. icon))
	end

	gohelper.CreateObjList(self, self.onCreateItem, showDatas, self._itemContent, self._item)
end

function ExploreBonusSceneRecordView:onCreateItem(obj, data, index)
	local info = gohelper.findChildTextMesh(obj, "info")
	local bg = gohelper.findChild(obj, "bg")

	gohelper.setActive(info, data.desc)
	gohelper.setActive(bg, data.options)

	if data.desc then
		local tmpMarkTopText = self._tmpMarkTopTextList[index]

		if not tmpMarkTopText then
			tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(info.gameObject, TMPMarkTopText)

			tmpMarkTopText:setTopOffset(0, -5.2)
			tmpMarkTopText:setLineSpacing(15)

			self._tmpMarkTopTextList[index] = tmpMarkTopText
		else
			tmpMarkTopText:reInitByCmp(info)
		end

		tmpMarkTopText:setData(data.desc)
	end

	if index == 1 then
		self:_updateContentPaddingTop(self._tmpMarkTopTextList[index]:isContainsMarkTop())
	end

	if data.options then
		for i = 1, 3 do
			local txt1 = gohelper.findChildTextMesh(bg, "txt" .. i)
			local play = gohelper.findChild(bg, "txt" .. i .. "/play")

			self._tmpMarkTopTextListList[index] = self._tmpMarkTopTextListList[index] or {}

			local tmpMarkTopTextList = self._tmpMarkTopTextListList[index]
			local tmpMarkTopText = tmpMarkTopTextList[i]

			if not tmpMarkTopText then
				tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(txt1.gameObject, TMPMarkTopText)

				tmpMarkTopText:setTopOffset(0, -5.5)
				tmpMarkTopText:setLineSpacing(7)

				self._tmpMarkTopTextListList[index][i] = tmpMarkTopText
			else
				tmpMarkTopText:reInitByCmp(txt1)
			end

			if data.options[i] then
				tmpMarkTopText:setData(data.options[i])
				gohelper.setActive(play, data.index == i)
				SLFramework.UGUI.GuiHelper.SetColor(txt1, data.index == i and "#445D42" or "#3D3939")
			else
				gohelper.setActive(txt1, false)
			end
		end
	end
end

function ExploreBonusSceneRecordView:onClickModalMask()
	self:closeThis()
end

function ExploreBonusSceneRecordView:onClose()
	GameUtil.onDestroyViewMemberList(self, "_tmpMarkTopTextList")

	if self._tmpMarkTopTextListList then
		for _, list in pairs(self._tmpMarkTopTextListList) do
			for _, item in pairs(list) do
				item:onDestroyView()
			end
		end

		self._tmpMarkTopTextListList = nil
	end

	self._simageicon:UnLoadImage()
end

return ExploreBonusSceneRecordView

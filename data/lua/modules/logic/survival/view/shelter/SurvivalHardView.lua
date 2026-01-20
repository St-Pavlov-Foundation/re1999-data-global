-- chunkname: @modules/logic/survival/view/shelter/SurvivalHardView.lua

module("modules.logic.survival.view.shelter.SurvivalHardView", package.seeall)

local SurvivalHardView = class("SurvivalHardView", BaseView)

function SurvivalHardView:onInitView()
	self.btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#btn_Next")
	self.btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self.btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self.goFrame1 = gohelper.findChild(self.viewGO, "#simage_Frame1")
	self.goFrame2 = gohelper.findChild(self.viewGO, "#simage_Frame2")
	self.goFrame3 = gohelper.findChild(self.viewGO, "#simage_Frame3")
	self.txtDifficulty = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/image_DifficultyBG/txt_Difficulty")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/#txt_Desc")
	self.simageLevelPic = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/#simage_LevelPic")
	self.goItemPanel = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel")
	self.selectPanelCanvasGroup = gohelper.onceAddComponent(self.goItemPanel, typeof(UnityEngine.CanvasGroup))
	self.btnEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Right/#go_Empty")
	self.goScroll = gohelper.findChild(self.viewGO, "Panel/Right/#scroll_List")
	self.goDifficultyAssess = gohelper.findChild(self.viewGO, "Panel/Right/image_DifficultyAssessBG")
	self.txtDifficultyAssess = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/image_DifficultyAssessBG/txt_DifficultyAssess")
	self.tabItems = {}

	for i = 1, 3 do
		self:createTab(i)
	end

	self.lineItems = {}
	self.goHardItem = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_SmallItem")
	self.goLineItem = gohelper.findChild(self.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_Item")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)

	self:setPanelVisible(false)
end

function SurvivalHardView:addEvents()
	self:addClickCb(self.btnnext, self.onClickNext, self)
	self:addClickCb(self.btnleft, self.onClickLeft, self)
	self:addClickCb(self.btnright, self.onClickRight, self)
	self:addClickCb(self.btnEmpty, self.onClickEmpty, self)
end

function SurvivalHardView:removeEvents()
	self:removeClickCb(self.btnnext)
	self:removeClickCb(self.btnleft)
	self:removeClickCb(self.btnright)
	self:removeClickCb(self.btnEmpty)
end

function SurvivalHardView:onClickNext()
	SurvivalDifficultyModel.instance:sendDifficultyChoose()
end

function SurvivalHardView:onClickLeft()
	local animName = SurvivalDifficultyModel.instance:changeDifficultyIndex(-1)

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickRight()
	local animName = SurvivalDifficultyModel.instance:changeDifficultyIndex(1)

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickEmpty()
	self.inSelectCustom = true

	self:refreshView()
end

function SurvivalHardView:onClickTab(index)
	local flag = SurvivalDifficultyModel.instance:setCustomSelectIndex(index)

	if not flag then
		return
	end

	local animName = "switch_buff"

	self:playAnim(animName)
	UIBlockHelper.instance:startBlock(self.viewName, 0.167, self.viewName)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function SurvivalHardView:onClickGrid(item)
	if not item.config.id then
		return
	end

	local info = SurvivalModel.instance:getOutSideInfo()
	local hasUnlock = info and info:isUnlockDifficulty(item.config.id) or false

	if not hasUnlock then
		if string.nilorempty(item.config.lockDesc) then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		else
			GameFacade.showToastString(item.config.lockDesc)
		end

		return
	end

	if SurvivalDifficultyModel.instance:selectCustomDifficulty(item.config.id) then
		self:refreshNextBtn()
		self:refreshTab()
		self:refreshLine(item.line, item.line.data)
		self:refreshDifficultyList()
		self:refreshAssess()
	end
end

function SurvivalHardView:createTab(index)
	local item = self:getUserDataTb_()

	item.index = index
	item.go = gohelper.findChild(self.viewGO, string.format("Panel/Left/#go_ItemPanel/Tab/#go_Tab%s", index))
	item.goSelect = gohelper.findChild(item.go, "#go_TabSelected")
	item.goUnSelect = gohelper.findChild(item.go, "#go_TabUnSelected")
	item.txtSelectNum = gohelper.findChildTextMesh(item.goSelect, "#txt_Num")
	item.txtUnSelectNum = gohelper.findChildTextMesh(item.goUnSelect, "#txt_Num")
	item.btn = gohelper.findButtonWithAudio(item.go)

	item.btn:AddClickListener(self.onClickTab, self, index)

	self.tabItems[index] = item
end

function SurvivalHardView:onOpen()
	SurvivalDifficultyModel.instance:refreshDifficulty()
	self:refreshView()
end

function SurvivalHardView:refreshView()
	local isCustom = SurvivalDifficultyModel.instance:isCustomDifficulty()

	if isCustom then
		self:refreshCustomView()
	else
		self:refreshNormalView()
	end
end

function SurvivalHardView:refreshCustomView()
	local difficultyId = SurvivalDifficultyModel.instance:getDifficultyId()

	self.simageLevelPic:LoadImage("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_01.png")
	self:refreshCustomPanel()
	self:refreshPanel(difficultyId)
end

function SurvivalHardView:refreshCustomPanel()
	local list = SurvivalDifficultyModel.instance:getDifficultyShowList()
	local isEmpty = next(list) == nil and not self.inSelectCustom

	self:setPanelVisible(not isEmpty)
	gohelper.setActive(self.btnEmpty, isEmpty)
	gohelper.setActive(self.goScroll, not isEmpty)
	self:refreshNextBtn()

	if not isEmpty then
		self:refreshTab()
		self:refreshGridList()
		self:refreshDifficultyList()
	end
end

function SurvivalHardView:refreshNextBtn()
	local isCustom = SurvivalDifficultyModel.instance:isCustomDifficulty()

	if not isCustom then
		ZProj.UGUIHelper.SetGrayscale(self.btnnext.gameObject, false)

		return
	end

	local list = SurvivalDifficultyModel.instance:getDifficultyShowList()
	local isEmpty = next(list) == nil

	ZProj.UGUIHelper.SetGrayscale(self.btnnext.gameObject, isEmpty)
end

function SurvivalHardView:refreshNormalView()
	local difficultyId = SurvivalDifficultyModel.instance:getDifficultyId()

	self.simageLevelPic:LoadImage(string.format("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_0%s.png", difficultyId))
	self:setPanelVisible(false)
	gohelper.setActive(self.btnEmpty, false)
	gohelper.setActive(self.goScroll, true)
	self:refreshNextBtn()
	self:refreshDifficultyList()
	self:refreshPanel(difficultyId)
end

function SurvivalHardView:refreshPanel(difficultyId)
	local difficultyConfig = lua_survival_hardness_mod.configDict[difficultyId]

	self.txtDifficulty.text = difficultyConfig.name
	self.txtDesc.text = difficultyConfig.desc

	self:refreshFrame(difficultyId)
	self:refreshAssess()

	local left, right = SurvivalDifficultyModel.instance:getArrowStatus()

	gohelper.setActive(self.btnleft, left)
	gohelper.setActive(self.btnright, right)
end

function SurvivalHardView:refreshFrame(difficultyId)
	gohelper.setActive(self.goFrame1, difficultyId == 2)
	gohelper.setActive(self.goFrame2, difficultyId == 3)
	gohelper.setActive(self.goFrame3, difficultyId == 4)
end

function SurvivalHardView:refreshAssess()
	local assess = SurvivalDifficultyModel.instance:getDifficultyAssess()

	self.txtDifficultyAssess.text = formatLuaLang("survivalselectdifficultyview_txt_assess", assess)
end

function SurvivalHardView:refreshDifficultyList()
	SurvivalDifficultyModel.instance:refreshDifficultyShowList()
end

function SurvivalHardView:refreshTab()
	local selectIndex = SurvivalDifficultyModel.instance:getCustomSelectIndex()

	for i, v in ipairs(self.tabItems) do
		local isSelect = selectIndex == i

		gohelper.setActive(v.goSelect, isSelect)
		gohelper.setActive(v.goUnSelect, not isSelect)

		local assess = SurvivalDifficultyModel.instance:getCustomDifficultyAssess(i)

		v.txtSelectNum.text = assess
		v.txtUnSelectNum.text = assess
	end
end

function SurvivalHardView:refreshGridList()
	local selectIndex = SurvivalDifficultyModel.instance:getCustomSelectIndex()
	local list = SurvivalDifficultyModel.instance.customDifficultyList[selectIndex]
	local dataList = {}

	for subtype, subList in pairs(list) do
		table.insert(dataList, {
			subtype = subtype,
			list = subList
		})
	end

	table.sort(dataList, SortUtil.keyLower("subtype"))

	for i = 1, math.max(#self.lineItems, #dataList) do
		local line = self.lineItems[i]

		if not line then
			line = self:getUserDataTb_()
			line.index = i
			line.go = gohelper.cloneInPlace(self.goLineItem, tostring(i))
			line.goEvent = gohelper.findChild(line.go, "#go_EvenBG")
			line.goGrid = gohelper.findChild(line.go, "Grid")
			line.items = self:getUserDataTb_()
			self.lineItems[i] = line
		end

		self:refreshLine(line, dataList[i])
	end
end

function SurvivalHardView:refreshLine(line, data)
	line.data = data

	if not data then
		gohelper.setActive(line.go, false)

		return
	end

	gohelper.setActive(line.go, true)

	local list = data.list

	gohelper.setActive(line.goEvent, line.index % 2 == 0)

	for i = 1, math.max(#line.items, #list) do
		local item = line.items[i]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.clone(self.goHardItem, line.goGrid, tostring(i))
			item.imageQuality = gohelper.findChildImage(item.go, "#image_Quality")
			item.goQuality = item.imageQuality.gameObject
			item.goSelected = gohelper.findChild(item.go, "#go_Selected")
			item.goIcon = gohelper.findChild(item.go, "image_Icon")
			item.simageIcon = gohelper.findChildSingleImage(item.go, "image_Icon")
			item.btn = gohelper.findButtonWithAudio(item.go)

			item.btn:AddClickListener(self.onClickGrid, self, item)

			item.line = line
			line.items[i] = item
		end

		self:refreshGridItem(line.items[i], list[i])
	end
end

function SurvivalHardView:refreshGridItem(item, config)
	local info = SurvivalModel.instance:getOutSideInfo()

	item.config = config

	local isEmpty = config.id == nil

	gohelper.setActive(item.go, true)

	if isEmpty then
		gohelper.setActive(item.goIcon, false)
		UISpriteSetMgr.instance:setSurvivalSprite(item.imageQuality, "survivalselectdifficulty_item_empty")
		gohelper.setActive(item.goSelected, false)

		return
	end

	gohelper.setActive(item.goIcon, true)

	local hasUnlock = info and info:isUnlockDifficulty(config.id) or false

	UISpriteSetMgr.instance:setSurvivalSprite(item.imageQuality, string.format("survivalselectdifficulty_item_quality_%s", config.level))

	local iconPath = string.format("singlebg/survival_singlebg/difficulty/difficulticon/%s.png", config.icon)

	item.simageIcon:LoadImage(iconPath)
	ZProj.UGUIHelper.SetGrayscale(item.goIcon, not hasUnlock)
	ZProj.UGUIHelper.SetGrayscale(item.goQuality, not hasUnlock)

	local isSelect = SurvivalDifficultyModel.instance:isSelectCustomDifficulty(config.id)

	gohelper.setActive(item.goSelected, hasUnlock and isSelect)
end

function SurvivalHardView:playAnim(animName)
	if not animName then
		return
	end

	self.animator:Play(animName, 0, 0)
end

function SurvivalHardView:setPanelVisible(isVisible)
	if self.isPanelVisible == isVisible then
		return
	end

	self.isPanelVisible = isVisible

	gohelper.setActive(self.goItemPanel, isVisible)
end

function SurvivalHardView:onClose()
	self.simageLevelPic:UnLoadImage()

	for i, v in ipairs(self.tabItems) do
		v.btn:RemoveClickListener()
	end

	for _, v in ipairs(self.lineItems) do
		for _, item in ipairs(v.items) do
			item.btn:RemoveClickListener()
			item.simageIcon:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(self.refreshView, self)
end

return SurvivalHardView

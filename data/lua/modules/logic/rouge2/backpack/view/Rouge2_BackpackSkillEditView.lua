-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillEditView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillEditView", package.seeall)

local Rouge2_BackpackSkillEditView = class("Rouge2_BackpackSkillEditView", BaseView)
local DefaultSelectIndex = 1

function Rouge2_BackpackSkillEditView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "SkilleditPanel/#simage_bg")
	self._txtCapacity = gohelper.findChildText(self.viewGO, "SkilleditPanel/SkillPanel/Capacity/List/Capacity/#txt_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/Capacity/List/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/Capacity/List/#go_AssemblyList/#go_AssemblyItem")
	self._goSkillItem = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/#go_SkillItem")
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "SkilleditPanel/List/#scroll_List")
	self._goViewport = gohelper.findChild(self.viewGO, "SkilleditPanel/List/#scroll_List/Viewport")
	self._goContent = gohelper.findChild(self.viewGO, "SkilleditPanel/List/#scroll_List/Viewport/Content")
	self._goDragArea = gohelper.findChild(self.viewGO, "SkilleditPanel/#go_DragArea")
	self._goAttribute = gohelper.findChild(self.viewGO, "SkilleditPanel/#go_Attribute")
	self._goDrag = gohelper.findChild(self.viewGO, "SkilleditPanel/#go_Drag")
	self._goDragItem = gohelper.findChild(self.viewGO, "SkilleditPanel/#go_Drag/#go_DragItem")
	self._simageDrag = gohelper.findChildSingleImage(self.viewGO, "SkilleditPanel/#go_Drag/#go_DragItem/#image_Drag")
	self._btnOrder = gohelper.findChildButtonWithAudio(self.viewGO, "SkilleditPanel/Tab/#btn_Order")
	self._btnCost = gohelper.findChildButtonWithAudio(self.viewGO, "SkilleditPanel/Tab/#btn_Cost")
	self._goMode = gohelper.findChild(self.viewGO, "SkilleditPanel/Tab/#go_Mode")
	self._goEmpty = gohelper.findChild(self.viewGO, "SkilleditPanel/List/#go_Empty")
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "SkilleditPanel/#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillEditView:addEvents()
	self._btnOrder:AddClickListener(self._btnOrderOnClick, self)
	self._btnCost:AddClickListener(self._btnCostOnClick, self)
	self._btnClose:AddClickDownListener(self._btnCloseOnClick, self)

	self._dragClick = gohelper.getClickWithDefaultAudio(self._goDragArea)

	self._dragClick:AddClickUpListener(self._onClickDragAreaUp, self)
	CommonDragHelper.instance:registerDragObj(self._goDragArea, self._onDragBegin, self._onDrag, self._onDragEnd, nil, self, nil, true)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnUpdateActiveSkillInfo, self._onUpdateActiveSkillInfo, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnLongPressEditSkill, self._onLongPressEditSkill, self)
end

function Rouge2_BackpackSkillEditView:removeEvents()
	self._btnOrder:RemoveClickListener()
	self._btnCost:RemoveClickListener()
	self._btnClose:RemoveClickDownListener()
	self._dragClick:RemoveClickUpListener()
	CommonDragHelper.instance:unregisterDragObj(self._goDragArea, self._onDragBegin, self._onDrag, self._onDragEnd, nil, self, nil, true)
end

function Rouge2_BackpackSkillEditView:_btnOrderOnClick()
	Rouge2_BackpackSkillEditListModel.instance:setCurSortType(Rouge2_Enum.BackpackSkillSortType.GetTime)
	self:refreshBtnStatus()
end

function Rouge2_BackpackSkillEditView:_btnCostOnClick()
	Rouge2_BackpackSkillEditListModel.instance:setCurSortType(Rouge2_Enum.BackpackSkillSortType.AssembleCost)
	self:refreshBtnStatus()
end

function Rouge2_BackpackSkillEditView:_btnCloseOnClick()
	if ViewMgr.instance:isOpen(ViewName.Rouge2_CareerSkillTipsView) then
		ViewMgr.instance:closeView(ViewName.Rouge2_CareerSkillTipsView)

		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchSkillViewType, Rouge2_BackpackSkillView.ViewState.Panel)
end

function Rouge2_BackpackSkillEditView:_onClickDragAreaUp()
	if not self._longPressUid then
		return
	end

	self:setIsDraging(false)
	self:refreshDragItem()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnEndDragSkill, self._longPressUid)

	self._longPressUid = nil
end

function Rouge2_BackpackSkillEditView:_onDragBegin(param, pointerEventData)
	if self._pointerId ~= -1 or self._isDragging then
		return
	end

	self._pointerId = pointerEventData.pointerId

	local isScroll = self:passEvent2Scroll(pointerEventData, 4)

	self._isScroll = isScroll

	if self._isScroll then
		return
	end

	local position = GamepadController.instance:getMousePosition()
	local skillMo = self._scrollView and self._scrollView:getDragSkillMo(position)

	skillMo = skillMo or self:getDragHoleSkillMo(position)

	if not skillMo then
		return
	end

	if not Rouge2_BackpackModel.instance:isActiveSkillInUse(skillMo:getUid()) and Rouge2_BackpackSkillEditListModel.instance:isAttrBlockInBXS(skillMo:getAttrTag()) then
		return
	end

	self:reallyBeginDrag(skillMo)
end

function Rouge2_BackpackSkillEditView:getDragHoleSkillMo(position)
	for index, skillItem in pairs(self._skillHoleItemTab) do
		local inRect = skillItem:isScreenPosInRect(position)

		if inRect then
			local skillMo = skillItem:getSkillMo()

			return skillMo
		end
	end
end

function Rouge2_BackpackSkillEditView:reallyBeginDrag(skillMo)
	self:setIsDraging(true)
	ViewMgr.instance:closeView(ViewName.Rouge2_CareerSkillTipsView)

	self._curDragUid = skillMo:getUid()

	self:updateDragItemPos()
	self:refreshDragItem(skillMo)
	self:setScrollInteractable(false)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnBeginDragSkill, self._curDragUid)
end

function Rouge2_BackpackSkillEditView:setIsDraging(isDrag)
	self._isDragging = isDrag

	Rouge2_BackpackSkillEditListModel.instance:setIsDraging(self._isDragging)
end

function Rouge2_BackpackSkillEditView:isScroll(pointerEventData)
	if not pointerEventData then
		return
	end

	if self._isScroll then
		return self._isScroll
	end

	local isScroll = math.abs(pointerEventData.delta.y) > math.abs(pointerEventData.delta.x)

	return isScroll and recthelper.screenPosInRect(self._tranContent, nil, pointerEventData.position.x, pointerEventData.position.y)
end

function Rouge2_BackpackSkillEditView:passEvent2Scroll(pointerEventData, eventType)
	if self:isScroll(pointerEventData) then
		ZProj.UGUIHelper.PassEvent(self._goScroll, pointerEventData, eventType)

		self._isScroll = true
	else
		ZProj.UGUIHelper.PassEvent(self._goScroll, pointerEventData, 6)

		self._isScroll = false
	end

	return self._isScroll
end

function Rouge2_BackpackSkillEditView:_onDrag(param, pointerEventData)
	self._isTriggerDragFunc = false

	if self._close then
		return
	end

	if self._pointerId ~= pointerEventData.pointerId then
		return
	end

	if self._isScroll then
		self:passEvent2Scroll(pointerEventData, 5)

		return
	end

	if not self._isDragging then
		return
	end

	self._isTriggerDragFunc = true

	self:updateDragItemPos()
end

function Rouge2_BackpackSkillEditView:_onDragEnd(param, pointerEventData)
	self:refreshDragItem()

	self._isTriggerDragFunc = false

	if self._close then
		return
	end

	if self._pointerId ~= pointerEventData.pointerId then
		return
	end

	self._pointerId = -1

	if self._isScroll then
		self._scrollRect.enabled = true

		self:passEvent2Scroll(pointerEventData, 6)
		self:setIsDraging(false)

		self._isScroll = false

		return
	end

	self:setScrollInteractable(true)

	if not self._isDragging then
		return
	end

	self:refreshDragItem()
	self:updateDragItemPos()
	self:setIsDraging(false)

	local isSuccess, index = self:checkDragItemSuccess()
	local result = isSuccess

	if isSuccess then
		result = Rouge2_BackpackController.instance:tryReplaceActiveSkill(index, self._curDragUid)
	else
		local isUse = Rouge2_BackpackModel.instance:isActiveSkillInUse(self._curDragUid)

		if isUse and self:checkDragItemInScrollView() then
			result = Rouge2_BackpackController.instance:tryRemoveActiveSkillByUid(self._curDragUid)
		end
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnEndDragSkill, self._curDragUid, result)
end

function Rouge2_BackpackSkillEditView:_editableInitView()
	self._scrollView = Rouge2_BackpackSkillEditScrollView.New()

	self:addChildView(self._scrollView)
	Rouge2_BackpackSkillEditListModel.instance:initSort()
	Rouge2_BackpackSkillEditListModel.instance:setCurSortType(Rouge2_Enum.BackpackSkillSortType.GetTime, true)

	self._goScroll = self._scrollList.gameObject
	self._tranScroll = self._goScroll.transform
	self._tranContent = self._goContent.transform
	self._tranViewport = self._goViewport.transform
	self._isDragging = false
	self._isScroll = false
	self._close = false
	self._pointerId = -1
	self._nextContentScreenPos = Vector2()
	self._skillHoleItemTab = self:getUserDataTb_()
	self._scrollRect = gohelper.onceAddComponent(self._goScroll, gohelper.Type_ScrollRect)
	self._tranDrag = self._goDrag.transform
	self._tranDragItem = self._goDragItem.transform
	self._sortBtnNodeList = self:getUserDataTb_()

	self:initSortNode(Rouge2_Enum.BackpackSkillSortType.GetTime, "#btn_Order")
	self:initSortNode(Rouge2_Enum.BackpackSkillSortType.AssembleCost, "#btn_Cost")
	self:refreshBtnStatus()
	self:refreshDragItem()
	self:initSkillEditItems()
	Rouge2_AttributeToolBar.Load(self._goAttribute, Rouge2_Enum.AttributeToolType.Attr_Detail)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)
end

function Rouge2_BackpackSkillEditView:onOpen()
	self._close = false
end

function Rouge2_BackpackSkillEditView:onOpenChildView(selectIndex)
	AudioMgr.instance:trigger(AudioEnum.Rouge2.OpenSkillEditView)
	self:refreshList()
	self:updateDefaultSelect(selectIndex)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideAssembleCost)
end

function Rouge2_BackpackSkillEditView:onCloseChildView()
	self:refreshDragItem()
	self:setIsDraging(false)
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnEndDragSkill, self._curDragUid)
end

function Rouge2_BackpackSkillEditView:refreshList()
	Rouge2_BackpackSkillEditListModel.instance:initList()
	self:refreshAssembly()
end

function Rouge2_BackpackSkillEditView:refreshAssembly()
	self._maxAssembleCost = Rouge2_Model.instance:getAttrValue(Rouge2_MapEnum.BasicAttrId.ActiveSkillCapacity)

	local allAssembleCost = Rouge2_BackpackModel.instance:getUseActiveSkillAssembleCost()

	self._preUseAssembleCost = self._allUseAssembleCost or allAssembleCost
	self._allUseAssembleCost = allAssembleCost
	self._isUseCostUpdate = self._preUseAssembleCost ~= self._allUseAssembleCost

	local fixAssembleCost, tmpAssembleCost = self:getTmpAllAssembleCost()

	self._fixAssembleCost = fixAssembleCost
	self._tmpAssembleCost = tmpAssembleCost
	self._lightAssembleCost = self._fixAssembleCost + self._tmpAssembleCost
	self._txtCapacity.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("rouge2_backpackskillview_capacity"), self._allUseAssembleCost, self._maxAssembleCost)

	gohelper.setActive(self._goEmpty, Rouge2_BackpackSkillEditListModel.instance:getCount() <= 0)
	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, self._maxAssembleCost, self._refreshSingleAssembly, self)
end

function Rouge2_BackpackSkillEditView:getTmpAllAssembleCost()
	local selectUseIndex = Rouge2_BackpackSkillEditListModel.instance:getSelectUseSkillIndex()
	local normalCost, tmpCost = 0, 0

	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		if self._tipsSkillCo and i == selectUseIndex then
			local skillCo = self._tipsSkillCo
			local cost = skillCo and skillCo.assembleCost or 0

			tmpCost = tmpCost + cost
		else
			local skillMo = Rouge2_BackpackModel.instance:index2UseActiveSkill(i)
			local skillCo = skillMo and skillMo:getConfig()
			local cost = skillCo and skillCo.assembleCost or 0

			normalCost = normalCost + cost
		end
	end

	return normalCost, tmpCost
end

function Rouge2_BackpackSkillEditView:_refreshSingleAssembly(obj, index)
	local goType1 = gohelper.findChild(obj, "go_Type1")
	local goType2 = gohelper.findChild(obj, "go_Type2")
	local animator1 = gohelper.onceAddComponent(goType1, gohelper.Type_Animator)
	local animator2 = gohelper.onceAddComponent(goType2, gohelper.Type_Animator)
	local isSelect = index <= self._lightAssembleCost
	local useType1 = index % 2 ~= 0

	gohelper.setActive(goType1, useType1)
	gohelper.setActive(goType2, not useType1)

	local goRoot = useType1 and goType1 or goType2
	local goSelected = gohelper.findChild(goRoot, "#image_Icon")

	gohelper.setActive(goSelected, isSelect)

	local animator = useType1 and animator1 or animator2

	animator:Play("idle", 0, 0)

	if isSelect then
		if self._isUseCostUpdate and index > self._preUseAssembleCost then
			animator:Play("in", 0, 0)
		elseif index > self._fixAssembleCost then
			animator:Play("light", 0, 0)
		end
	end
end

function Rouge2_BackpackSkillEditView:initSkillEditItems()
	for i = 1, Rouge2_Enum.MaxActiveSkillNum do
		local goSkillPos = gohelper.findChild(self.viewGO, "SkilleditPanel/SkillPanel/#go_SkillPos" .. i)
		local goSkill = gohelper.clone(self._goSkillItem, goSkillPos, i)
		local skillHoleItem = MonoHelper.addNoUpdateLuaComOnceToGo(goSkill, Rouge2_BackpackSkillEditItem, i)

		skillHoleItem:onUpdateMO()
		table.insert(self._skillHoleItemTab, skillHoleItem)
	end

	gohelper.setActive(self._goSkillItem, false)
end

function Rouge2_BackpackSkillEditView:updateDefaultSelect(selectIndex)
	selectIndex = selectIndex or DefaultSelectIndex

	Rouge2_BackpackSkillEditListModel.instance:onSelectUseSkillIndex(selectIndex)
end

function Rouge2_BackpackSkillEditView:refreshDragItem(skillMo)
	gohelper.setActive(self._goDragItem, skillMo ~= nil)

	if not skillMo then
		return
	end

	Rouge2_IconHelper.setActiveSkillIcon(skillMo:getItemId(), self._simageDrag)
end

function Rouge2_BackpackSkillEditView:updateDragItemPos()
	local position = GamepadController.instance:getMousePosition()
	local posX, posY = recthelper.screenPosToAnchorPos2(position, self._tranDrag)

	recthelper.setAnchor(self._tranDragItem, posX, posY)
end

function Rouge2_BackpackSkillEditView:checkDragItemSuccess()
	local position = GamepadController.instance:getMousePosition()

	for index, skillItem in ipairs(self._skillHoleItemTab) do
		local isInRect = skillItem:isScreenPosInRect(position)

		if isInRect then
			return true, index
		end
	end
end

function Rouge2_BackpackSkillEditView:checkDragItemInScrollView()
	local position = GamepadController.instance:getMousePosition()

	return recthelper.screenPosInRect(self._tranScroll, nil, position.x, position.y)
end

function Rouge2_BackpackSkillEditView:setScrollInteractable(interactable)
	self._scrollRect:StopMovement()

	self._scrollRect.enabled = interactable
end

function Rouge2_BackpackSkillEditView:_onOpenView(viewName, viewParam)
	if viewName ~= ViewName.Rouge2_CareerSkillTipsView then
		return
	end

	local dataType = viewParam and viewParam.dataType
	local dataId = viewParam and viewParam.dataId

	self._tipsSkillCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)

	self:refreshAssembly()
end

function Rouge2_BackpackSkillEditView:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_CareerSkillTipsView then
		return
	end

	self._tipsSkillCo = nil

	self:refreshAssembly()
end

function Rouge2_BackpackSkillEditView:_onUpdateActiveSkillInfo()
	self:refreshList()
end

function Rouge2_BackpackSkillEditView:_onLongPressEditSkill(uid, isLongPress)
	if self._longPressUid == uid and not isLongPress then
		self._longPressUid = nil

		self:setIsDraging(false)
		self:refreshDragItem()

		return
	end

	if self._isDragging or self._isScroll then
		return
	end

	local mo = Rouge2_BackpackSkillEditListModel.instance:getMo(uid)

	if not mo then
		return
	end

	if Rouge2_BackpackSkillEditListModel.instance:isAttrBlockInBXS(mo:getAttrTag()) then
		return
	end

	self._longPressUid = mo:getUid()

	self:reallyBeginDrag(mo)
end

function Rouge2_BackpackSkillEditView:initSortNode(sortType, btnName)
	local btn1 = gohelper.findChild(self.viewGO, string.format("SkilleditPanel/Tab/%s/btn1", btnName))
	local btn1Arrow = gohelper.findChild(self.viewGO, string.format("SkilleditPanel/Tab/%s/btn1/txt/arrow", btnName))
	local btn2 = gohelper.findChild(self.viewGO, string.format("SkilleditPanel/Tab/%s/btn2", btnName))
	local btn2Arrow = gohelper.findChild(self.viewGO, string.format("SkilleditPanel/Tab/%s/btn2/txt/arrow", btnName))
	local tab = self:getUserDataTb_()

	tab.btn1 = btn1
	tab.btn1ArrowTrans = btn1Arrow and btn1Arrow.transform
	tab.btn2 = btn2
	tab.btn2ArrowTrans = btn2Arrow and btn2Arrow.transform
	self._sortBtnNodeList[sortType] = tab
end

function Rouge2_BackpackSkillEditView:refreshBtnStatus()
	local curSortType = Rouge2_BackpackSkillEditListModel.instance:getCurSortType()

	for sortType, v in pairs(self._sortBtnNodeList) do
		local isSelected = sortType == curSortType

		gohelper.setActive(v.btn1, not isSelected)
		gohelper.setActive(v.btn2, isSelected)

		local sortState = Rouge2_BackpackSkillEditListModel.instance:getSortState(sortType)

		transformhelper.setLocalScale(v.btn1ArrowTrans, 1, -sortState, 1)
		transformhelper.setLocalScale(v.btn2ArrowTrans, 1, -sortState, 1)
	end
end

function Rouge2_BackpackSkillEditView:onClose()
	self._close = true
end

function Rouge2_BackpackSkillEditView:onDestroyView()
	self._simageDrag:UnLoadImage()
end

return Rouge2_BackpackSkillEditView

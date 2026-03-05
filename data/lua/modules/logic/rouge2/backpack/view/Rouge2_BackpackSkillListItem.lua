-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillListItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillListItem", package.seeall)

local Rouge2_BackpackSkillListItem = class("Rouge2_BackpackSkillListItem", ListScrollCellExtend)

function Rouge2_BackpackSkillListItem:onInitView()
	self._simageSkillIcon = gohelper.findChildSingleImage(self.viewGO, "#image_SkillIcon")
	self._imageAttribute = gohelper.findChildImage(self.viewGO, "#image_Icon")
	self._txtName = gohelper.findChildText(self.viewGO, "#txt_Name")
	self._goCapacity = gohelper.findChild(self.viewGO, "Layout/#go_Capacity")
	self._goAssemblyList = gohelper.findChild(self.viewGO, "Layout/#go_Capacity/#go_AssemblyList")
	self._goAssemblyItem = gohelper.findChild(self.viewGO, "Layout/#go_Capacity/#go_AssemblyList/#go_AssemblyItem")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Layout/#txt_Descr")
	self._goReddot = gohelper.findChild(self.viewGO, "#go_Reddot")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goClick = gohelper.findChild(self.viewGO, "#btn_Click")
	self._goBXSMask = gohelper.findChild(self.viewGO, "#go_Mask")
	self._btnClick = SLFramework.UGUI.UILongPressListener.Get(self._goClick)

	self._btnClick:SetLongPressTime({
		Rouge2_Enum.SkillEditItemLongPressTime,
		99999
	})
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick:AddLongPressListener(self._btnClickOnLongClick, self)

	self._tran = self.viewGO.transform
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._listener = Rouge2_CommonItemDescModeListener.Get(self.viewGO, Rouge2_Enum.ItemDescModeDataKey.BackpackSkill)

	self._listener:initCallback(self._refreshItemDesc, self)
end

function Rouge2_BackpackSkillListItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnBeginDragSkill, self._onBeginDragSkill, self)
	self:addEventCb(Rouge2_Controller.instance, Rouge2_Event.OnEndDragSkill, self._onEndDragSkill, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Rouge2_BackpackSkillListItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnClick:RemoveLongPressListener()
end

function Rouge2_BackpackSkillListItem:_btnClickOnClick()
	if self._isBlock then
		return
	end

	Rouge2_BackpackController.instance:updateItemReddotStatus(self._skillUid, Rouge2_Enum.ItemStatus.Old)

	if not self._isSelect then
		local tipPos = Rouge2_Enum.SkillTipsPos.BackpackSkillEdit1

		Rouge2_BackpackSkillEditListModel.instance:selectCell(self._index, true)
		Rouge2_ViewHelper.openCareerSkillTipsView(Rouge2_Enum.ItemDataType.Server, self._skillUid, tipPos, Rouge2_Enum.SkillTipsUsage.BackpackEditView_Right)
	end
end

function Rouge2_BackpackSkillListItem:_btnClickOnLongClick()
	if Rouge2_BackpackSkillEditListModel.instance:isDraging() then
		return
	end

	local dragEndFrame = Rouge2_BackpackSkillEditListModel.instance:getLastEndDragTime()

	if UnityEngine.Time.frameCount - dragEndFrame < 30 then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnLongPressEditSkill, self._skillUid, true)
end

function Rouge2_BackpackSkillListItem:onUpdateMO(skillMo)
	self._isLongPress = false
	self._skillMo = skillMo
	self._skillUid = skillMo and skillMo:getUid()
	self._skillId = skillMo and skillMo:getItemId()
	self._skillCo = Rouge2_CollectionConfig.instance:getActiveSkillConfig(self._skillId)

	RedDotController.instance:addRedDot(self._goReddot, RedDotEnum.DotNode.Rouge2ActiveSkillTab, self._skillUid)
	self:refreshUI()
end

function Rouge2_BackpackSkillListItem:refreshUI()
	self._txtName.text = self._skillCo and self._skillCo.name

	self._listener:startListen()

	local assemblyNum = self._skillCo and self._skillCo.assembleCost or 0

	gohelper.setActive(self._goCapacity, assemblyNum > 0)
	gohelper.CreateNumObjList(self._goAssemblyList, self._goAssemblyItem, assemblyNum)
	Rouge2_IconHelper.setActiveSkillIcon(self._skillId, self._simageSkillIcon)
	Rouge2_IconHelper.setAttributeIcon(self._skillCo.attributeTag, self._imageAttribute)
	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, true)

	self._isBlock = Rouge2_BackpackSkillEditListModel.instance:isAttrBlockInBXS(self._skillCo.attributeTag)

	gohelper.setActive(self._goBXSMask, self._isBlock)
end

function Rouge2_BackpackSkillListItem:_refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(Rouge2_Enum.ItemDataType.Server, self._skillUid, self._txtDescr, descMode)
end

function Rouge2_BackpackSkillListItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
end

function Rouge2_BackpackSkillListItem:_onBeginDragSkill(uid)
	if self._skillUid ~= uid then
		return
	end

	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, false)
end

function Rouge2_BackpackSkillListItem:_onEndDragSkill(uid, isSuccess)
	if self._skillUid ~= uid then
		return
	end

	if isSuccess then
		return
	end

	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, true)
end

function Rouge2_BackpackSkillListItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_CareerSkillTipsView then
		return
	end

	Rouge2_BackpackSkillEditListModel.instance:selectCell(self._index, false)
end

function Rouge2_BackpackSkillListItem:getTran()
	return self._tran
end

function Rouge2_BackpackSkillListItem:onDestroyView()
	self._simageSkillIcon:UnLoadImage()
end

return Rouge2_BackpackSkillListItem

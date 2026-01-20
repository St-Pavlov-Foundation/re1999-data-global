-- chunkname: @modules/logic/toast/view/ToastView.lua

module("modules.logic.toast.view.ToastView", package.seeall)

local ToastView = class("ToastView", BaseView)
local OutSidePos = 10000

function ToastView:onInitView()
	self._gotemplate = gohelper.findChild(self.viewGO, "#go_template")
	self._gopoint = gohelper.findChild(self.viewGO, "#go_point")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ToastView:addEvents()
	return
end

function ToastView:removeEvents()
	return
end

function ToastView:_editableInitView()
	self._usingList = {}
	self._freeList = {}
	self._cacheMsgList = {}
	self._maxCount = 4
	self.space = 5
	self._showNextToastInterval = 0.1
	self.hadTask = false

	local templateTransform = self._gotemplate.transform

	self._itemHeight = recthelper.getHeight(templateTransform)
	self._itemWidth = recthelper.getWidth(templateTransform)

	self:_initExpandedSpace()
	recthelper.setAnchor(self._gotemplate.transform, OutSidePos, OutSidePos)
end

function ToastView:onUpdateParam()
	return
end

function ToastView:onDestroyView()
	return
end

function ToastView:onOpen()
	self:addToastMsg(self.viewParam)

	local msgList = ToastController.instance._msgList

	while #msgList > 0 do
		self:addToastMsg(table.remove(msgList, 1))
	end

	self:addEventCb(ToastController.instance, ToastEvent.ShowToast, self.addToastMsg, self)
	self:addEventCb(ToastController.instance, ToastEvent.RecycleToast, self._doRecycleAnimation, self)
end

function ToastView:onClose()
	self:removeEventCb(ToastController.instance, ToastEvent.ShowToast, self.addToastMsg, self)
	self:removeEventCb(ToastController.instance, ToastEvent.RecycleToast, self._doRecycleAnimation, self)
	TaskDispatcher.cancelTask(self._showToast, self)

	self.hadTask = false
end

function ToastView:addToastMsg(msg)
	table.insert(self._cacheMsgList, msg)

	if not self.hadTask then
		self:_showToast()
		TaskDispatcher.runRepeat(self._showToast, self, self._showNextToastInterval)

		self.hadTask = true
	end
end

function ToastView:_showToast()
	local msg = table.remove(self._cacheMsgList, 1)

	if not msg then
		TaskDispatcher.cancelTask(self._showToast, self)

		self.hadTask = false

		return
	end

	local newItem = table.remove(self._freeList, 1)

	if not newItem then
		local go = gohelper.clone(self._gotemplate, self._gopoint)

		newItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, ToastItem)
	end

	local item

	if #self._usingList >= self._maxCount then
		item = self._usingList[1]

		self:_doRecycleAnimation(item, true)
	end

	table.insert(self._usingList, newItem)
	newItem:setMsg(msg)
	newItem:appearAnimation(msg)
	self:_refreshAllItemsAnimation()
end

function ToastView:_doRecycleAnimation(item, isManualRecycle)
	local index = tabletool.indexOf(self._usingList, item)

	if index then
		table.remove(self._usingList, index)
	end

	item:clearAllTask()
	item:quitAnimation(self._recycleToast, self)
end

function ToastView:_recycleToast(item)
	item:reset()
	table.insert(self._freeList, item)
end

function ToastView:_refreshAllItemsAnimation()
	local anchorY = 0

	self._preAnchorY = 0

	for i = 1, #self._usingList do
		if i > 1 then
			local lastItemHeight = self._usingList[i - 1]:getToastItemHeight()
			local curItemHeight = self._usingList[i]:getToastItemHeight()
			local isExpanded = lastItemHeight > self._templateMinHeight and curItemHeight > self._templateMinHeight
			local space = isExpanded and self._spaceWhenExpanded or self.space

			anchorY = self._preAnchorY - lastItemHeight - space
		end

		self._preAnchorY = anchorY

		if i == #self._usingList then
			recthelper.setAnchorY(self._usingList[i].tr, anchorY)
		else
			self._usingList[i]:upAnimation(anchorY)
		end
	end
end

function ToastView:_initExpandedSpace()
	local bgTrans = gohelper.findChild(self.viewGO, "#go_template/#go_normal/bg").transform
	local layoutElement = self._gotemplate:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	self._spaceWhenExpanded = self.space
	self._templateMinHeight = layoutElement.minHeight

	if bgTrans.anchorMin.y == 0 and bgTrans.anchorMax.y == 1 then
		self._spaceWhenExpanded = (bgTrans.offsetMax.y - bgTrans.offsetMin.y) * 0.5
	end
end

return ToastView

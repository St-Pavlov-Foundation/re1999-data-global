-- chunkname: @modules/logic/survival/view/survivalsimplelistcomp/SurvivalSimpleListComp.lua

module("modules.logic.survival.view.survivalsimplelistcomp.SurvivalSimpleListComp", package.seeall)

local SurvivalSimpleListComp = class("SurvivalSimpleListComp", LuaCompBase)

function SurvivalSimpleListComp:ctor(param)
	self.param = param.listScrollParam
	self.viewContainer = param.viewContainer
	self.className = self.param.cellClass.__cname
	self.items = {}
end

function SurvivalSimpleListComp:init(go)
	self.go = go

	local _, scrollRect = go:TryGetComponent(gohelper.Type_ScrollRect, self.scrollRect)

	self.scrollRect = scrollRect

	if self.scrollRect then
		self.scrollbarWrap = gohelper.onceAddComponent(self.go, typeof(SLFramework.UGUI.ScrollRectWrap))
		self.isScrollMode = true
		self.scrollDir = self.scrollRect.vertical and ScrollEnum.ScrollDirV or ScrollEnum.ScrollDirH
		self.content = self.scrollRect.content
		self.csListScroll = SLFramework.UGUI.ListScrollView.Get(go)

		self.csListScroll:Init(self.scrollDir, self.param.lineCount, self.param.cellWidth, self.param.cellHeight, self.param.cellSpaceH, self.param.cellSpaceV, self.param.startSpace, self.param.endSpace, self.param.sortMode, self.param.frameUpdateMs, self.param.minUpdateCountInFrame, self.onUpdateCell, nil, nil, self)
		self.scrollbarWrap:AddOnValueChanged(self.onValueChanged, self)
	end

	if self.param.cloneRef then
		gohelper.setActive(self.param.cloneRef, false)
	end
end

function SurvivalSimpleListComp:setRes(res)
	self.res = res
	self.isResString = type(self.res) == "string"

	if not self.isResString then
		gohelper.setActive(self.res, false)
	end
end

function SurvivalSimpleListComp:addEventListeners()
	return
end

function SurvivalSimpleListComp:removeEventListeners()
	if self.scrollbarWrap then
		self.scrollbarWrap:RemoveOnValueChanged()
	end
end

function SurvivalSimpleListComp:setOnValueChanged(onValueChangedCallBack, context)
	self.callBackContext = context
	self.onValueChangedCallBack = onValueChangedCallBack
end

function SurvivalSimpleListComp:onValueChanged(scrollX, scrollY)
	if self.onValueChangedCallBack then
		self.onValueChangedCallBack(self.callBackContext, scrollX, scrollY)
	end
end

function SurvivalSimpleListComp:setList(datas)
	self.datas = datas

	if self.isScrollMode then
		tabletool.clear(self.items)
		self.csListScroll:UpdateTotalCount(#datas)
	else
		self:refreshCustomMode()
	end
end

function SurvivalSimpleListComp:setRefreshAnimation(interval, groupNum, startDelayS)
	self.animInterval = interval
	self.animationStartTime = Time.time
	self.groupNum = groupNum or 1
	self.startDelayS = startDelayS or 0
end

function SurvivalSimpleListComp:onUpdateCell(cellGO, index)
	index = index + 1

	local go = gohelper.findChild(cellGO, self.className)
	local item

	if not go then
		if self.isResString then
			go = self.viewContainer:getResInst(self.res, cellGO, self.className)
		else
			go = gohelper.clone(self.res, cellGO, self.className)
		end

		gohelper.setActive(go, true)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, self.param.cellClass, self.viewContainer)
	else
		item = MonoHelper.getLuaComFromGo(go, self.param.cellClass, self.viewContainer)
	end

	if self.items[index] and self.items[index] ~= item then
		self.items[index]:hideItem()
	end

	self.items[index] = item

	local isSelect = index == self.select

	item:showItem(self.datas[index], index, isSelect)
	item:setSelect(self.select == index)

	if self.animationStartTime then
		local animators = item:getItemAnimators()

		if animators then
			for i, animator in ipairs(animators) do
				animator:Play(UIAnimationName.Open, 0, 0)
				animator:Update(0)

				local num = math.floor(index / self.groupNum)
				local openAnimTime = self.startDelayS + self.animationStartTime + self.animInterval * num
				local currentAnimatorStateInfo = animator:GetCurrentAnimatorStateInfo(0)
				local length = currentAnimatorStateInfo.length
				local nor = (Time.time - openAnimTime) / length

				animator:Play(UIAnimationName.Open, 0, nor)
				animator:Update(0)
			end
		end
	end
end

function SurvivalSimpleListComp:refreshCustomMode()
	local customItemAmount = #self.items
	local listLength = #self.datas

	for index = 1, listLength do
		if customItemAmount < index then
			local go

			if self.isResString then
				go = self.viewContainer:getResInst(self.res, self.go, self.className)
			else
				go = gohelper.clone(self.res, self.go, self.className)
			end

			gohelper.setActive(go, true)

			self.items[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, self.param.cellClass)
		end

		local item = self.items[index]

		gohelper.setActive(item.viewGO, true)

		local isSelect = index == self.select

		item:showItem(self.datas[index], index, isSelect)
	end

	for i = listLength + 1, customItemAmount do
		local item = self.items[i]

		gohelper.setActive(item.viewGO, false)
		self.items[i]:hideItem()
	end
end

function SurvivalSimpleListComp:addCustomItem(go)
	self.items[#self.items + 1] = MonoHelper.addNoUpdateLuaComOnceToGo(go, self.param.cellClass)
end

function SurvivalSimpleListComp:getItems()
	return self.items
end

function SurvivalSimpleListComp:setSelect(tarSelect)
	local haveChange = (not tarSelect or not self.select or self.select ~= tarSelect) and (not not tarSelect or not not self.select)

	if haveChange then
		if self.select and self.items[self.select] then
			self.items[self.select]:setSelect(false)
		end

		self.select = tarSelect

		if self.select and self.items[self.select] then
			self.items[self.select]:setSelect(true)
		end

		if self.onSelectCallBack then
			self.onSelectCallBack(self.onSelectCallBackContext, self.select)
		end
	end
end

function SurvivalSimpleListComp:setSelectCallBack(onSelectCallBack, onSelectCallBackContext)
	self.onSelectCallBack = onSelectCallBack
	self.onSelectCallBackContext = onSelectCallBackContext
end

function SurvivalSimpleListComp:getSelect()
	return self.select
end

function SurvivalSimpleListComp:getScrollPixel()
	if self.scrollDir == ScrollEnum.ScrollDirV then
		return self.csListScroll.VerticalScrollPixel
	elseif self.scrollDir == ScrollEnum.ScrollDirH then
		return self.csListScroll.HorizontalScrollPixel
	end
end

function SurvivalSimpleListComp:getScrollSpace()
	if self.scrollDir == ScrollEnum.ScrollDirV then
		return self.param.cellSpaceV
	elseif self.scrollDir == ScrollEnum.ScrollDirH then
		return self.param.cellSpaceH
	end
end

function SurvivalSimpleListComp:moveTo(index)
	index = index - 1

	local space = 0

	if index > 0 then
		space = self:getScrollSpace()
	end

	if self.scrollDir == ScrollEnum.ScrollDirV then
		self.csListScroll.VerticalScrollPixel = (self.param.cellHeight + space) * index
	elseif self.scrollDir == ScrollEnum.ScrollDirH then
		self.csListScroll.HorizontalScrollPixel = (self.param.cellWidth + space) * index
	end
end

return SurvivalSimpleListComp

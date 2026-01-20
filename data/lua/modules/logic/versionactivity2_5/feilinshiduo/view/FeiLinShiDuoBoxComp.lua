-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoBoxComp.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoBoxComp", package.seeall)

local FeiLinShiDuoBoxComp = class("FeiLinShiDuoBoxComp", LuaCompBase)

function FeiLinShiDuoBoxComp:init(go)
	self.go = go
	self.boxTrans = self.go.transform
	self.moveSpeed = FeiLinShiDuoEnum.PlayerMoveSpeed
	self.fallAddSpeed = FeiLinShiDuoEnum.FallSpeed

	self:resetData()
end

function FeiLinShiDuoBoxComp:resetData()
	self.isGround = true
	self.fallYSpeed = 0
	self.deltaMoveX = 0
	self.curInPlaneItem = nil
	self.planeStartPosX = 0
	self.planeEndPosX = 0
	self.isTopBox = false
	self.topBoxOffset = -10000
	self.topBoxDeltaMove = self.deltaMoveX
	self.bottomBoxMap = {}
end

function FeiLinShiDuoBoxComp:initData(mapItemInfo, viewCls)
	self.itemInfo = mapItemInfo
	self.sceneViewCls = viewCls

	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	self.boxElementMap = elementMap[FeiLinShiDuoEnum.ObjectType.Box]
end

function FeiLinShiDuoBoxComp:addEventListeners()
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, self.cleanTopBoxBottomInfo, self)
end

function FeiLinShiDuoBoxComp:removeEventListeners()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.CleanTopBoxBottomInfo, self.cleanTopBoxBottomInfo, self)
end

function FeiLinShiDuoBoxComp:cleanTopBoxBottomInfo()
	if self.isTopBox then
		self.bottomBoxMap = {}
	end
end

function FeiLinShiDuoBoxComp:onTick()
	self:handleEvent()
end

function FeiLinShiDuoBoxComp:handleEvent()
	if not self.sceneViewCls then
		return
	end

	if FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo) and not self:checkBoxInPlane() then
		self:checkBoxFall()
	end
end

function FeiLinShiDuoBoxComp:checkBoxFall(isChangeColor)
	if self.deltaMoveX and self.itemInfo or self.isTopBox then
		local isTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, self.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, nil, {
			FeiLinShiDuoEnum.ObjectType.Option,
			FeiLinShiDuoEnum.ObjectType.Start
		})

		if #isTouchElementList == 0 then
			self.isGround = false
			self.fallYSpeed = self.fallYSpeed + self.fallAddSpeed

			if not self.isTopBox then
				local elementShowStateMap = FeiLinShiDuoGameModel.instance:getElementShowStateMap()
				local fallPosX = self.boxTrans.localPosition.x

				if self.curInPlaneItem and elementShowStateMap[self.curInPlaneItem.id] and self.deltaMoveX ~= 0 then
					fallPosX = self.deltaMoveX > 0 and self.planeEndPosX or self.planeStartPosX - self.itemInfo.width
				end

				transformhelper.setLocalPosXY(self.boxTrans, fallPosX, self.boxTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
			else
				local checkY = isChangeColor and self.boxTrans.localPosition.y or self.boxTrans.localPosition.y - FeiLinShiDuoEnum.HalfSlotWidth
				local fallCheckTouchBoxList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, checkY, self.itemInfo, FeiLinShiDuoEnum.checkDir.Bottom, self.boxElementMap)
				local fallPosX = self.boxTrans.localPosition.x

				if #fallCheckTouchBoxList == 0 then
					if not FeiLinShiDuoGameModel.instance:getElementShowState(self.bottomBoxItemInfo) then
						fallPosX = self.boxTrans.localPosition.x
					elseif self.bottomBoxItemInfo and Mathf.Abs(self.boxTrans.localPosition.x + self.itemInfo.width / 2 - (self.bottomBoxItemInfo.pos[1] + self.bottomBoxItemInfo.width / 2)) > self.itemInfo.width / 2 + self.bottomBoxItemInfo.width / 2 then
						fallPosX = self.boxTrans.localPosition.x
					else
						fallPosX = self.topBoxDeltaMove > 0 and self.bottomBoxItemInfo.pos[1] + self.bottomBoxItemInfo.width or self.bottomBoxItemInfo.pos[1] - self.itemInfo.width
					end
				end

				transformhelper.setLocalPosXY(self.boxTrans, fallPosX, self.boxTrans.localPosition.y - self.fallYSpeed * Time.deltaTime)
			end
		else
			if not self.isGround then
				self.boxTrans.localPosition = self:fixStandPos(isTouchElementList)

				AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_activity_organ_open)
				FeiLinShiDuoGameController.instance:dispatchEvent(FeiLinShiDuoEvent.CleanTopBoxBottomInfo)
			end

			self.isGround = true
			self.fallYSpeed = 0
			self.deltaMoveX = 0
			self.isTopBox = false

			for _, mapItem in ipairs(isTouchElementList) do
				if mapItem.type == FeiLinShiDuoEnum.ObjectType.Box then
					self.isTopBox = true
					self.topBoxOffset = mapItem.pos[1] - self.boxTrans.localPosition.x
					self.bottomBoxItemInfo = mapItem
					self.bottomBoxMap[self.bottomBoxItemInfo.id] = self.topBoxOffset

					break
				end
			end

			if not self.isTopBox then
				self.bottomBoxMap = {}
			end
		end

		local posTab = {
			self.boxTrans.localPosition.x,
			self.boxTrans.localPosition.y
		}

		FeiLinShiDuoGameModel.instance:updateBoxPos(self.itemInfo.id, posTab)
	end
end

function FeiLinShiDuoBoxComp:setMove(trans, deltaMoveX, boxParam, isChangeColor)
	local isBox = boxParam and boxParam.isBox
	local isTopBox = boxParam and boxParam.isTopBox

	if not self.isGround or self:checkBoxInPlane() then
		return
	end

	if self.deltaMoveX == 0 then
		self.deltaMoveX = deltaMoveX
	end

	if self.deltaMoveX ~= deltaMoveX then
		return
	end

	self.isTopBox = isTopBox

	local curInPlaneItem, planeStartPosX, planeEndPosX = self:getBoxInColorPlane(self.boxTrans.localPosition.x + (self.deltaMoveX >= 0 and -FeiLinShiDuoEnum.HalfSlotWidth or self.itemInfo.width + FeiLinShiDuoEnum.HalfSlotWidth), self.boxTrans.localPosition.y - 2, self.curInPlaneItem)

	self.curInPlaneItem = curInPlaneItem
	self.planeStartPosX = planeStartPosX or self.planeStartPosX
	self.planeEndPosX = planeEndPosX or self.planeEndPosX

	if isBox then
		local boxCanMove, touchPosX = FeiLinShiDuoGameModel.instance:checkForwardCanMove(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, deltaMoveX, self.itemInfo, isBox)

		self.topBoxDeltaMove = self.deltaMoveX

		if boxCanMove then
			if self.isTopBox then
				self.bottomBoxTrans = trans
				self.bottomBoxItemInfo = boxParam.itemInfo

				local tempTopBoxOffset = self.bottomBoxMap[self.bottomBoxItemInfo.id]

				if not tempTopBoxOffset or self.topBoxOffset == -10000 then
					self.topBoxOffset = self.bottomBoxItemInfo.pos[1] - self.boxTrans.localPosition.x
					self.bottomBoxMap[self.bottomBoxItemInfo.id] = self.topBoxOffset
					tempTopBoxOffset = self.topBoxOffset
				end

				self.topBoxOffset = tempTopBoxOffset

				transformhelper.setLocalPosXY(self.boxTrans, self.bottomBoxItemInfo.pos[1] - self.topBoxOffset, self.boxTrans.localPosition.y)
			else
				transformhelper.setLocalPosXY(self.boxTrans, trans.localPosition.x + (self.deltaMoveX >= 0 and boxParam.itemInfo.width or -self.itemInfo.width), self.boxTrans.localPosition.y)
			end
		else
			self.topBoxDeltaMove = self.isTopBox and -self.deltaMoveX or self.deltaMoveX

			transformhelper.setLocalPosXY(self.boxTrans, self.deltaMoveX > 0 and touchPosX - self.itemInfo.width or touchPosX, self.boxTrans.localPosition.y)
		end
	else
		local playerCanMoveForward = FeiLinShiDuoGameModel.instance:checkForwardCanMove(trans.localPosition.x + self.deltaMoveX * (FeiLinShiDuoEnum.HalfSlotWidth + 1), trans.localPosition.y + FeiLinShiDuoEnum.HalfSlotWidth / 2, self.deltaMoveX)

		if playerCanMoveForward and not isChangeColor then
			transformhelper.setLocalPosXY(self.boxTrans, trans.localPosition.x + self.deltaMoveX * FeiLinShiDuoEnum.HalfSlotWidth / 2 + (self.deltaMoveX >= 0 and 0 or -self.itemInfo.width), self.boxTrans.localPosition.y)
		end
	end

	local posTab = {
		self.boxTrans.localPosition.x,
		self.boxTrans.localPosition.y
	}

	FeiLinShiDuoGameModel.instance:updateBoxPos(self.itemInfo.id, posTab)
	self:boxTouchElement()
end

function FeiLinShiDuoBoxComp:getBoxInColorPlane(posX, posY, curInPlaneItem)
	if curInPlaneItem then
		local planeStartPosX, planeEndPosX = self:getPlaneWidthRange(curInPlaneItem.id)

		if planeStartPosX <= posX and posX <= planeEndPosX then
			return curInPlaneItem, planeStartPosX, planeEndPosX
		end
	end

	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local standeItems = {}
	local colorPlaneItems = elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}
	local boxItems = elementMap[FeiLinShiDuoEnum.ObjectType.Box] or {}
	local wallItems = elementMap[FeiLinShiDuoEnum.ObjectType.Wall] or {}
	local trapItems = elementMap[FeiLinShiDuoEnum.ObjectType.Trap] or {}
	local stairsItems = elementMap[FeiLinShiDuoEnum.ObjectType.Stairs] or {}

	for index, item in pairs(wallItems) do
		table.insert(standeItems, item)
	end

	for index, item in pairs(colorPlaneItems) do
		table.insert(standeItems, item)
	end

	for index, item in pairs(boxItems) do
		table.insert(standeItems, item)
	end

	for index, item in pairs(trapItems) do
		table.insert(standeItems, item)
	end

	for index, item in pairs(stairsItems) do
		table.insert(standeItems, item)
	end

	for _, mapItem in pairs(standeItems) do
		local planeStartPosX, planeEndPosX = self:getPlaneWidthRange(mapItem.id)

		if planeStartPosX <= posX and posX <= planeEndPosX and posY > mapItem.pos[2] and posY <= mapItem.pos[2] + mapItem.height then
			return mapItem, planeStartPosX, planeEndPosX
		end
	end
end

function FeiLinShiDuoBoxComp:getPlaneWidthRange(id)
	local elementMap = FeiLinShiDuoGameModel.instance:getInterElementMap()
	local planeItem = elementMap[id] or {}
	local startPosX = planeItem.pos[1]
	local endPosX = planeItem.pos[1] + planeItem.width

	return startPosX, endPosX
end

function FeiLinShiDuoBoxComp:fixStandPos(isTouchElementList)
	local subItemBLPos, subItemTRPos = FeiLinShiDuoGameModel.instance:getFixStandePos(isTouchElementList, self.boxTrans.localPosition.x, self.boxTrans.localPosition.y)

	if subItemBLPos and subItemTRPos then
		return Vector3(self.boxTrans.localPosition.x, subItemTRPos.y, 0)
	end

	return self.boxTrans.localPosition
end

function FeiLinShiDuoBoxComp:boxTouchElement()
	if self.isGround and self.deltaMoveX ~= 0 then
		local checkDir = self.deltaMoveX > 0 and FeiLinShiDuoEnum.checkDir.Right or FeiLinShiDuoEnum.checkDir.Left
		local forwardTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x + self.deltaMoveX, self.boxTrans.localPosition.y, self.itemInfo, checkDir)

		if #forwardTouchElementList > 0 then
			for _, element in pairs(forwardTouchElementList) do
				if element.type == FeiLinShiDuoEnum.ObjectType.Box then
					local boxParam = {}
					local boxComp = self.sceneViewCls:getBoxComp(element.id)

					boxParam.touchElementData = element
					boxParam.isBox = true
					boxParam.isTopBox = false
					boxParam.itemInfo = self.itemInfo

					boxComp:setMove(self.boxTrans, self.deltaMoveX, boxParam)
				end
			end
		end

		local topTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.boxTrans.localPosition.x, self.boxTrans.localPosition.y, self.itemInfo, FeiLinShiDuoEnum.checkDir.Top)

		if #topTouchElementList > 0 then
			for _, element in pairs(topTouchElementList) do
				if element.type == FeiLinShiDuoEnum.ObjectType.Box then
					local boxParam = {}
					local boxComp = self.sceneViewCls:getBoxComp(element.id)

					boxParam.touchElementData = element
					boxParam.isBox = true
					boxParam.isTopBox = true
					boxParam.itemInfo = self.itemInfo

					boxComp:setMove(self.boxTrans, self.deltaMoveX, boxParam)
				end
			end
		end
	end
end

function FeiLinShiDuoBoxComp:checkBoxInPlane()
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()
	local checkElementList = {}
	local colorPlaneItems = elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] or {}

	for index, item in pairs(colorPlaneItems) do
		table.insert(checkElementList, item)
	end

	for _, checkItem in pairs(checkElementList) do
		if FeiLinShiDuoGameModel.instance:getElementShowState(checkItem) and FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo) then
			local curItemCenterPosX = self.itemInfo.pos[1] + self.itemInfo.width / 2
			local checkItemCenterPosX = checkItem.pos[1] + checkItem.width / 2

			if Mathf.Abs(curItemCenterPosX - checkItemCenterPosX) < self.itemInfo.width / 2 + checkItem.width / 2 - 2 * FeiLinShiDuoEnum.touchCheckRange and Mathf.Abs(self.itemInfo.pos[2] - checkItem.pos[2]) < FeiLinShiDuoEnum.HalfSlotWidth / 4 then
				return true
			end
		end
	end

	return false
end

function FeiLinShiDuoBoxComp:getShowState()
	return FeiLinShiDuoGameModel.instance:getElementShowState(self.itemInfo)
end

return FeiLinShiDuoBoxComp

-- chunkname: @modules/logic/versionactivity3_4/chg/model/ChgMapDragContext_MyFrameData.lua

local ti = table.insert
local sf = string.format
local string_rep = string.rep
local abs = math.abs

local function myAssert(...)
	local res = ...

	return res
end

local assert = isDebugBuild and _G.assert or myAssert

module("modules.logic.versionactivity3_4.chg.model.ChgMapDragContext_MyFrameData", package.seeall)

local ChgMapDragContext_MyFrameData = class("ChgMapDragContext_MyFrameData")
local kCacheFrameCount = 3

ChgMapDragContext_MyFrameData.kCacheFrameCount = kCacheFrameCount

function ChgMapDragContext_MyFrameData:ctor(root)
	self._root = root
	self._ctx = root._ctx
	self._viewContainer = root._viewContainer
	self.deltaV2 = Vector2.New(0, 0)

	self:clear()
end

function ChgMapDragContext_MyFrameData:clear()
	self.frameIndex = -1
	self.dir = ChgEnum.Dir.None

	self.deltaV2:Set(0, 0)

	self.deltaDistance = 0
	self.isDirectionLocked = false
	self.lineItem = false
	self.startItem = false
	self.detectFinalEndItem = false
	self.detectFinalWidth = 0
	self.detectFinalEnergy = 0
	self.detectInfoList = {}
	self.detectVisitedKeyDict = {}
	self.snapLineItem = false
	self.snapLineEndItem = false
	self.detectObstacleItem = false
end

function ChgMapDragContext_MyFrameData:snapshot(dragObj)
	self:clear()

	local frameCount = self._root.frameCount

	self.frameIndex = frameCount

	local dragInfo = dragObj:dragInfo()

	self:_setupInput(dragInfo.dirHorV, dragInfo.deltaNorm)
	self:_startJudge()
end

function ChgMapDragContext_MyFrameData:_setupInput(eDir, deltaV2)
	self.dir = eDir

	self.deltaV2:Set(deltaV2.x, deltaV2.y)

	self.deltaDistance = ChgEnum.deltaV2ToDeltaDistance(eDir, deltaV2)
end

function ChgMapDragContext_MyFrameData:_setupByDeltaDistance(newDeltaDistance, eDir)
	eDir = eDir or self.dir
	self.dir = eDir
	self.deltaDistance = newDeltaDistance

	local newDeltaV2 = ChgEnum.deltaDistanceToDeltaV2(eDir, newDeltaDistance)

	self.deltaV2:Set(newDeltaV2.x, newDeltaV2.y)
end

function ChgMapDragContext_MyFrameData:_startJudge()
	if self.frameIndex == 1 then
		self:_defaultJudge()
	else
		self:_judgeByLastFrame()
	end
end

function ChgMapDragContext_MyFrameData:_defaultJudge()
	local eDir = self.dir
	local lastEnergy = self._root.editEnergy
	local lineItem = self._ctx:getOrCreateLineItem(nil, eDir, lastEnergy)

	if ChgEnum.rDir and not lineItem then
		self:dumpLog()
		assert(false)
	end

	local startItem = lineItem:startItem()
	local judgeInfo = self:_getJudgeInfo(startItem, eDir, self.deltaDistance, lastEnergy)
	local detectInfoList = judgeInfo.detectInfoList
	local detectFinalEndItem = judgeInfo.detectFinalEndItem

	self.startItem = startItem
	self.lineItem = lineItem
	self.detectFinalEndItem = detectFinalEndItem
	self.detectFinalEnergy = judgeInfo.endUpEnergy
	self.detectInfoList = detectInfoList
	self.detectFinalWidth = startItem:clampMovableDistance(eDir, self.deltaDistance)
end

function ChgMapDragContext_MyFrameData:_internal_diff_dirInfo(refInfo, rhs)
	refInfo.isSameDir = self.dir == rhs.dir
	refInfo.isFlipDir = ChgEnum.isFlipDir(self.dir, rhs.dir)
	refInfo.isParallelDir = refInfo.isSameDir or refInfo.isFlipDir
	refInfo.isPerpendicularDir = not refInfo.isParallelDir
end

function ChgMapDragContext_MyFrameData:_internal_diff_distInfo(refInfo, rhs)
	refInfo.diffDtDist = self.deltaDistance - rhs.deltaDistance
end

function ChgMapDragContext_MyFrameData:_internal_diff(rhs)
	local isValid = self.frameIndex > 0 and rhs.frameIndex > 0
	local info = {
		isValid = isValid
	}

	if not isValid then
		return info
	end

	self:_internal_diff_dirInfo(info, rhs)
	self:_internal_diff_distInfo(info, rhs)

	return info
end

function ChgMapDragContext_MyFrameData:_copyFrame(rhs)
	self.dir = rhs.dir
	self.deltaV2 = rhs.deltaV2
	self.deltaDistance = rhs.deltaDistance
	self.lineItem = rhs.lineItem
	self.startItem = rhs.startItem
	self.detectFinalEndItem = rhs.detectFinalEndItem
	self.detectFinalWidth = rhs.detectFinalWidth
	self.detectInfoList = rhs.detectInfoList
	self.detectFinalEnergy = rhs.detectFinalEnergy
	self.snapLineItem = rhs.snapLineItem
	self.snapLineEndItem = rhs.snapLineEndItem
	self.detectObstacleItem = rhs.detectObstacleItem
end

function ChgMapDragContext_MyFrameData:_doWithoutInput(optNewDir)
	self.deltaV2:Set(0, 0)

	self.deltaDistance = 0

	if optNewDir then
		self.dir = optNewDir
	end
end

function ChgMapDragContext_MyFrameData:_copyFrame_WithoutInput(rhs)
	self:_copyFrame(rhs)
	self:_doWithoutInput()

	self.snapLineItem = false
	self.snapLineEndItem = false
	self.detectObstacleItem = false
end

function ChgMapDragContext_MyFrameData:isVisited(...)
	return self._root:isVisited(...)
end

function ChgMapDragContext_MyFrameData:addVisit(...)
	self._root:addVisit(...)
end

function ChgMapDragContext_MyFrameData:addVisitByLine(...)
	self._root:addVisitByLine(...)
end

function ChgMapDragContext_MyFrameData:_getJudgeInfo(targetItem, eDir, deltaDistance, startUpEnergy)
	local detectInfoList = targetItem:getItemInfoListByVector(eDir, deltaDistance)
	local ptList = {}
	local checkPointList = {}
	local endUpEnergy = startUpEnergy or 0
	local breakIndex
	local isSnapToEnd = false
	local obstacleItem

	for i, info in ipairs(detectInfoList) do
		local item = info.item
		local mapObj = item:mapObj()
		local isPt = item:isPoint()

		if mapObj:isObstacle() then
			breakIndex = i
			obstacleItem = item

			break
		end

		if self:isVisited(item, eDir) then
			obstacleItem = item
			breakIndex = i
			isSnapToEnd = true

			break
		end

		if mapObj:isCheckPoint() then
			ti(checkPointList, item)
		end

		if isPt then
			ti(ptList, item)

			if item ~= targetItem then
				endUpEnergy = endUpEnergy - 1

				if endUpEnergy <= 0 then
					breakIndex = i

					break
				end
			end
		end

		if mapObj:isEnd() then
			breakIndex = i

			break
		end
	end

	if breakIndex then
		local tot = #detectInfoList

		for i = breakIndex + 1, tot do
			table.remove(detectInfoList)
		end
	end

	local lastInfo = detectInfoList[#detectInfoList]
	local detectFinalEndItem = assert(lastInfo.item)

	isSnapToEnd = isSnapToEnd or endUpEnergy <= 0 or detectFinalEndItem:isObstacle() or detectFinalEndItem:isEnd()

	return {
		detectInfoList = detectInfoList,
		endUpEnergy = endUpEnergy,
		ptList = ptList,
		checkPointList = checkPointList,
		detectFinalEndItem = detectFinalEndItem,
		isSnapToEnd = isSnapToEnd,
		obstacleItem = obstacleItem
	}
end

function ChgMapDragContext_MyFrameData:_makeDetectData(lineItem, detectEnergy, lastFinalWidth, detectItem)
	local eDir = lineItem:getDir()
	local deltaDistance = self.deltaDistance

	self.lineItem = assert(lineItem)

	local startItem = lineItem:startItem()

	lastFinalWidth = lastFinalWidth or 0
	detectItem = detectItem or startItem
	detectEnergy = detectEnergy or lineItem:startEnergy()

	local detectItemFinalWidth = lineItem:calcDistFromStart(detectItem)
	local detectDistance = deltaDistance + math.max(0, lastFinalWidth - detectItemFinalWidth)
	local judgeInfo = self:_getJudgeInfo(detectItem, eDir, detectDistance, detectEnergy)
	local detectInfoList = judgeInfo.detectInfoList
	local detectFinalEnergy = judgeInfo.endUpEnergy
	local detectFinalEndItem = judgeInfo.detectFinalEndItem
	local isSnapToEnd = judgeInfo.isSnapToEnd

	self.startItem = startItem
	self.detectInfoList = detectInfoList
	self.detectFinalEndItem = detectFinalEndItem
	self.detectFinalEnergy = detectFinalEnergy
	self.detectObstacleItem = judgeInfo.obstacleItem

	if isSnapToEnd then
		self.detectFinalWidth = lineItem:calcDistFromStart(detectFinalEndItem)
	else
		self.detectFinalWidth = startItem:clampMovableDistance(eDir, lastFinalWidth + deltaDistance)
	end
end

function ChgMapDragContext_MyFrameData:_judgeWithSameDir(last, diffInfo)
	self:_myDPadInput():clear()
	self:_makeDetectData(last.lineItem, last.detectFinalEnergy, last.detectFinalWidth, last.detectFinalEndItem)
end

function ChgMapDragContext_MyFrameData:_judgeWithDiffDir(last, diffInfo)
	self:_myDPadInput():snapshot(self)

	if ChgEnum.rDir and not last.detectFinalEndItem then
		last:dumpLog()
		assert(false)
	end

	if self:_myDPadInput():isValid() then
		local peakDir, peakDeltaV2 = self:_myDPadInput():peak()
		local popDeltaDistance = ChgEnum.deltaV2ToDeltaDistance(self.dir, peakDeltaV2)

		if peakDir == self.dir or abs(popDeltaDistance - self.deltaDistance) > 10 then
			local popDir, popDeltaV2 = self:_myDPadInput():pop()

			self:_setupInput(popDir, popDeltaV2)
			self:_judgeWithDiffDirImpl(last)

			return
		end
	end

	self:_copyFrame_WithoutInput(last)
end

function ChgMapDragContext_MyFrameData:debug_dirStr(eDir)
	if ChgEnum.rDir then
		return ChgEnum.rDir[eDir or self.dir]
	end

	return ""
end

local kLineFastSnapDtDistF = 20
local kLineFastSnapDtDistB = 10

function ChgMapDragContext_MyFrameData:_judgeWithDiffDirImpl(last)
	local lastEnergy = self._root.editEnergy
	local lastEndItem = last.detectFinalEndItem
	local eDir = self.dir

	if not last:isValid() then
		self:_copyFrame_WithoutInput(last)

		return
	end

	if lastEndItem:isPoint() then
		self.snapLineItem = last.lineItem
		self.snapLineEndItem = lastEndItem

		local lastLineDir = last.lineItem:getDirStr()
		local bLastLineZero = last.lineItem:isZero()

		if bLastLineZero then
			lastLineDir = last.dir
		end

		if self.snapLineItem:isZero() and self.snapLineItem:startItem() ~= self.snapLineEndItem then
			self.snapLineItem:setWidth(0.1)
		end

		local lineItem = self._ctx:getOrCreateLineItem(lastEndItem, eDir, lastEnergy)

		if not lineItem._refLineItem then
			local newRefLineItem

			if self.snapLineEndItem == lastEndItem then
				newRefLineItem = self._ctx:recentValidLineItemBySpecificEnd(lastEndItem)
			else
				newRefLineItem = self._ctx:recentValidLineItem()
			end

			if newRefLineItem then
				local newRefLineDir = newRefLineItem:getDir()
				local _isSameDir, _isFlipDir = ChgEnum.isSameFlipDir(lastLineDir, newRefLineDir)

				if _isSameDir or _isFlipDir then
					lineItem:reset(newRefLineDir, newRefLineItem)

					if _isFlipDir then
						self:_doWithoutInput(newRefLineDir)
					end
				elseif newRefLineDir == eDir then
					lineItem:reset(eDir, newRefLineItem)
				elseif ChgEnum.isFlipDir(newRefLineDir, eDir) then
					lineItem:reset(newRefLineDir, newRefLineItem)
					self:_doWithoutInput(newRefLineDir)
				end
			end
		end

		self:_makeDetectData(lineItem)
	else
		local forwardItem = lastEndItem:getNeighborItemByDir(last.dir)
		local backwardItem = lastEndItem:getNeighborItemByDir(ChgEnum.simpleFlipDir(last.dir))
		local isExistsF = forwardItem ~= nil
		local isExistsB = backwardItem ~= nil
		local deltaDistanceF = isExistsF and last.lineItem:calcDistFromStart(forwardItem) or 1999999
		local deltaDistanceB = isExistsB and last.lineItem:calcDistFromStart(backwardItem) or 1999999
		local diffFOfLine = math.abs(deltaDistanceF - last.detectFinalWidth)
		local diffBOfLine = math.abs(deltaDistanceB - last.detectFinalWidth)
		local isAllowNormalSnap = diffFOfLine < kLineFastSnapDtDistF or diffBOfLine < kLineFastSnapDtDistB

		if not isAllowNormalSnap and kLineFastSnapDtDistF < self.deltaDistance then
			isAllowNormalSnap = true

			local newDeltaDistance = math.min(self.deltaDistance - kLineFastSnapDtDistF, kLineFastSnapDtDistF * 0.5)

			self:_setupByDeltaDistance(newDeltaDistance, eDir)
		end

		if isAllowNormalSnap then
			local isChooseF = diffFOfLine < diffBOfLine

			self.snapLineItem = last.lineItem

			local deltaEnergy = 0

			if isChooseF then
				deltaEnergy = deltaEnergy - 1
				self.snapLineEndItem = forwardItem
			else
				self.snapLineEndItem = backwardItem
			end

			if self.snapLineItem:isZero() and self.snapLineItem:startItem() ~= self.snapLineEndItem then
				self.snapLineItem:setWidth(0.1)
			end

			local lineItem = self._ctx:getOrCreateLineItem(self.snapLineEndItem, eDir, lastEnergy + deltaEnergy)

			self:_makeDetectData(lineItem)
		else
			self:_copyFrame_WithoutInput(last)
		end
	end
end

function ChgMapDragContext_MyFrameData:_judgeByLastFrame()
	local last = self._root:lastFrame()
	local diffInfo = self:_internal_diff(last)
	local isSameDir = diffInfo.isSameDir
	local isFlipDir = diffInfo.isFlipDir

	if last.lineItem then
		isSameDir, isFlipDir = ChgEnum.isSameFlipDir(last.lineItem:getDir(), self.dir)
	end

	if last.detectFinalEnergy <= 0 or isFlipDir then
		self:_copyFrame_WithoutInput(last)

		return
	end

	if isSameDir then
		self:_judgeWithSameDir(last, diffInfo)
	else
		self:_judgeWithDiffDir(last, diffInfo)
	end

	self:_checkVisited(last)
end

function ChgMapDragContext_MyFrameData:_checkVisited(last)
	if not last then
		return
	end

	if last.lineItem == self.lineItem then
		return
	end

	local editLastSaved = self._root.editLastSaved
	local _, using = self._ctx:lastUsedAndUsing()

	if editLastSaved > using - 2 then
		return
	end

	local lineItemList = self._ctx:getValidLineItemListFromEnd(editLastSaved + 1, using)

	if #lineItemList < 2 then
		return
	end

	for i = 2, #lineItemList do
		local lineItem = lineItemList[i]
		local infoList = lineItem:getValidItemInfoList(true)
		local itemCount = #infoList

		for j, info in ipairs(infoList) do
			local item = info.item

			self:addVisitByLine(j, itemCount, lineItem:getDir(), item)
		end
	end

	self._root.editLastSaved = math.max(self._root.editLastSaved, using - 2)
end

function ChgMapDragContext_MyFrameData:_myDPadInput()
	return self._root._myDPadInput
end

function ChgMapDragContext_MyFrameData:isValid()
	return self.frameIndex >= kCacheFrameCount
end

function ChgMapDragContext_MyFrameData:isDirNone()
	return self.dir == ChgEnum.Dir.None
end

function ChgMapDragContext_MyFrameData:getDirDeltaValue()
	if self:isDirNone() then
		return 0
	end

	return ChgEnum.isVertical(self.dir) and self.deltaV2.y or self.deltaV2.x
end

function ChgMapDragContext_MyFrameData:diff(rhs)
	local info = self:_internal_diff(rhs)

	if not info.isValid then
		return info
	end

	info.deltaEnergy = self.detectFinalEnergy - rhs.detectFinalEnergy

	return info
end

function ChgMapDragContext_MyFrameData:dumpLog()
	local refStrBuf = {}

	self:dump(refStrBuf)
	logError(table.concat(refStrBuf, "\n"))
end

function ChgMapDragContext_MyFrameData:dump(refStrBuf, depth)
	if not ChgEnum.rDir then
		return
	end

	depth = depth or 0

	local tab = string_rep("\t", depth)
	local tab2 = string_rep("\t", depth + 1)
	local setColor = ChgTesting.setColorDesc
	local kYellow = ChgTesting.kYellow
	local kGreen = ChgTesting.kGreen

	ti(refStrBuf, tab .. "============ ChgMapDragContext_MyFrameData ============")
	ti(refStrBuf, tab .. sf("Frame: #%s", self.frameIndex))
	ti(refStrBuf, tab .. sf("Dir: %s", setColor(ChgEnum.rDir[self.dir], kYellow)))
	ti(refStrBuf, tab .. sf("deltaV2: { x = %.2f, y = %.2f}", self.deltaV2.x, self.deltaV2.y))
	ti(refStrBuf, tab .. sf("deltaDistance: %s", setColor(self.deltaDistance, kGreen)))

	if self.lineItem then
		ti(refStrBuf, tab .. sf("lineItem: %s(%s) w:%.2f", self.lineItem:name(), self.lineItem:getDirStr(), self.lineItem:getWidth()))
	else
		ti(refStrBuf, tab .. sf("lineItem: %s", setColor("Nil", kYellow)))
	end

	if self.startItem then
		ti(refStrBuf, tab .. sf("startItem: %s", setColor(self.startItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("startItem: %s", setColor("Nil", kYellow)))
	end

	if self.detectFinalEndItem then
		ti(refStrBuf, tab .. sf("detectFinalEndItem: %s", setColor(self.detectFinalEndItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("detectFinalEndItem: %s", setColor("Nil", kYellow)))
	end

	local strList = {}

	ti(refStrBuf, tab .. sf("#detectInfoList: %s", #self.detectInfoList))

	for i, info in ipairs(self.detectInfoList) do
		local item = info.item

		ti(strList, tab2 .. sf("%s: %s", i, item:debugName()))
	end

	if #strList > 0 then
		ti(refStrBuf, table.concat(strList, "\n"))
	end

	ti(refStrBuf, tab .. sf("detectFinalWidth: %s", setColor(self.detectFinalWidth, kYellow)))
	ti(refStrBuf, tab .. sf("detectFinalEnergy: %s", self.detectFinalEnergy))

	if self.snapLineItem then
		ti(refStrBuf, tab .. sf("snapLineItem: %s(%s) w:%.2f", self.snapLineItem:name(), self.snapLineItem:getDirStr(), self.snapLineItem:getWidth()))
	else
		ti(refStrBuf, tab .. sf("snapLineItem: %s", setColor("Nil", kYellow)))
	end

	if self.snapLineEndItem then
		ti(refStrBuf, tab .. sf("snapLineEndItem: %s", setColor(self.snapLineEndItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("snapLineEndItem: %s", setColor("Nil", kYellow)))
	end

	if self.detectObstacleItem then
		ti(refStrBuf, tab .. sf("detectObstacleItem: %s", setColor(self.detectObstacleItem:debugName(), kYellow)))
	else
		ti(refStrBuf, tab .. sf("detectObstacleItem: %s", setColor("Nil", kYellow)))
	end
end

return ChgMapDragContext_MyFrameData

-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeWordEffectComp.lua

module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectComp", package.seeall)

local DungeonMazeWordEffectComp = class("DungeonMazeWordEffectComp", LuaCompBase)
local CSRectTrHelper = SLFramework.UGUI.RectTrHelper
local kSpace = "<size=40><alpha=#00>.<alpha=#ff></size>"
local ti = table.insert
local sgmatch = string.gmatch

local function _getUCharArr(str)
	if not str then
		return {}
	end

	local wordList = {}

	for ch in sgmatch(str, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if (LangSettings.instance:isEn() or LangSettings.instance:isKr()) and ch == " " then
			ch = kSpace
		end

		ti(wordList, ch)
	end

	return wordList
end

function DungeonMazeWordEffectComp:_warpInScreenX()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._fTimer = FrameTimerController.instance:register(self._onWarpInScreenX, self, 2)

	self._fTimer:Start()
end

function DungeonMazeWordEffectComp:_onWarpInScreenX()
	if gohelper.isNil(self.go) then
		return
	end

	if not self._parent then
		return
	end

	local parentViewGO = self._parent.viewGO

	if gohelper.isNil(parentViewGO) then
		return
	end

	local viewRootTrans = parentViewGO.transform

	if gohelper.isNil(viewRootTrans) then
		return
	end

	local hSW = UnityEngine.Screen.width * 0.5
	local curHW = recthelper.getWidth(self._itemTran) * 0.5
	local screenCenterPos = Vector3(hSW, 0, 0)
	local uiCamera = CameraMgr.instance:getUICamera()
	local localPosV2 = CSRectTrHelper.ScreenPosToAnchorPos(screenCenterPos, self._itemTran.parent, uiCamera)
	local APosXInScreenCenter = localPosV2.x
	local kPadding = 15
	local rangePosX = {
		min = APosXInScreenCenter + (-hSW + curHW + kPadding),
		max = APosXInScreenCenter + (hSW - curHW - kPadding)
	}
	local posX = self._originalPosX

	if posX <= rangePosX.min or posX >= rangePosX.max then
		if self._dir == DungeonMazeEnum.dir.right then
			local v2 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.MR_L, self._itemTran, viewRootTrans)

			posX = v2.x - kPadding
		elseif self._dir == DungeonMazeEnum.dir.left then
			local v2 = UIDockingHelper.calcDockLocalPosV2(UIDockingHelper.Dock.ML_R, self._itemTran, viewRootTrans)

			posX = v2.x + kPadding
		end

		posX = GameUtil.clamp(posX, rangePosX.min, rangePosX.max)
	end

	recthelper.setAnchor(self._itemTran, posX, self._originalPosY)
end

function DungeonMazeWordEffectComp:ctor(params)
	self._parent = params.parent
	self._dir = params.dir
	self._co = params.co
	self._res = params.res
	self._done = params.done
end

function DungeonMazeWordEffectComp:init(go)
	self._item = gohelper.findChild(go, "item")
	self._itemTran = self._item.transform
	self._originalPosX = recthelper.getAnchorX(self._itemTran)
	self._originalPosY = recthelper.getAnchorY(self._itemTran)
	self._trans = go.transform
	self.go = go
	self._line1 = gohelper.findChild(go, "item/line1")
	self._line2 = gohelper.findChild(go, "item/line2")
	self._effect = gohelper.findChild(go, "item/effect")
	self._animEffect = self._effect:GetComponent(gohelper.Type_Animator)

	self:createTxt()
	self:_warpInScreenX()
end

function DungeonMazeWordEffectComp:createTxt()
	local oneWordTime = Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose

	self._allAnimWork = {}

	local arr = string.split(self._co.desc, "\n")
	local words1 = _getUCharArr(arr[1]) or {}
	local offsetX = 0

	for i = 1, #words1 do
		local txtAnim, txt = self:getRes(self._line1, false)

		txt.text = words1[i]
		offsetX = offsetX + txt.preferredWidth + Season166Enum.WordTxtPosXOffset

		local p = txt.transform.parent

		recthelper.setWidth(p, txt.preferredWidth)
		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + oneWordTime - Season166Enum.WordTxtClose
		})
	end

	offsetX = 0

	local words2 = _getUCharArr(arr[2]) or {}

	for i = 1, #words2 do
		local txtAnim, txt = self:getRes(self._line2, false)

		txt.text = words2[i]
		offsetX = offsetX + txt.preferredWidth + Season166Enum.WordTxtPosXOffset

		local p = txt.transform.parent

		recthelper.setWidth(p, txt.preferredWidth)
		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + oneWordTime - Season166Enum.WordTxtClose
		})
	end

	local line1TotalTime = oneWordTime + Season166Enum.WordTxtInterval * (#words1 - 1)
	local line2TotalTime = 0

	if #words2 > 0 then
		line2TotalTime = oneWordTime + Season166Enum.WordTxtInterval * (#words2 - 1)
	end

	local totalTime = math.max(line1TotalTime, line2TotalTime)

	table.insert(self._allAnimWork, {
		showEndEffect = true,
		time = totalTime - Season166Enum.WordTxtClose
	})
	table.insert(self._allAnimWork, {
		destroy = false,
		time = totalTime
	})
	table.sort(self._allAnimWork, Season166WordEffectComp.sortAnim)
	self:nextStep()
end

function DungeonMazeWordEffectComp:nextStep()
	TaskDispatcher.cancelTask(self.nextStep, self)

	local work = table.remove(self._allAnimWork, 1)

	if not work then
		return
	end

	if work.destroy then
		gohelper.destroy(self.go)

		return
	elseif work.showEndEffect then
		self._animEffect:Play(UIAnimationName.Close, 0, 0)
	elseif work.playAnim == "open" then
		work.anim.enabled = true
	end

	local nextWork = self._allAnimWork[1]

	if not nextWork then
		return
	end

	TaskDispatcher.runDelay(self.nextStep, self, nextWork.time - work.time)
end

function DungeonMazeWordEffectComp.sortAnim(a, b)
	return a.time < b.time
end

local Type_Animtor = typeof(UnityEngine.Animator)

function DungeonMazeWordEffectComp:getRes(root, isImage)
	local go = gohelper.clone(self._res, root)
	local image = gohelper.findChildSingleImage(go, "img")
	local txt = gohelper.findChildTextMesh(go, "txt")
	local anim = go:GetComponent(Type_Animtor)

	gohelper.setActive(image, isImage)
	gohelper.setActive(txt, not isImage)
	gohelper.setActive(go, true)
	anim:Play("open", 0, 0)
	anim:Update(0)

	anim.enabled = false

	return anim, isImage and image or txt
end

function DungeonMazeWordEffectComp:onDestroy()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	TaskDispatcher.cancelTask(self.nextStep, self)
end

return DungeonMazeWordEffectComp

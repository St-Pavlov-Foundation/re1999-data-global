-- chunkname: @modules/logic/toughbattle/view/ToughBattleWordComp.lua

module("modules.logic.toughbattle.view.ToughBattleWordComp", package.seeall)

local ToughBattleWordComp = class("ToughBattleWordComp", LuaCompBase)
local kSpace = "<size=40><alpha=#00>.<alpha=#ff></size>"

local function _getUCharArr(str)
	local wordList

	if LangSettings.instance:isEn() then
		wordList = {
			string.byte(str, 1, -1)
		}

		for i = 1, #wordList do
			if wordList[i] == 32 then
				wordList[i] = kSpace
			else
				wordList[i] = string.char(wordList[i])
			end
		end
	else
		wordList = LuaUtil.getUCharArr(str)
	end

	return wordList or {}
end

function ToughBattleWordComp:ctor(params)
	self._co = params.co
	self._res = params.res
end

function ToughBattleWordComp:init(go)
	self.go = go
	self._sign = gohelper.findChild(go, "sign")
	self._line1 = gohelper.findChild(go, "line1")
	self._line2 = gohelper.findChild(go, "line2")

	self:createTxt()
end

function ToughBattleWordComp:createTxt()
	local oneWordTime = ToughBattleEnum.WordTxtOpen + ToughBattleEnum.WordTxtIdle + ToughBattleEnum.WordTxtClose

	self._allAnimWork = {}

	local imageAnim, image = self:getRes(self._sign, true)

	image:LoadImage(ResUrl.getSignature(self._co.sign))

	local arr = string.split(self._co.desc, "\n")
	local words1 = _getUCharArr(arr[1])

	for i = 1, #words1 do
		local txtAnim, txt = self:getRes(self._line1, false)

		txt.text = words1[i]

		local p = txt.transform.parent

		recthelper.setWidth(p, txt.preferredWidth)
		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * ToughBattleEnum.WordTxtInterval
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * ToughBattleEnum.WordTxtInterval + oneWordTime - ToughBattleEnum.WordTxtClose
		})
	end

	local words2 = _getUCharArr(arr[2])

	for i = 1, #words2 do
		local txtAnim, txt = self:getRes(self._line2, false)

		txt.text = words2[i]

		local p = txt.transform.parent

		recthelper.setWidth(p, txt.preferredWidth)
		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay + oneWordTime - ToughBattleEnum.WordTxtClose
		})
	end

	table.insert(self._allAnimWork, {
		playAnim = "open",
		time = 0,
		anim = imageAnim
	})

	local line1TotalTime = oneWordTime + ToughBattleEnum.WordTxtInterval * (#words1 - 1)
	local line2TotalTime = 0

	if #words2 > 0 then
		line2TotalTime = oneWordTime + ToughBattleEnum.WordTxtInterval * (#words2 - 1)
	end

	local totalTime = math.max(line1TotalTime, line2TotalTime)

	table.insert(self._allAnimWork, {
		playAnim = "close",
		anim = imageAnim,
		time = totalTime - ToughBattleEnum.WordTxtClose
	})
	table.insert(self._allAnimWork, {
		destroy = true,
		time = totalTime
	})
	table.sort(self._allAnimWork, ToughBattleWordComp.sortAnim)
	self:nextStep()
end

function ToughBattleWordComp:nextStep()
	TaskDispatcher.cancelTask(self.nextStep, self)

	local work = table.remove(self._allAnimWork, 1)

	if not work then
		return
	end

	if work.destroy then
		gohelper.destroy(self.go)

		return
	elseif work.playAnim == "open" then
		work.anim.enabled = true
	else
		work.anim:Play(work.playAnim, 0, 0)
	end

	local nextWork = self._allAnimWork[1]

	if not nextWork then
		return
	end

	TaskDispatcher.runDelay(self.nextStep, self, nextWork.time - work.time)
end

function ToughBattleWordComp.sortAnim(a, b)
	return a.time < b.time
end

local Type_Animtor = typeof(UnityEngine.Animator)

function ToughBattleWordComp:getRes(root, isImage)
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

function ToughBattleWordComp:onDestroy()
	TaskDispatcher.cancelTask(self.nextStep, self)
end

return ToughBattleWordComp

-- chunkname: @modules/logic/gm/view/GMGuideStatusItem.lua

module("modules.logic.gm.view.GMGuideStatusItem", package.seeall)

local GMGuideStatusItem = class("GMGuideStatusItem", ListScrollCell)

function GMGuideStatusItem:init(go)
	self._guideCO = nil
	self._txtGuideId = gohelper.findChildText(go, "txtGuideId")
	self._txtClientStep = gohelper.findChildText(go, "txtClientStep")
	self._txtServerStep = gohelper.findChildText(go, "txtServerStep")
	self._txtExecStep = gohelper.findChildText(go, "txtExecStep")
	self._txtStatus = gohelper.findChildText(go, "txtStatus")
	self._btnRestart = gohelper.findChildButtonWithAudio(go, "btnRestart")
	self._btnFinish = gohelper.findChildButtonWithAudio(go, "btnFinish")
	self._btnDel = gohelper.findChildButtonWithAudio(go, "btnDel")
	self._clickGuideId = gohelper.getClick(self._txtGuideId.gameObject)

	self._btnRestart:AddClickListener(self._onClickRestart, self)
	self._btnFinish:AddClickListener(self._onClickFinish, self)
	self._btnDel:AddClickListener(self._onClickDel, self)
	self._clickGuideId:AddClickListener(self._onClickGuideId, self)
end

function GMGuideStatusItem:onUpdateMO(mo)
	self._guideId = mo.id
	self._guideCO = mo

	local guideMO = GuideModel.instance:getById(self._guideCO.id)

	self._txtGuideId.text = self._guideCO.id

	if guideMO then
		self._txtClientStep.text = guideMO.clientStepId
		self._txtServerStep.text = guideMO.serverStepId

		if guideMO.currGuideId == -1 or guideMO.currGuideId == self._guideCO then
			self._txtExecStep.text = guideMO.currStepId
		else
			self._txtExecStep.text = guideMO.currGuideId .. "_" .. guideMO.currStepId
		end

		if guideMO.serverStepId == -1 then
			if guideMO.isExceptionFinish then
				self._txtStatus.text = "<color=#FF0000>异常终止</color>"
			elseif guideMO.clientStepId == -1 then
				self._txtStatus.text = "<color=#00DD00>已完成</color>"
			else
				self._txtStatus.text = "<color=#00DD00>前端收尾ing</color>"
			end
		elseif guideMO.currGuideId == self._guideCO.id then
			if ViewMgr.instance:isOpen(ViewName.GuideView) then
				if GuideViewMgr.instance.guideId == guideMO.currGuideId and GuideViewMgr.instance.stepId == guideMO.currrStepId then
					self._txtStatus.text = "<color=#EA00B3>指引点击ing</color>"
				else
					self._txtStatus.text = "<color=#EA00B3>执行ing</color>"
				end
			else
				self._txtStatus.text = "<color=#EA00B3>执行ing</color>"
			end
		else
			self._txtStatus.text = "<color=#EA00B3>中断重来ing</color>"
		end
	else
		self._txtClientStep.text = ""
		self._txtServerStep.text = ""
		self._txtExecStep.text = ""
		self._txtStatus.text = "<color=#444444>未接取</color>"
	end

	gohelper.setActive(self._btnRestart.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnFinish.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(self._btnDel.gameObject, GMGuideStatusModel.instance.showOpBtn)
end

function GMGuideStatusItem:_onClickDel()
	local guideId = self._guideCO.id
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	GMRpc.instance:sendGMRequest("delete guide " .. guideId)
	GuideStepController.instance:clearFlow(guideId)
	GuideModel.instance:remove(GuideModel.instance:getById(guideId))
end

function GMGuideStatusItem:_onClickFinish()
	local guideId = self._guideCO.id
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	local stepList = GuideConfig.instance:getStepList(guideId)

	for j = #stepList, 1, -1 do
		local stepCO = stepList[j]

		if stepCO.keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

			break
		end
	end

	guideMO.isJumpPass = true

	GuideStepController.instance:clearFlow(guideId)
end

function GMGuideStatusItem:_onClickRestart()
	local guideId = self._guideCO.id
	local guideStep = 0
	local guideMO = GuideModel.instance:getById(guideId)

	GuideModel.instance:gmStartGuide(guideId, guideStep)

	if guideMO then
		GuideStepController.instance:clearFlow(guideId)

		guideMO.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. guideId)
		GuideRpc.instance:sendFinishGuideRequest(guideId, guideStep)
	elseif guideId then
		GuideController.instance:startGudie(guideId)
	end
end

function GMGuideStatusItem:_onClickGuideId()
	GameFacade.showToast(ToastEnum.IconId, self._guideCO.desc)
	logNormal(self._guideCO.id .. ":" .. self._guideCO.desc)
end

function GMGuideStatusItem:onDestroy()
	self._btnRestart:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
	self._btnDel:RemoveClickListener()
	self._clickGuideId:RemoveClickListener()
end

return GMGuideStatusItem

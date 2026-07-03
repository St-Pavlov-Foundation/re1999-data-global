-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitResultRecordDoneWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitResultRecordDoneWork", package.seeall)

local Rouge2_WaitResultRecordDoneWork = class("Rouge2_WaitResultRecordDoneWork", BaseWork)

function Rouge2_WaitResultRecordDoneWork:ctor()
	return
end

function Rouge2_WaitResultRecordDoneWork:onStart()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local isSucc = true
	local difficulty = resultInfo and resultInfo:getDifficulty()
	local minRecordDifficulty = Rouge2_FightRecordController.instance:getMinRecordDifficulty()

	if not isSucc or difficulty < minRecordDifficulty then
		self:onDone(true)

		return
	end

	MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.Rouge2RecordResult, MsgBoxEnum.BoxType.Yes_No, luaLang("rouge2_fightrecord_confirm"), "CONFIRM", luaLang("rouge2_fightrecord_abort"), "QUIT", self._startRecord, self._abortRecord, nil, self, self)
end

function Rouge2_WaitResultRecordDoneWork:_startRecord()
	Rouge2_Controller.instance:registerCallback(Rouge2_Event.OnSaveRecordDone, self._onSaveRecordDone, self)

	local params = {
		viewType = Rouge2_Enum.RecordViewType.Edit
	}

	ViewMgr.instance:openView(ViewName.Rouge2_FightRecordView, params)
end

function Rouge2_WaitResultRecordDoneWork:_onSaveRecordDone()
	self:onDone(true)
end

function Rouge2_WaitResultRecordDoneWork:_abortRecord()
	self:onDone(true)
end

function Rouge2_WaitResultRecordDoneWork:clearWork()
	Rouge2_Controller.instance:unregisterCallback(Rouge2_Event.OnSaveRecordDone, self._onSaveRecordDone, self)
end

return Rouge2_WaitResultRecordDoneWork

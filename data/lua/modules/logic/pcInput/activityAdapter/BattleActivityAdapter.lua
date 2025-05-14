module("modules.logic.pcInput.activityAdapter.BattleActivityAdapter", package.seeall)

local var_0_0 = class("BattleActivityAdapter", BaseActivityAdapter)

var_0_0.skillSelectKey = {
	21,
	22
}
var_0_0.keytoFunction = {
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpenEnemyInfo)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpentips)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSpeedUp)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleAutoFight)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 2)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectLeft)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectRight)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 2)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 3)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 4)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 5)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 6)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 7)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 8)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 9)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleMoveCardEnd)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleBackPack)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillOpen)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 1)
	end,
	function()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 2)
	end
}

function var_0_0.ctor(arg_23_0)
	BaseActivityAdapter.ctor(arg_23_0)

	arg_23_0.keytoFunction = var_0_0.keytoFunction
	arg_23_0.activitid = PCInputModel.Activity.battle

	arg_23_0:registerFunction()
end

function var_0_0.OnkeyUp(arg_24_0, arg_24_1)
	if not PCInputModel.instance:getkeyconfigBykeyName(PCInputModel.Activity.battle, arg_24_1) then
		return
	end

	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(102) then
		return
	end

	BaseActivityAdapter.OnkeyUp(arg_24_0, arg_24_1)
end

function var_0_0.OnkeyDown(arg_25_0, arg_25_1)
	if not PCInputModel.instance:getkeyconfigBykeyName(PCInputModel.Activity.battle, arg_25_1) then
		return
	end

	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	if GuideModel.instance:isDoingClickGuide() or not GuideModel.instance:isGuideFinish(102) then
		return
	end

	BaseActivityAdapter.OnkeyDown(arg_25_0, arg_25_1)
end

return var_0_0

module("modules.logic.pcInput.activityAdapter.BattleActivityAdapter", package.seeall)

slot0 = class("BattleActivityAdapter", BaseActivityAdapter)
slot0.skillSelectKey = {
	21,
	22
}
slot0.keytoFunction = {
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpenEnemyInfo)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleOpentips)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSpeedUp)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleAutoFight)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 1)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelect, 2)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectLeft)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectRight)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 1)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 2)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 3)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 4)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 5)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 6)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 7)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 8)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSelectCard, 9)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleMoveCardEnd)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleBackPack)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillOpen)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 1)
	end,
	function ()
		PCInputController.instance:dispatchEvent(PCInputEvent.NotifyBattleSkillIndex, 2)
	end
}

function slot0.ctor(slot0)
	BaseActivityAdapter.ctor(slot0)

	slot0.keytoFunction = uv0.keytoFunction
	slot0.activitid = PCInputModel.Activity.battle

	slot0:registerFunction()
end

function slot0.OnkeyUp(slot0, slot1)
	if not PCInputModel.instance:getkeyconfigBykeyName(PCInputModel.Activity.battle, slot1) then
		return
	end

	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	BaseActivityAdapter.OnkeyUp(slot0, slot1)
end

return slot0

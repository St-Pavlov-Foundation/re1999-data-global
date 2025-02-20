module("modules.logic.pcInput.PCInputController", package.seeall)

slot0 = class("PCInputController", BaseController)

function slot0.onInit(slot0)
	slot0.Adapters = slot0.Adapters or {}
	slot0.eventMgr = ZProj.GamepadEvent

	slot0.eventMgr.Instance:AddLuaLisenter(slot0.eventMgr.UpKey, slot0.OnKeyUp, slot0)
	slot0.eventMgr.Instance:AddLuaLisenter(slot0.eventMgr.DownKey, slot0.OnKeyDown, slot0)

	slot0.inputInst = ZProj.PCInputManager.Instance

	if not slot0:getIsUse() then
		slot0.init = false
	else
		slot0.init = true
	end

	logNormal("PCInputController:onInit()" .. tostring(slot0.init))
end

function slot0.getIsUse(slot0)
	return false
end

function slot0.Switch(slot0)
	slot0.init = slot0:getIsUse()
end

function slot0.getCurrentPresskey(slot0)
	if slot0.init then
		return slot0.inputInst:getCurrentPresskey()
	end

	return nil
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenViewCallBack, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseViewCallBack, slot0)
end

function slot0.onOpenViewCallBack(slot0, slot1)
	TaskDispatcher.runDelay(function ()
		if uv0 == ViewName.MainView then
			if uv1.Adapters[PCInputModel.Activity.MainActivity] == nil then
				uv1.Adapters[PCInputModel.Activity.MainActivity] = MainActivityAdapter.New()
			end
		elseif uv0 == ViewName.ExploreView then
			if uv1.Adapters[PCInputModel.Activity.thrityDoor] == nil then
				uv1.Adapters[PCInputModel.Activity.thrityDoor] = ThirdDoorActivtiyAdapter.New()
			end
		elseif uv0 == ViewName.FightView then
			if uv1.Adapters[PCInputModel.Activity.battle] == nil then
				uv1.Adapters[PCInputModel.Activity.battle] = BattleActivityAdapter.New()
			end
		elseif uv0 == ViewName.RoomView then
			if uv1.Adapters[PCInputModel.Activity.room] == nil then
				uv1.Adapters[PCInputModel.Activity.room] = RoomActivityAdapter.New()
			end
		elseif uv0 == ViewName.WeekWalkDialogView or uv0 == ViewName.StoryFrontView or uv0 == ViewName.ExploreInteractView or uv0 == ViewName.RoomBranchView or uv0.StoryBranchView then
			if uv1.Adapters[PCInputModel.Activity.storyDialog] == nil then
				uv1.Adapters[PCInputModel.Activity.storyDialog] = StoryDialogAdapter.New()
			end
		elseif (uv0 == ViewName.MessageBoxView or uv0 == ViewName.TopMessageBoxView or uv0 == ViewName.SDKExitGameView or uv0 == ViewName.FightQuitTipView) and uv1.Adapters[PCInputModel.Activity.CommonDialog] == nil then
			uv1.Adapters[PCInputModel.Activity.CommonDialog] = CommonActivityAdapter.New()
		end
	end, slot0, 0.01)
end

function slot0.onCloseViewCallBack(slot0, slot1)
	TaskDispatcher.runDelay(function ()
		if uv0 == ViewName.MainView then
			uv1:_removeAdapter(PCInputModel.Activity.MainActivity)
		elseif uv0 == ViewName.ExploreView then
			uv1:_removeAdapter(PCInputModel.Activity.thrityDoor)
		elseif uv0 == ViewName.FightView then
			uv1:_removeAdapter(PCInputModel.Activity.battle)
		elseif uv0 == ViewName.RoomView then
			uv1:_removeAdapter(PCInputModel.Activity.room)
		elseif uv0 == ViewName.WeekWalkDialogView or uv0 == ViewName.StoryFrontView or uv0 == ViewName.ExploreInteractView or uv0 == ViewName.RoomBranchView or uv0.StoryBranchView then
			uv1:_removeAdapter(PCInputModel.Activity.storyDialog)
		elseif uv0 == ViewName.MessageBoxView or uv0 == ViewName.TopMessageBoxView or uv0 == ViewName.SDKExitGameView or uv0 == ViewName.FightQuitTipView then
			uv1:_removeAdapter(PCInputModel.Activity.CommonDialog)
		elseif uv0 == ViewName.SettingsView then
			uv1:ReRegisterKeys()
		end
	end, slot0, 0.01)
end

function slot0.ReRegisterKeys(slot0)
	for slot4, slot5 in pairs(slot0.Adapters) do
		if slot5 then
			slot5:unRegisterFunction()
			slot5:registerFunction()
		end
	end
end

function slot0._removeAdapter(slot0, slot1)
	if slot0.Adapters[slot1] then
		slot0.Adapters[slot1]:destroy()

		slot0.Adapters[slot1] = nil
	end
end

function slot0.registerKey(slot0, slot1, slot2)
	if slot1 and slot0.inputInst then
		slot0.inputInst:RegisterKey(slot1, slot2)
	end
end

function slot0.unregisterKey(slot0, slot1, slot2)
	if slot1 and slot0.inputInst then
		slot0.inputInst:UnregisterKey(slot1, slot2)
	end
end

function slot0.registerKeys(slot0, slot1, slot2)
	if slot1 and slot0.inputInst then
		for slot6, slot7 in pairs(slot1) do
			if slot7 then
				slot0.inputInst:RegisterKey(slot7, slot2)
			end
		end
	end
end

function slot0.unregisterKeys(slot0, slot1, slot2)
	if slot1 and slot0.inputInst then
		for slot6, slot7 in pairs(slot1) do
			if slot7 then
				slot0.inputInst:UnregisterKey(slot7, slot2)
			end
		end
	end
end

function slot0.getKeyPress(slot0, slot1)
	if slot0.init and slot0.inputInst and not ViewMgr.instance:isOpen(ViewName.GuideView) then
		return slot0.inputInst:getKeyPress(slot1)
	end

	return false
end

function slot0.getActivityFunPress(slot0, slot1, slot2)
	if PCInputModel.instance:getActivityKeys(slot1) then
		if slot3[slot2] then
			return slot0:getKeyPress(slot4[4])
		else
			return false
		end
	end

	return false
end

function slot0.OnKeyDown(slot0, slot1)
	if not slot0.init or not slot0.inputInst then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.SettingsView) then
		return
	end

	for slot6, slot7 in pairs(slot0.Adapters) do
		if slot7 then
			slot7:OnkeyDown(slot0.inputInst:keyCodeToKey(slot1))
		end
	end
end

function slot0.OnKeyUp(slot0, slot1)
	if not slot0.init or not slot0.inputInst then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) then
		return
	end

	for slot6, slot7 in pairs(slot0.Adapters) do
		if slot7 then
			slot7:OnkeyUp(slot0.inputInst:keyCodeToKey(slot1))
		end
	end
end

function slot0.getThirdMoveKey(slot0)
	return PCInputModel.instance:getThirdDoorMoveKey()
end

function slot0.getKeyMap(slot0)
	return LuaUtil.deepCopy(PCInputModel.instance:getKeyBinding())
end

function slot0.saveKeyMap(slot0, slot1)
	PCInputModel.instance:Save(slot1)
end

function slot0.showkeyTips(slot0, slot1, slot2, slot3, slot4)
	if slot1 == nil or not slot0.init then
		return
	end

	if PlayerPrefsHelper.getNumber("keyTips", 0) == 0 then
		return
	end

	if not slot4 then
		MonoHelper.addLuaComOnceToGo(slot1, keyTipsView, {
			keyname = slot4,
			activityId = slot2,
			keyid = slot3
		}):Refresh(slot2, slot3)
	else
		slot6:RefreshByKeyName(slot4)
	end

	return slot6
end

function slot0.KeyNameToDescName(slot0, slot1)
	return PCInputModel.instance:ReplaceKeyName(slot1)
end

slot0.instance = slot0.New()

return slot0

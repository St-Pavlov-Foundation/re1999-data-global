module("modules.logic.pcInput.PCInputController", package.seeall)

local var_0_0 = class("PCInputController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0.Adapters = arg_1_0.Adapters or {}
	arg_1_0.eventMgr = ZProj.GamepadEvent

	arg_1_0.eventMgr.Instance:AddLuaLisenter(arg_1_0.eventMgr.UpKey, arg_1_0.OnKeyUp, arg_1_0)
	arg_1_0.eventMgr.Instance:AddLuaLisenter(arg_1_0.eventMgr.DownKey, arg_1_0.OnKeyDown, arg_1_0)

	arg_1_0.inputInst = ZProj.PCInputManager.Instance

	if not arg_1_0:getIsUse() then
		arg_1_0.init = false
	else
		arg_1_0.init = true
	end

	logNormal("PCInputController:onInit()" .. tostring(arg_1_0.init))
end

function var_0_0.PauseListen(arg_2_0)
	arg_2_0._pauseListen = true
end

function var_0_0.resumeListen(arg_3_0)
	arg_3_0._pauseListen = false
end

function var_0_0.getIsUse(arg_4_0)
	if ZProj.PCInputManager and ZProj.PCInputManager.Instance:isWindows() then
		if UnityEngine.Application.isEditor then
			return UnityEngine.PlayerPrefs.GetInt("PCInputSwitch", 1) == 1
		else
			return true
		end
	end

	return false
end

function var_0_0.Switch(arg_5_0)
	arg_5_0.init = arg_5_0:getIsUse()
end

function var_0_0.getCurrentPresskey(arg_6_0)
	if arg_6_0.init then
		return arg_6_0.inputInst:getCurrentPresskey()
	end

	return nil
end

function var_0_0.onInitFinish(arg_7_0)
	return
end

function var_0_0.reInit(arg_8_0)
	return
end

function var_0_0.addConstEvents(arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_9_0.onOpenViewCallBack, arg_9_0)
	arg_9_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_9_0.onCloseViewCallBack, arg_9_0)
end

function var_0_0.onOpenViewCallBack(arg_10_0, arg_10_1)
	TaskDispatcher.runDelay(function()
		if arg_10_1 == ViewName.MainView then
			if arg_10_0.Adapters[PCInputModel.Activity.MainActivity] == nil then
				arg_10_0.Adapters[PCInputModel.Activity.MainActivity] = MainActivityAdapter.New()
			end
		elseif arg_10_1 == ViewName.ExploreView then
			if arg_10_0.Adapters[PCInputModel.Activity.thrityDoor] == nil then
				arg_10_0.Adapters[PCInputModel.Activity.thrityDoor] = ThirdDoorActivtiyAdapter.New()
			end
		elseif arg_10_1 == ViewName.FightView then
			if arg_10_0.Adapters[PCInputModel.Activity.battle] == nil then
				arg_10_0.Adapters[PCInputModel.Activity.battle] = BattleActivityAdapter.New()
			end
		elseif arg_10_1 == ViewName.RoomView then
			if arg_10_0.Adapters[PCInputModel.Activity.room] == nil then
				arg_10_0.Adapters[PCInputModel.Activity.room] = RoomActivityAdapter.New()
			end
		elseif arg_10_1 == ViewName.WeekWalkDialogView or arg_10_1 == ViewName.StoryFrontView or arg_10_1 == ViewName.ExploreInteractView or arg_10_1 == ViewName.RoomBranchView or arg_10_1.StoryBranchView then
			if arg_10_0.Adapters[PCInputModel.Activity.storyDialog] == nil then
				arg_10_0.Adapters[PCInputModel.Activity.storyDialog] = StoryDialogAdapter.New()
			end
		elseif (arg_10_1 == ViewName.MessageBoxView or arg_10_1 == ViewName.TopMessageBoxView or arg_10_1 == ViewName.SDKExitGameView or arg_10_1 == ViewName.FightQuitTipView or arg_10_1 == ViewName.FixResTipView) and arg_10_0.Adapters[PCInputModel.Activity.CommonDialog] == nil then
			arg_10_0.Adapters[PCInputModel.Activity.CommonDialog] = CommonActivityAdapter.New()
		end
	end, arg_10_0, 0.01)
end

function var_0_0.onCloseViewCallBack(arg_12_0, arg_12_1)
	TaskDispatcher.runDelay(function()
		if arg_12_1 == ViewName.MainView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.MainActivity)
		elseif arg_12_1 == ViewName.ExploreView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.thrityDoor)
		elseif arg_12_1 == ViewName.FightView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.battle)
		elseif arg_12_1 == ViewName.RoomView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.room)
		elseif arg_12_1 == ViewName.WeekWalkDialogView or arg_12_1 == ViewName.StoryFrontView or arg_12_1 == ViewName.ExploreInteractView or arg_12_1 == ViewName.RoomBranchView or arg_12_1.StoryBranchView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.storyDialog)
		elseif arg_12_1 == ViewName.MessageBoxView or arg_12_1 == ViewName.TopMessageBoxView or arg_12_1 == ViewName.SDKExitGameView or arg_12_1 == ViewName.FightQuitTipView then
			arg_12_0:_removeAdapter(PCInputModel.Activity.CommonDialog)
		elseif arg_12_1 == ViewName.SettingsView then
			arg_12_0:ReRegisterKeys()
		end
	end, arg_12_0, 0.01)
end

function var_0_0.ReRegisterKeys(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0.Adapters) do
		if iter_14_1 then
			iter_14_1:unRegisterFunction()
			iter_14_1:registerFunction()
		end
	end
end

function var_0_0._removeAdapter(arg_15_0, arg_15_1)
	if arg_15_0.Adapters[arg_15_1] then
		arg_15_0.Adapters[arg_15_1]:destroy()

		arg_15_0.Adapters[arg_15_1] = nil
	end
end

function var_0_0.registerKey(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 and arg_16_0.inputInst then
		arg_16_0.inputInst:RegisterKey(arg_16_1, arg_16_2)
	end
end

function var_0_0.unregisterKey(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 and arg_17_0.inputInst then
		arg_17_0.inputInst:UnregisterKey(arg_17_1, arg_17_2)
	end
end

function var_0_0.registerKeys(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 and arg_18_0.inputInst then
		for iter_18_0, iter_18_1 in pairs(arg_18_1) do
			if iter_18_1 then
				arg_18_0.inputInst:RegisterKey(iter_18_1, arg_18_2)
			end
		end
	end
end

function var_0_0.unregisterKeys(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 and arg_19_0.inputInst then
		for iter_19_0, iter_19_1 in pairs(arg_19_1) do
			if iter_19_1 then
				arg_19_0.inputInst:UnregisterKey(iter_19_1, arg_19_2)
			end
		end
	end
end

function var_0_0.getKeyPress(arg_20_0, arg_20_1)
	if arg_20_0.init and arg_20_0.inputInst and not GuideController.instance:isAnyGuideRunning() then
		return arg_20_0.inputInst:getKeyPress(arg_20_1)
	end

	return false
end

function var_0_0.getActivityFunPress(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = PCInputModel.instance:getActivityKeys(arg_21_1)

	if var_21_0 then
		local var_21_1 = var_21_0[arg_21_2]

		if var_21_1 then
			return arg_21_0:getKeyPress(var_21_1[4])
		else
			return false
		end
	end

	return false
end

function var_0_0.OnKeyDown(arg_22_0, arg_22_1)
	if not arg_22_0.init or not arg_22_0.inputInst or arg_22_0._pauseListen then
		return
	end

	if GuideController.instance:isAnyGuideRunning() then
		return
	end

	local var_22_0 = arg_22_0.inputInst:keyCodeToKey(arg_22_1)
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0.Adapters) do
		table.insert(var_22_1, iter_22_1)
	end

	table.sort(var_22_1, function(arg_23_0, arg_23_1)
		return arg_23_0:getPriorty() > arg_23_1:getPriorty()
	end)

	for iter_22_2, iter_22_3 in ipairs(var_22_1) do
		if iter_22_3 and iter_22_3:OnkeyDown(var_22_0) then
			return
		end
	end
end

function var_0_0.OnKeyUp(arg_24_0, arg_24_1)
	if not arg_24_0.init or not arg_24_0.inputInst or arg_24_0._pauseListen then
		return
	end

	if GuideController.instance:isAnyGuideRunning() then
		return
	end

	local var_24_0 = arg_24_0.inputInst:keyCodeToKey(arg_24_1)
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in pairs(arg_24_0.Adapters) do
		table.insert(var_24_1, iter_24_1)
	end

	table.sort(var_24_1, function(arg_25_0, arg_25_1)
		return arg_25_0:getPriorty() > arg_25_1:getPriorty()
	end)

	for iter_24_2, iter_24_3 in ipairs(var_24_1) do
		if iter_24_3 and iter_24_3:OnkeyDown(var_24_0) then
			return
		end
	end
end

function var_0_0.getThirdMoveKey(arg_26_0)
	return PCInputModel.instance:getThirdDoorMoveKey()
end

function var_0_0.getKeyMap(arg_27_0)
	local var_27_0 = PCInputModel.instance:getKeyBinding()

	return LuaUtil.deepCopy(var_27_0)
end

function var_0_0.saveKeyMap(arg_28_0, arg_28_1)
	PCInputModel.instance:Save(arg_28_1)
end

function var_0_0.showkeyTips(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	if arg_29_1 == nil or not arg_29_0.init then
		return
	end

	local var_29_0 = MonoHelper.addLuaComOnceToGo(arg_29_1, keyTipsView, {
		keyname = arg_29_4,
		activityId = arg_29_2,
		keyid = arg_29_3
	})

	if not arg_29_4 then
		var_29_0:Refresh(arg_29_2, arg_29_3)
	else
		var_29_0:RefreshByKeyName(arg_29_4)
	end

	return var_29_0
end

function var_0_0.KeyNameToDescName(arg_30_0, arg_30_1)
	return PCInputModel.instance:ReplaceKeyName(arg_30_1)
end

function var_0_0.isPopUpViewOpen(arg_31_0, arg_31_1)
	local var_31_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_31_0 = #var_31_0, 1, -1 do
		local var_31_1 = var_31_0[iter_31_0]
		local var_31_2 = ViewMgr.instance:getSetting(var_31_1)

		if (var_31_2.layer == UILayerName.PopUpTop or var_31_2.layer == UILayerName.PopUp or var_31_2.layer == UILayerName.Guide) and not arg_31_0:viewInList(var_31_1, arg_31_1) then
			return true
		end
	end

	return false
end

function var_0_0.viewInList(arg_32_0, arg_32_1, arg_32_2)
	for iter_32_0, iter_32_1 in pairs(arg_32_2) do
		if iter_32_1 == arg_32_1 then
			return true
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0

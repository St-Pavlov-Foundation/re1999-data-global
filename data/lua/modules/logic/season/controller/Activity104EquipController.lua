module("modules.logic.season.controller.Activity104EquipController", package.seeall)

local var_0_0 = class("Activity104EquipController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

var_0_0.Toast_Save_Succ = 2855
var_0_0.Toast_Empty_Slot = 2856
var_0_0.Toast_TrialEquipNoChange = 40601

function var_0_0.onOpenView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, arg_4_0.handleHeroGroupUpdated, arg_4_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0.handleSnapshotSaveSucc, arg_4_0)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, arg_4_0.handleItemChanged, arg_4_0)
	Activity104Controller.instance:registerCallback(Activity104Event.OnPlayerPrefNewUpdate, arg_4_0.handlePlayerPrefNewUpdate, arg_4_0)
	Activity104EquipItemListModel.instance:initDatas(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.onCloseView(arg_5_0)
	arg_5_0._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_5_0.handleHeroGroupUpdated, arg_5_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_5_0.handleSnapshotSaveSucc, arg_5_0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, arg_5_0.handleItemChanged, arg_5_0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.OnPlayerPrefNewUpdate, arg_5_0.handlePlayerPrefNewUpdate, arg_5_0)
	Activity104EquipItemListModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemListModel.instance:clear()
end

function var_0_0.handleHeroGroupUpdated(arg_6_0)
	if not arg_6_0._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initPosData()
	arg_6_0:notifyUpdateView()
end

function var_0_0.handleSnapshotSaveSucc(arg_7_0, arg_7_1)
	if not arg_7_0._isOpening then
		return
	end

	if arg_7_1 == ModuleEnum.HeroGroupType.Season then
		Activity104EquipItemListModel.instance:initPosData()
		arg_7_0:notifyUpdateView()
	end
end

function var_0_0.handleItemChanged(arg_8_0)
	if not arg_8_0._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initItemMap()
	Activity104EquipItemListModel.instance:checkResetCurSelected()
	Activity104EquipItemListModel.instance:initPlayerPrefs()
	Activity104EquipItemListModel.instance:initPosData()
	Activity104EquipItemListModel.instance:initList()
	arg_8_0:notifyUpdateView()
end

function var_0_0.equipItemOnlyShow(arg_9_0, arg_9_1)
	local var_9_0 = Activity104EquipItemListModel.instance.curSelectSlot
	local var_9_1 = Activity104EquipItemListModel.instance.curEquipMap[var_9_0]
	local var_9_2

	for iter_9_0, iter_9_1 in pairs(Activity104EquipItemListModel.instance.curEquipMap) do
		if var_9_0 ~= iter_9_0 and arg_9_1 == iter_9_1 then
			Activity104EquipItemListModel.instance:unloadShowSlot(iter_9_0)

			var_9_2 = iter_9_0
		end
	end

	Activity104EquipItemListModel.instance:equipShowItem(arg_9_1)
	Activity104EquipItemListModel.instance:onModelUpdate()
	arg_9_0:dispatchEvent(Activity104EquipEvent.EquipChangeCard, {
		isNew = var_9_1 == Activity104EquipItemListModel.EmptyUid,
		unloadSlot = var_9_2
	})
end

function var_0_0.unloadItem(arg_10_0, arg_10_1)
	Activity104EquipItemListModel.instance:unloadItem(arg_10_1)
	arg_10_0:notifyUpdateView()
end

function var_0_0.setSlot(arg_11_0, arg_11_1)
	Activity104EquipItemListModel.instance:changeSelectSlot(arg_11_1)
	Activity104EquipItemListModel.instance:onModelUpdate()
	arg_11_0:dispatchEvent(Activity104EquipEvent.EquipChangeSlot)
end

function var_0_0.resumeShowSlot(arg_12_0)
	Activity104EquipItemListModel.instance:resumeSlotData()
	arg_12_0:notifyUpdateView()
end

function var_0_0.checkCanSaveSlot(arg_13_0)
	if not Activity104EquipItemListModel.instance.activityId then
		return
	end

	if arg_13_0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Activity104EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(var_0_0.Toast_Empty_Slot)

		return
	end

	if Activity104EquipItemListModel.instance:curSelectIsTrialEquip() or Activity104EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(var_0_0.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function var_0_0.saveShowSlot(arg_14_0)
	local var_14_0 = Activity104EquipItemListModel.instance:getEquipMaxCount(Activity104EquipItemListModel.instance.curPos)

	for iter_14_0 = 1, var_14_0 do
		Activity104EquipItemListModel.instance:flushSlot(iter_14_0)
	end

	local var_14_1 = Activity104EquipItemListModel.instance:flushGroup()
	local var_14_2 = Activity104EquipItemListModel.instance:getGroupMO()

	for iter_14_1, iter_14_2 in pairs(var_14_1) do
		var_14_2:updateActivity104PosEquips(iter_14_2)
	end

	arg_14_0:syncHeroGroupMO(Activity104EquipItemListModel.instance.groupIndex, var_14_2)
	arg_14_0:notifyUpdateView()
end

function var_0_0.syncHeroGroupMO(arg_15_0, arg_15_1, arg_15_2)
	HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0.checkSlotUnlock(arg_16_0)
	local var_16_0 = Activity104EquipItemListModel.instance.curPos

	if var_16_0 ~= Activity104EquipItemListModel.MainCharPos then
		return Activity104EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for iter_16_0 = Activity104EquipItemListModel.HeroMaxPos, 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(Activity104EquipItemListModel.instance.activityId, Activity104EquipItemListModel.instance.groupIndex, iter_16_0, var_16_0) then
				return false
			end
		end

		return true
	end
end

function var_0_0.checkHeroGroupCardExist(arg_17_0, arg_17_1)
	local var_17_0 = Activity104Model.instance:getAllHeroGroupSnapshot(arg_17_1)
	local var_17_1 = Activity104Model.instance:getAllItemMo(arg_17_1) or {}

	for iter_17_0, iter_17_1 in pairs(var_17_0) do
		if arg_17_0:checkSingleHeroGroupExist(iter_17_1, iter_17_0, var_17_1, arg_17_1) then
			logNormal("group [" .. tostring(iter_17_0) .. "] need resync!")
			arg_17_0:syncHeroGroupMO(iter_17_0, iter_17_1)
		end
	end
end

function var_0_0.checkSingleHeroGroupExist(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_1 then
		return false
	end

	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(arg_18_1.activity104Equips) do
		for iter_18_2, iter_18_3 in pairs(iter_18_1.equipUid) do
			if iter_18_3 ~= Activity104EquipItemListModel.EmptyUid and arg_18_3[iter_18_3] == nil then
				logNormal(string.format("empty card [%s] found in group [%s] pos [%s]", iter_18_3, tostring(arg_18_2), tostring(iter_18_0)))

				iter_18_1.equipUid[iter_18_2] = Activity104EquipItemListModel.EmptyUid
				var_18_0 = true
			end
		end
	end

	return var_18_0
end

function var_0_0.exchangeEquip(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6, arg_19_7)
	local var_19_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.activity104Equips

	for iter_19_0, iter_19_1 in pairs(var_19_1) do
		if iter_19_1.index == arg_19_1 then
			iter_19_1.equipUid[arg_19_2] = arg_19_6 or 0
		end

		if iter_19_1.index == arg_19_4 then
			iter_19_1.equipUid[arg_19_5] = arg_19_3 or 0
		end
	end

	for iter_19_2, iter_19_3 in pairs(var_19_1) do
		var_19_0:updateActivity104PosEquips(iter_19_3)
	end

	arg_19_0:syncHeroGroupMO(arg_19_7, var_19_0)
	arg_19_0:notifyUpdateView()
end

function var_0_0.handlePlayerPrefNewUpdate(arg_20_0)
	if Activity104EquipItemListModel.instance.recordNew then
		Activity104EquipItemListModel.instance.recordNew:initLocalSave()
	end

	arg_20_0:notifyUpdateView()
end

function var_0_0.notifyUpdateView(arg_21_0)
	Activity104EquipItemListModel.instance:onModelUpdate()
	arg_21_0:dispatchEvent(Activity104EquipEvent.EquipUpdate)
end

function var_0_0.setSelectTag(arg_22_0, arg_22_1)
	if Activity104EquipItemListModel.instance.tagModel then
		Activity104EquipItemListModel.instance.tagModel:selectTagIndex(arg_22_1)
		Activity104EquipItemListModel.instance:initList()
	end
end

function var_0_0.getFilterModel(arg_23_0)
	return Activity104EquipItemListModel.instance.tagModel
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

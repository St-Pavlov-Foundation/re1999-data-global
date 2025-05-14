module("modules.logic.seasonver.act123.controller.Season123EquipHeroController", package.seeall)

local var_0_0 = class("Season123EquipHeroController", BaseController)

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

function var_0_0.onOpenView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	arg_4_0._isOpening = true
	arg_4_0._callback = arg_4_4
	arg_4_0._callbackObj = arg_4_5

	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, arg_4_0.handleItemChanged, arg_4_0)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, arg_4_0.handlePlayerPrefNewUpdate, arg_4_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0.handleSnapshotSaveSucc, arg_4_0)

	local var_4_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_4_1

	if var_4_0 and var_4_0.activity104Equips and var_4_0.activity104Equips[Activity123Enum.MainCharPos] then
		var_4_1 = tabletool.copy(var_4_0.activity104Equips[Activity123Enum.MainCharPos].equipUid)
	end

	Season123EquipHeroItemListModel.instance:initDatas(arg_4_1, arg_4_2, arg_4_3, var_4_1)
end

function var_0_0.onCloseView(arg_5_0)
	arg_5_0._isOpening = false

	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, arg_5_0.handleItemChanged, arg_5_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, arg_5_0.handlePlayerPrefNewUpdate, arg_5_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnSnapshotSaveSucc, arg_5_0.handleSnapshotSaveSucc, arg_5_0)
	Season123EquipHeroItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipHeroItemListModel.instance:clear()
end

function var_0_0.handleSnapshotSaveSucc(arg_6_0, arg_6_1)
	if not arg_6_0._isOpening then
		return
	end

	if arg_6_1 == ModuleEnum.HeroGroupSnapshotType.Season123 then
		if arg_6_0._callback then
			if arg_6_0._callbackObj then
				arg_6_0._callback(arg_6_0._callbackObj, arg_6_1)
			else
				arg_6_0._callback(arg_6_1)
			end
		end

		arg_6_0:notifyUpdateView()
	end
end

function var_0_0.handleItemChanged(arg_7_0)
	if not arg_7_0._isOpening then
		return
	end

	Season123EquipHeroItemListModel.instance:initItemMap()
	Season123EquipHeroItemListModel.instance:checkResetCurSelected()
	Season123EquipHeroItemListModel.instance:initPlayerPrefs()
	Season123EquipHeroItemListModel.instance:initPosData()
	Season123EquipHeroItemListModel.instance:initList()
	arg_7_0:notifyUpdateView()
end

function var_0_0.equipItemOnlyShow(arg_8_0, arg_8_1)
	local var_8_0 = Season123EquipHeroItemListModel.instance.curSelectSlot
	local var_8_1 = Season123EquipHeroItemListModel.instance.curEquipMap[var_8_0]
	local var_8_2

	for iter_8_0, iter_8_1 in pairs(Season123EquipHeroItemListModel.instance.curEquipMap) do
		if var_8_0 ~= iter_8_0 and arg_8_1 == iter_8_1 then
			Season123EquipHeroItemListModel.instance:unloadShowSlot(iter_8_0)

			var_8_2 = iter_8_0
		end
	end

	Season123EquipHeroItemListModel.instance:equipShowItem(arg_8_1)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	arg_8_0:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = var_8_1 == Season123EquipHeroItemListModel.EmptyUid,
		unloadSlot = var_8_2
	})
end

function var_0_0.unloadItem(arg_9_0, arg_9_1)
	Season123EquipHeroItemListModel.instance:unloadItem(arg_9_1)
	arg_9_0:notifyUpdateView()
end

function var_0_0.setSlot(arg_10_0, arg_10_1)
	Season123EquipHeroItemListModel.instance:changeSelectSlot(arg_10_1)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	arg_10_0:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function var_0_0.resumeShowSlot(arg_11_0)
	Season123EquipHeroItemListModel.instance:resumeSlotData()
	arg_11_0:notifyUpdateView()
end

function var_0_0.checkCanSaveSlot(arg_12_0)
	if not Season123EquipHeroItemListModel.instance.activityId then
		return
	end

	if arg_12_0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	return true
end

function var_0_0.saveShowSlot(arg_13_0)
	local var_13_0 = Season123EquipHeroItemListModel.instance:getEquipMaxCount(Season123EquipHeroItemListModel.instance.curPos)

	for iter_13_0 = 1, var_13_0 do
		Season123EquipHeroItemListModel.instance:flushSlot(iter_13_0)
	end

	local var_13_1 = Season123EquipHeroItemListModel.instance:getEquipedCards()
	local var_13_2 = HeroGroupModel.instance:getCurGroupMO()

	if var_13_2 and var_13_2.activity104Equips and var_13_2.activity104Equips[Activity123Enum.MainCharPos] then
		for iter_13_1, iter_13_2 in ipairs(var_13_1) do
			local var_13_3 = var_13_1[iter_13_1] or Activity123Enum.EmptyUid

			var_13_2.activity104Equips[Activity123Enum.MainCharPos].equipUid[iter_13_1] = var_13_3
		end

		HeroGroupModel.instance:saveCurGroupData()
	end
end

function var_0_0.checkSlotUnlock(arg_14_0)
	local var_14_0 = Season123EquipHeroItemListModel.instance.curPos

	if var_14_0 ~= Season123EquipHeroItemListModel.MainCharPos then
		return Season123EquipHeroItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for iter_14_0 = Season123EquipHeroItemListModel.HeroMaxPos, 1, -1 do
			if Season123Model.instance:isSeasonStagePosUnlock(Season123EquipHeroItemListModel.instance.activityId, Season123EquipHeroItemListModel.instance.stage, iter_14_0, var_14_0) then
				return false
			end
		end

		return true
	end
end

function var_0_0.handlePlayerPrefNewUpdate(arg_15_0)
	if Season123EquipHeroItemListModel.instance.recordNew then
		Season123EquipHeroItemListModel.instance.recordNew:initLocalSave()
	end

	arg_15_0:notifyUpdateView()
end

function var_0_0.notifyUpdateView(arg_16_0)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	arg_16_0:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function var_0_0.setSelectTag(arg_17_0, arg_17_1)
	if Season123EquipHeroItemListModel.instance.tagModel then
		Season123EquipHeroItemListModel.instance.tagModel:selectTagIndex(arg_17_1)
		Season123EquipHeroItemListModel.instance:initList()
	end
end

function var_0_0.getFilterModel(arg_18_0)
	return Season123EquipHeroItemListModel.instance.tagModel
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

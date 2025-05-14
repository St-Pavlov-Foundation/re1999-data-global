module("modules.logic.seasonver.act123.controller.Season123EquipController", package.seeall)

local var_0_0 = class("Season123EquipController", BaseController)

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

function var_0_0.onOpenView(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	arg_4_0._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, arg_4_0.handleHeroGroupUpdated, arg_4_0)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_4_0.handleSnapshotSaveSucc, arg_4_0)
	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, arg_4_0.handleItemChanged, arg_4_0)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, arg_4_0.handlePlayerPrefNewUpdate, arg_4_0)
	Season123EquipItemListModel.instance:initDatas(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
end

function var_0_0.onCloseView(arg_5_0)
	arg_5_0._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, arg_5_0.handleHeroGroupUpdated, arg_5_0)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, arg_5_0.handleSnapshotSaveSucc, arg_5_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, arg_5_0.handleItemChanged, arg_5_0)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, arg_5_0.handlePlayerPrefNewUpdate, arg_5_0)
	Season123EquipItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipItemListModel.instance:clear()
end

function var_0_0.handleHeroGroupUpdated(arg_6_0)
	if not arg_6_0._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initPosData()
	arg_6_0:notifyUpdateView()
end

function var_0_0.handleSnapshotSaveSucc(arg_7_0, arg_7_1)
	if not arg_7_0._isOpening then
		return
	end

	if arg_7_1 == ModuleEnum.HeroGroupSnapshotType.Season123 then
		Season123EquipItemListModel.instance:initPosData()
		arg_7_0:notifyUpdateView()
	end
end

function var_0_0.handleItemChanged(arg_8_0)
	if not arg_8_0._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initItemMap()
	Season123EquipItemListModel.instance:checkResetCurSelected()
	Season123EquipItemListModel.instance:initPlayerPrefs()
	Season123EquipItemListModel.instance:initPosData()
	Season123EquipItemListModel.instance:initList()
	arg_8_0:notifyUpdateView()
end

function var_0_0.equipItemOnlyShow(arg_9_0, arg_9_1)
	local var_9_0 = Season123EquipItemListModel.instance.curSelectSlot
	local var_9_1 = Season123EquipItemListModel.instance.curEquipMap[var_9_0]
	local var_9_2

	for iter_9_0, iter_9_1 in pairs(Season123EquipItemListModel.instance.curEquipMap) do
		if var_9_0 ~= iter_9_0 and arg_9_1 == iter_9_1 then
			Season123EquipItemListModel.instance:unloadShowSlot(iter_9_0)

			var_9_2 = iter_9_0
		end
	end

	Season123EquipItemListModel.instance:equipShowItem(arg_9_1)
	Season123EquipItemListModel.instance:onModelUpdate()
	arg_9_0:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = var_9_1 == Season123EquipItemListModel.EmptyUid,
		unloadSlot = var_9_2
	})
end

function var_0_0.unloadItem(arg_10_0, arg_10_1)
	Season123EquipItemListModel.instance:unloadItem(arg_10_1)
	arg_10_0:notifyUpdateView()
end

function var_0_0.setSlot(arg_11_0, arg_11_1)
	Season123EquipItemListModel.instance:changeSelectSlot(arg_11_1)
	Season123EquipItemListModel.instance:onModelUpdate()
	arg_11_0:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function var_0_0.resumeShowSlot(arg_12_0)
	Season123EquipItemListModel.instance:resumeSlotData()
	arg_12_0:notifyUpdateView()
end

function var_0_0.checkCanSaveSlot(arg_13_0)
	if not Season123EquipItemListModel.instance.activityId then
		return
	end

	if arg_13_0:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Season123EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(var_0_0.Toast_Empty_Slot)

		return
	end

	if Season123EquipItemListModel.instance:curSelectIsTrialEquip() or Season123EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(var_0_0.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function var_0_0.saveShowSlot(arg_14_0)
	local var_14_0 = Season123EquipItemListModel.instance:getEquipMaxCount(Season123EquipItemListModel.instance.curPos)

	for iter_14_0 = 1, var_14_0 do
		Season123EquipItemListModel.instance:flushSlot(iter_14_0)
	end

	local var_14_1 = Season123EquipItemListModel.instance:flushGroup()
	local var_14_2 = Season123EquipItemListModel.instance:getGroupMO()

	for iter_14_1, iter_14_2 in pairs(var_14_1) do
		if iter_14_2.index == Activity123Enum.MainCharPos then
			local var_14_3 = var_14_2.activity104Equips[iter_14_2.index]

			for iter_14_3, iter_14_4 in ipairs(iter_14_2.equipUid) do
				var_14_3.equipUid[iter_14_3] = iter_14_4
			end
		else
			var_14_2:updateActivity104PosEquips(iter_14_2)
		end
	end

	Season123HeroGroupUtils.formation104Equips(var_14_2)
	arg_14_0:syncHeroGroupMO(Season123EquipItemListModel.instance.groupIndex, var_14_2)
	arg_14_0:notifyUpdateView()
end

function var_0_0.syncHeroGroupMO(arg_15_0, arg_15_1, arg_15_2)
	HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0.checkSlotUnlock(arg_16_0)
	local var_16_0 = Season123EquipItemListModel.instance.curPos

	if var_16_0 ~= Season123EquipItemListModel.MainCharPos then
		return Season123EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for iter_16_0 = Season123EquipItemListModel.HeroMaxPos, 1, -1 do
			if Season123EquipItemListModel.instance:isEquipCardPosUnlock(iter_16_0, var_16_0) then
				return false
			end
		end

		return true
	end
end

function var_0_0.checkHeroGroupCardExist(arg_17_0, arg_17_1)
	local var_17_0 = Season123Model.instance:getActInfo(arg_17_1)

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.heroGroupSnapshot
	local var_17_2 = Season123Model.instance:getAllItemMo(arg_17_1) or {}

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		if arg_17_0:checkSingleHeroGroupExist(iter_17_1, iter_17_0, var_17_2, arg_17_1) then
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
			if iter_18_3 ~= Season123EquipItemListModel.EmptyUid and arg_18_3[iter_18_3] == nil then
				logNormal(string.format("empty card [%s] found in group [%s] pos [%s]", iter_18_3, tostring(arg_18_2), tostring(iter_18_0)))

				iter_18_1.equipUid[iter_18_2] = Season123EquipItemListModel.EmptyUid
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

	arg_19_0:syncHeroGroupMO(arg_19_7, var_19_0)
	arg_19_0:notifyUpdateView()
end

function var_0_0.handlePlayerPrefNewUpdate(arg_20_0)
	if Season123EquipItemListModel.instance.recordNew then
		Season123EquipItemListModel.instance.recordNew:initLocalSave()
	end

	arg_20_0:notifyUpdateView()
end

function var_0_0.notifyUpdateView(arg_21_0)
	Season123EquipItemListModel.instance:onModelUpdate()
	arg_21_0:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function var_0_0.setSelectTag(arg_22_0, arg_22_1)
	if Season123EquipItemListModel.instance.tagModel then
		Season123EquipItemListModel.instance.tagModel:selectTagIndex(arg_22_1)
		Season123EquipItemListModel.instance:initList()
	end
end

function var_0_0.getFilterModel(arg_23_0)
	return Season123EquipItemListModel.instance.tagModel
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

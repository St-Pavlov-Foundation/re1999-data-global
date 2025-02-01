module("modules.logic.season.controller.Activity104EquipComposeController", package.seeall)

slot0 = class("Activity104EquipComposeController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onOpenView(slot0, slot1)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104EquipItemComposeModel.instance:initDatas(slot1)
end

function slot0.onCloseView(slot0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, slot0.handleItemChanged, slot0)
	Activity104EquipItemComposeModel.instance:clear()
end

function slot0.changeSelectCard(slot0, slot1)
	if Activity104EquipItemComposeModel.instance:isEquipSelected(slot1) then
		Activity104EquipItemComposeModel.instance:unloadEquip(slot1)
		slot0:notifyUpdateView()
	else
		slot2 = Activity104EquipItemComposeModel.instance:getSelectedRare()

		if not Activity104EquipItemComposeModel.instance:getEquipMO(slot1) then
			return
		end

		if not SeasonConfig.instance:getSeasonEquipCo(slot3.itemId) then
			return
		end

		if slot2 ~= nil and slot4.rare ~= slot2 then
			GameFacade.showToast(ToastEnum.SeasonChangeSelectCard)

			return
		end

		Activity104EquipItemComposeModel.instance:setSelectEquip(slot1)
		slot0:notifyUpdateView()
	end
end

function slot0.notifyUpdateView(slot0)
	Activity104EquipItemComposeModel.instance:onModelUpdate()
	slot0:dispatchEvent(Activity104Event.OnComposeDataChanged)
end

function slot0.checkMaterialHasEquiped(slot0)
	for slot4 = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		if Activity104EquipItemComposeModel.instance:getEquipedHeroUid(Activity104EquipItemComposeModel.instance.curSelectMap[slot4]) then
			return true
		end
	end

	return false
end

function slot0.sendCompose(slot0)
	if Activity104EquipItemComposeModel.instance:isMaterialAllReady() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_synthesis)
		Activity104Rpc.instance:sendComposeActivity104EquipRequest(Activity104EquipItemComposeModel.instance.activityId, Activity104EquipItemComposeModel.instance:getMaterialList())
	end
end

function slot0.handleItemChanged(slot0)
	Activity104EquipItemComposeModel.instance:initItemMap()
	Activity104EquipItemComposeModel.instance:checkResetCurSelected()
	Activity104EquipItemComposeModel.instance:initPosList()
	Activity104EquipItemComposeModel.instance:initList()
	slot0:notifyUpdateView()
end

function slot0.setSelectTag(slot0, slot1)
	if Activity104EquipItemComposeModel.instance.tagModel then
		Activity104EquipItemComposeModel.instance.tagModel:selectTagIndex(slot1)
		slot0:handleItemChanged()
	end
end

function slot0.getFilterModel(slot0)
	return Activity104EquipItemComposeModel.instance.tagModel
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0

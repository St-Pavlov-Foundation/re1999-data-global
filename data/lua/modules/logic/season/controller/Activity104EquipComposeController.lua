module("modules.logic.season.controller.Activity104EquipComposeController", package.seeall)

local var_0_0 = class("Activity104EquipComposeController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	return
end

function var_0_0.onOpenView(arg_4_0, arg_4_1)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, arg_4_0.handleItemChanged, arg_4_0)
	Activity104EquipItemComposeModel.instance:initDatas(arg_4_1)
end

function var_0_0.onCloseView(arg_5_0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, arg_5_0.handleItemChanged, arg_5_0)
	Activity104EquipItemComposeModel.instance:clear()
end

function var_0_0.changeSelectCard(arg_6_0, arg_6_1)
	if Activity104EquipItemComposeModel.instance:isEquipSelected(arg_6_1) then
		Activity104EquipItemComposeModel.instance:unloadEquip(arg_6_1)
		arg_6_0:notifyUpdateView()
	else
		local var_6_0 = Activity104EquipItemComposeModel.instance:getSelectedRare()
		local var_6_1 = Activity104EquipItemComposeModel.instance:getEquipMO(arg_6_1)

		if not var_6_1 then
			return
		end

		local var_6_2 = SeasonConfig.instance:getSeasonEquipCo(var_6_1.itemId)

		if not var_6_2 then
			return
		end

		if var_6_0 ~= nil and var_6_2.rare ~= var_6_0 then
			GameFacade.showToast(ToastEnum.SeasonChangeSelectCard)

			return
		end

		Activity104EquipItemComposeModel.instance:setSelectEquip(arg_6_1)
		arg_6_0:notifyUpdateView()
	end
end

function var_0_0.notifyUpdateView(arg_7_0)
	Activity104EquipItemComposeModel.instance:onModelUpdate()
	arg_7_0:dispatchEvent(Activity104Event.OnComposeDataChanged)
end

function var_0_0.checkMaterialHasEquiped(arg_8_0)
	for iter_8_0 = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		local var_8_0 = Activity104EquipItemComposeModel.instance.curSelectMap[iter_8_0]

		if Activity104EquipItemComposeModel.instance:getEquipedHeroUid(var_8_0) then
			return true
		end
	end

	return false
end

function var_0_0.sendCompose(arg_9_0)
	if Activity104EquipItemComposeModel.instance:isMaterialAllReady() then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_synthesis)
		Activity104Rpc.instance:sendComposeActivity104EquipRequest(Activity104EquipItemComposeModel.instance.activityId, Activity104EquipItemComposeModel.instance:getMaterialList())
	end
end

function var_0_0.handleItemChanged(arg_10_0)
	Activity104EquipItemComposeModel.instance:initItemMap()
	Activity104EquipItemComposeModel.instance:checkResetCurSelected()
	Activity104EquipItemComposeModel.instance:initPosList()
	Activity104EquipItemComposeModel.instance:initList()
	arg_10_0:notifyUpdateView()
end

function var_0_0.setSelectTag(arg_11_0, arg_11_1)
	if Activity104EquipItemComposeModel.instance.tagModel then
		Activity104EquipItemComposeModel.instance.tagModel:selectTagIndex(arg_11_1)
		arg_11_0:handleItemChanged()
	end
end

function var_0_0.getFilterModel(arg_12_0)
	return Activity104EquipItemComposeModel.instance.tagModel
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0

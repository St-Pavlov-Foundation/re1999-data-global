module("modules.logic.character.view.CharacterEquipItem", package.seeall)

local var_0_0 = class("CharacterEquipItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._click = gohelper.getClickWithAudio(arg_4_0.viewGO)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._onClick(arg_5_0)
	local var_5_0 = {
		equipMO = arg_5_0._mo,
		equipList = CharacterBackpackEquipListModel.instance:_getEquipList()
	}

	EquipController.instance:openEquipView(var_5_0)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	if not arg_8_0._commonEquipIcon then
		arg_8_0._commonEquipIcon = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.viewGO, CommonEquipIcon)

		arg_8_0._commonEquipIcon:_overrideLoadIconFunc(EquipHelper.getEquipIconLoadPath, arg_8_0._commonEquipIcon)
	end

	arg_8_0._mo = arg_8_1
	arg_8_0._config = EquipConfig.instance:getEquipCo(arg_8_1.equipId)

	arg_8_0._commonEquipIcon:setEquipMO(arg_8_1)
	arg_8_0._commonEquipIcon:refreshLock(arg_8_0._mo.isLock)
	arg_8_0._commonEquipIcon:hideHeroIcon()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.getAnimator(arg_10_0)
	return arg_10_0._animator
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._click:RemoveClickListener()
end

return var_0_0

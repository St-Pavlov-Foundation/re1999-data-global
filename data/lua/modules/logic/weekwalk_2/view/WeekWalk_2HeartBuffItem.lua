module("modules.logic.weekwalk_2.view.WeekWalk_2HeartBuffItem", package.seeall)

local var_0_0 = class("WeekWalk_2HeartBuffItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelect = gohelper.findChild(arg_1_0.viewGO, "#go_Select")
	arg_1_0._imageBuffIcon = gohelper.findChildImage(arg_1_0.viewGO, "#image_BuffIcon")
	arg_1_0._goEquiped = gohelper.findChild(arg_1_0.viewGO, "#go_Equiped")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._isSelected then
		return
	end

	arg_4_0._view:selectCell(arg_4_0._index, true)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._goEquiped, false)
end

function var_0_0._editableAddEvents(arg_6_0)
	arg_6_0:addEventCb(WeekWalk_2Controller.instance, WeekWalk_2Event.OnBuffSetupReply, arg_6_0._onBuffSetupReply, arg_6_0)
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0._onBuffSetupReply(arg_8_0)
	arg_8_0:_checkEquiped()
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._config = arg_9_1

	arg_9_0:_checkEquiped()
	UISpriteSetMgr.instance:setWeekWalkSprite(arg_9_0._imageBuffIcon, arg_9_0._config.icon)

	local var_9_0 = WeekWalk_2BuffListModel.instance.prevBattleSkillId

	ZProj.UGUIHelper.SetGrayscale(arg_9_0._imageBuffIcon.gameObject, var_9_0 == arg_9_0._config.id)
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	arg_10_0._isSelected = arg_10_1

	gohelper.setActive(arg_10_0._goSelect, arg_10_0._isSelected)

	if arg_10_0._isSelected then
		WeekWalk_2Controller.instance:dispatchEvent(WeekWalk_2Event.OnBuffSelectedChange, arg_10_0._config)
	end
end

function var_0_0._checkEquiped(arg_11_0)
	if not WeekWalk_2BuffListModel.instance.isBattle then
		return
	end

	local var_11_0 = WeekWalk_2BuffListModel.getCurHeroGroupSkillId()

	gohelper.setActive(arg_11_0._goEquiped, var_11_0 == arg_11_0._config.id)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0

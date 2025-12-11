module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamTabItem", package.seeall)

local var_0_0 = class("HeroGroupPresetTeamTabItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._gounselectedbg = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_unselectedbg")
	arg_1_0._txtunselectedname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_unselectedbg/#txt_unselectedname")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_unselectedbg/#image_icon")
	arg_1_0._gobeselectedbg = gohelper.findChild(arg_1_0.viewGO, "#go_info/#go_beselectedbg")
	arg_1_0._txtbeselectedname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#go_beselectedbg/#txt_beselectedname")
	arg_1_0._imageicon2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_info/#go_beselectedbg/#image_icon2")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_info/#btn_click")

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
	HeroGroupPresetTabListModel.instance:setSelectedCell(arg_4_0._index, true)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = arg_5_0.viewGO:GetComponent("Animator")
end

function var_0_0.getAnimator(arg_6_0)
	return arg_6_0._animator
end

function var_0_0._editableAddEvents(arg_7_0)
	return
end

function var_0_0._editableRemoveEvents(arg_8_0)
	return
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0._mo = arg_9_1
	arg_9_0._txtbeselectedname.text = arg_9_0._mo.name
	arg_9_0._txtunselectedname.text = arg_9_0._mo.name
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._gobeselectedbg, arg_10_1)
	gohelper.setActive(arg_10_0._gounselectedbg, not arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0

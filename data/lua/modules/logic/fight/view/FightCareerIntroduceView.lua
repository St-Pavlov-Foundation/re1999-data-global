module("modules.logic.fight.view.FightCareerIntroduceView", package.seeall)

local var_0_0 = class("FightCareerIntroduceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goblackbg = gohelper.findChild(arg_1_0.viewGO, "#go_blackbg")
	arg_1_0._btnitem1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_item1")
	arg_1_0._btnitem2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_item2")
	arg_1_0._btnitem3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_item3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnitem1:AddClickListener(arg_2_0._btnitem1OnClick, arg_2_0)
	arg_2_0._btnitem2:AddClickListener(arg_2_0._btnitem2OnClick, arg_2_0)
	arg_2_0._btnitem3:AddClickListener(arg_2_0._btnitem3OnClick, arg_2_0)
	gohelper.getClickWithAudio(arg_2_0._goblackbg):AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnitem1:RemoveClickListener()
	arg_3_0._btnitem2:RemoveClickListener()
	arg_3_0._btnitem3:RemoveClickListener()
	gohelper.getClickWithAudio(arg_3_0._goblackbg):RemoveClickListener()
end

function var_0_0._btnitem1OnClick(arg_4_0)
	arg_4_0:_onItemClick()
end

function var_0_0._btnitem2OnClick(arg_5_0)
	arg_5_0:_onItemClick()
end

function var_0_0._btnitem3OnClick(arg_6_0)
	arg_6_0:_onItemClick()
end

function var_0_0._onItemClick(arg_7_0)
	arg_7_0:closeThis()
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView, {
		isGuide = true
	})
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	return
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0

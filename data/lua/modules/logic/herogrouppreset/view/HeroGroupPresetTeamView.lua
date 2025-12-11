module("modules.logic.herogrouppreset.view.HeroGroupPresetTeamView", package.seeall)

local var_0_0 = class("HeroGroupPresetTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrolltab = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_tab")
	arg_1_0._scrollgroup = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_group")

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
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	HeroGroupPresetTabListModel.instance:initTabList()
end

function var_0_0.onClose(arg_7_0)
	HeroGroupPresetItemListModel.instance:clearInfo()
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0

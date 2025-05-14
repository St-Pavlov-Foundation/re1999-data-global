module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologyPlanetItem", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologyPlanetItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0.viewGO, "#go_Selected")
	arg_1_0._imagePlanetSelected = gohelper.findChildImage(arg_1_0.viewGO, "#go_Selected/#image_PlanetSelected")
	arg_1_0._txtNumSelected = gohelper.findChildText(arg_1_0.viewGO, "#go_Selected/#txt_NumSelected")
	arg_1_0._goUnSelected = gohelper.findChild(arg_1_0.viewGO, "#go_UnSelected")
	arg_1_0._imagePlanetUnSelected = gohelper.findChildImage(arg_1_0.viewGO, "#go_UnSelected/#image_PlanetUnSelected")
	arg_1_0._txtNumUnSelected = gohelper.findChildText(arg_1_0.viewGO, "#go_UnSelected/#txt_NumUnSelected")
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
	arg_4_0._astrologySelectView:setSelected(arg_4_0)
end

function var_0_0.ctor(arg_5_0, arg_5_1)
	arg_5_0._id = arg_5_1[1]
	arg_5_0._astrologySelectView = arg_5_1[2]
	arg_5_0._mo = VersionActivity1_3AstrologyModel.instance:getPlanetMo(arg_5_0._id)
end

function var_0_0.getPlanetMo(arg_6_0)
	return arg_6_0._mo
end

function var_0_0.getId(arg_7_0)
	return arg_7_0._id
end

function var_0_0._editableInitView(arg_8_0)
	local var_8_0 = "v1a3_astrology_planet" .. arg_8_0._id

	UISpriteSetMgr.instance:setV1a3AstrologySprite(arg_8_0._imagePlanetSelected, var_8_0)

	local var_8_1 = arg_8_0._imagePlanetUnSelected.color.a

	UISpriteSetMgr.instance:setV1a3AstrologySprite(arg_8_0._imagePlanetUnSelected, var_8_0, nil, var_8_1)
	arg_8_0:updateNum()
end

function var_0_0.setSelected(arg_9_0, arg_9_1)
	arg_9_0._isSelected = arg_9_1

	gohelper.setActive(arg_9_0._goSelected, arg_9_0._isSelected)
	gohelper.setActive(arg_9_0._goUnSelected, not arg_9_0._isSelected)
end

function var_0_0.isSelected(arg_10_0)
	return arg_10_0._isSelected
end

function var_0_0.updateNum(arg_11_0)
	local var_11_0 = arg_11_0._mo.num
	local var_11_1 = string.format("%s%s", luaLang("multiple"), var_11_0)

	arg_11_0._txtNumSelected.text = var_11_1
	arg_11_0._txtNumUnSelected.text = var_11_1
end

function var_0_0._editableAddEvents(arg_12_0)
	return
end

function var_0_0._editableRemoveEvents(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

return var_0_0

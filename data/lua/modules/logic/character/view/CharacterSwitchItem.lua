module("modules.logic.character.view.CharacterSwitchItem", package.seeall)

local var_0_0 = class("CharacterSwitchItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorandom = gohelper.findChild(arg_1_0.viewGO, "#go_random")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "#go_normal")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_normal/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_normal/#txt_name")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "#go_selected")

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
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0.viewGO)
end

function var_0_0._editableAddEvents(arg_5_0)
	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
end

function var_0_0._editableRemoveEvents(arg_6_0)
	arg_6_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_7_0)
	if arg_7_0._isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)
	arg_7_0._view:selectCell(arg_7_0._index, true)
	CharacterController.instance:dispatchEvent(CharacterEvent.SwitchHero, {
		arg_7_0._heroId,
		arg_7_0._skinId,
		arg_7_0._mo.isRandom
	})
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1
	arg_8_0._skinId = arg_8_0._mo.skinId
	arg_8_0._heroId = nil

	gohelper.setActive(arg_8_0._gorandom, arg_8_0._mo.isRandom)
	gohelper.setActive(arg_8_0._gonormal, not arg_8_0._mo.isRandom)

	if arg_8_0._mo.isRandom then
		return
	end

	arg_8_0._config = arg_8_0._mo.heroMO.config
	arg_8_0._heroId = arg_8_0._mo.heroMO.heroId
	arg_8_0._txtname.text = arg_8_0._config.name

	arg_8_0._simageicon:LoadImage(ResUrl.getHeadIconSmall(arg_8_0._skinId))
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	arg_9_0._isSelect = arg_9_1

	arg_9_0._goselected:SetActive(arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageicon:UnLoadImage()
end

return var_0_0

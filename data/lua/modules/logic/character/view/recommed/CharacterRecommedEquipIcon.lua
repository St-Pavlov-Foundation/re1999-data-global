module("modules.logic.character.view.recommed.CharacterRecommedEquipIcon", package.seeall)

local var_0_0 = class("CharacterRecommedEquipIcon", ListScrollCell)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare2 = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare2")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "clickarea")

	arg_1_0._btnclick = SLFramework.UGUI.UIClickListener.Get(var_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if arg_4_0._clickCB and arg_4_0._clickCBobj then
		arg_4_0._clickCB(arg_4_0._clickCBobj)
	end
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0._equipId = arg_7_1

	local var_7_0 = EquipConfig.instance:getEquipCo(arg_7_0._equipId)

	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(var_7_0.rare))
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagerare2, "bgequip" .. tostring(ItemEnum.Color[var_7_0.rare]))
	arg_7_0._simageicon:LoadImage(ResUrl.getEquipIcon(var_7_0.icon))
	ZProj.UGUIHelper.SetGrayscale(arg_7_0._simageicon.gameObject, not EquipModel.instance:haveEquip(arg_7_0._equipId))
end

function var_0_0.setClickCallback(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._clickCB = arg_8_1
	arg_8_0._clickCBobj = arg_8_2
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0._simageicon:UnLoadImage()
end

return var_0_0

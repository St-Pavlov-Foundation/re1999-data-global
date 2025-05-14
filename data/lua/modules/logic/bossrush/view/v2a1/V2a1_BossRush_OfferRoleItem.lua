module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleItem", package.seeall)

local var_0_0 = class("V2a1_BossRush_OfferRoleItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "role/#image_rare")
	arg_1_0._simageheroicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "role/#image_career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "role/#txt_name")
	arg_1_0._txtnameEn = gohelper.findChildText(arg_1_0.viewGO, "role/#txt_name/#txt_nameEn")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#go_click")

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
	arg_4_0._uiclick = SLFramework.UGUI.UIClickListener.Get(arg_4_0._goclick)

	arg_4_0._uiclick:AddClickListener(arg_4_0._btnclickOnClick, arg_4_0)
end

function var_0_0._btnclickOnClick(arg_5_0)
	BossRushEnhanceRoleViewListModel.instance:setSelect(arg_5_0._mo.characterId)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:_refreshItem()
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._goselect, arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageheroicon:UnLoadImage()
	arg_10_0._uiclick:RemoveClickListener()
end

function var_0_0._refreshItem(arg_11_0)
	local var_11_0 = arg_11_0._mo.characterId
	local var_11_1 = HeroConfig.instance:getHeroCO(var_11_0)
	local var_11_2 = var_11_1.skinId
	local var_11_3 = SkinConfig.instance:getSkinCo(var_11_2)

	arg_11_0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(var_11_3.headIcon))

	arg_11_0._txtname.text = var_11_1.name
	arg_11_0._txtnameEn.text = var_11_1.nameEng

	UISpriteSetMgr.instance:setCommonSprite(arg_11_0._imagecareer, "lssx_" .. var_11_1.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_11_0._imagerare, "bgequip" .. CharacterEnum.Color[var_11_1.rare])
end

return var_0_0

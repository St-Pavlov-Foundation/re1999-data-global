module("modules.logic.versionactivity1_5.aizila.view.AiZiLaGoodsItem", package.seeall)

local var_0_0 = class("AiZiLaGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "#image_rare")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._imageselected = gohelper.findChildImage(arg_1_0.viewGO, "#image_selected")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_count")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_0.viewGO, "#go_count/#txt_count")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._goredPoint = gohelper.findChild(arg_1_0.viewGO, "#go_redPiont")
	arg_1_0._imagecountBG = gohelper.findChildImage(arg_1_0.viewGO, "#go_count")
	arg_1_0._singleicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#image_icon")

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
	if arg_4_0._itemId then
		MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.V1a5AiZiLa, arg_4_0._itemId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._imageselected, false)
	arg_5_0:setShowCount(true)
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:setItemId(arg_8_1.itemId)

	if arg_8_1.quantity or arg_8_1.getQuantity then
		local var_8_0 = arg_8_1.quantity or arg_8_1:getQuantity()

		arg_8_0:setCountStr(var_8_0)
	end
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._imageselected, arg_9_1)
end

function var_0_0.setItemId(arg_10_0, arg_10_1)
	arg_10_0._itemId = arg_10_1

	arg_10_0:_refreshIcon(arg_10_1)
end

function var_0_0.setShowCount(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._isShow ~= arg_11_1 then
		arg_11_0._isShow = arg_11_1

		gohelper.setActive(arg_11_0._gocount, arg_11_1)
	end

	if arg_11_2 == true then
		arg_11_0._imagecountBG.enabled = true
	elseif arg_11_2 == false then
		arg_11_0._imagecountBG.enabled = false
	end
end

function var_0_0.setCountStr(arg_12_0, arg_12_1)
	arg_12_0._txtcount.text = arg_12_1
end

function var_0_0._refreshIcon(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or arg_13_0._itemId

	if arg_13_1 ~= arg_13_0._lastItemId then
		local var_13_0 = AiZiLaConfig.instance:getItemCo(arg_13_1)

		if var_13_0 then
			arg_13_0._lastItemId = arg_13_1

			arg_13_0._singleicon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(var_13_0.icon))
			UISpriteSetMgr.instance:setV1a5AiZiLaSprite(arg_13_0._imagerare, AiZiLaEnum.RareIcon[var_13_0.rare])
		end
	end
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0._singleicon:UnLoadImage()
end

var_0_0.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem.prefab"
var_0_0.prefabPath2 = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_goodsitem2.prefab"

return var_0_0

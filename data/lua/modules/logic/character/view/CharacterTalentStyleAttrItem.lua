module("modules.logic.character.view.CharacterTalentStyleAttrItem", package.seeall)

local var_0_0 = class("CharacterTalentStyleAttrItem", LuaCompBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._gonew = gohelper.findChild(arg_1_0.viewGO, "#go_new")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_num")
	arg_1_0._txtchange = gohelper.findChildText(arg_1_0.viewGO, "#txt_name/#txt_num/#txt_change")
	arg_1_0._imagechange = gohelper.findChildImage(arg_1_0.viewGO, "#txt_name/#txt_num/#image_change")
	arg_1_0._godelete = gohelper.findChild(arg_1_0.viewGO, "#go_delete")

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

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0.viewGO = arg_5_1

	arg_5_0:onInitView()

	arg_5_0._canvasgroup = arg_5_1:GetComponent(typeof(UnityEngine.CanvasGroup))
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0:addEvents()
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0:removeEvents()
end

function var_0_0.onStart(arg_8_0)
	return
end

function var_0_0.onDestroy(arg_9_0)
	return
end

function var_0_0.onRefreshMo(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_10_2.key))
	local var_10_1
	local var_10_2 = arg_10_2.isDelete and 0 or arg_10_2.value

	if var_10_0.type ~= 1 then
		var_10_1 = var_10_2 * 0.1 .. "%"
	else
		var_10_1 = math.floor(var_10_2)
	end

	arg_10_0._txtnum.text = var_10_1
	arg_10_0._txtname.text = var_10_0.name

	gohelper.setActive(arg_10_0._gobg.gameObject, arg_10_1 % 2 == 0)
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imageicon, "icon_att_" .. var_10_0.id, true)
	arg_10_0:_showAttrChage(arg_10_2)
end

function var_0_0._showAttrChage(arg_11_0, arg_11_1)
	local var_11_0 = 0

	if arg_11_1.isNew then
		var_11_0 = 3
	end

	if arg_11_1.isDelete then
		var_11_0 = 4
	end

	if arg_11_1.changeNum then
		var_11_0 = arg_11_1.changeNum > 0 and 1 or 2
	end

	local var_11_1 = CharacterTalentStyleEnum.AttrChange[var_11_0]

	arg_11_0._txtnum.color = GameUtil.parseColor(var_11_1.NumColor)

	local var_11_2 = not string.nilorempty(var_11_1.ChangeImage)

	if var_11_2 then
		UISpriteSetMgr.instance:setUiCharacterSprite(arg_11_0._imagechange, var_11_1.ChangeImage)
	end

	gohelper.setActive(arg_11_0._imagechange.gameObject, var_11_2)

	local var_11_3 = not string.nilorempty(var_11_1.ChangeText)

	if var_11_3 then
		arg_11_0._txtchange.text = var_11_1.ChangeText
		arg_11_0._txtchange.color = GameUtil.parseColor(var_11_1.ChangeColor)
	end

	local var_11_4 = var_11_1.Alpha or 1

	arg_11_0._canvasgroup.alpha = var_11_4

	gohelper.setActive(arg_11_0._txtchange.gameObject, var_11_3)
	gohelper.setActive(arg_11_0._gonew.gameObject, arg_11_1.isNew)
	gohelper.setActive(arg_11_0._godelete.gameObject, arg_11_1.isDelete)
end

return var_0_0

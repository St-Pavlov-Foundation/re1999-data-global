module("modules.logic.fight.view.FightAttributeTipView", package.seeall)

local var_0_0 = class("FightAttributeTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goattributetipcontent = gohelper.findChild(arg_1_0.viewGO, "main/bg/content")
	arg_1_0.attrList = {
		"attack",
		"technic",
		"defense",
		"mdefense"
	}

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

function var_0_0.onClickModalMask(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onReceiveEntityInfoReply(arg_6_0, arg_6_1)
	arg_6_0._proto = arg_6_1

	if not arg_6_0._proto.entityInfo then
		arg_6_0:closeThis()

		return
	end

	local var_6_0 = arg_6_0.viewParam.data

	arg_6_0.isCharacter = arg_6_0.viewParam.isCharacter
	arg_6_0.attrMO = arg_6_0.viewParam.mo

	if arg_6_0.isCharacter then
		gohelper.CreateObjList(arg_6_0, arg_6_0._onAttributeTipShow, var_6_0, arg_6_0._goattributetipcontent)
	else
		gohelper.CreateObjList(arg_6_0, arg_6_0._onMonsterAttrItemShow, var_6_0, arg_6_0._goattributetipcontent)
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(FightController.instance, FightEvent.onReceiveEntityInfoReply, arg_7_0._onReceiveEntityInfoReply, arg_7_0)
	FightRpc.instance:sendEntityInfoRequest(arg_7_0.viewParam.entityMO.id)
end

function var_0_0._onAttributeTipShow(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1.transform
	local var_8_1 = var_8_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_8_2 = var_8_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_8_3 = HeroConfig.instance:getHeroAttributeCO(arg_8_2.id)

	UISpriteSetMgr.instance:setCommonSprite(var_8_1, "icon_att_" .. var_8_3.id)

	local var_8_4 = var_8_0:Find("num"):GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(var_8_4.gameObject, true)

	local var_8_5 = arg_8_0._proto.entityInfo.baseAttr[arg_8_0.attrList[arg_8_3]]

	var_8_4.text = var_8_5
	var_8_2.text = var_8_3.name

	do return end

	var_8_0:Find("add"):GetComponent(gohelper.Type_TextMesh).text = arg_8_0:_getAddValueStr(var_8_5, arg_8_0._proto.entityInfo.attr[arg_8_0.attrList[arg_8_3]])
end

function var_0_0._getAddValueStr(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2 - arg_9_1

	if var_9_0 >= 0 then
		return "+" .. var_9_0
	end

	return var_9_0
end

function var_0_0._onMonsterAttrItemShow(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_1.transform
	local var_10_1 = var_10_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_10_2 = var_10_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_10_3 = HeroConfig.instance:getHeroAttributeCO(arg_10_2.id)

	var_10_2.text = var_10_3.name

	UISpriteSetMgr.instance:setCommonSprite(var_10_1, "icon_att_" .. var_10_3.id)

	local var_10_4 = var_10_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_10_5 = var_10_0:Find("add"):GetComponent(gohelper.Type_TextMesh)
	local var_10_6 = var_10_0:Find("rate"):GetComponent(gohelper.Type_Image)

	if arg_10_0.isCharacter then
		gohelper.setActive(var_10_4.gameObject, true)
		gohelper.setActive(var_10_5.gameObject, true)
		gohelper.setActive(var_10_6.gameObject, false)

		local var_10_7 = arg_10_0._proto.entityInfo.baseAttr[arg_10_0.attrList[arg_10_3]]

		var_10_4.text = arg_10_0.attrMo[arg_10_0.attrList[arg_10_3]]
		var_10_5.text = arg_10_0:_getAddValueStr(var_10_7, arg_10_0._proto.entityInfo.attr[arg_10_0.attrList[arg_10_3]])
	else
		gohelper.setActive(var_10_4.gameObject, false)
		gohelper.setActive(var_10_5.gameObject, false)
		gohelper.setActive(var_10_6.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(var_10_6, "sx_" .. arg_10_2.value, true)
	end
end

return var_0_0

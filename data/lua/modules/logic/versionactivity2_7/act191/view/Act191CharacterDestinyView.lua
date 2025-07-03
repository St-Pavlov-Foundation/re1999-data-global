module("modules.logic.versionactivity2_7.act191.view.Act191CharacterDestinyView", package.seeall)

local var_0_0 = class("Act191CharacterDestinyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_icon")
	arg_1_0._txtstonename = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_stonename")
	arg_1_0._simagestone = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/go_stone/#simage_stone")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

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
	arg_4_0._goeffect = gohelper.findChild(arg_4_0.viewGO, "root/effectItem")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0.config = arg_6_0.viewParam.config
	arg_6_0.stoneId = arg_6_0.viewParam.stoneId
	arg_6_0._levelCos = CharacterDestinyConfig.instance:getDestinyFacetCo(arg_6_0.stoneId)
	arg_6_0.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_6_0.stoneId)
	arg_6_0._effectItems = arg_6_0:getUserDataTb_()

	for iter_6_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_6_0 = gohelper.findChild(arg_6_0._goeffect, iter_6_0)
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.go = var_6_0
		var_6_1.txt = gohelper.findChildText(var_6_0, "txt_dec")
		var_6_1.canvasgroup = var_6_0:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_6_0._effectItems[iter_6_0] = var_6_1
	end

	arg_6_0:_refreshStoneItem()
end

function var_0_0._refreshStoneItem(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._effectItems) do
		local var_7_0 = arg_7_0._levelCos[iter_7_0]

		iter_7_1.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(iter_7_1.txt.gameObject, Act191SkillDescComp)

		iter_7_1.skillDesc:updateInfo(iter_7_1.txt, var_7_0.desc, arg_7_0.config)
		iter_7_1.skillDesc:setTipParam(0, Vector2(300, 100))
	end

	arg_7_0._txtstonename.text = arg_7_0.conusmeCo.name

	local var_7_1 = ResUrl.getDestinyIcon(arg_7_0.conusmeCo.icon)

	arg_7_0._simagestone:LoadImage(var_7_1)

	local var_7_2 = CharacterDestinyEnum.SlotTend[arg_7_0.conusmeCo.tend]
	local var_7_3 = var_7_2.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(arg_7_0._imageicon, var_7_3)

	arg_7_0._txtstonename.color = GameUtil.parseColor(var_7_2.TitleColor)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterDestinyView", package.seeall)

local var_0_0 = class("Act191CharacterDestinyView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/#image_icon")
	arg_1_0._txtstonename = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_stonename")
	arg_1_0._simagestone = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/go_stone/#simage_stone")
	arg_1_0._goprestone = gohelper.findChild(arg_1_0.viewGO, "root/#go_prestone")
	arg_1_0._btnprestone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_prestone/#btn_prestone")
	arg_1_0._gonextstone = gohelper.findChild(arg_1_0.viewGO, "root/#go_nextstone")
	arg_1_0._btnnextstone = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_nextstone/#btn_nextstone")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "root/btn/#go_select")
	arg_1_0._btnselect = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btn/#go_select/#btn_select")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnprestone:AddClickListener(arg_2_0._btnprestoneOnClick, arg_2_0)
	arg_2_0._btnnextstone:AddClickListener(arg_2_0._btnnextstoneOnClick, arg_2_0)
	arg_2_0._btnselect:AddClickListener(arg_2_0._btnselectOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnprestone:RemoveClickListener()
	arg_3_0._btnnextstone:RemoveClickListener()
	arg_3_0._btnselect:RemoveClickListener()
end

function var_0_0._btnprestoneOnClick(arg_4_0)
	if arg_4_0.selectIndex > 1 then
		arg_4_0.selectIndex = arg_4_0.selectIndex - 1
	end

	arg_4_0:refreshUI()
end

function var_0_0._btnnextstoneOnClick(arg_5_0)
	if arg_5_0.selectIndex < #arg_5_0.stoneIds then
		arg_5_0.selectIndex = arg_5_0.selectIndex + 1
	end

	arg_5_0:refreshUI()
end

function var_0_0._btnselectOnClick(arg_6_0)
	Activity191Rpc.instance:sendSelect191UseHeroFacetsIdRequest(arg_6_0.actId, arg_6_0.config.roleId, arg_6_0.stoneId, arg_6_0.onSwitchStone, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = Activity191Model.instance:getCurActId()
	arg_7_0._goeffect = gohelper.findChild(arg_7_0.viewGO, "root/effectItem")
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.config = arg_8_0.viewParam
	arg_8_0.stoneIds = string.splitToNumber(arg_8_0.config.facetsId, "#")
	arg_8_0.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	arg_8_0.equippingStoneId = arg_8_0.gameInfo:getStoneId(arg_8_0.config)
	arg_8_0.selectIndex = tabletool.indexOf(arg_8_0.stoneIds, arg_8_0.equippingStoneId)

	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0.stoneId = arg_9_0.stoneIds[arg_9_0.selectIndex]

	gohelper.setActive(arg_9_0._goprestone, arg_9_0.selectIndex > 1)
	gohelper.setActive(arg_9_0._gonextstone, arg_9_0.selectIndex < #arg_9_0.stoneIds)
	gohelper.setActive(arg_9_0._goselect, arg_9_0.stoneId ~= arg_9_0.equippingStoneId)

	arg_9_0._levelCos = CharacterDestinyConfig.instance:getDestinyFacetCo(arg_9_0.stoneId)
	arg_9_0.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(arg_9_0.stoneId)
	arg_9_0._effectItems = arg_9_0:getUserDataTb_()

	for iter_9_0 = 1, CharacterDestinyEnum.EffectItemCount do
		local var_9_0 = gohelper.findChild(arg_9_0._goeffect, iter_9_0)
		local var_9_1 = arg_9_0:getUserDataTb_()

		var_9_1.go = var_9_0
		var_9_1.txt = gohelper.findChildText(var_9_0, "txt_dec")
		var_9_1.canvasgroup = var_9_0:GetComponent(typeof(UnityEngine.CanvasGroup))
		arg_9_0._effectItems[iter_9_0] = var_9_1
	end

	arg_9_0:_refreshStoneItem()
end

function var_0_0._refreshStoneItem(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._effectItems) do
		local var_10_0 = arg_10_0._levelCos[iter_10_0]

		iter_10_1.skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(iter_10_1.txt.gameObject, Act191SkillDescComp)

		iter_10_1.skillDesc:updateInfo(iter_10_1.txt, var_10_0.desc, arg_10_0.config)
		iter_10_1.skillDesc:setTipParam(0, Vector2(300, 100))
	end

	arg_10_0._txtstonename.text = arg_10_0.conusmeCo.name

	local var_10_1 = ResUrl.getDestinyIcon(arg_10_0.conusmeCo.icon)

	arg_10_0._simagestone:LoadImage(var_10_1)

	local var_10_2 = CharacterDestinyEnum.SlotTend[arg_10_0.conusmeCo.tend]
	local var_10_3 = var_10_2.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(arg_10_0._imageicon, var_10_3)

	arg_10_0._txtstonename.color = GameUtil.parseColor(var_10_2.TitleColor)
end

function var_0_0.onSwitchStone(arg_11_0)
	arg_11_0.equippingStoneId = arg_11_0.gameInfo:getStoneId(arg_11_0.config)

	arg_11_0:refreshUI()
end

return var_0_0

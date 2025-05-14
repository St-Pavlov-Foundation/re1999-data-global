module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessCard", package.seeall)

local var_0_0 = class("AutoChessCard", LuaCompBase)

var_0_0.ShowType = {
	Buy = 1,
	ForcePick = 3,
	Sell = 2
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._imageBg = gohelper.findChildImage(arg_1_1, "critters/image_bg")
	arg_1_0._goMesh = gohelper.findChild(arg_1_1, "critters/Mesh")
	arg_1_0._txtName = gohelper.findChildText(arg_1_1, "critters/#txt_Name")
	arg_1_0._imageType = gohelper.findChildImage(arg_1_1, "critters/#image_Type")
	arg_1_0._txtType = gohelper.findChildText(arg_1_1, "critters/#image_Type/#txt_Type")
	arg_1_0._goHp = gohelper.findChild(arg_1_1, "#go_Hp")
	arg_1_0._txtHp = gohelper.findChildText(arg_1_1, "#go_Hp/#txt_Hp")
	arg_1_0._goAttack = gohelper.findChild(arg_1_1, "#go_Attack")
	arg_1_0._txtAttack = gohelper.findChildText(arg_1_1, "#go_Attack/#txt_Attack")
	arg_1_0._goLevel = gohelper.findChild(arg_1_1, "#go_Level")
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_1, "#go_Level/#image_Level")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_1, "#go_Level/#txt_Level")
	arg_1_0._goStar = gohelper.findChild(arg_1_1, "#go_Level/#go_Star")
	arg_1_0._goStar1 = gohelper.findChild(arg_1_1, "#go_Level/#go_Star/#go_Star1")
	arg_1_0._goLight1 = gohelper.findChildImage(arg_1_1, "#go_Level/#go_Star/#go_Star1/#go_Light1")
	arg_1_0._goStar2 = gohelper.findChild(arg_1_1, "#go_Level/#go_Star/#go_Star2")
	arg_1_0._goLight2 = gohelper.findChildImage(arg_1_1, "#go_Level/#go_Star/#go_Star2/#go_Light2")
	arg_1_0._goStar3 = gohelper.findChild(arg_1_1, "#go_Level/#go_Star/#go_Star3")
	arg_1_0._goLight3 = gohelper.findChildImage(arg_1_1, "#go_Level/#go_Star/#go_Star3/#go_Light3")
	arg_1_0._txtSkillDesc = gohelper.findChildText(arg_1_1, "scroll_desc/viewport/#txt_SkillDesc")
	arg_1_0._imageTag = gohelper.findChildImage(arg_1_1, "#image_Tag")
	arg_1_0._btnSell = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_Sell")
	arg_1_0._txtSellCoin = gohelper.findChildText(arg_1_1, "#btn_Sell/#txt_SellCoin")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_Buy")
	arg_1_0._txtBuyCost = gohelper.findChildText(arg_1_1, "#btn_Buy/#txt_BuyCost")
	arg_1_0._imageBuyCost = gohelper.findChildImage(arg_1_1, "#btn_Buy/#txt_BuyCost/#image_BuyCost")
	arg_1_0._goNotEnough = gohelper.findChild(arg_1_1, "#btn_Buy/#go_notEnough")
	arg_1_0._btnFree = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_Free")
	arg_1_0._btnFull = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_Full")
	arg_1_0._txtBuyCost1 = gohelper.findChildText(arg_1_1, "#btn_Full/#txt_BuyCost1")
	arg_1_0._imageBuyCost1 = gohelper.findChildImage(arg_1_1, "#btn_Full/#txt_BuyCost1/#image_BuyCost1")
	arg_1_0._btnSelect = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_Select")
	arg_1_0._goSkillTip = gohelper.findChild(arg_1_1, "#go_SkillTip")
	arg_1_0._btnCloseTip = gohelper.findChildButtonWithAudio(arg_1_1, "#go_SkillTip/#btn_CloseTip")
	arg_1_0._txtSkillTipTitle = gohelper.findChildText(arg_1_1, "#go_SkillTip/#txt_SkillTipTitle")
	arg_1_0._txtSkillTip = gohelper.findChildText(arg_1_1, "#go_SkillTip/scroll_tips/viewport/#txt_SkillTip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnSell:AddClickListener(arg_2_0._btnSellOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
	arg_2_0._btnFree:AddClickListener(arg_2_0._btnFreeOnClick, arg_2_0)
	arg_2_0._btnFull:AddClickListener(arg_2_0._btnFullOnClick, arg_2_0)
	arg_2_0._btnSelect:AddClickListener(arg_2_0._btnSelectOnClick, arg_2_0)
	arg_2_0._btnCloseTip:AddClickListener(arg_2_0._btnCloseTipOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnSell:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnFree:RemoveClickListener()
	arg_3_0._btnFull:RemoveClickListener()
	arg_3_0._btnSelect:RemoveClickListener()
	arg_3_0._btnCloseTip:RemoveClickListener()
end

function var_0_0._btnSellOnClick(arg_4_0)
	local var_4_0 = AutoChessModel.instance:getCurModuleId()
	local var_4_1 = arg_4_0.param.entity
	local var_4_2 = var_4_1.warZone

	if AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableSale, var_4_1.data.id) then
		return
	end

	AutoChessRpc.instance:sendAutoChessBuildRequest(var_4_0, AutoChessEnum.BuildType.Sell, var_4_2, var_4_1.index, var_4_1.data.uid)
end

function var_0_0._btnBuyOnClick(arg_5_0)
	local var_5_0 = AutoChessModel.instance:getCurModuleId()

	if AutoChessController.instance:isClickDisable() then
		return
	end

	if arg_5_0.isFree or arg_5_0.costEnough then
		local var_5_1, var_5_2 = AutoChessModel.instance:getChessMo():getEmptyPos(arg_5_0.config.type)

		if not var_5_1 then
			GameFacade.showToast(ToastEnum.AutoChessBoardFull)

			return
		end

		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
		AutoChessRpc.instance:sendAutoChessBuyChessRequest(var_5_0, arg_5_0.param.mallId, arg_5_0.itemData.uid, var_5_1, var_5_2 - 1)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZBuyChess, arg_5_0.itemData.chess.id)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDrayChessToPos, string.format("%d_%d", arg_5_0.itemData.chess.id, var_5_1))

		if arg_5_0.isFree then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragFreeChess)
		end
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function var_0_0._btnFreeOnClick(arg_6_0)
	arg_6_0:_btnBuyOnClick()
end

function var_0_0._btnFullOnClick(arg_7_0)
	arg_7_0:_btnBuyOnClick()
end

function var_0_0._btnSelectOnClick(arg_8_0)
	local var_8_0 = AutoChessModel.instance:getCurModuleId()

	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)
	AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(var_8_0, arg_8_0.param.itemId)
end

function var_0_0._btnCloseTipOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._goSkillTip, false)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(arg_10_0._txtSkillDesc, arg_10_0.clcikHyperLink, arg_10_0)
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0.loader then
		arg_11_0.loader:dispose()

		arg_11_0.loader = nil
	end
end

function var_0_0.setData(arg_12_0, arg_12_1)
	arg_12_0.param = arg_12_1

	local var_12_0 = arg_12_0.param.type

	if var_12_0 == var_0_0.ShowType.Sell then
		arg_12_0:refreshSell()
	elseif var_12_0 == var_0_0.ShowType.Buy then
		arg_12_0:refreshBuy()
	elseif var_12_0 == var_0_0.ShowType.ForcePick then
		arg_12_0:refreshForcePick()
	end

	arg_12_0:refreshLevelStar()

	if arg_12_0.config.type == AutoChessStrEnum.ChessType.Support then
		UISpriteSetMgr.instance:setAutoChessSprite(arg_12_0._imageBg, "v2a5_autochess_quality2_" .. arg_12_0.config.levelFromMall)
		gohelper.setActive(arg_12_0._goHp, false)
		gohelper.setActive(arg_12_0._goAttack, false)
	else
		UISpriteSetMgr.instance:setAutoChessSprite(arg_12_0._imageBg, "v2a5_autochess_quality1_" .. arg_12_0.config.levelFromMall)
		gohelper.setActive(arg_12_0._goHp, true)
		gohelper.setActive(arg_12_0._goAttack, true)
	end
end

function var_0_0.refreshSell(arg_13_0)
	local var_13_0 = arg_13_0.param.entity.data

	arg_13_0.config = lua_auto_chess.configDict[var_13_0.id][var_13_0.star]

	local var_13_1 = arg_13_0.param.entity.teamType == AutoChessEnum.TeamType.Enemy

	arg_13_0.meshComp:setData(arg_13_0.config.image, var_13_1)

	local var_13_2 = AutoChessEnum.ConstKey.ChessSellPrice

	arg_13_0._txtSellCoin.text = lua_auto_chess_const.configDict[var_13_2].value
	arg_13_0._txtAttack.text = var_13_0.battle
	arg_13_0._txtHp.text = var_13_0.hp

	arg_13_0:refreshConfigAttr()
	gohelper.setActive(arg_13_0._btnSell, arg_13_0.param.entity.teamType == AutoChessEnum.TeamType.Player)
end

function var_0_0.refreshBuy(arg_14_0)
	arg_14_0.itemData = arg_14_0.param.data
	arg_14_0.config = lua_auto_chess.configDict[arg_14_0.itemData.chess.id][arg_14_0.itemData.chess.star]

	arg_14_0.meshComp:setData(arg_14_0.config.image)

	arg_14_0.isFree = lua_auto_chess_mall.configDict[arg_14_0.param.mallId].type == AutoChessEnum.MallType.Free
	arg_14_0._txtAttack.text = arg_14_0.itemData.chess.battle
	arg_14_0._txtHp.text = arg_14_0.itemData.chess.hp

	arg_14_0:refreshConfigAttr()

	local var_14_0 = AutoChessModel.instance:getChessMo()
	local var_14_1 = var_14_0:getEmptyPos(arg_14_0.config.type)
	local var_14_2, var_14_3 = AutoChessConfig.instance:getItemBuyCost(arg_14_0.itemData.id)

	if var_14_0.svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(arg_14_0.itemData.chess.battle) and AutoChessHelper.isPrimeNumber(arg_14_0.itemData.chess.hp) then
		var_14_3 = var_14_3 - 1
	end

	arg_14_0.costEnough = var_14_0:checkCostEnough(var_14_2, var_14_3)
	var_14_3 = arg_14_0.costEnough and var_14_3 or string.format("<color=#BD2C2C>%s</color>", var_14_3)

	local var_14_4 = "v2a5_autochess_cost" .. var_14_2

	if var_14_1 then
		if not arg_14_0.isFree then
			UISpriteSetMgr.instance:setAutoChessSprite(arg_14_0._imageBuyCost, var_14_4)

			arg_14_0._txtBuyCost.text = var_14_3

			gohelper.setActive(arg_14_0._goNotEnough, not arg_14_0.costEnough)
		end

		gohelper.setActive(arg_14_0._btnFull, false)
		gohelper.setActive(arg_14_0._btnFree, arg_14_0.isFree)
		gohelper.setActive(arg_14_0._btnBuy, not arg_14_0.isFree)
	else
		if arg_14_0.isFree then
			arg_14_0._txtBuyCost1.text = luaLang("p_autochesscard_txt_free")

			gohelper.setActive(arg_14_0._imageBuyCost1, false)
		else
			UISpriteSetMgr.instance:setAutoChessSprite(arg_14_0._imageBuyCost1, var_14_4)
			gohelper.setActive(arg_14_0._imageBuyCost1, true)

			arg_14_0._txtBuyCost1.text = var_14_3
		end

		gohelper.setActive(arg_14_0._btnFull, true)
		gohelper.setActive(arg_14_0._btnFree, false)
		gohelper.setActive(arg_14_0._btnBuy, false)
	end
end

function var_0_0.refreshForcePick(arg_15_0)
	arg_15_0.config = AutoChessConfig.instance:getChessCoByItemId(arg_15_0.param.itemId)

	arg_15_0.meshComp:setData(arg_15_0.config.image)

	arg_15_0._txtAttack.text = arg_15_0.config.attack
	arg_15_0._txtHp.text = arg_15_0.config.hp

	arg_15_0:refreshConfigAttr()
	gohelper.setActive(arg_15_0._btnSelect, true)
end

function var_0_0.refreshConfigAttr(arg_16_0)
	arg_16_0._txtName.text = arg_16_0.config.name
	arg_16_0._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(arg_16_0.config.skillDesc)

	local var_16_0 = lua_auto_chess_translate.configDict[arg_16_0.config.race]

	if var_16_0 then
		arg_16_0._txtType.text = var_16_0.name

		SLFramework.UGUI.GuiHelper.SetColor(arg_16_0._imageType, var_16_0.color)
		gohelper.setActive(arg_16_0._imageType, true)
		UISpriteSetMgr.instance:setAutoChessSprite(arg_16_0._imageTag, var_16_0.tagResName)
	else
		gohelper.setActive(arg_16_0._imageTag, false)
		gohelper.setActive(arg_16_0._imageType, false)
	end
end

function var_0_0.refreshLevelStar(arg_17_0)
	local var_17_0 = arg_17_0.param.type

	gohelper.setActive(arg_17_0._goLevel, var_17_0 == var_0_0.ShowType.Sell)

	if var_17_0 == var_0_0.ShowType.Sell then
		local var_17_1 = arg_17_0.param.entity.data
		local var_17_2 = luaLang("autochess_malllevelupview_level")

		UISpriteSetMgr.instance:setAutoChessSprite(arg_17_0._imageLevel, "v2a5_autochess_levelbg_" .. var_17_1.star)

		arg_17_0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_17_2, var_17_1.star)

		if var_17_1.maxExpLimit == 0 then
			gohelper.setActive(arg_17_0._goStar, false)

			return
		end

		for iter_17_0 = 1, 3 do
			local var_17_3 = arg_17_0["_goLight" .. iter_17_0]

			gohelper.setActive(var_17_3, iter_17_0 <= var_17_1.exp)

			local var_17_4 = arg_17_0["_goStar" .. iter_17_0]

			gohelper.setActive(var_17_4, iter_17_0 <= var_17_1.maxExpLimit)
		end
	end
end

function var_0_0.clcikHyperLink(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_0.param.type == var_0_0.ShowType.ForcePick then
		recthelper.setAnchor(arg_18_0._goSkillTip.transform, 0, 120)
		gohelper.setAsLastSibling(arg_18_0._go)
	end

	local var_18_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_18_1))

	if var_18_0 then
		arg_18_0._txtSkillTipTitle.text = var_18_0.name
		arg_18_0._txtSkillTip.text = var_18_0.desc

		gohelper.setActive(arg_18_0._goSkillTip, true)
	end
end

return var_0_0

module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessCard", package.seeall)

local var_0_0 = class("AutoChessCard", LuaCompBase)

var_0_0.ShowType = {
	HandBook = 4,
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
	arg_1_0._goArrow = gohelper.findChild(arg_1_1, "#go_arrow")
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
	arg_1_0._btnCheck = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_check")

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
	arg_2_0._btnCheck:AddClickListener(arg_2_0._btnCheckOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnSell:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnFree:RemoveClickListener()
	arg_3_0._btnFull:RemoveClickListener()
	arg_3_0._btnSelect:RemoveClickListener()
	arg_3_0._btnCloseTip:RemoveClickListener()
	arg_3_0._btnCheck:RemoveClickListener()
end

function var_0_0._btnSellOnClick(arg_4_0)
	local var_4_0 = AutoChessModel.instance.moduleId
	local var_4_1 = arg_4_0.param.entity
	local var_4_2 = var_4_1.warZone

	AutoChessRpc.instance:sendAutoChessBuildRequest(var_4_0, AutoChessEnum.BuildType.Sell, var_4_2, var_4_1.index, var_4_1.data.uid)
end

function var_0_0._btnBuyOnClick(arg_5_0)
	local var_5_0 = AutoChessModel.instance.moduleId
	local var_5_1 = AutoChessModel.instance:getChessMo()
	local var_5_2, var_5_3 = var_5_1:checkCostEnough(arg_5_0.costType, arg_5_0.cost)

	if arg_5_0.isFree or var_5_2 then
		local var_5_4, var_5_5 = var_5_1:getEmptyPos(arg_5_0.config.type)

		if not var_5_4 then
			GameFacade.showToast(ToastEnum.AutoChessBoardFull)

			return
		end

		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
		AutoChessRpc.instance:sendAutoChessBuyChessRequest(var_5_0, arg_5_0.param.mallId, arg_5_0.itemData.uid, var_5_4, var_5_5 - 1)
	else
		GameFacade.showToast(var_5_3)
	end
end

function var_0_0._btnFreeOnClick(arg_6_0)
	arg_6_0:_btnBuyOnClick()
end

function var_0_0._btnFullOnClick(arg_7_0)
	arg_7_0:_btnBuyOnClick()
end

function var_0_0._btnSelectOnClick(arg_8_0)
	local var_8_0 = AutoChessModel.instance.moduleId

	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)
	AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(var_8_0, arg_8_0.param.itemId)
end

function var_0_0._btnCloseTipOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._goSkillTip, false)
end

function var_0_0._btnCheckOnClick(arg_10_0)
	local var_10_0 = {
		chessId = arg_10_0.param.itemId
	}

	AutoChessController.instance:openAutoChessHandbookPreviewView(var_10_0)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_11_0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(arg_11_0._txtSkillDesc, arg_11_0.clcikHyperLink, arg_11_0)
end

function var_0_0.onDestroy(arg_12_0)
	if arg_12_0.loader then
		arg_12_0.loader:dispose()

		arg_12_0.loader = nil
	end
end

function var_0_0.setData(arg_13_0, arg_13_1)
	arg_13_0.param = arg_13_1

	local var_13_0 = arg_13_0.param.type

	if var_13_0 == var_0_0.ShowType.Sell then
		arg_13_0:refreshSell()
	elseif var_13_0 == var_0_0.ShowType.Buy then
		arg_13_0:refreshBuy()
	elseif var_13_0 == var_0_0.ShowType.ForcePick then
		arg_13_0:refreshForcePick()
	elseif var_13_0 == var_0_0.ShowType.HandBook then
		arg_13_0:refreshHandbook()
	end
end

function var_0_0.refreshSell(arg_14_0)
	local var_14_0 = arg_14_0.param.entity.data

	arg_14_0.config = AutoChessConfig.instance:getChessCfgById(var_14_0.id, var_14_0.star)

	local var_14_1 = arg_14_0.param.entity.teamType == AutoChessEnum.TeamType.Enemy

	arg_14_0.meshComp:setData(arg_14_0.config.image, var_14_1)

	local var_14_2 = AutoChessEnum.ConstKey.ChessSellPrice

	arg_14_0._txtSellCoin.text = lua_auto_chess_const.configDict[var_14_2].value
	arg_14_0._txtAttack.text = var_14_0.battle
	arg_14_0._txtHp.text = var_14_0.hp

	arg_14_0:refreshConfigAttr(var_14_0.cd)
	arg_14_0:refreshLevelStar()
	gohelper.setActive(arg_14_0._btnSell, arg_14_0.param.entity.teamType == AutoChessEnum.TeamType.Player)
end

function var_0_0.refreshBuy(arg_15_0)
	arg_15_0.itemData = arg_15_0.param.data
	arg_15_0.config = AutoChessConfig.instance:getChessCfgById(arg_15_0.itemData.chess.id, arg_15_0.itemData.chess.star)

	arg_15_0.meshComp:setData(arg_15_0.config.image)

	arg_15_0.isFree = lua_auto_chess_mall.configDict[arg_15_0.param.mallId].type == AutoChessEnum.MallType.Free
	arg_15_0._txtAttack.text = arg_15_0.itemData.chess.battle
	arg_15_0._txtHp.text = arg_15_0.itemData.chess.hp

	arg_15_0:refreshConfigAttr()

	local var_15_0 = AutoChessModel.instance:getChessMo()
	local var_15_1 = var_15_0:getEmptyPos(arg_15_0.config.type)

	if arg_15_0.isFree then
		arg_15_0.cost = 0

		if not var_15_1 then
			arg_15_0._txtBuyCost1.text = luaLang("p_autochesscard_txt_free")

			gohelper.setActive(arg_15_0._imageBuyCost1, false)
		end
	else
		arg_15_0.costType, arg_15_0.cost = AutoChessConfig.instance:getItemBuyCost(arg_15_0.itemData.id)

		if arg_15_0.cost >= 1 and var_15_0.svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(arg_15_0.itemData.chess.battle) and AutoChessHelper.isPrimeNumber(arg_15_0.itemData.chess.hp) then
			arg_15_0.cost = arg_15_0.cost - 1
		end

		local var_15_2 = var_15_0:checkCostEnough(arg_15_0.costType, arg_15_0.cost)
		local var_15_3 = var_15_2 and arg_15_0.cost or string.format("<color=#BD2C2C>%s</color>", arg_15_0.cost)
		local var_15_4 = "v2a5_autochess_cost" .. arg_15_0.costType

		if var_15_1 then
			UISpriteSetMgr.instance:setAutoChessSprite(arg_15_0._imageBuyCost, var_15_4)

			arg_15_0._txtBuyCost.text = var_15_3

			gohelper.setActive(arg_15_0._goNotEnough, not var_15_2)
		else
			UISpriteSetMgr.instance:setAutoChessSprite(arg_15_0._imageBuyCost1, var_15_4)
			gohelper.setActive(arg_15_0._imageBuyCost1, true)

			arg_15_0._txtBuyCost1.text = var_15_3
		end
	end

	if var_15_1 then
		gohelper.setActive(arg_15_0._btnFull, false)
		gohelper.setActive(arg_15_0._btnFree, arg_15_0.isFree)
		gohelper.setActive(arg_15_0._btnBuy, not arg_15_0.isFree)
	else
		gohelper.setActive(arg_15_0._btnFull, true)
		gohelper.setActive(arg_15_0._btnFree, false)
		gohelper.setActive(arg_15_0._btnBuy, false)
	end
end

function var_0_0.refreshForcePick(arg_16_0)
	local var_16_0 = lua_auto_chess_mall_item.configDict[arg_16_0.param.itemId]
	local var_16_1 = string.splitToNumber(var_16_0.context, "#")

	arg_16_0.config = AutoChessConfig.instance:getChessCfgById(var_16_1[1], var_16_1[2])

	arg_16_0.meshComp:setData(arg_16_0.config.image)

	arg_16_0._txtAttack.text = arg_16_0.config.attack
	arg_16_0._txtHp.text = arg_16_0.config.hp

	arg_16_0:refreshConfigAttr()
	gohelper.setActive(arg_16_0._btnSelect, true)
end

function var_0_0.refreshHandbook(arg_17_0)
	local var_17_0 = arg_17_0.param.star
	local var_17_1 = AutoChessConfig.instance:getChessCfgById(arg_17_0.param.itemId)

	arg_17_0.config = var_17_1[var_17_0 and var_17_0 or next(var_17_1)]

	arg_17_0.meshComp:setData(arg_17_0.config.image)

	arg_17_0._txtAttack.text = arg_17_0.config.attack
	arg_17_0._txtHp.text = arg_17_0.config.hp

	arg_17_0:refreshConfigAttr()
	gohelper.setActive(arg_17_0._btnSelect, false)

	local var_17_2 = arg_17_0.param.arrow

	gohelper.setActive(arg_17_0._goArrow, var_17_2)
	gohelper.setActive(arg_17_0._btnCheck.gameObject, var_17_0 == nil)
	gohelper.setActive(arg_17_0._goLevel, var_17_0 ~= nil)

	if var_17_0 then
		local var_17_3 = luaLang("autochess_malllevelupview_level")

		UISpriteSetMgr.instance:setAutoChessSprite(arg_17_0._imageLevel, "v2a5_autochess_levelbg_" .. var_17_0)

		arg_17_0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_17_3, var_17_0)

		gohelper.setActive(arg_17_0._goStar, false)
	end
end

function var_0_0.refreshConfigAttr(arg_18_0, arg_18_1)
	arg_18_0._txtName.text = arg_18_0.config.name

	local var_18_0 = AutoChessHelper.buildSkillDesc(arg_18_0.config.skillDesc)

	if arg_18_1 and arg_18_1 ~= 0 then
		local var_18_1 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochesscard_growup_tip"), arg_18_1)

		arg_18_0._txtSkillDesc.text = string.format("%s%s", var_18_0, var_18_1)
	else
		arg_18_0._txtSkillDesc.text = var_18_0
	end

	local var_18_2 = lua_auto_chess_translate.configDict[arg_18_0.config.race]

	if var_18_2 then
		arg_18_0._txtType.text = var_18_2.name

		if string.nilorempty(var_18_2.color) then
			gohelper.setActive(arg_18_0._imageType, false)
		else
			SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._imageType, var_18_2.color)
			gohelper.setActive(arg_18_0._imageType, true)
		end

		if string.nilorempty(var_18_2.tagResName) then
			gohelper.setActive(arg_18_0._imageTag, false)
		else
			UISpriteSetMgr.instance:setAutoChessSprite(arg_18_0._imageTag, var_18_2.tagResName)
			gohelper.setActive(arg_18_0._imageTag, true)
		end
	end

	if arg_18_0.config.type == AutoChessStrEnum.ChessType.Attack then
		UISpriteSetMgr.instance:setAutoChessSprite(arg_18_0._imageBg, "v2a5_autochess_quality1_" .. arg_18_0.config.levelFromMall)
	elseif arg_18_0.config.type == AutoChessStrEnum.ChessType.Support then
		UISpriteSetMgr.instance:setAutoChessSprite(arg_18_0._imageBg, "v2a5_autochess_quality2_" .. arg_18_0.config.levelFromMall)
	else
		UISpriteSetMgr.instance:setAutoChessSprite(arg_18_0._imageBg, "autochess_leader_chessbg" .. arg_18_0.config.levelFromMall)
	end

	gohelper.setActive(arg_18_0._goHp, arg_18_0.config.type == AutoChessStrEnum.ChessType.Attack)
	gohelper.setActive(arg_18_0._goAttack, arg_18_0.config.type == AutoChessStrEnum.ChessType.Attack)
end

function var_0_0.refreshLevelStar(arg_19_0)
	local var_19_0 = arg_19_0.param.entity.data

	if var_19_0.star == 0 then
		return
	end

	local var_19_1 = luaLang("autochess_malllevelupview_level")

	UISpriteSetMgr.instance:setAutoChessSprite(arg_19_0._imageLevel, "v2a5_autochess_levelbg_" .. var_19_0.star)

	arg_19_0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_19_1, var_19_0.star)

	if var_19_0.maxExpLimit == 0 then
		gohelper.setActive(arg_19_0._goStar, false)
	else
		for iter_19_0 = 1, 3 do
			local var_19_2 = arg_19_0["_goLight" .. iter_19_0]

			gohelper.setActive(var_19_2, iter_19_0 <= var_19_0.exp)

			local var_19_3 = arg_19_0["_goStar" .. iter_19_0]

			gohelper.setActive(var_19_3, iter_19_0 <= var_19_0.maxExpLimit)
		end
	end

	gohelper.setActive(arg_19_0._goLevel, true)
end

function var_0_0.clcikHyperLink(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.param.type == var_0_0.ShowType.ForcePick then
		recthelper.setAnchor(arg_20_0._goSkillTip.transform, 0, 120)
		gohelper.setAsLastSibling(arg_20_0._go)
	elseif arg_20_0.param.type == var_0_0.ShowType.HandBook then
		recthelper.setAnchor(arg_20_0._goSkillTip.transform, 0, 129)
	end

	local var_20_0 = AutoChessConfig.instance:getSkillEffectDesc(tonumber(arg_20_1))

	if var_20_0 then
		arg_20_0._txtSkillTipTitle.text = var_20_0.name
		arg_20_0._txtSkillTip.text = var_20_0.desc

		gohelper.setActive(arg_20_0._goSkillTip, true)
	end
end

return var_0_0

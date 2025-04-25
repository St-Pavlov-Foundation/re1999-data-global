module("modules.logic.versionactivity2_5.autochess.view.comp.AutoChessCard", package.seeall)

slot0 = class("AutoChessCard", LuaCompBase)
slot0.ShowType = {
	Buy = 1,
	ForcePick = 3,
	Sell = 2
}

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._imageBg = gohelper.findChildImage(slot1, "critters/image_bg")
	slot0._goMesh = gohelper.findChild(slot1, "critters/Mesh")
	slot0._txtName = gohelper.findChildText(slot1, "critters/#txt_Name")
	slot0._imageType = gohelper.findChildImage(slot1, "critters/#image_Type")
	slot0._txtType = gohelper.findChildText(slot1, "critters/#image_Type/#txt_Type")
	slot0._goHp = gohelper.findChild(slot1, "#go_Hp")
	slot0._txtHp = gohelper.findChildText(slot1, "#go_Hp/#txt_Hp")
	slot0._goAttack = gohelper.findChild(slot1, "#go_Attack")
	slot0._txtAttack = gohelper.findChildText(slot1, "#go_Attack/#txt_Attack")
	slot0._goLevel = gohelper.findChild(slot1, "#go_Level")
	slot0._imageLevel = gohelper.findChildImage(slot1, "#go_Level/#image_Level")
	slot0._txtLevel = gohelper.findChildText(slot1, "#go_Level/#txt_Level")
	slot0._goStar = gohelper.findChild(slot1, "#go_Level/#go_Star")
	slot0._goStar1 = gohelper.findChild(slot1, "#go_Level/#go_Star/#go_Star1")
	slot0._goLight1 = gohelper.findChildImage(slot1, "#go_Level/#go_Star/#go_Star1/#go_Light1")
	slot0._goStar2 = gohelper.findChild(slot1, "#go_Level/#go_Star/#go_Star2")
	slot0._goLight2 = gohelper.findChildImage(slot1, "#go_Level/#go_Star/#go_Star2/#go_Light2")
	slot0._goStar3 = gohelper.findChild(slot1, "#go_Level/#go_Star/#go_Star3")
	slot0._goLight3 = gohelper.findChildImage(slot1, "#go_Level/#go_Star/#go_Star3/#go_Light3")
	slot0._txtSkillDesc = gohelper.findChildText(slot1, "scroll_desc/viewport/#txt_SkillDesc")
	slot0._imageTag = gohelper.findChildImage(slot1, "#image_Tag")
	slot0._btnSell = gohelper.findChildButtonWithAudio(slot1, "#btn_Sell")
	slot0._txtSellCoin = gohelper.findChildText(slot1, "#btn_Sell/#txt_SellCoin")
	slot0._btnBuy = gohelper.findChildButtonWithAudio(slot1, "#btn_Buy")
	slot0._txtBuyCost = gohelper.findChildText(slot1, "#btn_Buy/#txt_BuyCost")
	slot0._imageBuyCost = gohelper.findChildImage(slot1, "#btn_Buy/#txt_BuyCost/#image_BuyCost")
	slot0._goNotEnough = gohelper.findChild(slot1, "#btn_Buy/#go_notEnough")
	slot0._btnFree = gohelper.findChildButtonWithAudio(slot1, "#btn_Free")
	slot0._btnFull = gohelper.findChildButtonWithAudio(slot1, "#btn_Full")
	slot0._txtBuyCost1 = gohelper.findChildText(slot1, "#btn_Full/#txt_BuyCost1")
	slot0._imageBuyCost1 = gohelper.findChildImage(slot1, "#btn_Full/#txt_BuyCost1/#image_BuyCost1")
	slot0._btnSelect = gohelper.findChildButtonWithAudio(slot1, "#btn_Select")
	slot0._goSkillTip = gohelper.findChild(slot1, "#go_SkillTip")
	slot0._btnCloseTip = gohelper.findChildButtonWithAudio(slot1, "#go_SkillTip/#btn_CloseTip")
	slot0._txtSkillTipTitle = gohelper.findChildText(slot1, "#go_SkillTip/#txt_SkillTipTitle")
	slot0._txtSkillTip = gohelper.findChildText(slot1, "#go_SkillTip/scroll_tips/viewport/#txt_SkillTip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._btnSell:AddClickListener(slot0._btnSellOnClick, slot0)
	slot0._btnBuy:AddClickListener(slot0._btnBuyOnClick, slot0)
	slot0._btnFree:AddClickListener(slot0._btnFreeOnClick, slot0)
	slot0._btnFull:AddClickListener(slot0._btnFullOnClick, slot0)
	slot0._btnSelect:AddClickListener(slot0._btnSelectOnClick, slot0)
	slot0._btnCloseTip:AddClickListener(slot0._btnCloseTipOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnSell:RemoveClickListener()
	slot0._btnBuy:RemoveClickListener()
	slot0._btnFree:RemoveClickListener()
	slot0._btnFull:RemoveClickListener()
	slot0._btnSelect:RemoveClickListener()
	slot0._btnCloseTip:RemoveClickListener()
end

function slot0._btnSellOnClick(slot0)
	slot1 = AutoChessModel.instance:getCurModuleId()
	slot2 = slot0.param.entity
	slot3 = slot2.warZone

	if AutoChessController.instance:isDragDisable(GuideModel.GuideFlag.AutoChessEnableSale, slot2.data.id) then
		return
	end

	AutoChessRpc.instance:sendAutoChessBuildRequest(slot1, AutoChessEnum.BuildType.Sell, slot3, slot2.index, slot2.data.uid)
end

function slot0._btnBuyOnClick(slot0)
	slot1 = AutoChessModel.instance:getCurModuleId()

	if AutoChessController.instance:isClickDisable() then
		return
	end

	if slot0.isFree or slot0.costEnough then
		slot3, slot4 = AutoChessModel.instance:getChessMo():getEmptyPos(slot0.config.type)

		if not slot3 then
			GameFacade.showToast(ToastEnum.AutoChessBoardFull)

			return
		end

		AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
		AutoChessRpc.instance:sendAutoChessBuyChessRequest(slot1, slot0.param.mallId, slot0.itemData.uid, slot3, slot4 - 1)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZBuyChess, slot0.itemData.chess.id)
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDrayChessToPos, string.format("%d_%d", slot0.itemData.chess.id, slot3))

		if slot0.isFree then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.ZDragFreeChess)
		end
	else
		GameFacade.showToast(ToastEnum.AutoChessCoinNotEnough)
	end
end

function slot0._btnFreeOnClick(slot0)
	slot0:_btnBuyOnClick()
end

function slot0._btnFullOnClick(slot0)
	slot0:_btnBuyOnClick()
end

function slot0._btnSelectOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_award_get)
	AutoChessRpc.instance:sendAutoChessMallRegionSelectItemRequest(AutoChessModel.instance:getCurModuleId(), slot0.param.itemId)
end

function slot0._btnCloseTipOnClick(slot0)
	gohelper.setActive(slot0._goSkillTip, false)
end

function slot0._editableInitView(slot0)
	slot0.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(slot0._txtSkillDesc, slot0.clcikHyperLink, slot0)
end

function slot0.onDestroy(slot0)
	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

function slot0.setData(slot0, slot1)
	slot0.param = slot1

	if slot0.param.type == uv0.ShowType.Sell then
		slot0:refreshSell()
	elseif slot2 == uv0.ShowType.Buy then
		slot0:refreshBuy()
	elseif slot2 == uv0.ShowType.ForcePick then
		slot0:refreshForcePick()
	end

	slot0:refreshLevelStar()

	if slot0.config.type == AutoChessStrEnum.ChessType.Support then
		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageBg, "v2a5_autochess_quality2_" .. slot0.config.levelFromMall)
		gohelper.setActive(slot0._goHp, false)
		gohelper.setActive(slot0._goAttack, false)
	else
		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageBg, "v2a5_autochess_quality1_" .. slot0.config.levelFromMall)
		gohelper.setActive(slot0._goHp, true)
		gohelper.setActive(slot0._goAttack, true)
	end
end

function slot0.refreshSell(slot0)
	slot1 = slot0.param.entity.data
	slot0.config = lua_auto_chess.configDict[slot1.id][slot1.star]

	slot0.meshComp:setData(slot0.config.image, slot0.param.entity.teamType == AutoChessEnum.TeamType.Enemy)

	slot0._txtSellCoin.text = lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.ChessSellPrice].value
	slot0._txtAttack.text = slot1.battle
	slot0._txtHp.text = slot1.hp

	slot0:refreshConfigAttr()
	gohelper.setActive(slot0._btnSell, slot0.param.entity.teamType == AutoChessEnum.TeamType.Player)
end

function slot0.refreshBuy(slot0)
	slot0.itemData = slot0.param.data
	slot0.config = lua_auto_chess.configDict[slot0.itemData.chess.id][slot0.itemData.chess.star]

	slot0.meshComp:setData(slot0.config.image)

	slot0.isFree = lua_auto_chess_mall.configDict[slot0.param.mallId].type == AutoChessEnum.MallType.Free
	slot0._txtAttack.text = slot0.itemData.chess.battle
	slot0._txtHp.text = slot0.itemData.chess.hp

	slot0:refreshConfigAttr()

	slot2 = AutoChessModel.instance:getChessMo()
	slot3 = slot2:getEmptyPos(slot0.config.type)
	slot4, slot5 = AutoChessConfig.instance:getItemBuyCost(slot0.itemData.id)

	if slot2.svrFight.mySideMaster.id == AutoChessEnum.SpecialMaster.Role37 and AutoChessHelper.isPrimeNumber(slot0.itemData.chess.battle) and AutoChessHelper.isPrimeNumber(slot0.itemData.chess.hp) then
		slot5 = slot5 - 1
	end

	slot0.costEnough = slot2:checkCostEnough(slot4, slot5)

	if slot3 then
		if not slot0.isFree then
			UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageBuyCost, "v2a5_autochess_cost" .. slot4)

			slot0._txtBuyCost.text = slot0.costEnough and slot5 or string.format("<color=#BD2C2C>%s</color>", slot5)

			gohelper.setActive(slot0._goNotEnough, not slot0.costEnough)
		end

		gohelper.setActive(slot0._btnFull, false)
		gohelper.setActive(slot0._btnFree, slot0.isFree)
		gohelper.setActive(slot0._btnBuy, not slot0.isFree)
	else
		if slot0.isFree then
			slot0._txtBuyCost1.text = luaLang("p_autochesscard_txt_free")

			gohelper.setActive(slot0._imageBuyCost1, false)
		else
			UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageBuyCost1, slot6)
			gohelper.setActive(slot0._imageBuyCost1, true)

			slot0._txtBuyCost1.text = slot5
		end

		gohelper.setActive(slot0._btnFull, true)
		gohelper.setActive(slot0._btnFree, false)
		gohelper.setActive(slot0._btnBuy, false)
	end
end

function slot0.refreshForcePick(slot0)
	slot0.config = AutoChessConfig.instance:getChessCoByItemId(slot0.param.itemId)

	slot0.meshComp:setData(slot0.config.image)

	slot0._txtAttack.text = slot0.config.attack
	slot0._txtHp.text = slot0.config.hp

	slot0:refreshConfigAttr()
	gohelper.setActive(slot0._btnSelect, true)
end

function slot0.refreshConfigAttr(slot0)
	slot0._txtName.text = slot0.config.name
	slot0._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(slot0.config.skillDesc)

	if lua_auto_chess_translate.configDict[slot0.config.race] then
		slot0._txtType.text = slot1.name

		SLFramework.UGUI.GuiHelper.SetColor(slot0._imageType, slot1.color)
		gohelper.setActive(slot0._imageType, true)
		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageTag, slot1.tagResName)
	else
		gohelper.setActive(slot0._imageTag, false)
		gohelper.setActive(slot0._imageType, false)
	end
end

function slot0.refreshLevelStar(slot0)
	gohelper.setActive(slot0._goLevel, slot0.param.type == uv0.ShowType.Sell)

	if slot1 == uv0.ShowType.Sell then
		slot2 = slot0.param.entity.data

		UISpriteSetMgr.instance:setAutoChessSprite(slot0._imageLevel, "v2a5_autochess_levelbg_" .. slot2.star)

		slot0._txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_malllevelupview_level"), slot2.star)

		if slot2.maxExpLimit == 0 then
			gohelper.setActive(slot0._goStar, false)

			return
		end

		for slot7 = 1, 3 do
			gohelper.setActive(slot0["_goLight" .. slot7], slot7 <= slot2.exp)
			gohelper.setActive(slot0["_goStar" .. slot7], slot7 <= slot2.maxExpLimit)
		end
	end
end

function slot0.clcikHyperLink(slot0, slot1, slot2)
	if slot0.param.type == uv0.ShowType.ForcePick then
		recthelper.setAnchor(slot0._goSkillTip.transform, 0, 120)
		gohelper.setAsLastSibling(slot0._go)
	end

	if AutoChessConfig.instance:getSkillEffectDesc(tonumber(slot1)) then
		slot0._txtSkillTipTitle.text = slot3.name
		slot0._txtSkillTip.text = slot3.desc

		gohelper.setActive(slot0._goSkillTip, true)
	end
end

return slot0

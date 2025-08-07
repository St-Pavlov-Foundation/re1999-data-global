module("modules.logic.sp01.act205.view.card.Act205CardSelectView", package.seeall)

local var_0_0 = class("Act205CardSelectView", BaseView)
local var_0_1 = {
	PlayerSelectCard = 2,
	ShowEnemyCard = 1
}
local var_0_2 = "Act205CardSelectViewConfirmSelect"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "BG/Mask")
	arg_1_0._goenemyCards = gohelper.findChild(arg_1_0.viewGO, "Enemy/#go_enemyCards")
	arg_1_0._goplayer = gohelper.findChild(arg_1_0.viewGO, "Self")
	arg_1_0._goplayerCards = gohelper.findChild(arg_1_0.viewGO, "Self/#go_playerCards")
	arg_1_0._txtWeaponNum = gohelper.findChildText(arg_1_0.viewGO, "Self/txt_Selected/#txt_WeaponNum")
	arg_1_0._txtRoleNum = gohelper.findChildText(arg_1_0.viewGO, "Self/txt_Selected/#txt_RoleNum")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Start")
	arg_1_0._goNext = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_Next")
	arg_1_0._goStart = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/#go_Start")
	arg_1_0._golight2 = gohelper.findChild(arg_1_0.viewGO, "#btn_Start/stepIndexContent/#go_stepIndex2/go_light")
	arg_1_0._godesc = gohelper.findChild(arg_1_0.viewGO, "Info/image_DescrBG")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "Info/image_DescrBG/#txt_InfoDescr")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rule")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0._btnruleOnClick, arg_2_0)
	arg_2_0:addEventCb(Act205CardController.instance, Act205Event.PlayerSelectCard, arg_2_0._onSelectedCard, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnStart:RemoveClickListener()
	arg_3_0._btnrule:RemoveClickListener()
	arg_3_0:removeEventCb(Act205CardController.instance, Act205Event.PlayerSelectCard, arg_3_0._onSelectedCard, arg_3_0)
end

function var_0_0._btnStartOnClick(arg_4_0)
	if arg_4_0._viewStage == var_0_1.ShowEnemyCard then
		arg_4_0:_enterNextStage()
	elseif arg_4_0._viewStage == var_0_1.PlayerSelectCard then
		if Act205CardController.instance:checkPkPoint() then
			arg_4_0:playAnim("close", arg_4_0._openCardShowAfterCloseAnim, arg_4_0)
		end
	else
		arg_4_0:setViewStage()
	end
end

function var_0_0._openCardShowAfterCloseAnim(arg_5_0)
	Act205CardController.instance:openCardShowView()
end

function var_0_0._btnruleOnClick(arg_6_0)
	Act205Controller.instance:openRuleTipsView()
end

function var_0_0._onSelectedCard(arg_7_0)
	arg_7_0:refreshSelectedCard()
end

function var_0_0._enterNextStage(arg_8_0)
	arg_8_0:setViewStage(var_0_1.PlayerSelectCard, true)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_9_0.viewGO)

	local var_9_0 = arg_9_0.viewContainer:getSetting().otherRes[1]

	arg_9_0._goCardItem = arg_9_0:getResInst(var_9_0, arg_9_0.viewGO, "cardItem")

	gohelper.setActive(arg_9_0._goCardItem, false)
	arg_9_0:setViewStage()
end

function var_0_0.setViewStage(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._viewStage = arg_10_1 or var_0_1.ShowEnemyCard

	arg_10_0:refreshViewStage(arg_10_2)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	local var_12_0 = Act205CardController.instance:getEnemyCardIdList()

	gohelper.CreateObjList(arg_12_0, arg_12_0._onEnemyCardItemCreated, var_12_0, arg_12_0._goenemyCards, arg_12_0._goCardItem, Act205CardItem)

	local var_12_1 = Act205CardController.instance:getPlayerCardIdList()

	gohelper.CreateObjList(arg_12_0, arg_12_0._onPlayerCardItemCreated, var_12_1, arg_12_0._goplayerCards, arg_12_0._goCardItem, Act205CardItem)
end

function var_0_0._onEnemyCardItemCreated(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:setData(arg_13_2)
end

function var_0_0._onPlayerCardItemCreated(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	arg_14_1:setData(arg_14_2, true)
end

function var_0_0.refreshViewStage(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._viewStage == var_0_1.PlayerSelectCard

	gohelper.setActive(arg_15_0._goNext, not var_15_0)
	gohelper.setActive(arg_15_0._goStart, var_15_0)
	gohelper.setActive(arg_15_0._golight2, var_15_0)

	if arg_15_1 then
		local var_15_1 = var_15_0 and "selfin" or "open"

		arg_15_0:playAnim(var_15_1)

		if var_15_0 then
			AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_swich1)
		end
	end

	arg_15_0:refreshSelectedCard()
end

function var_0_0.playAnim(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if string.nilorempty(arg_16_1) or not arg_16_0._animatorPlayer then
		return
	end

	UIBlockMgr.instance:startBlock(var_0_2)

	arg_16_0._animCb = arg_16_2
	arg_16_0._animCbObj = arg_16_3

	arg_16_0._animatorPlayer:Play(arg_16_1, arg_16_0._playAnimFinish, arg_16_0)
end

function var_0_0._playAnimFinish(arg_17_0)
	if arg_17_0._animCb then
		arg_17_0._animCb(arg_17_0._animCbObj)
	end

	arg_17_0._animCb = nil
	arg_17_0._animCbObj = nil

	UIBlockMgr.instance:endBlock(var_0_2)
end

function var_0_0.refreshSelectedCard(arg_18_0)
	if not (arg_18_0._viewStage == var_0_1.PlayerSelectCard) then
		return
	end

	local var_18_0 = Act205CardModel.instance:isSelectedCardTypeCard(Act205Enum.CardType.Role)

	arg_18_0._txtRoleNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act205_card_selected"), var_18_0 and 1 or 0)

	UIColorHelper.set(arg_18_0._txtRoleNum, var_18_0 and "#BA1515" or "#4B2A1E")

	local var_18_1 = Act205CardModel.instance:isSelectedCardTypeCard(Act205Enum.CardType.Weapon)

	arg_18_0._txtWeaponNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act205_card_selected"), var_18_1 and 1 or 0)

	UIColorHelper.set(arg_18_0._txtWeaponNum, var_18_1 and "#BA1515" or "#4B2A1E")

	local var_18_2 = Act205CardModel.instance:getIsCanBeginPK()

	ZProj.UGUIHelper.SetGrayscale(arg_18_0._goStart, not var_18_2)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._viewStage = nil

	UIBlockMgr.instance:endBlock(var_0_2)
end

return var_0_0

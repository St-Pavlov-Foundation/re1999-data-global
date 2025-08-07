module("modules.logic.sp01.act205.view.card.Act205CardShowView", package.seeall)

local var_0_0 = class("Act205CardShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goenemyCards = gohelper.findChild(arg_1_0.viewGO, "Enemy/#go_enemyCards")
	arg_1_0._goenemyCardItem = gohelper.findChild(arg_1_0.viewGO, "Enemy/#go_enemyCards/#go_CardItem")
	arg_1_0._goplayerCards = gohelper.findChild(arg_1_0.viewGO, "Self/#go_playerCards")
	arg_1_0._goplayerCardItem = gohelper.findChild(arg_1_0.viewGO, "Self/#go_playerCards/#go_CardItem")
	arg_1_0._txtBroadcast = gohelper.findChildText(arg_1_0.viewGO, "#txt_Broadcast")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Skip")
	arg_1_0._goTarget = gohelper.findChild(arg_1_0.viewGO, "#selectcontainer")
	arg_1_0._goLine = gohelper.findChild(arg_1_0.viewGO, "#selectline")
	arg_1_0._goEnemyLineEnd = gohelper.findChild(arg_1_0.viewGO, "#selectline/#enemy_tou")
	arg_1_0._goPlayerLineEnd = gohelper.findChild(arg_1_0.viewGO, "#selectline/#player_tou")
	arg_1_0._goLineStart = gohelper.findChild(arg_1_0.viewGO, "#selectline/#pot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._btnSkipOnClick, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0.showResult, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0._btnSkipOnClick(arg_4_0)
	arg_4_0:showResult()
end

function var_0_0.showResult(arg_5_0)
	arg_5_0._finish = true

	Act205CardController.instance:cardGameFinishGetReward()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.cardItemPath = arg_6_0.viewContainer:getSetting().otherRes[1]
	arg_6_0._enemyCardItemList = {}

	local var_6_0 = Act205CardController.instance:getEnemyCardIdList()

	gohelper.CreateObjList(arg_6_0, arg_6_0._onEnemyCardItemCreated, var_6_0, arg_6_0._goenemyCards, arg_6_0._goenemyCardItem)

	arg_6_0._playerCardItemList = {}

	local var_6_1 = Act205CardModel.instance:getSelectedCardList()

	gohelper.CreateObjList(arg_6_0, arg_6_0._onPlayerCardItemCreated, var_6_1, arg_6_0._goplayerCards, arg_6_0._goplayerCardItem)

	arg_6_0._playIndex = 0
	arg_6_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_6_0.viewGO)
	arg_6_0._viewTrans = arg_6_0.viewGO.transform
	arg_6_0.lineCtrl = arg_6_0._goLine:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function var_0_0._onEnemyCardItemCreated(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getUserDataTb_()

	var_7_0.go = arg_7_1
	var_7_0.trans = var_7_0.go.transform
	var_7_0.itemGo = gohelper.findChild(var_7_0.go, "ani/#go_item")

	local var_7_1 = arg_7_0:getResInst(arg_7_0.cardItemPath, var_7_0.itemGo, "cardItem")

	var_7_0.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, Act205CardItem)

	var_7_0.item:setData(arg_7_2)

	var_7_0.cardType = Act205Config.instance:getCardType(arg_7_2)
	var_7_0.animator = var_7_0.go:GetComponent(typeof(UnityEngine.Animator))
	var_7_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_7_0.go)
	arg_7_0._enemyCardItemList[arg_7_3] = var_7_0
end

function var_0_0._onPlayerCardItemCreated(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.go = arg_8_1
	var_8_0.trans = var_8_0.go.transform
	var_8_0.itemGo = gohelper.findChild(var_8_0.go, "ani/#go_item")

	local var_8_1 = arg_8_0:getResInst(arg_8_0.cardItemPath, var_8_0.itemGo, "cardItem")

	var_8_0.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, Act205CardItem)

	var_8_0.item:setData(arg_8_2)

	var_8_0.cardType = Act205Config.instance:getCardType(arg_8_2)
	var_8_0.animator = var_8_0.go:GetComponent(typeof(UnityEngine.Animator))
	var_8_0.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_8_0.go)
	arg_8_0._playerCardItemList[arg_8_3] = var_8_0
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._finish = false

	arg_10_0._animatorPlayer:Play("open", arg_10_0.checkPlay, arg_10_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_swich2)
end

function var_0_0.checkPlay(arg_11_0)
	if arg_11_0._finish then
		return
	end

	arg_11_0._playIndex = arg_11_0._playIndex + 1

	local var_11_0 = arg_11_0._enemyCardItemList[arg_11_0._playIndex]
	local var_11_1 = arg_11_0._playerCardItemList[arg_11_0._playIndex]

	if not var_11_0 or not var_11_1 then
		arg_11_0:showResult()

		return
	end

	arg_11_0:showLine()
end

function var_0_0.showLine(arg_12_0)
	if arg_12_0._finish then
		return
	end

	local var_12_0 = arg_12_0._enemyCardItemList[arg_12_0._playIndex]
	local var_12_1 = arg_12_0._playerCardItemList[arg_12_0._playIndex]
	local var_12_2 = Act205CardModel.instance:getPKResult(var_12_1.cardType)
	local var_12_3 = arg_12_0._viewTrans:InverseTransformPoint(var_12_1.trans.position)
	local var_12_4 = arg_12_0._viewTrans:InverseTransformPoint(var_12_0.trans.position)
	local var_12_5 = var_12_3.x
	local var_12_6 = var_12_3.y
	local var_12_7 = var_12_4.x
	local var_12_8 = var_12_4.y
	local var_12_9 = var_12_2 == Act205Enum.CardPKResult.Restrain or var_12_2 == Act205Enum.CardPKResult.Draw

	transformhelper.setLocalPosXY(arg_12_0._goTarget.transform, var_12_9 and var_12_7 or var_12_5, var_12_9 and var_12_8 or var_12_6)
	transformhelper.setLocalPosXY(arg_12_0._goLineStart.transform, var_12_9 and var_12_5 or var_12_7, var_12_9 and var_12_6 or var_12_8)

	if var_12_9 then
		transformhelper.setLocalPosXY(arg_12_0._goEnemyLineEnd.transform, var_12_7, var_12_8)
	else
		transformhelper.setLocalPosXY(arg_12_0._goPlayerLineEnd.transform, var_12_5, var_12_6)
	end

	gohelper.setActive(arg_12_0._goTarget, true)
	gohelper.setActive(arg_12_0._goLineStart, true)
	gohelper.setActive(arg_12_0._goEnemyLineEnd, var_12_9)
	gohelper.setActive(arg_12_0._goPlayerLineEnd, not var_12_9)
	gohelper.setActive(arg_12_0._goLine, true)

	arg_12_0.lineCtrl.vector_01 = Vector4.New(var_12_7, var_12_8, 0, 0)
	arg_12_0.lineCtrl.vector_02 = Vector4.New(var_12_5, var_12_6, 0, 0)

	arg_12_0.lineCtrl:SetProps()
	var_12_0.animator:Play("select", 0, 0)
	var_12_1.animatorPlayer:Play("select", arg_12_0.hideLine, arg_12_0)
	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_pk)
end

function var_0_0.hideLine(arg_13_0)
	if arg_13_0._finish then
		return
	end

	local var_13_0 = arg_13_0._enemyCardItemList[arg_13_0._playIndex]
	local var_13_1 = arg_13_0._playerCardItemList[arg_13_0._playIndex]

	gohelper.setActive(arg_13_0._goTarget, false)
	gohelper.setActive(arg_13_0._goLineStart, false)
	gohelper.setActive(arg_13_0._goEnemyLineEnd, false)
	gohelper.setActive(arg_13_0._goPlayerLineEnd, false)
	gohelper.setActive(arg_13_0._goLine, false)
	var_13_0.animator:Play("unselect", 0, 0)
	var_13_1.animatorPlayer:Play("unselect", arg_13_0.playHit, arg_13_0)
end

function var_0_0.playHit(arg_14_0)
	if arg_14_0._finish then
		return
	end

	local var_14_0 = arg_14_0._enemyCardItemList[arg_14_0._playIndex]
	local var_14_1 = arg_14_0._playerCardItemList[arg_14_0._playIndex]
	local var_14_2 = Act205CardModel.instance:getPKResult(var_14_1.cardType)

	if var_14_2 ~= Act205Enum.CardPKResult.Draw then
		if var_14_2 == Act205Enum.CardPKResult.Restrain then
			var_14_0.item:playAnim("disappear_e", true)
			var_14_0.animatorPlayer:Play("hit", arg_14_0.playFinished, arg_14_0)
		else
			var_14_1.item:playAnim("disappear_s", true)
			var_14_1.animatorPlayer:Play("hit", arg_14_0.playFinished, arg_14_0)
		end
	else
		var_14_0.item:playAnim("disappear_e", true)
		var_14_0.animatorPlayer:Play("hit")
		var_14_1.item:playAnim("disappear_s", true)
		var_14_1.animatorPlayer:Play("hit", arg_14_0.playFinished, arg_14_0)
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Activity205.play_ui_s01_yunying_gone)
end

function var_0_0.playFinished(arg_15_0)
	arg_15_0:checkPlay()
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

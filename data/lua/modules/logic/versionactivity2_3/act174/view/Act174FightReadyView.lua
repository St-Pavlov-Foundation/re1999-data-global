module("modules.logic.versionactivity2_3.act174.view.Act174FightReadyView", package.seeall)

slot0 = class("Act174FightReadyView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "#go_Left")
	slot0._btnEnemyBuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Left/enemy/txt_enemy/#btn_EnemyBuff")
	slot0._goFrame = gohelper.findChild(slot0.viewGO, "#go_Frame")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "#go_Right")
	slot0._btnPlayerBuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Right/player/txt_player/#btn_PlayerBuff")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "go_top/tips/#txt_Round")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "go_top/hp/bg/#image_HpPercent")
	slot0._btnBet = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Bet")
	slot0._btnBetCancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_BetCancel")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Start")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "#go_Right/tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEnemyBuff:AddClickListener(slot0._btnEnemyBuffOnClick, slot0)
	slot0._btnPlayerBuff:AddClickListener(slot0._btnPlayerBuffOnClick, slot0)
	slot0._btnBet:AddClickListener(slot0._btnBetOnClick, slot0)
	slot0._btnBetCancel:AddClickListener(slot0._btnBetCancelOnClick, slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEnemyBuff:RemoveClickListener()
	slot0._btnPlayerBuff:RemoveClickListener()
	slot0._btnBet:RemoveClickListener()
	slot0._btnBetCancel:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
end

function slot0._btnEnemyBuffOnClick(slot0)
	Activity174Controller.instance:openBuffTipView(true, Vector2.New(-450, 80))
end

function slot0._btnPlayerBuffOnClick(slot0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(475, 80))
end

function slot0._btnBetOnClick(slot0)
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(slot0.actId, true, slot0.betReply, slot0)
end

function slot0._btnBetCancelOnClick(slot0)
	Activity174Rpc.instance:sendBetHpBeforeAct174FightRequest(slot0.actId, false, slot0.betReply, slot0)
end

function slot0._btnStartOnClick(slot0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Act174FightReadyView")
	slot0._animatorPlayer:Play(UIAnimationName.Close, slot0._starFight, slot0)
end

function slot0._starFight(slot0)
	Activity174Rpc.instance:sendStartAct174FightRequest(slot0.actId, slot0._fightReply, slot0)
end

function slot0._fightReply(slot0)
	Activity174Controller.instance:playFight()
	UIBlockMgr.instance:endBlock("Act174FightReadyView")
	UIBlockMgrExtend.setNeedCircleMv(true)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	slot0.hpEffList = slot0:getUserDataTb_()

	for slot4 = 1, slot0.maxHp do
		slot0.hpEffList[#slot0.hpEffList + 1] = gohelper.findChild(slot0.viewGO, "go_top/hp/bg/#hp0" .. slot4)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	slot0.unLockTeamCnt = Activity174Config.instance:getTurnCo(slot0.actId, slot0.gameInfo.gameCount).groupNum

	slot0:initLeftArea()
	slot0:initMiddleArea()
	slot0:initRightArea()
	gohelper.setActive(slot0._btnPlayerBuff, #slot0.gameInfo:getWarehouseInfo().enhanceId ~= 0)
	gohelper.setActive(slot0._btnEnemyBuff, #slot0.gameInfo:getFightInfo().matchInfo.enhanceId ~= 0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, slot0.closeThis, slot0)
end

function slot0.onOpenFinish(slot0)
	Activity174Controller.instance:dispatchEvent(Activity174Event.FightReadyViewLevelCount, slot0.gameInfo.gameCount)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.initLeftArea(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "#go_Left/EnemyGroup")

	for slot6 = 1, slot0.unLockTeamCnt do
		MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot1, "EnemyGroup" .. slot6), Act174FightReadyItem, slot0):setData(slot0.gameInfo:getFightInfo().matchInfo.teamInfo[slot6], true)
	end

	gohelper.setActive(slot1, false)
end

function slot0.initMiddleArea(slot0)
	slot0._txtRound.text = string.format("%s/%s", slot0.gameInfo.gameCount, Activity174Config.instance:getMaxRound(slot0.actId, slot0.gameInfo.gameCount))
	slot0.maxHp = lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value
	slot0._imageHpPercent.fillAmount = slot0.gameInfo.hp / slot0.maxHp

	slot0:refreshBetStatus()
end

function slot0.refreshBetStatus(slot0)
	slot3 = slot0.gameInfo.fightInfo.betHp

	if Activity174Config.instance:getTurnCo(slot0.actId, slot0.gameInfo.gameCount).winCoin == 0 or slot0.gameInfo.hp <= 1 then
		for slot7 = 1, slot0.maxHp do
			gohelper.setActive(slot0.hpEffList[slot7], false)
		end

		gohelper.setActive(slot0._btnBet, false)
		gohelper.setActive(slot0._btnBetCancel, false)
	else
		slot0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

		for slot7 = 1, slot0.maxHp do
			gohelper.setActive(slot0.hpEffList[slot7], slot3 and slot7 == slot0.gameInfo.hp)
		end

		gohelper.setActive(slot0._btnBet, not slot3)
		gohelper.setActive(slot0._btnBetCancel, slot3)
	end
end

function slot0.initRightArea(slot0)
	gohelper.setActive(slot0._goTips, slot0.unLockTeamCnt > 1)

	slot0.frameTrList = {}
	slot2 = gohelper.findChild(slot0.viewGO, "#go_Frame/frame")

	for slot6 = 1, slot1 do
		slot0.frameTrList[slot6] = gohelper.cloneInPlace(slot2).transform
	end

	gohelper.setActive(slot2, false)
	ZProj.UGUIHelper.RebuildLayout(slot2.transform.parent)
	recthelper.setHeight(slot0._goRight.transform, 211 * slot1 + 65)

	slot0.readyItemList = {}
	slot4 = gohelper.findChild(slot0.viewGO, "#go_Right/PlayerGroup")

	for slot9 = 1, slot1 do
		slot10 = gohelper.cloneInPlace(slot4, "PlayerGroup" .. slot9)
		slot11 = recthelper.rectToRelativeAnchorPos(slot0.frameTrList[slot9].position, slot0._goRight.transform)

		recthelper.setAnchor(slot10.transform, slot11.x, slot11.y)

		slot12 = MonoHelper.addNoUpdateLuaComOnceToGo(slot10, Act174FightReadyItem, slot0)

		slot12:setData(slot0.gameInfo:getTeamMoList()[slot9], false)

		slot0.readyItemList[slot9] = slot12
	end

	gohelper.setActive(slot4, false)
end

function slot0.exchangeItem(slot0, slot1, slot2)
	slot0.readyItemList[slot1] = slot0.readyItemList[slot2]
	slot0.readyItemList[slot2] = slot0.readyItemList[slot1]

	Activity174Rpc.instance:sendSwitchAct174TeamRequest(slot0.actId, slot1, slot2, slot0.switchReply, slot0)
end

function slot0.switchReply(slot0)
	slot1 = slot0.gameInfo:getTeamMoList()

	for slot5 = 1, #slot0.readyItemList do
		if slot1[slot5] then
			slot0.readyItemList[slot5]:setData(slot1[slot5], false)
		else
			logError("dont esixt teamInfo" .. slot5)
		end
	end
end

function slot0.betReply(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		if slot3.bet then
			ViewMgr.instance:openView(ViewName.Act174BetSuccessView)
		end

		slot0:refreshBetStatus()
	end
end

return slot0

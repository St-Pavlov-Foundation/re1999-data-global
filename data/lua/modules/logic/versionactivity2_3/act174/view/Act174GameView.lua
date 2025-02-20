module("modules.logic.versionactivity2_3.act174.view.Act174GameView", package.seeall)

slot0 = class("Act174GameView", BaseView)

function slot0.onInitView(slot0)
	slot0._goShop = gohelper.findChild(slot0.viewGO, "#go_Shop")
	slot0._goEditTeam = gohelper.findChild(slot0.viewGO, "#go_EditTeam")
	slot0._goLeftBtn = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn")
	slot0._goUnlockTeamTip = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn/go_tips")
	slot0._btnEditTeam = gohelper.findChildButton(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam")
	slot0._btnShop = gohelper.findChildButton(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop")
	slot0._btnBuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "BtnGroup/#btn_Buff")
	slot0._btnMatch = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Match")
	slot0._goCoin1 = gohelper.findChild(slot0.viewGO, "go_topright/#go_Coin1")
	slot0._txtCoinCnt1 = gohelper.findChildText(slot0.viewGO, "go_topright/#go_Coin1/#txt_CoinCnt1")
	slot0._goEndlessDetail = gohelper.findChild(slot0.viewGO, "go_topright/btn_detail")
	slot0._btnEndlessDetail = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "go_topright/btn_detail/clickarea")
	slot0._goCoin2 = gohelper.findChild(slot0.viewGO, "go_topright/#go_Coin2")
	slot0._txtCoinCnt2 = gohelper.findChildText(slot0.viewGO, "go_topright/#go_Coin2/#txt_CoinCnt2")
	slot0._goEndlessMultiple = gohelper.findChild(slot0.viewGO, "go_topright/go_tips")
	slot0._txtEndlessMultiple = gohelper.findChildText(slot0.viewGO, "go_topright/go_tips/txt_tips")
	slot0._btnCloseEndlessTips = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "go_topright/go_tips/#btn_closetip")
	slot0._txtRound = gohelper.findChildText(slot0.viewGO, "go_top/tips/#txt_Round")
	slot0._goHp = gohelper.findChild(slot0.viewGO, "go_top/#go_Hp")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "go_top/#go_Hp/bg/#image_HpPercent")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnEditTeam:AddClickListener(slot0._btnEditTeamOnClick, slot0)
	slot0._btnShop:AddClickListener(slot0._btnShopOnClick, slot0)
	slot0._btnBuff:AddClickListener(slot0._btnBuffOnClick, slot0)
	slot0._btnMatch:AddClickListener(slot0._btnMatchOnClick, slot0)
	slot0._btnEndlessDetail:AddClickListener(slot0._onOpenEndlessTips, slot0)
	slot0._btnCloseEndlessTips:AddClickListener(slot0._onCloseEndlessTips, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnEditTeam:RemoveClickListener()
	slot0._btnShop:RemoveClickListener()
	slot0._btnBuff:RemoveClickListener()
	slot0._btnMatch:RemoveClickListener()
	slot0._btnEndlessDetail:RemoveClickListener()
	slot0._btnCloseEndlessTips:RemoveClickListener()
end

function slot0._btnBuffOnClick(slot0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(-600, -698), true)
end

function slot0._btnMatchOnClick(slot0)
	if Activity174Controller.instance:checkTeamDataWrong(slot0.actId) then
		GameFacade.showToast(ToastEnum.Act174TeamGroupEmpty)

		return
	end

	Activity174Controller.instance:syncLocalTeam2Server(slot0.actId)
	ViewMgr.instance:openView(ViewName.Act174MatchView)
end

function slot0._btnEditTeamOnClick(slot0, slot1)
	slot0:closeUnlockTeamTip(true)

	if not slot1 and slot0._goEditTeam.activeInHierarchy then
		return
	end

	slot0.anim:Play("switch_editteam", 0, 0)
	gohelper.setActive(slot0._goEditTeam, true)
	gohelper.setActive(slot0._goShop, false)
	gohelper.setActive(slot0._goBtnEditTeamS, true)
	gohelper.setActive(slot0._goBtnEditTeamU, false)
	gohelper.setActive(slot0._goBtnShopS, false)
	gohelper.setActive(slot0._goBtnShopU, true)
	gohelper.setActive(slot0._btnMatch, true)

	if not slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)
end

function slot0._btnShopOnClick(slot0, slot1)
	if not slot1 and slot0._goShop.activeInHierarchy then
		return
	end

	slot0.anim:Play("switch_shop", 0, 0)
	gohelper.setActive(slot0._goEditTeam, false)
	gohelper.setActive(slot0._goShop, true)
	gohelper.setActive(slot0._goBtnEditTeamS, false)
	gohelper.setActive(slot0._goBtnEditTeamU, true)
	gohelper.setActive(slot0._goBtnShopS, true)
	gohelper.setActive(slot0._goBtnShopU, false)
	gohelper.setActive(slot0._btnMatch, false)

	if not slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)

	if Activity174Model.instance:getActInfo():getGameInfo().gameCount > 1 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.EnterGameStore)
	end
end

function slot0._onOpenEndlessTips(slot0)
	gohelper.setActive(slot0._goEndlessMultiple, true)
end

function slot0._onCloseEndlessTips(slot0)
	gohelper.setActive(slot0._goEndlessMultiple, false)
end

function slot0._editableInitView(slot0)
	slot0._goBtnEditTeamS = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/select")
	slot0._goBtnEditTeamU = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/unselect")
	slot0._goBtnShopS = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/select")
	slot0._goBtnShopU = gohelper.findChild(slot0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/unselect")
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)
	slot0.goCoinAdd = gohelper.findChild(slot0._goCoin1, "#add")
	slot0.goCoinSubtract = gohelper.findChild(slot0._goCoin1, "#subtract")
	slot0.goHpAdd = gohelper.findChild(slot0._goHp, "bg/#recover_hp")
	slot0.goHpSubtract = gohelper.findChild(slot0._goHp, "bg/#lose_hp")
	slot0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

	slot0:_btnShopOnClick(true)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.actInfo = Activity174Model.instance:getActInfo()

	slot0:refreshUI()
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.FreshShopReply, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, slot0.closeThis, slot0)
end

function slot0.checkUnlockTeamTipShow(slot0)
	slot1 = false
	slot2 = slot0.actInfo and slot0.actInfo:getGameInfo()

	if slot2 and slot2.gameCount then
		slot1 = Activity174Model.instance:getIsShowUnlockNewTeamTip(slot3)
	end

	gohelper.setActive(slot0._goUnlockTeamTip, slot1)

	if slot1 then
		Activity174Model.instance:setHasShowUnlockNewTeamTip(slot3)
		TaskDispatcher.runDelay(slot0.closeUnlockTeamTip, slot0, 3)
	end
end

function slot0.closeUnlockTeamTip(slot0, slot1)
	gohelper.setActive(slot0._goUnlockTeamTip, false)

	if slot1 then
		TaskDispatcher.cancelTask(slot0.closeUnlockTeamTip, slot0)
	end
end

function slot0.onClose(slot0)
	slot0:closeUnlockTeamTip(true)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	slot1 = slot0.actInfo:getGameInfo()
	slot0._txtCoinCnt1.text = slot1.coin
	slot0._txtCoinCnt2.text = slot1.score
	slot3, slot4 = Activity174Config.instance:getMaxRound(slot0.actId, slot1.gameCount)
	slot0._txtRound.text = string.format("%s/%s", slot1.gameCount, slot3)
	slot0._imageHpPercent.fillAmount = slot1.hp / slot0.maxHp

	if slot4 or slot2 == 1 then
		if slot4 then
			slot0._txtEndlessMultiple.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act174_endless_multiple"), slot1:getBetScore(), string.format("%s%s", luaLang("multiple"), Activity174Config.instance:getTurnCo(slot0.actId, slot2).point / 1000))

			gohelper.setActive(slot0._goCoin1, false)
			gohelper.setActive(slot0._goHp, false)
		end

		gohelper.setActive(slot0._goLeftBtn, false)
		slot0:_btnEditTeamOnClick(true)
	end

	slot0:_onCloseEndlessTips()
	gohelper.setActive(slot0._goEndlessDetail, slot4)
	slot0:checkUnlockTeamTipShow()
	gohelper.setActive(slot0._btnBuff, #slot1:getWarehouseInfo().enhanceId ~= 0)
	slot0:checkTriggerEffect()
end

function slot0.checkTriggerEffect(slot0)
	slot1 = 0
	slot2 = 0

	for slot7, slot8 in ipairs(slot0.actInfo:getTriggerList()) do
		for slot12, slot13 in ipairs(slot8.effectId) do
			slot14 = lua_activity174_effect.configDict[slot13]

			if slot14.type == Activity174Enum.EffectType.AddHp then
				slot1 = slot1 + string.splitToNumber(slot14.typeParam, "#")[1]
			elseif slot14.type == Activity174Enum.EffectType.Rebirth then
				slot1 = slot1 + 1
				slot2 = slot2 - slot15[2]
			elseif slot14.type == Activity174Enum.EffectType.DirectAddCoin then
				slot2 = slot2 + slot15[1]
			elseif slot14.type == Activity174Enum.EffectType.DelayAddCoin then
				slot2 = slot2 + slot15[2]
			elseif slot14.type == Activity174Enum.EffectType.BuyAddCoin then
				slot2 = slot2 + slot15[3]
			elseif slot14.type == Activity174Enum.EffectType.ReduceHpAddCoin then
				slot2 = slot2 + slot15[1]
			elseif slot14.type == Activity174Enum.EffectType.MaybeAddCoin and tonumber(slot8.param) then
				slot2 = slot2 + slot16
			end
		end
	end

	slot0.actInfo:cleanTriggerEffect()

	if slot1 ~= 0 then
		slot0:playHpAnim(slot1)
	end

	if slot2 ~= 0 then
		slot0:playCoinAnim(slot2)
	end
end

function slot0.playHpAnim(slot0, slot1)
	slot3 = slot0._imageHpPercent.fillAmount
	slot4 = nil

	if slot1 > 0 then
		slot4 = (slot0.actInfo:getGameInfo().hp - slot1) / slot0.maxHp
	elseif (slot2.hp + slot1) / slot0.maxHp > 1 then
		return
	end

	slot0._imageHpPercent.fillAmount = slot4

	if slot1 > 0 then
		gohelper.setActive(slot0.goHpAdd, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_move)
	else
		gohelper.setActive(slot0.goHpSubtract, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_put)
	end

	ZProj.TweenHelper.DOFillAmount(slot0._imageHpPercent, slot3, 1, slot0.hpAnimEnd, slot0)
end

function slot0.hpAnimEnd(slot0)
	gohelper.setActive(slot0.goHpAdd, false)
	gohelper.setActive(slot0.goHpSubtract, false)
end

function slot0.playCoinAnim(slot0, slot1)
	slot3 = slot0.actInfo:getGameInfo().coin
	slot4 = slot1 > 0 and slot2.coin - slot1 or slot2.coin + slot1

	if slot1 > 0 then
		gohelper.setActive(slot0.goCoinAdd, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_buff_curses_up)
	else
		gohelper.setActive(slot0.goCoinSubtract, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_down)
	end

	ZProj.TweenHelper.DOTweenFloat(slot4, slot3, 1, slot0.coinAnimFrame, slot0.coinAnimEnd, slot0)
end

function slot0.coinAnimFrame(slot0, slot1, slot2)
	slot0._txtCoinCnt1.text = math.floor(slot1)
end

function slot0.coinAnimEnd(slot0)
	gohelper.setActive(slot0.goCoinAdd, false)
	gohelper.setActive(slot0.goCoinSubtract, false)
end

return slot0

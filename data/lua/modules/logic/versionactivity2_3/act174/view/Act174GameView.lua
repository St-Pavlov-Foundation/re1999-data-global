module("modules.logic.versionactivity2_3.act174.view.Act174GameView", package.seeall)

local var_0_0 = class("Act174GameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goShop = gohelper.findChild(arg_1_0.viewGO, "#go_Shop")
	arg_1_0._goEditTeam = gohelper.findChild(arg_1_0.viewGO, "#go_EditTeam")
	arg_1_0._goLeftBtn = gohelper.findChild(arg_1_0.viewGO, "BtnGroup/#go_LeftBtn")
	arg_1_0._goUnlockTeamTip = gohelper.findChild(arg_1_0.viewGO, "BtnGroup/#go_LeftBtn/go_tips")
	arg_1_0._btnEditTeam = gohelper.findChildButton(arg_1_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam")
	arg_1_0._btnShop = gohelper.findChildButton(arg_1_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop")
	arg_1_0._btnBuff = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "BtnGroup/#btn_Buff")
	arg_1_0._btnMatch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Match")
	arg_1_0._goCoin1 = gohelper.findChild(arg_1_0.viewGO, "go_topright/#go_Coin1")
	arg_1_0._txtCoinCnt1 = gohelper.findChildText(arg_1_0.viewGO, "go_topright/#go_Coin1/#txt_CoinCnt1")
	arg_1_0._goEndlessDetail = gohelper.findChild(arg_1_0.viewGO, "go_topright/btn_detail")
	arg_1_0._btnEndlessDetail = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "go_topright/btn_detail/clickarea")
	arg_1_0._goCoin2 = gohelper.findChild(arg_1_0.viewGO, "go_topright/#go_Coin2")
	arg_1_0._txtCoinCnt2 = gohelper.findChildText(arg_1_0.viewGO, "go_topright/#go_Coin2/#txt_CoinCnt2")
	arg_1_0._goEndlessMultiple = gohelper.findChild(arg_1_0.viewGO, "go_topright/go_tips")
	arg_1_0._txtEndlessMultiple = gohelper.findChildText(arg_1_0.viewGO, "go_topright/go_tips/txt_tips")
	arg_1_0._btnCloseEndlessTips = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "go_topright/go_tips/#btn_closetip")
	arg_1_0._txtRound = gohelper.findChildText(arg_1_0.viewGO, "go_top/tips/#txt_Round")
	arg_1_0._goHp = gohelper.findChild(arg_1_0.viewGO, "go_top/#go_Hp")
	arg_1_0._imageHpPercent = gohelper.findChildImage(arg_1_0.viewGO, "go_top/#go_Hp/bg/#image_HpPercent")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnEditTeam:AddClickListener(arg_2_0._btnEditTeamOnClick, arg_2_0)
	arg_2_0._btnShop:AddClickListener(arg_2_0._btnShopOnClick, arg_2_0)
	arg_2_0._btnBuff:AddClickListener(arg_2_0._btnBuffOnClick, arg_2_0)
	arg_2_0._btnMatch:AddClickListener(arg_2_0._btnMatchOnClick, arg_2_0)
	arg_2_0._btnEndlessDetail:AddClickListener(arg_2_0._onOpenEndlessTips, arg_2_0)
	arg_2_0._btnCloseEndlessTips:AddClickListener(arg_2_0._onCloseEndlessTips, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnEditTeam:RemoveClickListener()
	arg_3_0._btnShop:RemoveClickListener()
	arg_3_0._btnBuff:RemoveClickListener()
	arg_3_0._btnMatch:RemoveClickListener()
	arg_3_0._btnEndlessDetail:RemoveClickListener()
	arg_3_0._btnCloseEndlessTips:RemoveClickListener()
end

function var_0_0._btnBuffOnClick(arg_4_0)
	Activity174Controller.instance:openBuffTipView(false, Vector2.New(-600, -698), true)
end

function var_0_0._btnMatchOnClick(arg_5_0)
	if Activity174Controller.instance:checkTeamDataWrong(arg_5_0.actId) then
		GameFacade.showToast(ToastEnum.Act174TeamGroupEmpty)

		return
	end

	Activity174Controller.instance:syncLocalTeam2Server(arg_5_0.actId)
	ViewMgr.instance:openView(ViewName.Act174MatchView)
end

function var_0_0._btnEditTeamOnClick(arg_6_0, arg_6_1)
	arg_6_0:closeUnlockTeamTip(true)

	if not arg_6_1 and arg_6_0._goEditTeam.activeInHierarchy then
		return
	end

	arg_6_0.anim:Play("switch_editteam", 0, 0)
	gohelper.setActive(arg_6_0._goEditTeam, true)
	gohelper.setActive(arg_6_0._goShop, false)
	gohelper.setActive(arg_6_0._goBtnEditTeamS, true)
	gohelper.setActive(arg_6_0._goBtnEditTeamU, false)
	gohelper.setActive(arg_6_0._goBtnShopS, false)
	gohelper.setActive(arg_6_0._goBtnShopU, true)
	gohelper.setActive(arg_6_0._btnMatch, true)

	if not arg_6_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)
end

function var_0_0._btnShopOnClick(arg_7_0, arg_7_1)
	if not arg_7_1 and arg_7_0._goShop.activeInHierarchy then
		return
	end

	arg_7_0.anim:Play("switch_shop", 0, 0)
	gohelper.setActive(arg_7_0._goEditTeam, false)
	gohelper.setActive(arg_7_0._goShop, true)
	gohelper.setActive(arg_7_0._goBtnEditTeamS, false)
	gohelper.setActive(arg_7_0._goBtnEditTeamU, true)
	gohelper.setActive(arg_7_0._goBtnShopS, true)
	gohelper.setActive(arg_7_0._goBtnShopU, false)
	gohelper.setActive(arg_7_0._btnMatch, false)

	if not arg_7_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.SwitchShopTeam)

	if Activity174Model.instance:getActInfo():getGameInfo().gameCount > 1 then
		Activity174Controller.instance:dispatchEvent(Activity174Event.EnterGameStore)
	end
end

function var_0_0._onOpenEndlessTips(arg_8_0)
	gohelper.setActive(arg_8_0._goEndlessMultiple, true)
end

function var_0_0._onCloseEndlessTips(arg_9_0)
	gohelper.setActive(arg_9_0._goEndlessMultiple, false)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0._goBtnEditTeamS = gohelper.findChild(arg_10_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/select")
	arg_10_0._goBtnEditTeamU = gohelper.findChild(arg_10_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_EditTeam/unselect")
	arg_10_0._goBtnShopS = gohelper.findChild(arg_10_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/select")
	arg_10_0._goBtnShopU = gohelper.findChild(arg_10_0.viewGO, "BtnGroup/#go_LeftBtn/#btn_Shop/unselect")
	arg_10_0.anim = arg_10_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_10_0.goCoinAdd = gohelper.findChild(arg_10_0._goCoin1, "#add")
	arg_10_0.goCoinSubtract = gohelper.findChild(arg_10_0._goCoin1, "#subtract")
	arg_10_0.goHpAdd = gohelper.findChild(arg_10_0._goHp, "bg/#recover_hp")
	arg_10_0.goHpSubtract = gohelper.findChild(arg_10_0._goHp, "bg/#lose_hp")
	arg_10_0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)

	arg_10_0:_btnShopOnClick(true)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.actId = Activity174Model.instance:getCurActId()
	arg_12_0.actInfo = Activity174Model.instance:getActInfo()

	arg_12_0:refreshUI()
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.UpdateGameInfo, arg_12_0.refreshUI, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.FreshShopReply, arg_12_0.refreshUI, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.BuyInShopReply, arg_12_0.refreshUI, arg_12_0)
	arg_12_0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, arg_12_0.closeThis, arg_12_0)
end

function var_0_0.checkUnlockTeamTipShow(arg_13_0)
	local var_13_0 = false
	local var_13_1 = arg_13_0.actInfo and arg_13_0.actInfo:getGameInfo()
	local var_13_2 = var_13_1 and var_13_1.gameCount

	if var_13_2 then
		var_13_0 = Activity174Model.instance:getIsShowUnlockNewTeamTip(var_13_2)
	end

	gohelper.setActive(arg_13_0._goUnlockTeamTip, var_13_0)

	if var_13_0 then
		Activity174Model.instance:setHasShowUnlockNewTeamTip(var_13_2)
		TaskDispatcher.runDelay(arg_13_0.closeUnlockTeamTip, arg_13_0, 3)
	end
end

function var_0_0.closeUnlockTeamTip(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._goUnlockTeamTip, false)

	if arg_14_1 then
		TaskDispatcher.cancelTask(arg_14_0.closeUnlockTeamTip, arg_14_0)
	end
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:closeUnlockTeamTip(true)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

function var_0_0.refreshUI(arg_17_0)
	local var_17_0 = arg_17_0.actInfo:getGameInfo()

	arg_17_0._txtCoinCnt1.text = var_17_0.coin
	arg_17_0._txtCoinCnt2.text = var_17_0.score

	local var_17_1 = var_17_0.gameCount
	local var_17_2, var_17_3 = Activity174Config.instance:getMaxRound(arg_17_0.actId, var_17_1)

	arg_17_0._txtRound.text = string.format("%s/%s", var_17_0.gameCount, var_17_2)
	arg_17_0._imageHpPercent.fillAmount = var_17_0.hp / arg_17_0.maxHp

	if var_17_3 or var_17_1 == 1 then
		if var_17_3 then
			local var_17_4 = var_17_0:getBetScore()
			local var_17_5 = Activity174Config.instance:getTurnCo(arg_17_0.actId, var_17_1)
			local var_17_6 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multiple_1"), var_17_5.point / 1000)

			arg_17_0._txtEndlessMultiple.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("act174_endless_multiple"), var_17_4, var_17_6)

			gohelper.setActive(arg_17_0._goCoin1, false)
			gohelper.setActive(arg_17_0._goHp, false)
		end

		gohelper.setActive(arg_17_0._goLeftBtn, false)
		arg_17_0:_btnEditTeamOnClick(true)
	end

	arg_17_0:_onCloseEndlessTips()
	gohelper.setActive(arg_17_0._goEndlessDetail, var_17_3)
	arg_17_0:checkUnlockTeamTipShow()

	local var_17_7 = var_17_0:getWarehouseInfo()

	gohelper.setActive(arg_17_0._btnBuff, #var_17_7.enhanceId ~= 0)
	arg_17_0:checkTriggerEffect()
end

function var_0_0.checkTriggerEffect(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = 0
	local var_18_2 = arg_18_0.actInfo:getTriggerList()

	for iter_18_0, iter_18_1 in ipairs(var_18_2) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1.effectId) do
			local var_18_3 = lua_activity174_effect.configDict[iter_18_3]
			local var_18_4 = string.splitToNumber(var_18_3.typeParam, "#")

			if var_18_3.type == Activity174Enum.EffectType.AddHp then
				var_18_0 = var_18_0 + var_18_4[1]
			elseif var_18_3.type == Activity174Enum.EffectType.Rebirth then
				var_18_0 = var_18_0 + 1
				var_18_1 = var_18_1 - var_18_4[2]
			elseif var_18_3.type == Activity174Enum.EffectType.DirectAddCoin then
				var_18_1 = var_18_1 + var_18_4[1]
			elseif var_18_3.type == Activity174Enum.EffectType.DelayAddCoin then
				var_18_1 = var_18_1 + var_18_4[2]
			elseif var_18_3.type == Activity174Enum.EffectType.BuyAddCoin then
				var_18_1 = var_18_1 + var_18_4[3]
			elseif var_18_3.type == Activity174Enum.EffectType.ReduceHpAddCoin then
				var_18_1 = var_18_1 + var_18_4[1]
			elseif var_18_3.type == Activity174Enum.EffectType.MaybeAddCoin then
				local var_18_5 = tonumber(iter_18_1.param)

				if var_18_5 then
					var_18_1 = var_18_1 + var_18_5
				end
			end
		end
	end

	arg_18_0.actInfo:cleanTriggerEffect()

	if var_18_0 ~= 0 then
		arg_18_0:playHpAnim(var_18_0)
	end

	if var_18_1 ~= 0 then
		arg_18_0:playCoinAnim(var_18_1)
	end
end

function var_0_0.playHpAnim(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.actInfo:getGameInfo()
	local var_19_1 = arg_19_0._imageHpPercent.fillAmount
	local var_19_2

	if arg_19_1 > 0 then
		var_19_2 = (var_19_0.hp - arg_19_1) / arg_19_0.maxHp
	else
		var_19_2 = (var_19_0.hp + arg_19_1) / arg_19_0.maxHp

		if var_19_2 > 1 then
			return
		end
	end

	arg_19_0._imageHpPercent.fillAmount = var_19_2

	if arg_19_1 > 0 then
		gohelper.setActive(arg_19_0.goHpAdd, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_move)
	else
		gohelper.setActive(arg_19_0.goHpSubtract, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_home_door_effect_put)
	end

	ZProj.TweenHelper.DOFillAmount(arg_19_0._imageHpPercent, var_19_1, 1, arg_19_0.hpAnimEnd, arg_19_0)
end

function var_0_0.hpAnimEnd(arg_20_0)
	gohelper.setActive(arg_20_0.goHpAdd, false)
	gohelper.setActive(arg_20_0.goHpSubtract, false)
end

function var_0_0.playCoinAnim(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.actInfo:getGameInfo()
	local var_21_1 = var_21_0.coin
	local var_21_2 = arg_21_1 > 0 and var_21_0.coin - arg_21_1 or var_21_0.coin + arg_21_1

	if arg_21_1 > 0 then
		gohelper.setActive(arg_21_0.goCoinAdd, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_buff_curses_up)
	else
		gohelper.setActive(arg_21_0.goCoinSubtract, true)
		AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_down)
	end

	ZProj.TweenHelper.DOTweenFloat(var_21_2, var_21_1, 1, arg_21_0.coinAnimFrame, arg_21_0.coinAnimEnd, arg_21_0)
end

function var_0_0.coinAnimFrame(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._txtCoinCnt1.text = math.floor(arg_22_1)
end

function var_0_0.coinAnimEnd(arg_23_0)
	gohelper.setActive(arg_23_0.goCoinAdd, false)
	gohelper.setActive(arg_23_0.goCoinSubtract, false)
end

return var_0_0

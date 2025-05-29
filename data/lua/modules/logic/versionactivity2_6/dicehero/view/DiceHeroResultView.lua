module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroResultView", package.seeall)

local var_0_0 = class("DiceHeroResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnquitgame = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_quitgame")
	arg_1_0._btnrestart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#btn_restart")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0._onClickClose, arg_2_0)
	arg_2_0._btnquitgame:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0._btnrestart:AddClickListener(arg_2_0._onClickRestart, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnquitgame:RemoveClickListener()
	arg_3_0._btnrestart:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	gohelper.setActive(arg_4_0._gosuccess, arg_4_0.viewParam.status == DiceHeroEnum.GameStatu.Win)
	gohelper.setActive(arg_4_0._gofail, arg_4_0.viewParam.status == DiceHeroEnum.GameStatu.Lose)

	local var_4_0 = DiceHeroModel.instance.lastEnterLevelId
	local var_4_1 = lua_dice_level.configDict[var_4_0]

	arg_4_0.co = var_4_1

	local var_4_2 = false

	if var_4_1 then
		var_4_2 = arg_4_0.viewParam.status == DiceHeroEnum.GameStatu.Lose and var_4_1.mode == 1
	end

	gohelper.setActive(arg_4_0._gobtns, var_4_2)
	gohelper.setActive(arg_4_0._btnClick, not var_4_2)

	if arg_4_0.viewParam.status == DiceHeroEnum.GameStatu.Win then
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_endpoint_arrival)
	else
		AudioMgr.instance:trigger(AudioEnum2_6.DiceHero.play_ui_pkls_challenge_fail)
	end
end

function var_0_0._onClickRestart(arg_5_0)
	DiceHeroStatHelper.instance:resetGameDt()
	DiceHeroRpc.instance:sendDiceHeroEnterFight(arg_5_0.co.id, arg_5_0._onEnterFight, arg_5_0)
end

function var_0_0._onClickClose(arg_6_0)
	if arg_6_0.co then
		local var_6_0 = DiceHeroModel.instance:getGameInfo(arg_6_0.co.chapter)

		if var_6_0:hasReward() and var_6_0.currLevel == DiceHeroModel.instance.lastEnterLevelId then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = arg_6_0.co
			})
		elseif arg_6_0.co.mode == 2 and arg_6_0.viewParam.status == DiceHeroEnum.GameStatu.Win and arg_6_0.co.dialog ~= 0 then
			ViewMgr.instance:openView(ViewName.DiceHeroTalkView, {
				co = arg_6_0.co
			})
		end
	end

	arg_6_0:closeThis()
end

function var_0_0._onEnterFight(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 ~= 0 then
		return
	end

	arg_7_0._restart = true

	ViewMgr.instance:openView(ViewName.DiceHeroGameView)
	arg_7_0:closeThis()
end

function var_0_0.onClose(arg_8_0)
	if not arg_8_0._restart then
		ViewMgr.instance:closeView(ViewName.DiceHeroGameView)
	end

	DiceHeroFightModel.instance.finishResult = DiceHeroEnum.GameStatu.None

	if DiceHeroModel.instance.isUnlockNewChapter then
		ViewMgr.instance:closeView(ViewName.DiceHeroLevelView)
	end
end

return var_0_0

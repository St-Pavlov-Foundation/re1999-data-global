module("modules.logic.versionactivity2_3.act174.view.Act174SettlementView", package.seeall)

local var_0_0 = class("Act174SettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtWinCnt = gohelper.findChildText(arg_1_0.viewGO, "Right/fight/#txt_WinCnt")
	arg_1_0._txtLoseCnt = gohelper.findChildText(arg_1_0.viewGO, "Right/fight/#txt_LoseCnt")
	arg_1_0._gobadgeItem = gohelper.findChild(arg_1_0.viewGO, "Right/badge/layout/#go_badgeItem")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Right/score/#txt_Score")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.animEvent = arg_5_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_5_0.animEvent:AddEventListener("PlayBadgeAnim", arg_5_0.playBadgeAnim, arg_5_0)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actInfo = Activity174Model.instance:getActInfo()
	arg_7_0.gameInfo = arg_7_0.actInfo:getGameInfo()
	arg_7_0.gameEndInfo = arg_7_0.actInfo:getGameEndInfo()

	arg_7_0:refreshLeft()
	arg_7_0:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function var_0_0.onClose(arg_8_0)
	if arg_8_0.gameEndInfo and arg_8_0.gameEndInfo.gainScore ~= 0 then
		local var_8_0 = MaterialDataMO.New()

		var_8_0:initValue(2, 2302, arg_8_0.gameEndInfo.gainScore)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, {
			var_8_0
		})
	end

	arg_8_0.actInfo:clearEndInfo()
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function var_0_0.refreshLeft(arg_10_0)
	local var_10_0 = arg_10_0.actInfo:getGameInfo():getTeamMoList()
	local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "Left/Group/playergroup")

	if var_10_0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_2 = gohelper.cloneInPlace(var_10_1)
			local var_10_3 = gohelper.findChildImage(var_10_2, "numbg/image_Num")

			UISpriteSetMgr.instance:setAct174Sprite(var_10_3, "act174_ready_num_0" .. iter_10_1.index)

			for iter_10_2 = 1, 4 do
				local var_10_4 = Activity174Helper.MatchKeyInArray(iter_10_1.battleHeroInfo, iter_10_2, "index")
				local var_10_5 = arg_10_0:getResInst(Activity174Enum.PrefabPath.BattleHero, var_10_2)
				local var_10_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_5, Act174BattleHeroItem)

				var_10_6:setIndex(iter_10_2)
				var_10_6:setData(var_10_4, iter_10_1.index, false)
			end
		end
	end

	gohelper.setActive(var_10_1, false)
end

function var_0_0.refreshRight(arg_11_0)
	arg_11_0._txtLoseCnt.text = arg_11_0.gameEndInfo.winNum
	arg_11_0._txtWinCnt.text = arg_11_0.gameEndInfo.loseNum

	arg_11_0:initBadge()

	arg_11_0._txtScore.text = arg_11_0.gameEndInfo.gainScore
end

function var_0_0.initBadge(arg_12_0)
	arg_12_0.badgeItemList = {}

	local var_12_0 = arg_12_0.actInfo:getBadgeScoreChangeDic()
	local var_12_1 = arg_12_0.actInfo:getBadgeMoList()

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = arg_12_0:getUserDataTb_()
		local var_12_3 = gohelper.cloneInPlace(arg_12_0._gobadgeItem)

		var_12_2.Icon = gohelper.findChildSingleImage(var_12_3, "root/image_icon")

		local var_12_4 = gohelper.findChildText(var_12_3, "root/txt_num")
		local var_12_5 = gohelper.findChildText(var_12_3, "root/txt_score")

		var_12_4.text = iter_12_1.count

		local var_12_6 = var_12_0[iter_12_1.id]

		if var_12_6 and var_12_6 ~= 0 then
			var_12_5.text = "+" .. var_12_6
		end

		gohelper.setActive(var_12_5, var_12_6 ~= 0)

		local var_12_7 = iter_12_1:getState()
		local var_12_8 = ResUrl.getAct174BadgeIcon(iter_12_1.config.icon, var_12_7)

		var_12_2.Icon:LoadImage(var_12_8)

		var_12_2.anim = var_12_3:GetComponent(gohelper.Type_Animator)
		var_12_2.id = iter_12_1.id
		arg_12_0.badgeItemList[#arg_12_0.badgeItemList] = var_12_2
	end

	gohelper.setActive(arg_12_0._gobadgeItem, false)
end

function var_0_0.playBadgeAnim(arg_13_0)
	local var_13_0 = arg_13_0.actInfo:getBadgeScoreChangeDic()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.badgeItemList) do
		local var_13_1 = var_13_0[iter_13_1.id]

		if var_13_1 and var_13_1 ~= 0 then
			iter_13_1.anim:Play("refresh")
		end
	end
end

return var_0_0

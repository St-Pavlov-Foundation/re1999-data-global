module("modules.logic.versionactivity2_5.autochess.view.AutoChessRankUpView", package.seeall)

local var_0_0 = class("AutoChessRankUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBadgeRoot = gohelper.findChild(arg_1_0.viewGO, "#go_BadgeRoot")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_Reward/reward/#go_RewardItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Rewards)

	arg_7_0.actMo = Activity182Model.instance:getActMo()

	local var_7_0 = arg_7_0:getResInst(AutoChessStrEnum.ResPath.BadgeItem, arg_7_0._goBadgeRoot)

	MonoHelper.addNoUpdateLuaComOnceToGo(var_7_0, AutoChessBadgeItem):setData(arg_7_0.actMo.rank, arg_7_0.actMo.score, AutoChessBadgeItem.ShowType.RankUpView)

	if arg_7_0.actMo.newRankUp then
		local var_7_1 = lua_auto_chess_rank.configDict[arg_7_0.actMo.activityId][arg_7_0.actMo.rank]

		if var_7_1 then
			local var_7_2 = DungeonConfig.instance:getRewardItems(var_7_1.reward)

			for iter_7_0, iter_7_1 in ipairs(var_7_2) do
				local var_7_3 = gohelper.cloneInPlace(arg_7_0._goRewardItem, iter_7_0)
				local var_7_4 = IconMgr.instance:getCommonItemIcon(var_7_3)

				gohelper.setAsFirstSibling(var_7_4.go)
				var_7_4:setMOValue(iter_7_1[1], iter_7_1[2], iter_7_1[3], nil, true)
				var_7_4:setCountFontSize(32)
			end

			gohelper.setActive(arg_7_0.goReward, #var_7_2 ~= 0)
		end
	else
		gohelper.setActive(arg_7_0.goReward, false)
	end

	gohelper.setActive(arg_7_0._goRewardItem, false)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0.actMo:clearRankUpMark()
	AutoChessController.instance:popupRewardView()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0

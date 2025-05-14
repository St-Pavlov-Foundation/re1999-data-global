module("modules.logic.versionactivity2_5.autochess.view.game.AutoChessPveFirstSettleView", package.seeall)

local var_0_0 = class("AutoChessPveFirstSettleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSpecialTarget = gohelper.findChild(arg_1_0.viewGO, "root/#go_SpecialTarget")
	arg_1_0._txtSpecialTarget = gohelper.findChildText(arg_1_0.viewGO, "root/#go_SpecialTarget/#txt_SpecialTarget")
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

	local var_7_0 = AutoChessModel.instance.episodeId

	arg_7_0.config = lua_auto_chess_episode.configDict[var_7_0]

	local var_7_1 = GameUtil.splitString2(arg_7_0.config.firstBounds, true)

	if var_7_1 then
		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			local var_7_2 = gohelper.cloneInPlace(arg_7_0._goRewardItem)
			local var_7_3 = IconMgr.instance:getCommonItemIcon(var_7_2)

			gohelper.setAsFirstSibling(var_7_3.go)
			var_7_3:setMOValue(iter_7_1[1], iter_7_1[2], iter_7_1[3])

			local var_7_4 = var_7_3:getCountBg()

			transformhelper.setLocalScale(var_7_4.transform, 1, 1.7, 1)
			var_7_3:setCountFontSize(45)
		end
	else
		gohelper.setActive(arg_7_0._goReward, false)
	end

	gohelper.setActive(arg_7_0._goRewardItem, false)
	arg_7_0:refreshSpecialUnlockTips()
end

function var_0_0.onClose(arg_8_0)
	AutoChessController.instance:onSettleViewClose()
	AutoChessController.instance:popupRewardView()
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.refreshSpecialUnlockTips(arg_10_0)
	local var_10_0 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value)
	local var_10_1 = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	local var_10_2 = lua_auto_chess_episode.configDict[AutoChessEnum.PvpEpisodeId].preEpisode

	if arg_10_0.config.id == var_10_0 then
		arg_10_0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips3")
	elseif arg_10_0.config.id == var_10_1 then
		arg_10_0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips2")
	elseif arg_10_0.config.id == var_10_2 then
		arg_10_0._txtSpecialTarget.text = luaLang("autochess_pvesettleview_tips1")
	else
		gohelper.setActive(arg_10_0._goSpecialTarget, false)
	end
end

return var_0_0

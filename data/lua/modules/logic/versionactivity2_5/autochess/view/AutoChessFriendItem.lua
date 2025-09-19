module("modules.logic.versionactivity2_5.autochess.view.AutoChessFriendItem", package.seeall)

local var_0_0 = class("AutoChessFriendItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._textPlayerName = gohelper.findChildText(arg_1_0.viewGO, "#txt_Name")
	arg_1_0._playerHeadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "HeroHeadIcon/#simage_headicon")
	arg_1_0._playerBadge = gohelper.findChildText(arg_1_0.viewGO, "Badge/#txt_badge")
	arg_1_0._btnSelectFriend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btnClick")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSelectFriend:AddClickListener(arg_2_0.onClickSelectFriend, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSelectFriend:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickSelectFriend(arg_5_0)
	AutoChessController.instance:dispatchEvent(AutoChessEvent.SelectFriendSnapshot, arg_5_0._userId)
end

function var_0_0.onUpdateData(arg_6_0, arg_6_1)
	arg_6_0._textPlayerName.text = arg_6_1.name

	local var_6_0 = arg_6_1.portrait
	local var_6_1 = arg_6_1.rank

	arg_6_0._userId = arg_6_1.userId

	if not arg_6_0._playerLiveHeadIcon then
		arg_6_0._playerLiveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_6_0._playerHeadicon)
	end

	arg_6_0._playerLiveHeadIcon:setLiveHead(var_6_0)

	local var_6_2 = Activity182Model.instance:getCurActId()

	arg_6_0._playerRankCfg = lua_auto_chess_rank.configDict[var_6_2][var_6_1]

	if not arg_6_0._playerRankCfg then
		arg_6_0._playerBadge.text = luaLang("autochess_badgeitem_noget")
	end

	arg_6_0._playerBadge.text = arg_6_0._playerRankCfg.name
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0

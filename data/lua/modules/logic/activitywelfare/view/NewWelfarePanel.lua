module("modules.logic.activitywelfare.view.NewWelfarePanel", package.seeall)

local var_0_0 = class("NewWelfarePanel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._btnClose = gohelper.findChildButton(arg_1_0.viewGO, "Root/#btn_Close")
	arg_1_0._rewardItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnClaimOnClick(arg_4_0, arg_4_1)
	Activity160Rpc.instance:sendGetAct160FinishMissionRequest(arg_4_0.actId, arg_4_1)
end

function var_0_0._jumpToTargetDungeon(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1

	if var_5_0 ~= 0 then
		local var_5_1 = DungeonConfig.instance:getEpisodeCO(var_5_0)
		local var_5_2 = {}
		local var_5_3 = var_5_1.id
		local var_5_4 = var_5_1.chapterId

		var_5_2.chapterType = lua_chapter.configDict[var_5_4].type
		var_5_2.chapterId = var_5_4
		var_5_2.episodeId = var_5_3

		ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
		DungeonController.instance:jumpDungeon(var_5_2)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = ActivityEnum.Activity.NewWelfare
	arg_6_0.missionCO = Activity160Config.instance:getActivityMissions(arg_6_0.actId)

	arg_6_0:_initRewardItem()
end

function var_0_0._initRewardItem(arg_7_0)
	if not arg_7_0.missionCO then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.missionCO) do
		local var_7_0 = arg_7_0:getUserDataTb_()
		local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "Root/Card" .. iter_7_0)

		var_7_0.go = var_7_1
		var_7_0.co = iter_7_1
		var_7_0.id = iter_7_1.id
		var_7_0.gocomplete = gohelper.findChild(var_7_1, "#go_Complete")
		var_7_0.gonormal = gohelper.findChild(var_7_1, "#go_Normal")
		var_7_0.txttitle = gohelper.findChildText(var_7_1, "#txt_Title")
		var_7_0.txtnum = gohelper.findChildText(var_7_1, "#txt_Num")
		var_7_0.goClaim = gohelper.findChild(var_7_0.gonormal, "#btn_Claim")
		var_7_0.btnClaim = gohelper.findChildButton(var_7_0.gonormal, "#btn_Claim")

		var_7_0.btnClaim:AddClickListener(arg_7_0._btnClaimOnClick, arg_7_0, iter_7_1.id)

		var_7_0.gogo = gohelper.findChild(var_7_0.gonormal, "#btn_Go")
		var_7_0.btnGo = gohelper.findChildButton(var_7_0.gonormal, "#btn_Go")

		var_7_0.btnGo:AddClickListener(arg_7_0._jumpToTargetDungeon, arg_7_0, iter_7_1.episodeId)
		table.insert(arg_7_0._rewardItemList, var_7_0)
	end
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, arg_8_0._onInfoUpdate, arg_8_0)
	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	local var_9_0 = ActivityConfig.instance:getActivityCo(arg_9_0.actId)

	arg_9_0._txtDescr.text = var_9_0.actDesc
	arg_9_0._txtLimitTime.text = luaLang("activityshow_unlimittime")

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0:refreshItem()
end

function var_0_0._onInfoUpdate(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.actId then
		arg_11_0:refreshUI()
	end
end

function var_0_0._jumpFinishCallBack(arg_12_0)
	ViewMgr.instance:closeView(ViewName.NewWelfarePanel)
end

function var_0_0.refreshItem(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(arg_13_0._rewardItemList) do
		local var_13_0 = Activity160Model.instance:isMissionFinish(arg_13_0.actId, iter_13_1.id)
		local var_13_1 = Activity160Model.instance:isMissionCanGet(arg_13_0.actId, iter_13_1.id)

		gohelper.setActive(iter_13_1.gocomplete, var_13_0)
		gohelper.setActive(iter_13_1.goClaim, var_13_1)
	end
end

function var_0_0.onClose(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._rewardItemList) do
		iter_14_1.btnClaim:RemoveClickListener()
		iter_14_1.btnGo:RemoveClickListener()
	end
end

return var_0_0

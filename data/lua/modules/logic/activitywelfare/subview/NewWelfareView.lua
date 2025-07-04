module("modules.logic.activitywelfare.subview.NewWelfareView", package.seeall)

local var_0_0 = class("NewWelfareView", BaseView)

var_0_0.FirstProgress = 0.18
var_0_0.SecondProgress = 0.58

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_Descr")
	arg_1_0._imgfill = gohelper.findChildImage(arg_1_0.viewGO, "Root/Progress/go_fillbg/go_fill")
	arg_1_0._rewardItemList = {}
	arg_1_0._progressItemList = {}
	arg_1_0._isfirstopen = false

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

		ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
		DungeonController.instance:jumpDungeon(var_5_2)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0.actId = ActivityEnum.Activity.NewWelfare
	arg_6_0.missionCO = Activity160Config.instance:getActivityMissions(arg_6_0.actId)

	arg_6_0:_initRewardItem()
	arg_6_0:_initProgress()
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

function var_0_0._initProgress(arg_8_0)
	if not arg_8_0.missionCO then
		return
	end

	local var_8_0 = #arg_8_0.missionCO

	for iter_8_0 = 1, var_8_0 do
		local var_8_1 = arg_8_0:getUserDataTb_()
		local var_8_2 = gohelper.findChild(arg_8_0.viewGO, "Root/Progress/go_point" .. iter_8_0)

		var_8_1.id = arg_8_0.missionCO[iter_8_0].id
		var_8_1.go = var_8_2
		var_8_1.godark = gohelper.findChild(var_8_2, "dark")
		var_8_1.golight = gohelper.findChild(var_8_2, "light")

		table.insert(arg_8_0._progressItemList, var_8_1)
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = arg_10_0.viewParam.parent

	gohelper.addChild(var_10_0, arg_10_0.viewGO)
	arg_10_0:addEventCb(Activity160Controller.instance, Activity160Event.InfoUpdate, arg_10_0._onInfoUpdate, arg_10_0)
	arg_10_0:refreshView()
end

function var_0_0.refreshView(arg_11_0)
	local var_11_0 = ActivityConfig.instance:getActivityCo(arg_11_0.actId)

	arg_11_0._txtDescr.text = var_11_0.actDesc
	arg_11_0._txtLimitTime.text = luaLang("activityshow_unlimittime")

	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:refreshItem()
	arg_12_0:refreshProgress()
end

function var_0_0._onInfoUpdate(arg_13_0, arg_13_1)
	if arg_13_1 == arg_13_0.actId then
		arg_13_0:refreshUI()
	end
end

function var_0_0._jumpFinishCallBack(arg_14_0)
	ViewMgr.instance:closeView(ViewName.ActivityWelfareView)
end

function var_0_0.refreshItem(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._rewardItemList) do
		local var_15_0 = Activity160Model.instance:isMissionFinish(arg_15_0.actId, iter_15_1.id)
		local var_15_1 = Activity160Model.instance:isMissionCanGet(arg_15_0.actId, iter_15_1.id)

		gohelper.setActive(iter_15_1.gocomplete, var_15_0)
		gohelper.setActive(iter_15_1.gonormal, not var_15_0)
		gohelper.setActive(iter_15_1.goClaim, var_15_1)
		gohelper.setActive(iter_15_1.gogo, not var_15_1)
	end
end

function var_0_0.refreshProgress(arg_16_0)
	local var_16_0 = 0

	arg_16_0._progress = 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._progressItemList) do
		local var_16_1 = Activity160Model.instance:isMissionFinish(arg_16_0.actId, iter_16_1.id)
		local var_16_2 = Activity160Model.instance:isMissionCanGet(arg_16_0.actId, iter_16_1.id)
		local var_16_3 = var_16_1 or var_16_2

		if var_16_3 then
			var_16_0 = var_16_0 + 1
		end

		gohelper.setActive(iter_16_1.godark, not var_16_3)
		gohelper.setActive(iter_16_1.golight, var_16_3)
	end

	if var_16_0 == 1 then
		arg_16_0._progress = var_0_0.FirstProgress
	elseif var_16_0 == 2 then
		arg_16_0._progress = var_0_0.SecondProgress
	elseif var_16_0 == 3 then
		arg_16_0._progress = 1
	end

	if not arg_16_0._isfirstopen then
		arg_16_0._faithTweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_16_0._progress, 0.5, arg_16_0._setFaithPercent, arg_16_0._setFaithValue, arg_16_0, nil, EaseType.Linear)
		arg_16_0._isfirstopen = true
	end
end

function var_0_0._setFaithPercent(arg_17_0, arg_17_1)
	arg_17_0._imgfill.fillAmount = arg_17_1
end

function var_0_0._setFaithValue(arg_18_0)
	arg_18_0:_setFaithPercent(arg_18_0._progress)

	if arg_18_0._faithTweenId then
		ZProj.TweenHelper.KillById(arg_18_0._faithTweenId)

		arg_18_0._faithTweenId = nil
	end
end

function var_0_0.onClose(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._rewardItemList) do
		iter_19_1.btnClaim:RemoveClickListener()
		iter_19_1.btnGo:RemoveClickListener()
	end

	GameUtil.onDestroyViewMember_TweenId(arg_19_0, "_faithTweenId")
end

return var_0_0

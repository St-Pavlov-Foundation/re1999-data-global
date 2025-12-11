module("modules.logic.battlepass.view.BpMainBtnItem", package.seeall)

local var_0_0 = class("BpMainBtnItem", ActCenterItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, gohelper.cloneInPlace(arg_1_1))
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0._btnitem = gohelper.getClickWithAudio(arg_2_0._imgGo, AudioEnum2_6.BP.MainBtn)

	local var_2_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	gohelper.setActive(arg_2_0._goexpup, BpModel.instance:isShowExpUp())

	if var_2_0 and var_2_0.isSp then
		local var_2_1 = gohelper.findChild(arg_2_0.go, "link")

		gohelper.setActive(var_2_1, true)
	end

	gohelper.setActive(gohelper.findChild(arg_2_0.go, "bg_tarot"), true)
	arg_2_0:_initReddotitem()
	arg_2_0:_refreshItem()
end

function var_0_0.onClick(arg_3_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView()
end

function var_0_0._refreshItem(arg_4_0)
	local var_4_0 = ActivityModel.showActivityEffect()
	local var_4_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_4_2 = var_4_0 and var_4_1.mainViewActBtnPrefix .. "icon_3" or "icon_3"

	UISpriteSetMgr.instance:setMainSprite(arg_4_0._imgitem, var_4_2, true)

	if not var_4_0 then
		local var_4_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_4_3 then
			for iter_4_0, iter_4_1 in ipairs(var_4_3.mainViewActBtn) do
				local var_4_4 = gohelper.findChild(arg_4_0.go, iter_4_1)

				if var_4_4 then
					gohelper.setActive(var_4_4, var_4_0)
				end
			end
		end
	end

	arg_4_0:_refreshDeadline()
	TaskDispatcher.runRepeat(arg_4_0._refreshDeadline, arg_4_0, 1)
	arg_4_0._redDot:refreshDot()
end

function var_0_0._refreshDeadline(arg_5_0)
	local var_5_0 = BpConfig.instance:getBpCO(BpModel.instance.id).promptDays or 0
	local var_5_1 = BpModel.instance:getBpEndTime() - ServerTime.now()

	if var_5_1 > var_5_0 * TimeUtil.OneDaySecond then
		gohelper.setActive(arg_5_0._godeadline, false)

		return
	end

	gohelper.setActive(arg_5_0._godeadline, true)

	local var_5_2, var_5_3 = TimeUtil.secondToRoughTime(math.floor(var_5_1), true)

	arg_5_0._txttime.text = var_5_2 .. var_5_3
end

function var_0_0.isShowRedDot(arg_6_0)
	return arg_6_0._redDot.show
end

function var_0_0._initReddotitem(arg_7_0)
	local var_7_0 = arg_7_0.go
	local var_7_1 = gohelper.findChild(var_7_0, "go_activityreddot")

	arg_7_0._redDot = RedDotController.instance:addRedDot(var_7_1, RedDotEnum.DotNode.BattlePass)

	do return end

	local var_7_2 = gohelper.findChild(var_7_0, "go_activityreddot/#go_special_reds")
	local var_7_3 = var_7_2.transform
	local var_7_4 = var_7_3.childCount

	for iter_7_0 = 1, var_7_4 do
		local var_7_5 = var_7_3:GetChild(iter_7_0 - 1)

		gohelper.setActive(var_7_5.gameObject, false)
	end

	local var_7_6 = gohelper.findChild(var_7_2, "#go_bp_red")

	arg_7_0._redDot = RedDotController.instance:addRedDotTag(var_7_6, RedDotEnum.DotNode.BattlePass, false, arg_7_0._onRefreshDot, arg_7_0)
	arg_7_0._btnitem2 = gohelper.getClickWithAudio(var_7_6, AudioEnum2_6.BP.MainBtn)
end

function var_0_0._onRefreshDot(arg_8_0, arg_8_1)
	local var_8_0 = RedDotModel.instance:isDotShow(arg_8_1.dotId, 0)

	arg_8_1.show = var_8_0

	gohelper.setActive(arg_8_1.go, var_8_0)
	gohelper.setActive(arg_8_0._imgGo, not var_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._refreshDeadline, arg_9_0)
end

return var_0_0

module("modules.common.activity.ActivityLiveMgr", package.seeall)

local var_0_0 = class("ActivityLiveMgr")

function var_0_0.init(arg_1_0)
	arg_1_0:initActivityMgrList()
	arg_1_0:addConstEvents()
end

function var_0_0.getLiveMgrVersion(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.actMgrInstanceList) do
		local var_2_0 = iter_2_1.__cname

		return string.gsub(var_2_0, "ActivityLiveMgr", "")
	end
end

function var_0_0.initActivityMgrList(arg_3_0)
	arg_3_0.actMgrInstanceList = {
		ActivityLiveMgr2_8.instance
	}
	arg_3_0.actId2ViewList = {}
	arg_3_0.actIdCloseCheckList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.actMgrInstanceList) do
		iter_3_1:init()

		for iter_3_2, iter_3_3 in pairs(iter_3_1:getActId2ViewList()) do
			if arg_3_0.actId2ViewList[iter_3_2] then
				logWarn(string.format("act : %s config multiple, please check!"))
			end

			arg_3_0.actId2ViewList[iter_3_2] = iter_3_3
		end

		local var_3_0 = iter_3_1.getActIdCheckCloseList and iter_3_1:getActIdCheckCloseList()

		if var_3_0 then
			for iter_3_4, iter_3_5 in pairs(var_3_0) do
				arg_3_0.actIdCloseCheckList[iter_3_4] = iter_3_5
			end
		end
	end
end

function var_0_0.addConstEvents(arg_4_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_4_0.checkActivity, arg_4_0)
end

function var_0_0.checkActivity(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_1) or arg_5_1 == 0 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.actId2ViewList) do
			if arg_5_0:checkOneActivityIsEnd(iter_5_0) then
				return
			end
		end
	end

	arg_5_0:checkOneActivityIsEnd(arg_5_1)
end

function var_0_0.checkOneActivityIsEnd(arg_6_0, arg_6_1)
	if string.nilorempty(arg_6_1) or arg_6_1 == 0 then
		return false
	end

	if ActivityHelper.getActivityStatus(arg_6_1) ~= ActivityEnum.ActivityStatus.Normal then
		local var_6_0 = arg_6_0.actIdCloseCheckList[arg_6_1]
		local var_6_1 = arg_6_0.actId2ViewList[arg_6_1]

		if var_6_1 then
			for iter_6_0, iter_6_1 in ipairs(var_6_1) do
				if ViewMgr.instance:isOpen(iter_6_1) and (not var_6_0 or var_6_0(arg_6_1, iter_6_1)) then
					MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)

					return true
				end
			end
		end

		ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	end

	return false
end

function var_0_0.yesCallback()
	ActivityController.instance:dispatchEvent(ActivityEvent.CheckGuideOnEndActivity)
	NavigateButtonsView.homeClick()
end

var_0_0.instance = var_0_0.New()

return var_0_0

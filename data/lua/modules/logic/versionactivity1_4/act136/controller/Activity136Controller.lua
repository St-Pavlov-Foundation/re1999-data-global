module("modules.logic.versionactivity1_4.act136.controller.Activity136Controller", package.seeall)

local var_0_0 = class("Activity136Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayGetInfo, arg_3_0)
end

function var_0_0._onRefreshActivityState(arg_4_0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.SelfSelectCharacter) then
		TaskDispatcher.cancelTask(arg_4_0._delayGetInfo, arg_4_0)
		TaskDispatcher.runDelay(arg_4_0._delayGetInfo, arg_4_0, 0.2)
	end
end

function var_0_0._delayGetInfo(arg_5_0)
	Activity136Rpc.instance:sendGet136InfoRequest(ActivityEnum.Activity.SelfSelectCharacter)
end

function var_0_0.confirmReceiveCharacterCallback(arg_6_0)
	ViewMgr.instance:closeView(ViewName.Activity136ChoiceView)
end

function var_0_0.openActivity136View(arg_7_0, arg_7_1)
	if Activity136Model.instance:isActivity136InOpen(true) then
		ViewMgr.instance:openView(ViewName.Activity136View, arg_7_1)
	end
end

function var_0_0.openActivity136ChoiceView(arg_8_0)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	ViewMgr.instance:openView(ViewName.Activity136ChoiceView)
end

function var_0_0.receiveCharacter(arg_9_0, arg_9_1)
	if not Activity136Model.instance:isActivity136InOpen(true) then
		return
	end

	if not arg_9_1 then
		GameFacade.showToast(ToastEnum.Activity136NotSelect)

		return
	end

	if Activity136Model.instance:hasReceivedCharacter() then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	local var_9_0 = HeroModel.instance:getByHeroId(arg_9_1)
	local var_9_1 = HeroConfig.instance:getHeroCO(arg_9_1)
	local var_9_2 = MessageBoxIdDefine.Activity136SelectCharacter
	local var_9_3 = var_9_1 and var_9_1.name or ""
	local var_9_4 = ""
	local var_9_5 = ""

	if var_9_0 and var_9_1 then
		local var_9_6 = {}

		if not HeroModel.instance:isMaxExSkill(arg_9_1, true) then
			local var_9_7 = GameUtil.splitString2(var_9_1.duplicateItem, true)

			var_9_6 = var_9_7 and var_9_7[1] or var_9_6
			var_9_2 = MessageBoxIdDefine.Activity136SelectCharacterRepeat
		else
			var_9_6 = string.splitToNumber(var_9_1.duplicateItem2, "#") or var_9_6
			var_9_5 = var_9_6[3] or ""
			var_9_2 = MessageBoxIdDefine.Activity136SelectCharacterRepeat2
		end

		local var_9_8 = var_9_6[1]
		local var_9_9 = var_9_6[2]

		if var_9_8 and var_9_9 then
			local var_9_10, var_9_11 = ItemModel.instance:getItemConfigAndIcon(var_9_6[1], var_9_6[2])

			var_9_4 = var_9_10 and var_9_10.name or ""
		end
	end

	GameFacade.showMessageBox(var_9_2, MsgBoxEnum.BoxType.Yes_No, function()
		arg_9_0:_confirmSelect(arg_9_1)
	end, nil, nil, arg_9_0, nil, nil, var_9_3, var_9_4, var_9_5)
end

function var_0_0._confirmSelect(arg_11_0, arg_11_1)
	local var_11_0 = Activity136Model.instance:getCurActivity136Id()

	if var_11_0 then
		Activity136Rpc.instance:sendAct136SelectRequest(var_11_0, arg_11_1)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0

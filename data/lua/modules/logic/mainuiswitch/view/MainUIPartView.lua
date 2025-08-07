module("modules.logic.mainuiswitch.view.MainUIPartView", package.seeall)

local var_0_0 = class("MainUIPartView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goactbottomDec = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg/act_bottomDec")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_2_0.refreshMainUI, arg_2_0)
	arg_2_0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, arg_2_0._setViewVisible, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._OnCloseViewFinish, arg_2_0, LuaEventSystem.Low)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, arg_3_0.refreshMainUI, arg_3_0)
	arg_3_0:removeEventCb(MainController.instance, MainEvent.SetMainViewVisible, arg_3_0._setViewVisible, arg_3_0)
	arg_3_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._OnCloseViewFinish, arg_3_0, LuaEventSystem.Low)
end

function var_0_0._OnCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.LoadingView then
		arg_4_0:_setViewVisible(true)
	end
end

function var_0_0._setViewVisible(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_0._uiId then
		if arg_5_0._uiId == MainUISwitchEnum.Skin.Normal then
			if not arg_5_0._aniroommask then
				arg_5_0._aniroommask = gohelper.findChild(arg_5_0.viewGO, "right/#btn_summon/1/mask/image"):GetComponent(typeof(UnityEngine.Animation))
			end

			arg_5_0._aniroommask:Play()
		else
			if not arg_5_0._aniroommask1 then
				arg_5_0._aniroommask1 = gohelper.findChild(arg_5_0.viewGO, "right/#btn_summon/2/icon/mask1/image"):GetComponent(typeof(UnityEngine.Animator))
			end

			arg_5_0._aniroommask1:Play("in", 0, 0)
		end
	end
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.SkinId

	arg_6_0:refreshMainUI(var_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "right/#btn_role/2/act_rolehead/ani")

	arg_7_0._imagerolehead = gohelper.findChildImage(var_7_0, "act_rolehead")
	arg_7_0._animrolehead = var_7_0:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initMainUIPart(arg_8_0)
	local var_8_0 = gohelper.findChild(arg_8_0.viewGO, "left/#btn_mail")
	local var_8_1 = gohelper.findChild(arg_8_0.viewGO, "left/#btn_storage")
	local var_8_2 = gohelper.findChild(arg_8_0.viewGO, "left/#btn_quest/btn")
	local var_8_3 = gohelper.findChild(arg_8_0.viewGO, "left/#btn_bank")
	local var_8_4 = gohelper.findChild(arg_8_0.viewGO, "right/#btn_room")
	local var_8_5 = gohelper.findChild(arg_8_0.viewGO, "right/#btn_role")
	local var_8_6 = gohelper.findChild(arg_8_0.viewGO, "right/#btn_summon")
	local var_8_7 = gohelper.findChild(arg_8_0.viewGO, "right/#btn_power")
	local var_8_8 = gohelper.findChild(arg_8_0.viewGO, "right/go_fight")
	local var_8_9 = gohelper.findChild(arg_8_0.viewGO, "right/go_fight/#go_activityfight/#btn_fight")
	local var_8_10 = gohelper.findChild(arg_8_0.viewGO, "right/go_fight/#go_normalfight/#btn_jumpfight")
	local var_8_11 = gohelper.findChild(arg_8_0.viewGO, "right/go_fight/#go_normalfight/#btn_fight")

	arg_8_0._mainUIParts = arg_8_0:getUserDataTb_()

	for iter_8_0, iter_8_1 in pairs(MainUISwitchEnum.Skin) do
		local var_8_12 = arg_8_0._mainUIParts[iter_8_1]

		if not var_8_12 then
			var_8_12 = arg_8_0:getUserDataTb_()
			arg_8_0._mainUIParts[iter_8_1] = var_8_12
		end

		var_8_12[MainUISwitchEnum.MainUIPart.Mail] = gohelper.findChild(var_8_0, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Quest] = gohelper.findChild(var_8_1, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Storage] = gohelper.findChild(var_8_2, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Bank] = gohelper.findChild(var_8_3, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Room] = gohelper.findChild(var_8_4, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Role] = gohelper.findChild(var_8_5, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Summon] = gohelper.findChild(var_8_6, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Power] = gohelper.findChild(var_8_7, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.Fight] = gohelper.findChild(var_8_8, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.ActivityFight] = gohelper.findChild(var_8_9, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.NormalFight] = gohelper.findChild(var_8_11, iter_8_1)
		var_8_12[MainUISwitchEnum.MainUIPart.NormalJumpFight] = gohelper.findChild(var_8_10, iter_8_1)
	end
end

function var_0_0.refreshMainUI(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or MainUISwitchModel.instance:getCurUseUI()

	if arg_9_0._uiId == arg_9_1 then
		return
	end

	arg_9_0._uiId = arg_9_1
	arg_9_0._bankeffect = 1

	if not arg_9_0._mainUIParts then
		arg_9_0:_initMainUIPart()
	end

	for iter_9_0, iter_9_1 in pairs(MainUISwitchEnum.Skin) do
		local var_9_0 = arg_9_0._mainUIParts[iter_9_1]

		for iter_9_2, iter_9_3 in pairs(MainUISwitchEnum.MainUIPart) do
			local var_9_1 = var_9_0[iter_9_3]

			if arg_9_1 == iter_9_1 then
				var_9_1 = var_9_1 or arg_9_0._mainUIParts[MainUISwitchEnum.Skin.Normal][iter_9_3]

				gohelper.setActive(var_9_1, true)
			else
				local var_9_2 = arg_9_0._mainUIParts[arg_9_1][iter_9_3]

				if var_9_1 and var_9_2 ~= var_9_1 then
					gohelper.setActive(var_9_1, false)
				end
			end
		end
	end

	gohelper.setActive(arg_9_0._goactbottomDec, arg_9_1 == MainUISwitchEnum.Skin.Sp01)
	TaskDispatcher.cancelTask(arg_9_0._cutRoleHead, arg_9_0)

	if arg_9_1 == MainUISwitchEnum.Skin.Sp01 then
		arg_9_0:_delayCutHead()
		TaskDispatcher.runRepeat(arg_9_0._cutRoleHead, arg_9_0, MainUISwitchEnum.HeadCutTime)
	end

	arg_9_0:_setViewVisible(true)
end

function var_0_0._cutRoleHead(arg_10_0)
	arg_10_0._animrolehead:Play(MainUISwitchEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(arg_10_0._delayCutHead, arg_10_0)
	TaskDispatcher.runDelay(arg_10_0._delayCutHead, arg_10_0, MainUISwitchEnum.HeadCutLoadime)
end

function var_0_0._delayCutHead(arg_11_0)
	local var_11_0 = math.random(1, 3)

	UISpriteSetMgr.instance:setMainSprite(arg_11_0._imagerolehead, "main_act_rolehead_" .. var_11_0, true)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._cutRoleHead, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayCutHead, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0

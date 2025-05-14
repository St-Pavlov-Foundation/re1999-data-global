module("modules.logic.versionactivity1_2.jiexika.view.Activity114TravelItem", package.seeall)

local var_0_0 = class("Activity114TravelItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.index = arg_1_2
	arg_1_0._golock = gohelper.findChild(arg_1_0.go, "go_lock")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.go, "normal")
	arg_1_0._name = gohelper.findChildTextMesh(arg_1_0._gonormal, "name")
	arg_1_0._nameEn = gohelper.findChildTextMesh(arg_1_0._gonormal, "name/nameEn")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0._gonormal, "point/go_point")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.go, "btn_click")
	arg_1_0._selectAnim = SLFramework.AnimatorPlayer.Get(arg_1_0._goselect)

	arg_1_0:addEventListeners()
	arg_1_0:onInitView()
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnclick, arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0._btnclickOnClick(arg_3_0)
	if arg_3_0._eventStatu ~= Activity114Enum.TravelStatus.Normal then
		if arg_3_0._eventStatu == Activity114Enum.TravelStatus.EventBlock or arg_3_0._eventStatu == Activity114Enum.TravelStatus.EventEnd then
			GameFacade.showToast(ToastEnum.Act114TravelEnd)
		end

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_travel_circle)
	gohelper.setActive(arg_3_0._goselect, true)
	arg_3_0._selectAnim:Stop()
	arg_3_0._selectAnim:Play(UIAnimationName.Open, arg_3_0.showMsgBox, arg_3_0)
	UIBlockMgr.instance:startBlock("Activity114TravelItem")
end

function var_0_0.showMsgBox(arg_4_0)
	UIBlockMgr.instance:endBlock("Activity114TravelItem")
	arg_4_0:onTravel()
end

function var_0_0.onTravel(arg_5_0)
	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	Activity114Rpc.instance:travelRequest(Activity114Model.instance.id, arg_5_0.index)
end

function var_0_0.cancelTravel(arg_6_0)
	gohelper.setActive(arg_6_0._goselect, false)
end

function var_0_0.onInitView(arg_7_0)
	local var_7_0 = Activity114Config.instance:getTravelCoList(Activity114Model.instance.id)[arg_7_0.index]

	arg_7_0.co = var_7_0
	arg_7_0._name.text = var_7_0.place
	arg_7_0._nameEn.text = var_7_0.placeEn

	local var_7_1 = Activity114Model.instance.unLockTravelDict[arg_7_0.index]
	local var_7_2 = not var_7_1

	gohelper.setActive(arg_7_0._golock, var_7_2)
	gohelper.setActive(arg_7_0._gonormal, not var_7_2)
	gohelper.setActive(arg_7_0._goselect, false)
	gohelper.setActive(arg_7_0._gopoint, false)
	gohelper.setActive(arg_7_0._btnclick.gameObject, not var_7_2)

	arg_7_0._eventStatu = Activity114Enum.TravelStatus.Normal

	if var_7_2 then
		arg_7_0._eventStatu = Activity114Enum.TravelStatus.TravelLock

		return
	end

	local var_7_3 = string.splitToNumber(var_7_0.events, "#")
	local var_7_4 = var_7_1.times

	arg_7_0.points = {}

	for iter_7_0 = 1, #var_7_3 do
		local var_7_5 = 1

		if var_7_4 < iter_7_0 and var_7_1.isBlock ~= 1 then
			var_7_5 = 1

			local var_7_6 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, var_7_3[iter_7_0])

			if var_7_6.config.isCheckEvent == 1 then
				if var_7_6.config.disposable == 1 then
					var_7_5 = 6
				else
					var_7_5 = 7
				end
			end
		elseif iter_7_0 < var_7_4 or iter_7_0 == var_7_4 and var_7_1.isBlock ~= 1 then
			var_7_5 = 2
		elseif iter_7_0 == var_7_4 and var_7_1.isBlock == 1 then
			var_7_5 = 3
		elseif var_7_4 < iter_7_0 and var_7_1.isBlock == 1 then
			var_7_5 = 4
		end

		arg_7_0:_createPoint(iter_7_0, var_7_5)
	end

	if var_7_1.isBlock == 1 then
		arg_7_0._eventStatu = Activity114Enum.TravelStatus.EventBlock
	else
		local var_7_7 = var_7_3[var_7_1.times + 1]

		if not var_7_7 then
			arg_7_0._eventStatu = Activity114Enum.TravelStatus.EventEnd
		elseif not Activity114Model.instance.unLockEventDict[var_7_7] then
			arg_7_0._eventStatu = Activity114Enum.TravelStatus.EventLock
		end
	end

	if var_7_0.residentEvent > 0 then
		if arg_7_0._eventStatu ~= Activity114Enum.TravelStatus.Normal then
			arg_7_0._eventStatu = Activity114Enum.TravelStatus.Normal

			local var_7_8 = #arg_7_0.points + 1

			arg_7_0:_createPoint(var_7_8, 5)
		end
	elseif var_7_1.hasSpecialEvent and var_7_0.specialEvents > 0 then
		arg_7_0._eventStatu = Activity114Enum.TravelStatus.Normal
	end

	if not Activity114Model.instance:getIsPlayUnLock(Activity114Enum.EventType.Travel, var_7_1.travelId) then
		gohelper.setActive(arg_7_0._golock, true)
		arg_7_0:playUnlockEffect()
	end
end

function var_0_0._createPoint(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.points[arg_8_1] = arg_8_0:getUserDataTb_()
	arg_8_0.points[arg_8_1].go = gohelper.cloneInPlace(arg_8_0._gopoint, "Point")
	arg_8_0.points[arg_8_1].anim = arg_8_0.points[arg_8_1].go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_8_0.points[arg_8_1].go, true)

	for iter_8_0 = 1, 7 do
		local var_8_0 = gohelper.findChild(arg_8_0.points[arg_8_1].go, "type" .. iter_8_0)

		gohelper.setActive(var_8_0, arg_8_2 == iter_8_0)
	end
end

function var_0_0.playUnlockEffect(arg_9_0)
	for iter_9_0 = 1, #arg_9_0.points do
		arg_9_0.points[iter_9_0].anim:Play(UIAnimationName.Unlock, 0, 0)
	end

	local var_9_0 = SLFramework.AnimatorPlayer.Get(arg_9_0.go)

	var_9_0:Stop()
	var_9_0:Play(UIAnimationName.Unlock, arg_9_0.playUnlockEffectFinish, arg_9_0)
	Activity114Model.instance:setIsPlayUnLock(Activity114Enum.EventType.Travel, arg_9_0.index)
end

function var_0_0.playUnlockEffectFinish(arg_10_0)
	gohelper.setActive(arg_10_0._golock, false)
end

function var_0_0.onDestroy(arg_11_0)
	UIBlockMgr.instance:endBlock("Activity114TravelItem")

	if arg_11_0.points then
		for iter_11_0 = 1, #arg_11_0.points do
			gohelper.destroy(arg_11_0.points[iter_11_0].go)
		end
	end

	arg_11_0:__onDispose()
end

return var_0_0

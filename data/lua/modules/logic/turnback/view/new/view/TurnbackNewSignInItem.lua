module("modules.logic.turnback.view.new.view.TurnbackNewSignInItem", package.seeall)

local var_0_0 = class("TurnbackNewSignInItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.go, "group/txt_day")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.go, "#go_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.go, "#go_hasget")
	arg_1_0._btncanget = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_click")
	arg_1_0._btnlatter = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_latter")
	arg_1_0.canvasgroup = gohelper.findChild(arg_1_0.go, "group"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0.rewardList = {}
end

function var_0_0.addEventListeners(arg_2_0)
	TurnbackController.instance:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInItem, arg_2_0.refreshItem, arg_2_0)
	arg_2_0._btncanget:AddClickListener(arg_2_0._btncangetOnClick, arg_2_0)
	arg_2_0._btnlatter:AddClickListener(arg_2_0._btnlatterOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	TurnbackController.instance:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshSignInItem, arg_3_0.refreshItem, arg_3_0)
	arg_3_0._btncanget:RemoveClickListener()
	arg_3_0._btnlatter:RemoveClickListener()

	if arg_3_0._isLastDay then
		arg_3_0.btndetail:RemoveClickListener()
	end
end

function var_0_0.initItem(arg_4_0, arg_4_1)
	arg_4_0.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	arg_4_0.id = arg_4_1
	arg_4_0._isLastDay = arg_4_0.id == 7
	arg_4_0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(arg_4_0.turnbackId, arg_4_0.id)
	arg_4_0.state = TurnbackSignInModel.instance:getSignInStateById(arg_4_0.id)

	if not arg_4_0._isLastDay then
		arg_4_0._txtday.text = arg_4_0.id

		local var_4_0 = GameUtil.splitString2(arg_4_0.config.bonus, true)

		for iter_4_0 = 1, 2 do
			if not arg_4_0.rewardList[iter_4_0] then
				local var_4_1 = arg_4_0:getUserDataTb_()

				var_4_1.go = gohelper.findChild(arg_4_0.go, "group/reward" .. iter_4_0)
				var_4_1.goIcon = gohelper.findChild(var_4_1.go, "rewardicon")
				var_4_1.txtNum = gohelper.findChildText(var_4_1.go, "#txt_num")

				local var_4_2 = var_4_0[iter_4_0]
				local var_4_3 = var_4_2[1]
				local var_4_4 = var_4_2[2]
				local var_4_5 = var_4_2[3]
				local var_4_6, var_4_7 = ItemModel.instance:getItemConfigAndIcon(var_4_3, var_4_4, true)

				if var_4_7 then
					var_4_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(var_4_1.goIcon)

					var_4_1.itemIcon:setMOValue(var_4_3, var_4_4, var_4_5, nil, true)
					var_4_1.itemIcon:isShowQuality(false)
					var_4_1.itemIcon:isShowCount(false)
				end

				var_4_1.txtNum.text = var_4_5

				table.insert(arg_4_0.rewardList, var_4_1)
			end
		end
	else
		arg_4_0.btndetail = gohelper.findChildButtonWithAudio(arg_4_0.go, "group/dec3")

		arg_4_0.btndetail:AddClickListener(arg_4_0._btndetailOnClick, arg_4_0)
	end

	arg_4_0.canvasgroup.alpha = arg_4_0.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(arg_4_0._gohasget, arg_4_0.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(arg_4_0._gocanget, arg_4_0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_4_0._btncanget.gameObject, arg_4_0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_4_0._btnlatter.gameObject, arg_4_0.state == TurnbackEnum.SignInState.CanGet or arg_4_0.state == TurnbackEnum.SignInState.HasGet)
end

function var_0_0.refreshItem(arg_5_0)
	arg_5_0.state = TurnbackSignInModel.instance:getSignInStateById(arg_5_0.id)
	arg_5_0.canvasgroup.alpha = arg_5_0.state == TurnbackEnum.SignInState.HasGet and 0.5 or 1

	gohelper.setActive(arg_5_0._gohasget, arg_5_0.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(arg_5_0._gocanget, arg_5_0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_5_0._btncanget.gameObject, arg_5_0.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(arg_5_0._btnlatter.gameObject, arg_5_0.state == TurnbackEnum.SignInState.CanGet or arg_5_0.state == TurnbackEnum.SignInState.HasGet)
end

function var_0_0._btncangetOnClick(arg_6_0)
	if arg_6_0.state == TurnbackEnum.SignInState.CanGet then
		local var_6_0 = TurnbackModel.instance:getCurTurnbackId()

		TurnbackRpc.instance:sendTurnbackSignInRequest(var_6_0, arg_6_0.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function var_0_0._btndetailOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.TurnbackNewShowRewardView, {
		bonus = arg_7_0.config.bonus
	})
end

function var_0_0._btnlatterOnClick(arg_8_0)
	if arg_8_0.id == 1 then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = false,
			notfirst = true,
			day = arg_8_0.id
		})
	else
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = arg_8_0.id
		})
	end
end

function var_0_0._btnclickOnClick(arg_9_0)
	ViewMgr.openView(ViewName.TurnbackLatterView, arg_9_0.id)
end

function var_0_0.onDestroy(arg_10_0)
	return
end

return var_0_0

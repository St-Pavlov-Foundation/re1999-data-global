module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

local var_0_0 = class("BpSPMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = gohelper.cloneInPlace(arg_1_1)
	arg_1_0._goexpup = gohelper.findChild(arg_1_0.go, "#go_expup")

	gohelper.setActive(arg_1_0._goexpup, BpModel.instance:isShowExpUp())
	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")

	local var_1_0 = gohelper.findChild(arg_1_0.go, "bg")

	arg_1_0._btnitem = gohelper.getClickWithAudio(var_1_0, AudioEnum.UI.play_ui_role_pieces_open)
	arg_1_0._reddotitem = gohelper.findChild(arg_1_0.go, "go_activityreddot")

	arg_1_0:_refreshItem()
	arg_1_0:addEvent()
end

function var_0_0.addEvent(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEvent(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
end

function var_0_0._onItemClick(arg_4_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function var_0_0._refreshItem(arg_5_0)
	local var_5_0 = ActivityModel.showActivityEffect()
	local var_5_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_5_2 = var_5_0 and var_5_1.mainViewActBtnPrefix .. "icon_6" or "icon_6"

	UISpriteSetMgr.instance:setMainSprite(arg_5_0._imgitem, var_5_2, true)

	if not var_5_0 then
		local var_5_3 = ActivityConfig.instance:getMainActAtmosphereConfig()

		if var_5_3 then
			for iter_5_0, iter_5_1 in ipairs(var_5_3.mainViewActBtn) do
				local var_5_4 = gohelper.findChild(arg_5_0.go, iter_5_1)

				if var_5_4 then
					gohelper.setActive(var_5_4, var_5_0)
				end
			end
		end
	end

	arg_5_0._redDot = RedDotController.instance:addRedDot(arg_5_0._reddotitem, RedDotEnum.DotNode.BattlePassSPMain)
end

function var_0_0.destroy(arg_6_0)
	arg_6_0:removeEvent()
	gohelper.destroy(arg_6_0.go)

	arg_6_0.go = nil
	arg_6_0._imgitem = nil
	arg_6_0._btnitem = nil
	arg_6_0._reddotitem = nil
end

function var_0_0.isShowRedDot(arg_7_0)
	return arg_7_0._redDot and arg_7_0._redDot.isShowRedDot
end

return var_0_0

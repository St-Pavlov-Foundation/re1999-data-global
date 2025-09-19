module("modules.logic.battlepass.view.BpSPMainBtnItem", package.seeall)

local var_0_0 = class("BpSPMainBtnItem", ActCenterItemBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, gohelper.cloneInPlace(arg_1_1))
end

function var_0_0.onInit(arg_2_0, arg_2_1)
	arg_2_0._btnitem = gohelper.getClickWithAudio(arg_2_0._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	arg_2_0:_refreshItem()
end

function var_0_0.onClick(arg_3_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BP) then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.BP))

		return
	end

	BpController.instance:openBattlePassView(true)
end

function var_0_0._refreshItem(arg_4_0)
	local var_4_0 = ActivityModel.showActivityEffect()
	local var_4_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_4_2 = var_4_0 and var_4_1.mainViewActBtnPrefix .. "icon_6" or "icon_6"

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

	arg_4_0._redDot = RedDotController.instance:addRedDot(arg_4_0._goactivityreddot, RedDotEnum.DotNode.BattlePassSPMain)
end

function var_0_0.isShowRedDot(arg_5_0)
	return arg_5_0._redDot and arg_5_0._redDot.isShowRedDot
end

return var_0_0

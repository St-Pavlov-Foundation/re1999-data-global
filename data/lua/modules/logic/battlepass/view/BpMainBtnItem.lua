module("modules.logic.battlepass.view.BpMainBtnItem", package.seeall)

local var_0_0 = class("BpMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = gohelper.cloneInPlace(arg_1_1)

	gohelper.setActive(arg_1_0.go, true)

	arg_1_0._imgGo = gohelper.findChild(arg_1_0.go, "bg")
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0._imgGo, "")
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")
	arg_1_0._btnitem = gohelper.getClickWithAudio(arg_1_0._imgGo, AudioEnum.UI.play_ui_role_pieces_open)

	arg_1_0:_initReddotitem(arg_1_0.go)

	local var_1_0 = BpConfig.instance:getBpCO(BpModel.instance.id)

	arg_1_0._goexpup = gohelper.findChild(arg_1_0.go, "#go_expup")

	gohelper.setActive(arg_1_0._goexpup, BpModel.instance:isShowExpUp())

	if var_1_0 and var_1_0.isSp then
		local var_1_1 = gohelper.findChild(arg_1_0.go, "link")

		gohelper.setActive(var_1_1, true)
	end

	arg_1_0:addEvent()
	arg_1_0:_refreshItem()
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

	BpController.instance:openBattlePassView()
end

function var_0_0._refreshItem(arg_5_0)
	local var_5_0 = ActivityModel.showActivityEffect()
	local var_5_1 = ActivityConfig.instance:getMainActAtmosphereConfig()
	local var_5_2 = var_5_0 and var_5_1.mainViewActBtnPrefix .. "icon_3" or "icon_3"

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

	arg_5_0._redDot:refreshDot()
end

function var_0_0.destroy(arg_6_0)
	arg_6_0:removeEvent()
	gohelper.destroy(arg_6_0.go)
	arg_6_0:__onDispose()
end

function var_0_0.isShowRedDot(arg_7_0)
	return arg_7_0._redDot.show
end

function var_0_0._initReddotitem(arg_8_0, arg_8_1)
	local var_8_0 = gohelper.findChild(arg_8_1, "go_activityreddot")

	arg_8_0._redDot = RedDotController.instance:addRedDot(var_8_0, RedDotEnum.DotNode.BattlePass)

	do return end

	local var_8_1 = gohelper.findChild(arg_8_1, "go_activityreddot/#go_special_reds")
	local var_8_2 = var_8_1.transform
	local var_8_3 = var_8_2.childCount

	for iter_8_0 = 1, var_8_3 do
		local var_8_4 = var_8_2:GetChild(iter_8_0 - 1)

		gohelper.setActive(var_8_4.gameObject, false)
	end

	local var_8_5 = gohelper.findChild(var_8_1, "#go_bp_red")

	arg_8_0._redDot = RedDotController.instance:addRedDotTag(var_8_5, RedDotEnum.DotNode.BattlePass, false, arg_8_0._onRefreshDot, arg_8_0)
	arg_8_0._btnitem2 = gohelper.getClickWithAudio(var_8_5, AudioEnum2_6.BP.MainBtn)
end

function var_0_0._onRefreshDot(arg_9_0, arg_9_1)
	local var_9_0 = RedDotModel.instance:isDotShow(arg_9_1.dotId, 0)

	arg_9_1.show = var_9_0

	gohelper.setActive(arg_9_1.go, var_9_0)
	gohelper.setActive(arg_9_0._imgGo, not var_9_0)
end

return var_0_0

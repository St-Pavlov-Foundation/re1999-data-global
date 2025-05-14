module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentMainBtnItem", package.seeall)

local var_0_0 = class("GoldenMilletPresentMainBtnItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imgitem = gohelper.findChildImage(arg_1_0.go, "bg")
	arg_1_0._btnitem = gohelper.findChildClickWithAudio(arg_1_0.go, "bg", AudioEnum.UI.GoldenMilletMainBtnClick)
	arg_1_0._redDotParent = gohelper.findChild(arg_1_0.go, "go_activityreddot")

	UISpriteSetMgr.instance:setMainSprite(arg_1_0._imgitem, "v1a6_act_icon4")

	local var_1_0 = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()

	if not ActivityType101Model.instance:isInit(var_1_0) then
		Activity101Rpc.instance:sendGet101InfosRequest(var_1_0)
	end

	arg_1_0.redDot = RedDotController.instance:addNotEventRedDot(arg_1_0._redDotParent, GoldenMilletPresentModel.isShowRedDot, GoldenMilletPresentModel.instance)

	gohelper.setActive(arg_1_0.go, true)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnitem:AddClickListener(arg_2_0._onItemClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshRedDot, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnitem:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshRedDot, arg_3_0)
end

function var_0_0._onItemClick(arg_4_0)
	GoldenMilletPresentController.instance:openGoldenMilletPresentView()
end

function var_0_0.refreshRedDot(arg_5_0)
	if not gohelper.isNil(arg_5_0.redDot.gameObject) then
		return
	end

	arg_5_0.redDot:refreshRedDot()
end

function var_0_0.isShowRedDot(arg_6_0)
	return arg_6_0.redDot and arg_6_0.redDot.isShowRedDot
end

function var_0_0.destroy(arg_7_0)
	gohelper.setActive(arg_7_0.go, false)
	gohelper.destroy(arg_7_0.go)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0.go = nil
	arg_8_0._imgitem = nil
	arg_8_0._btnitem = nil
	arg_8_0.redDot = nil
end

return var_0_0

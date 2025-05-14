module("modules.logic.activity.view.show.ActivityGuestBindView", package.seeall)

local var_0_0 = class("ActivityGuestBindView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "leftbottom/#scroll_reward")
	arg_1_0._btngo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rightbottom/#btn_go")
	arg_1_0._txtbtngo = gohelper.findChildText(arg_1_0.viewGO, "rightbottom/#btn_go/#txt_btngo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngo:AddClickListener(arg_2_0._btngoOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngo:RemoveClickListener()
end

function var_0_0._btngoOnClick(arg_4_0)
	local var_4_0 = SDKEnum.RewardType
	local var_4_1 = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_btngoOnClick click: e=" .. tostring(var_4_1))

	if var_4_1 == var_4_0.None then
		SDKMgr.instance:openAccountBind()

		return
	end

	if var_4_1 == var_4_0.Claim then
		logNormal("ActivityGuestBindView:_btngoOnClick sendAct1000AccountBindBonusRequest")

		local var_4_2 = arg_4_0.viewParam.actId

		Activity1000Rpc.instance:sendAct1000AccountBindBonusRequest(var_4_2)

		return
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getActivityBg("full/img_blind_bg"))
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam
	local var_7_1 = var_7_0.parent
	local var_7_2 = var_7_0.actId

	gohelper.addChild(var_7_1, arg_7_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
	Activity1000Rpc.instance:sendAct1000GetInfoRequest(var_7_2, arg_7_0._refresh, arg_7_0)

	local var_7_3 = GameUtil.splitString2(SDKConfig.instance:getGuestBindRewards(), true, "|", "#")
	local var_7_4 = {}

	for iter_7_0 = 1, #var_7_3 do
		var_7_4[#var_7_4 + 1] = {
			itemCO = var_7_3[iter_7_0]
		}
	end

	ActivityGuestBindViewListModel.instance:setList(var_7_4)
	arg_7_0:_refresh()
	arg_7_0:addEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, arg_7_0._refresh, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(SDKController.instance, SDKEvent.UpdateAccountBindBonus, arg_8_0._refresh, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simagebg:UnLoadImage()
end

function var_0_0._onUpdateAccountBindBonus(arg_10_0)
	logNormal("ActivityGuestBindView:_onGuestBindSucc")
	arg_10_0:_refresh()
end

function var_0_0._refresh(arg_11_0)
	local var_11_0 = SDKEnum.RewardType
	local var_11_1 = SDKModel.instance:getAccountBindBonus()

	logNormal("ActivityGuestBindView:_refresh e=" .. tostring(var_11_1))

	if var_11_1 == var_11_0.None then
		arg_11_0._txtbtngo.text = luaLang("activityguestbindview_go")
	elseif var_11_1 == var_11_0.Claim then
		arg_11_0._txtbtngo.text = luaLang("activityguestbindview_reward")
	elseif var_11_1 == var_11_0.Got then
		arg_11_0._txtbtngo.text = luaLang("activityguestbindview_rewarded")
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._btngo.gameObject:GetComponent(gohelper.Type_Image), var_11_1 == var_11_0.Got and "#666666" or "#ffffff")
end

return var_0_0

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_FullView", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_FullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_check")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "root/reward/#go_canget")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward/#go_canget/#btn_Claim")
	arg_1_0._gocanuse = gohelper.findChild(arg_1_0.viewGO, "root/reward/#go_canuse")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/reward/#go_canuse/#btn_use")
	arg_1_0._txtcanuse = gohelper.findChildText(arg_1_0.viewGO, "root/reward/#go_canuse/tips/#txt_canuse")
	arg_1_0._gouesd = gohelper.findChild(arg_1_0.viewGO, "root/reward/#go_uesd")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "root/simage_fullbg/#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btncheckOnClick(arg_4_0)
	local var_4_0 = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

	if string.nilorempty(var_4_0.effect) then
		return
	end

	local var_4_1 = string.split(var_4_0.effect, "|")

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(var_4_1, 1)

	local var_4_2 = {
		isPreview = true
	}

	ViewMgr.instance:openView(ViewName.V2a7_SelfSelectSix_PickChoiceView, var_4_2)
end

function var_0_0._btnClaimOnClick(arg_5_0)
	if not arg_5_0:checkReceied() and arg_5_0:checkCanGet() then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_5_0._actId, 1)
	end
end

function var_0_0._btnuseOnClick(arg_6_0)
	if ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId) > 0 then
		local var_6_0 = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

		if string.nilorempty(var_6_0.effect) then
			return
		end

		local var_6_1 = string.split(var_6_0.effect, "|")
		local var_6_2 = {
			quantity = 1,
			id = var_6_0.id
		}

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(var_6_1, MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, var_6_2, nil, nil, 1)
	end
end

function var_0_0._editableInitView(arg_7_0)
	return
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)

	local var_9_0 = arg_9_0.viewParam.parent

	arg_9_0._actId = arg_9_0.viewParam.actId

	gohelper.addChild(var_9_0, arg_9_0.viewGO)
	Activity101Rpc.instance:sendGet101InfosRequest(arg_9_0._actId)

	arg_9_0._actCo = ActivityConfig.instance:getActivityCo(arg_9_0._actId)
	arg_9_0._txtdesc.text = arg_9_0._actCo.actDesc

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = arg_10_0:checkReceied()
	local var_10_1 = arg_10_0:checkCanUse()

	gohelper.setActive(arg_10_0._gocanget, not var_10_0)
	gohelper.setActive(arg_10_0._gocanuse, var_10_0 and var_10_1)
	gohelper.setActive(arg_10_0._gouesd, var_10_0 and not var_10_1)

	if var_10_1 then
		arg_10_0:_initListModel()

		local var_10_2, var_10_3 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getLastUnlockEpisodeId()

		if var_10_3 then
			arg_10_0._txtcanuse.text = luaLang("v2a7_newbie_rewardclaim_texts")
		else
			local var_10_4 = DungeonHelper.getEpisodeName(var_10_2)

			arg_10_0._txtcanuse.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("v2a7_newbie_storyprocess_locate_eventiterface"), var_10_4)
		end
	end
end

function var_0_0._initListModel(arg_11_0)
	local var_11_0 = ItemConfig.instance:getItemCo(V2a7_SelfSelectSix_Enum.RewardId)

	if string.nilorempty(var_11_0.effect) then
		return
	end

	local var_11_1 = string.split(var_11_0.effect, "|")

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(var_11_1, 1)
end

function var_0_0._onCloseView(arg_12_0, arg_12_1)
	if arg_12_1 == ViewName.CharacterGetView then
		arg_12_0:refreshUI()
	end
end

function var_0_0.checkReceied(arg_13_0)
	return (ActivityType101Model.instance:isType101RewardGet(arg_13_0._actId, 1))
end

function var_0_0.checkCanGet(arg_14_0)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_14_0._actId, 1))
end

function var_0_0.checkCanUse(arg_15_0)
	return ItemModel.instance:getItemCount(V2a7_SelfSelectSix_Enum.RewardId) > 0
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	return
end

return var_0_0

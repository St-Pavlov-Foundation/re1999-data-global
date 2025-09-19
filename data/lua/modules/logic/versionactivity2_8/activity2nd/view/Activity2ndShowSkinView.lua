module("modules.logic.versionactivity2_8.activity2nd.view.Activity2ndShowSkinView", package.seeall)

local var_0_0 = class("Activity2ndShowSkinView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "root/#go_time")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "root/#go_time/#txt_LimitTime")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_detail")
	arg_1_0._btnclaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_claim")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "root/#btn_claim/simage_canget")
	arg_1_0._gohasget = gohelper.findChild(arg_1_0.viewGO, "root/#btn_claim/simage_hasget")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._btnPresentList) do
		iter_2_1:AddClickListener(arg_2_0._btnPresentOnClick, arg_2_0, iter_2_0)
	end

	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnclaim:AddClickListener(arg_2_0._btnclaimOnClick, arg_2_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.onRefreshActivity, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnclaim:RemoveClickListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._btnPresentList) do
		iter_3_1:RemoveClickListener()
	end

	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, arg_3_0.refreshUI, arg_3_0)
end

function var_0_0._btndetailOnClick(arg_4_0)
	local var_4_0 = arg_4_0._rewardconfig and arg_4_0._rewardconfig.bonus and string.split(arg_4_0._rewardconfig.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(var_4_0[1], var_4_0[2])
end

function var_0_0._btnclaimOnClick(arg_5_0)
	if arg_5_0:checkCanGet(arg_5_0._actId) then
		Activity101Rpc.instance:sendGet101BonusRequest(arg_5_0._actId, 1)
	end
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._btnPresentList = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, Activity2ndEnum.DISPLAY_SKIN_COUNT do
		local var_7_0 = gohelper.findChildButtonWithAudio(arg_7_0.viewGO, "root/simage_FullBG/role/simage_role" .. iter_7_0)

		if var_7_0 then
			arg_7_0._btnPresentList[#arg_7_0._btnPresentList + 1] = var_7_0
		end
	end
end

function var_0_0._btnPresentOnClick(arg_8_0, arg_8_1)
	if not ActivityHelper.isOpen(arg_8_0._actId) then
		return
	end

	if arg_8_1 == 1 then
		local var_8_0 = Activity2ndEnum.ShowSkin4

		if var_8_0 then
			CharacterController.instance:openCharacterSkinTipView({
				isShowHomeBtn = false,
				skinId = var_8_0
			})

			local var_8_1 = SkinConfig.instance:getSkinCo(tonumber(var_8_0))

			if var_8_1 then
				StatController.instance:track(StatEnum.EventName.Activity2ndSkinCollectionClick, {
					[StatEnum.EventProperties.skinId] = tonumber(var_8_0),
					[StatEnum.EventProperties.HeroName] = var_8_1.name
				})
			end
		end
	else
		local var_8_2 = Activity2ndEnum.Index2GoodsId[arg_8_1]

		if var_8_2 then
			if not StoreModel.instance:getGoodsMO(tonumber(var_8_2)) then
				return
			end

			ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
				goodsMO = StoreModel.instance:getGoodsMO(tonumber(var_8_2))
			})

			local var_8_3 = StoreConfig.instance:getGoodsConfig(var_8_2)
			local var_8_4 = var_8_3 and var_8_3.product and string.split(var_8_3.product, "#")
			local var_8_5 = var_8_4 and var_8_4[2]

			if var_8_5 then
				local var_8_6 = SkinConfig.instance:getSkinCo(tonumber(var_8_5))

				if var_8_6 then
					StatController.instance:track(StatEnum.EventName.Activity2ndSkinCollectionClick, {
						[StatEnum.EventProperties.skinId] = tonumber(var_8_5),
						[StatEnum.EventProperties.HeroName] = var_8_6.name
					})
				end
			end
		end
	end
end

function var_0_0.checkReceied(arg_9_0, arg_9_1)
	return (ActivityType101Model.instance:isType101RewardGet(arg_9_1, 1))
end

function var_0_0.checkCanGet(arg_10_0, arg_10_1)
	return (ActivityType101Model.instance:isType101RewardCouldGet(arg_10_1, 1))
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._actId = arg_12_0.viewParam and arg_12_0.viewParam.actId
	arg_12_0._rewardconfig = ActivityConfig.instance:getNorSignActivityCo(arg_12_0._actId, 1)

	arg_12_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_day_night)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_13_0._actId)

	local var_13_0 = arg_13_0:checkCanGet(arg_13_0._actId)
	local var_13_1 = arg_13_0:checkReceied(arg_13_0._actId)

	gohelper.setActive(arg_13_0._gohasget, var_13_1)
	gohelper.setActive(arg_13_0._gocanget, var_13_0)
end

function var_0_0.onRefreshActivity(arg_14_0)
	local var_14_0 = ActivityHelper.getActivityStatus(arg_14_0._actId)

	if var_14_0 == ActivityEnum.ActivityStatus.NotOnLine or var_14_0 == ActivityEnum.ActivityStatus.Expired then
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)

		return
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0

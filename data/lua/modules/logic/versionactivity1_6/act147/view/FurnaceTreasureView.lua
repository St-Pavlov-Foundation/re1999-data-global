module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureView", package.seeall)

local var_0_0 = class("FurnaceTreasureView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "#go_spine")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Right/LimitTimeBg/#txt_LimitTime")
	arg_1_0._goDecContent = gohelper.findChild(arg_1_0.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content")
	arg_1_0._txtDecItem = gohelper.findChildText(arg_1_0.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content/#txt_DecItem")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_goto")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "Right/arrow")
	arg_1_0._txtlimitbuy = gohelper.findChildText(arg_1_0.viewGO, "LimitTips/bg/#txt_limitbuy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0:addEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_2_0.refreshBuyCount, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0:removeEventCb(FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, arg_3_0.refreshBuyCount, arg_3_0)
end

function var_0_0._btngotoOnClick(arg_4_0)
	local var_4_0 = FurnaceTreasureConfig.instance:getJumpId(arg_4_0.actId)

	if var_4_0 and var_4_0 ~= 0 then
		GameFacade.jump(var_4_0)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.actId = nil
	arg_5_0._uiSpine = GuiSpine.Create(arg_5_0._gospine, false)

	if arg_5_0._uiSpine then
		arg_5_0._uiSpine:useRT()
		arg_5_0._uiSpine:setImgPos(0, 0)
		arg_5_0._uiSpine:setImgParent(arg_5_0._gospine.transform)
	end
end

function var_0_0.onOpen(arg_6_0)
	if arg_6_0.viewParam then
		local var_6_0 = arg_6_0.viewParam.parent

		gohelper.addChild(var_6_0, arg_6_0.viewGO)

		arg_6_0.actId = arg_6_0.viewParam.actId
	end

	arg_6_0:setDescList()
	arg_6_0:setRewardList()
	arg_6_0:refreshBuyCount()
	arg_6_0:refreshLimitTime()
	TaskDispatcher.cancelTask(arg_6_0.refreshLimitTime, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0.refreshLimitTime, arg_6_0, TimeUtil.OneMinuteSecond)

	local var_6_1 = FurnaceTreasureConfig.instance:getSpineRes(arg_6_0.actId)

	if not arg_6_0._uiSpine or string.nilorempty(var_6_1) then
		return
	end

	arg_6_0._uiSpine:setResPath(var_6_1, arg_6_0._onSpineLoaded, arg_6_0)
end

function var_0_0.setDescList(arg_7_0)
	local var_7_0 = FurnaceTreasureConfig.instance:getDescList(arg_7_0.actId)

	gohelper.CreateObjList(arg_7_0, arg_7_0.onSetSingleDesc, var_7_0, arg_7_0._goDecContent, arg_7_0._txtDecItem.gameObject)
end

function var_0_0.onSetSingleDesc(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if gohelper.isNil(arg_8_1) then
		return
	end

	local var_8_0 = arg_8_1:GetComponent(gohelper.Type_TextMesh)

	if var_8_0 then
		var_8_0.text = arg_8_2
	end
end

function var_0_0.setRewardList(arg_9_0)
	local var_9_0 = FurnaceTreasureConfig.instance:getRewardList(arg_9_0.actId)

	IconMgr.instance:getCommonPropItemIconList(arg_9_0, arg_9_0.onSetSingleReward, var_9_0, arg_9_0._gorewards)
end

function var_0_0.onSetSingleReward(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_2.quantity then
		arg_10_2.quantity = 0
	end

	arg_10_1:onUpdateMO(arg_10_2)
	arg_10_1:isShowEffect(true)
	arg_10_1:setAutoPlay(true)
	arg_10_1:isShowCount(false)
end

function var_0_0._onSpineLoaded(arg_11_0)
	if not arg_11_0._uiSpine then
		return
	end

	arg_11_0._uiSpine:setImageUIMask(true)

	local var_11_0 = FurnaceTreasureModel.instance:getSpinePlayData()

	arg_11_0._uiSpine:playVoice(var_11_0)
end

function var_0_0.refreshBuyCount(arg_12_0)
	local var_12_0 = FurnaceTreasureModel.instance:getTotalRemainCount(arg_12_0.actId)

	arg_12_0._txtlimitbuy.text = formatLuaLang("remain_buy_count", var_12_0)
end

function var_0_0.refreshLimitTime(arg_13_0)
	local var_13_0 = ActivityModel.instance:getActMO(arg_13_0.actId)
	local var_13_1 = formatLuaLang("cachotprogressview_remainDay", 0)

	if var_13_0 then
		var_13_1 = TimeUtil.SecondToActivityTimeFormat(var_13_0:getRealEndTimeStamp() - ServerTime.now())
	end

	arg_13_0._txtLimitTime.text = string.format(luaLang("remain"), var_13_1)
end

function var_0_0.onClose(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0.refreshLimitTime, arg_14_0)
end

function var_0_0.onDestroyView(arg_15_0)
	if arg_15_0._uiSpine then
		arg_15_0._uiSpine:doClear()
	end

	arg_15_0._uiSpine = false
end

return var_0_0

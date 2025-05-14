module("modules.logic.activity.view.V2a1_MoonFestival_FullView", package.seeall)

local var_0_0 = class("V2a1_MoonFestival_FullView", Activity101SignViewBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_PanelBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_Title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._txtDec = gohelper.findChildText(arg_1_0.viewGO, "Root/image_DecBG/scroll_desc/Viewport/Content/#txt_Dec")
	arg_1_0._goNormalBG = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_NormalBG")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	arg_1_0._simagereward = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	arg_1_0._gocanget = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_canget")
	arg_1_0._goFinishedBG = gohelper.findChild(arg_1_0.viewGO, "Root/Task/#go_FinishedBG")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/#scroll_ItemList")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._txtLimitTime.text = ""

	arg_4_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	arg_4_0:_setActive_canget(false)
	arg_4_0:_setActive_goFinishedBG(false)
end

function var_0_0.onOpen(arg_5_0)
	GameUtil.onDestroyViewMember_ClickListener(arg_5_0, "_itemClick")

	arg_5_0._itemClick = gohelper.getClickWithAudio(arg_5_0._goNormalBG)

	arg_5_0._itemClick:AddClickListener(arg_5_0._onItemClick, arg_5_0)
	arg_5_0:internal_onOpen()
	arg_5_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_5_0._refreshTimeTick, arg_5_0, 1)
end

function var_0_0.onClose(arg_6_0)
	GameUtil.onDestroyViewMember_ClickListener(arg_6_0, "_itemClick")
	arg_6_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_7_0)
	Activity101SignViewBase._internal_onDestroy(arg_7_0)
	arg_7_0:_clearTimeTick()
end

function var_0_0._clearTimeTick(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_0.onRefresh(arg_9_0)
	arg_9_0:_refreshList()
	arg_9_0:_refreshTimeTick()
	arg_9_0:_refreshLeftTop()
	arg_9_0:_refreshRightTop()
end

function var_0_0._refreshTimeTick(arg_10_0)
	arg_10_0._txtLimitTime.text = arg_10_0:getRemainTimeStr()
end

function var_0_0._refreshLeftTop(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer:getCurrentDayCO()

	if not var_11_0 then
		arg_11_0._txtDec.text = ""

		return
	end

	arg_11_0._txtDec.text = var_11_0.desc
end

function var_0_0._refreshRightTop(arg_12_0)
	local var_12_0 = arg_12_0.viewContainer:getCurrentTaskCO()

	if not var_12_0 then
		arg_12_0._txtdec.text = ""

		arg_12_0._simagereward:UnLoadImage()

		arg_12_0._txtnum.text = ""

		return
	end

	local var_12_1 = GameUtil.splitString2(var_12_0.bonus, true)[1]
	local var_12_2 = var_12_1[1]
	local var_12_3 = var_12_1[2]
	local var_12_4, var_12_5 = ItemModel.instance:getItemConfigAndIcon(var_12_2, var_12_3)
	local var_12_6 = arg_12_0.viewContainer:isNone(var_12_0.id)
	local var_12_7 = arg_12_0.viewContainer:isFinishedTask(var_12_0.id)
	local var_12_8 = arg_12_0.viewContainer:isRewardable(var_12_0.id)

	arg_12_0:_setActive_canget(var_12_8)
	arg_12_0:_setActive_goFinishedBG(var_12_7)

	arg_12_0._txtdec.text = var_12_0.taskDesc

	GameUtil.loadSImage(arg_12_0._simagereward, var_12_5)

	arg_12_0._txtnum.text = var_12_6 and gohelper.getRichColorText("0/1", "#ff9673") or "1/1"
	arg_12_0._bonusItem = var_12_1
end

function var_0_0._onItemClick(arg_13_0)
	if not arg_13_0.viewContainer:sendGet101SpBonusRequest(arg_13_0._onReceiveGet101SpBonusReplySucc, arg_13_0) and arg_13_0._bonusItem then
		MaterialTipController.instance:showMaterialInfo(arg_13_0._bonusItem[1], arg_13_0._bonusItem[2])
	end
end

function var_0_0._setActive_canget(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._gocanget, arg_14_1)
end

function var_0_0._setActive_goFinishedBG(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._goFinishedBG, arg_15_1)
end

function var_0_0._onReceiveGet101SpBonusReplySucc(arg_16_0)
	arg_16_0:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(arg_16_0:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

return var_0_0

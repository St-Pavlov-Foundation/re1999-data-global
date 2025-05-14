module("modules.logic.activity.view.V2a1_MoonFestival_PanelView", package.seeall)

local var_0_0 = class("V2a1_MoonFestival_PanelView", Activity101SignViewBase)

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
	arg_1_0._btnemptyTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyTop")
	arg_1_0._btnemptyBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyBottom")
	arg_1_0._btnemptyLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyLeft")
	arg_1_0._btnemptyRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_emptyRight")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	Activity101SignViewBase.addEvents(arg_2_0)
	arg_2_0._btnemptyTop:AddClickListener(arg_2_0._btnemptyTopOnClick, arg_2_0)
	arg_2_0._btnemptyBottom:AddClickListener(arg_2_0._btnemptyBottomOnClick, arg_2_0)
	arg_2_0._btnemptyLeft:AddClickListener(arg_2_0._btnemptyLeftOnClick, arg_2_0)
	arg_2_0._btnemptyRight:AddClickListener(arg_2_0._btnemptyRightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	Activity101SignViewBase.removeEvents(arg_3_0)
	arg_3_0._btnemptyTop:RemoveClickListener()
	arg_3_0._btnemptyBottom:RemoveClickListener()
	arg_3_0._btnemptyLeft:RemoveClickListener()
	arg_3_0._btnemptyRight:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnemptyTopOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnemptyBottomOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._btnemptyLeftOnClick(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0._btnemptyRightOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._txtLimitTime.text = ""

	arg_9_0:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	arg_9_0:_setActive_canget(false)
	arg_9_0:_setActive_goFinishedBG(false)

	arg_9_0._itemClick = gohelper.getClickWithAudio(arg_9_0._goNormalBG)

	arg_9_0._itemClick:AddClickListener(arg_9_0._onItemClick, arg_9_0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:internal_set_actId(arg_10_0.viewParam.actId)
	arg_10_0:internal_onOpen()
	arg_10_0:_clearTimeTick()
	TaskDispatcher.runRepeat(arg_10_0._refreshTimeTick, arg_10_0, 1)
end

function var_0_0.onClose(arg_11_0)
	GameUtil.onDestroyViewMember_ClickListener(arg_11_0, "_itemClick")
	arg_11_0:_clearTimeTick()
end

function var_0_0.onDestroyView(arg_12_0)
	Activity101SignViewBase._internal_onDestroy(arg_12_0)
	arg_12_0:_clearTimeTick()
	arg_12_0._simagereward:UnLoadImage()
	arg_12_0._simageTitle:UnLoadImage()
end

function var_0_0._clearTimeTick(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._refreshTimeTick, arg_13_0)
end

function var_0_0.onRefresh(arg_14_0)
	arg_14_0:_refreshList()
	arg_14_0:_refreshTimeTick()
	arg_14_0:_refreshLeftTop()
	arg_14_0:_refreshRightTop()
end

function var_0_0._refreshTimeTick(arg_15_0)
	arg_15_0._txtLimitTime.text = arg_15_0:getRemainTimeStr()
end

function var_0_0._refreshLeftTop(arg_16_0)
	local var_16_0 = arg_16_0.viewContainer:getCurrentDayCO()

	if not var_16_0 then
		arg_16_0._txtDec.text = ""

		return
	end

	arg_16_0._txtDec.text = var_16_0.desc
end

function var_0_0._refreshRightTop(arg_17_0)
	local var_17_0 = arg_17_0.viewContainer:getCurrentTaskCO()

	if not var_17_0 then
		arg_17_0._txtdec.text = ""

		arg_17_0._simagereward:UnLoadImage()

		arg_17_0._txtnum.text = ""

		return
	end

	local var_17_1 = GameUtil.splitString2(var_17_0.bonus, true)[1]
	local var_17_2 = var_17_1[1]
	local var_17_3 = var_17_1[2]
	local var_17_4, var_17_5 = ItemModel.instance:getItemConfigAndIcon(var_17_2, var_17_3)
	local var_17_6 = arg_17_0.viewContainer:isNone(var_17_0.id)
	local var_17_7 = arg_17_0.viewContainer:isFinishedTask(var_17_0.id)
	local var_17_8 = arg_17_0.viewContainer:isRewardable(var_17_0.id)

	arg_17_0:_setActive_canget(var_17_8)
	arg_17_0:_setActive_goFinishedBG(var_17_7)

	arg_17_0._txtdec.text = var_17_0.taskDesc

	GameUtil.loadSImage(arg_17_0._simagereward, var_17_5)

	arg_17_0._txtnum.text = var_17_6 and gohelper.getRichColorText("0/1", "#ff9673") or "1/1"
	arg_17_0._bonusItem = var_17_1
end

function var_0_0._onItemClick(arg_18_0)
	if not arg_18_0.viewContainer:sendGet101SpBonusRequest(arg_18_0._onReceiveGet101SpBonusReplySucc, arg_18_0) and arg_18_0._bonusItem then
		MaterialTipController.instance:showMaterialInfo(arg_18_0._bonusItem[1], arg_18_0._bonusItem[2])
	end
end

function var_0_0._setActive_canget(arg_19_0, arg_19_1)
	gohelper.setActive(arg_19_0._gocanget, arg_19_1)
end

function var_0_0._setActive_goFinishedBG(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._goFinishedBG, arg_20_1)
end

function var_0_0._onReceiveGet101SpBonusReplySucc(arg_21_0)
	arg_21_0:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(arg_21_0:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

return var_0_0

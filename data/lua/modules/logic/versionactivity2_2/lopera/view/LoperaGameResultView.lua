module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultView", package.seeall)

local var_0_0 = class("LoperaGameResultView", BaseView)
local var_0_1 = VersionActivity2_2Enum.ActivityId.Lopera

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtStageNum = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classnum")
	arg_1_0._txtStageName = gohelper.findChildText(arg_1_0.viewGO, "txtFbName/#txt_classname")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "#go_fail")
	arg_1_0._txtEventNum = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_targetitem/#txt_Num")
	arg_1_0._txtActionPoint = gohelper.findChildText(arg_1_0.viewGO, "targets/#go_actionpoint/#txt_Num")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "content/Layout/#go_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "Tips/#txt_Tips")
	arg_1_0._scrollItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_List/Viewport/Content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	if arg_4_0:isLockOp() then
		return
	end

	LoperaController.instance:gameResultOver()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	arg_7_0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, arg_7_0.onExitGame, arg_7_0)

	if arg_7_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_7_0.viewContainer.viewName, arg_7_0._btncloseOnClick, arg_7_0)
	end

	arg_7_0:_setLockOpTime(1)
	arg_7_0:refreshUI()
end

function var_0_0.onExitGame(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

function var_0_0.playViewAnimator(arg_11_0, arg_11_1)
	if arg_11_0._animator then
		arg_11_0._animator.enabled = true

		arg_11_0._animator:Play(arg_11_1, 0, 0)
	end
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0._isEndLess = Activity168Model.instance:getCurGameState().endlessId > 0

	local var_12_0 = Activity168Model.instance:getCurEpisodeId()
	local var_12_1 = arg_12_0.viewParam
	local var_12_2 = var_12_1.settleReason
	local var_12_3 = var_12_2 == LoperaEnum.ResultEnum.Completed or arg_12_0._isEndLess
	local var_12_4 = var_12_2 == LoperaEnum.ResultEnum.PowerUseup and not arg_12_0._isEndLess
	local var_12_5 = var_12_2 == LoperaEnum.ResultEnum.Quit
	local var_12_6 = var_12_4 or var_12_5
	local var_12_7 = Activity168Config.instance:getEpisodeCfg(var_0_1, var_12_0)

	arg_12_0._txtStageName.text = var_12_7.name
	arg_12_0._txtStageNum.text = var_12_7.orderId

	gohelper.setActive(arg_12_0._gosuccess, var_12_3)
	gohelper.setActive(arg_12_0._gofail, var_12_6)
	AudioMgr.instance:trigger(var_12_6 and AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva)

	arg_12_0._txtEventNum.text = var_12_1.cellCount

	local var_12_8 = Activity168Model.instance:getCurActionPoint()

	arg_12_0._txtActionPoint.text = math.max(0, var_12_8)

	arg_12_0:refreshAllItems()
end

function var_0_0.refreshAllItems(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.totalItems

	arg_13_0._items = {}

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = {
			itemId = iter_13_1.itemId,
			count = iter_13_1.count
		}

		arg_13_0._items[#arg_13_0._items + 1] = var_13_1
	end

	gohelper.CreateObjList(arg_13_0, arg_13_0._createItem, arg_13_0._items, arg_13_0._gorewardContent, arg_13_0._scrollItem, LoperaGoodsItem)
end

function var_0_0._createItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_2.itemId
	local var_14_1 = Activity168Config.instance:getGameItemCfg(var_0_1, var_14_0)
	local var_14_2 = arg_14_2.count

	arg_14_1:onUpdateData(var_14_1, var_14_2, arg_14_3)
end

function var_0_0._setLockOpTime(arg_15_0, arg_15_1)
	arg_15_0._lockTime = Time.time + arg_15_1
end

function var_0_0.isLockOp(arg_16_0)
	if arg_16_0._lockTime and Time.time < arg_16_0._lockTime then
		return true
	end

	return false
end

return var_0_0

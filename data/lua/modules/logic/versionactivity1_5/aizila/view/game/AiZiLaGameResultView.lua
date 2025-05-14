module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultView", package.seeall)

local var_0_0 = class("AiZiLaGameResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtday = gohelper.findChildText(arg_1_0.viewGO, "content/Title/#txt_day")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "content/Title/#txt_Title")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "content/#go_success")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "content/#go_fail")
	arg_1_0._txtuseTimes = gohelper.findChildText(arg_1_0.viewGO, "content/roundUse/#txt_useTimes")
	arg_1_0._txttimes = gohelper.findChildText(arg_1_0.viewGO, "content/round/#txt_times")
	arg_1_0._goTips = gohelper.findChild(arg_1_0.viewGO, "content/Layout/#go_Tips")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "content/Layout/#go_Tips/#txt_Tips")
	arg_1_0._scrollItems = gohelper.findChildScrollRect(arg_1_0.viewGO, "content/Layout/#scroll_Items")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "content/Layout/#scroll_Items/Viewport/#go_rewardContent")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

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

	AiZiLaGameController.instance:gameResultOver()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goodsItemGo = arg_5_0:getResInst(AiZiLaGoodsItem.prefabPath, arg_5_0.viewGO)

	gohelper.setActive(arg_5_0._goodsItemGo, false)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._animator = arg_7_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	arg_7_0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, arg_7_0.closeThis, arg_7_0)

	if arg_7_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_7_0.viewContainer.viewName, arg_7_0._btncloseOnClick, arg_7_0)
	end

	arg_7_0:_setLockOpTime(1)
	arg_7_0:refreshUI()

	local var_7_0 = AiZiLaGameModel.instance:getIsSafe()

	AudioMgr.instance:trigger(var_7_0 and AudioEnum.V1a5AiZiLa.ui_wulu_aizila_safe_away or AudioEnum.V1a5AiZiLa.ui_wulu_aizila_urgent_away)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

function var_0_0.playViewAnimator(arg_10_0, arg_10_1)
	if arg_10_0._animator then
		arg_10_0._animator.enabled = true

		arg_10_0._animator:Play(arg_10_1, 0, 0)
	end
end

function var_0_0.refreshUI(arg_11_0)
	local var_11_0 = AiZiLaGameModel.instance:getIsSafe()
	local var_11_1 = AiZiLaGameModel.instance:getEpisodeMO()
	local var_11_2 = var_11_1 and var_11_1:getConfig()
	local var_11_3 = {}

	if AiZiLaGameModel.instance:getIsFirstPass() and var_11_2 then
		AiZiLaHelper.getItemMOListByBonusStr(var_11_2.bonus, var_11_3)
	end

	tabletool.addValues(var_11_3, AiZiLaGameModel.instance:getResultItemList())
	gohelper.setActive(arg_11_0._gosuccess, var_11_0)
	gohelper.setActive(arg_11_0._gofail, not var_11_0)
	gohelper.setActive(arg_11_0._goTips, not var_11_0 and #var_11_3 > 0)
	gohelper.CreateObjList(arg_11_0, arg_11_0._onRewardItem, var_11_3, arg_11_0._gorewardContent, arg_11_0._goodsItemGo, AiZiLaGoodsItem)

	if var_11_1 then
		local var_11_4 = var_11_1.day or 0

		arg_11_0._txtuseTimes.text = string.format("%sm", math.max(0, var_11_1.altitude or 0))
		arg_11_0._txttimes.text = math.max(0, var_11_1.actionPoint or 0)
		arg_11_0._txtTitle.text = var_11_2 and var_11_2.name or ""
		arg_11_0._txtday.text = formatLuaLang("v1a5_aizila_day_str", var_11_4)

		local var_11_5 = AiZiLaConfig.instance:getRoundCo(var_11_2.activityId, var_11_2.episodeId, math.max(1, var_11_4))

		if not var_11_0 and var_11_5 then
			local var_11_6 = 1000 - var_11_5.keepMaterialRate

			arg_11_0._txtTips.text = formatLuaLang("v1a5_aizila_keep_material_rate", var_11_6 * 0.1 .. "%")
		end
	end
end

function var_0_0._onRewardItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	arg_12_1:onUpdateMO(arg_12_2)
end

function var_0_0._setLockOpTime(arg_13_0, arg_13_1)
	arg_13_0._lockTime = Time.time + arg_13_1
end

function var_0_0.isLockOp(arg_14_0)
	if arg_14_0._lockTime and Time.time < arg_14_0._lockTime then
		return true
	end

	return false
end

return var_0_0

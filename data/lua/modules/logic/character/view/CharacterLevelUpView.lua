module("modules.logic.character.view.CharacterLevelUpView", package.seeall)

local var_0_0 = class("CharacterLevelUpView", BaseView)
local var_0_1 = 2
local var_0_2 = 0.3
local var_0_3 = 0.5
local var_0_4 = 0.05
local var_0_5 = 0.01

function var_0_0.onInitView(arg_1_0)
	arg_1_0._animGO = gohelper.findChild(arg_1_0.viewGO, "anim")
	arg_1_0._anim = arg_1_0._animGO and arg_1_0._animGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._waveAnimation = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._lvCtrl = arg_1_0.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0._goprevieweff = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#lvimge_ffect")
	arg_1_0._previewlvCtrl = arg_1_0._goprevieweff:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	arg_1_0._golv = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_Lv")
	arg_1_0._scrolllv = gohelper.findChildScrollRect(arg_1_0.viewGO, "anim/lv/#go_Lv/#scroll_Num")
	arg_1_0._scrollrectlv = arg_1_0._scrolllv:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_1_0._translvcontent = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_Lv/#scroll_Num/Viewport/Content").transform
	arg_1_0._gomax = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_Lv/Max")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/lv/#go_Lv/Max")
	arg_1_0._txtmax = gohelper.findChildText(arg_1_0.viewGO, "anim/lv/#go_Lv/Max/#txt_Num")
	arg_1_0._gomaxlarrow = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_Lv/Max/image_lArrow")
	arg_1_0._gomaxrarrow = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_Lv/Max/image_rArrow")
	arg_1_0._scrolldrag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._scrolllv.gameObject)
	arg_1_0._golvfull = gohelper.findChild(arg_1_0.viewGO, "anim/lv/#go_LvFull")
	arg_1_0._txtfulllvnum = gohelper.findChildText(arg_1_0.viewGO, "anim/lv/#go_LvFull/#txt_LvNum")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "anim/#go_tips")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "anim/#go_righttop")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "anim/#btn_insight")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "anim/#go_upgrade")
	arg_1_0._goupgradetexten = gohelper.findChild(arg_1_0.viewGO, "anim/#go_upgrade/txten")
	arg_1_0._btnuplevel = SLFramework.UGUI.UIClickListener.Get(arg_1_0._goupgrade)
	arg_1_0._btnuplevellongpress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._goupgrade)
	arg_1_0._golevelupbeffect = gohelper.findChild(arg_1_0.viewGO, "anim/#go_levelupbeffect")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gocharacterbg = gohelper.findChild(arg_1_0.viewGO, "anim/bg/#go_characterbg")
	arg_1_0._goherogroupbg = gohelper.findChild(arg_1_0.viewGO, "anim/bg/#go_herogroupbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrolldrag:AddDragBeginListener(arg_2_0._onLevelScrollDragBegin, arg_2_0)
	arg_2_0._scrolldrag:AddDragEndListener(arg_2_0._onLevelScrollDragEnd, arg_2_0)
	arg_2_0._scrolllv:AddOnValueChanged(arg_2_0._onLevelScrollChange, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._onMaxLevelClick, arg_2_0)

	local var_2_0 = {}

	var_2_0[1] = 0.5

	for iter_2_0 = 2, 100 do
		local var_2_1 = 0.9 * var_2_0[iter_2_0 - 1]
		local var_2_2 = math.max(var_2_1, 0.2)

		table.insert(var_2_0, var_2_2)
	end

	arg_2_0._btnuplevellongpress:SetLongPressTime(var_2_0)
	arg_2_0._btnuplevellongpress:AddLongPressListener(arg_2_0._onUpLevelLongPress, arg_2_0)
	arg_2_0._btnuplevel:AddClickListener(arg_2_0._onUpLevelClick, arg_2_0)
	arg_2_0._btnuplevel:AddClickUpListener(arg_2_0._onClickUp, arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_2_0._onClickHeroEditItem, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpClickLevel, arg_2_0._onClickLevel, arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpViewClick, arg_2_0._localLevelUpConfirmSend, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrolldrag:RemoveDragBeginListener()
	arg_3_0._scrolldrag:RemoveDragEndListener()
	arg_3_0._scrolllv:RemoveOnValueChanged()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnuplevellongpress:RemoveLongPressListener()
	arg_3_0._btnuplevel:RemoveClickListener()
	arg_3_0._btnuplevel:RemoveClickUpListener()
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_3_0._onClickHeroEditItem, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpClickLevel, arg_3_0._onClickLevel, arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpViewClick, arg_3_0._localLevelUpConfirmSend, arg_3_0)
end

function var_0_0._onLevelScrollDragBegin(arg_4_0)
	arg_4_0:killTween()

	arg_4_0._isDrag = true
end

function var_0_0._onLevelScrollDragEnd(arg_5_0)
	arg_5_0._isDrag = false

	if arg_5_0._scrollrectlv and arg_5_0:checkScrollMove(true) then
		arg_5_0:_selectToNearLevel(true)
	end
end

function var_0_0._onLevelScrollChange(arg_6_0, arg_6_1)
	arg_6_0:dispatchLevelScrollChange()

	if not arg_6_0._isDrag and not arg_6_0._tweenId and (arg_6_0:checkScrollMove() or arg_6_1 <= 0 or arg_6_1 >= 1) then
		arg_6_0:_selectToNearLevel(true)
	end

	local var_6_0 = arg_6_0:calScrollLevel()

	if arg_6_0.previewLevel and arg_6_0.previewLevel == var_6_0 then
		return
	end

	arg_6_0.previewLevel = var_6_0

	local var_6_1 = arg_6_0:getHeroLevel()
	local var_6_2 = arg_6_0.previewLevel == var_6_1

	gohelper.setActive(arg_6_0._goupgrade, not var_6_2)
	gohelper.setActive(arg_6_0._tips[3], var_6_2)
	arg_6_0:_refreshConsume(arg_6_0.previewLevel)
	arg_6_0:_refreshMaxBtnStatus(arg_6_0.previewLevel)
	arg_6_0:_refreshPreviewLevelHorizontal(arg_6_0.previewLevel)

	if not arg_6_0._skipScrollAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_lv_item_scroll)
	end

	arg_6_0._skipScrollAudio = nil

	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, arg_6_0.previewLevel)
end

function var_0_0.checkScrollMove(arg_7_0, arg_7_1)
	local var_7_0 = false
	local var_7_1 = math.abs(arg_7_0._scrollrectlv and arg_7_0._scrollrectlv.velocity.x or 0)

	if arg_7_1 then
		local var_7_2 = 10
		local var_7_3 = arg_7_0._scrollrectlv and arg_7_0._scrollrectlv.horizontalNormalizedPosition or 0

		var_7_0 = var_7_1 <= var_7_2 or var_7_3 <= 0.01 or var_7_3 >= 0.99
	else
		var_7_0 = var_7_1 <= 50
	end

	return var_7_0
end

function var_0_0._selectToNearLevel(arg_8_0, arg_8_1)
	arg_8_0:killTween()
	arg_8_0._scrollrectlv:StopMovement()

	arg_8_0._targetLevel = arg_8_0:calScrollLevel()

	arg_8_0:dispatchLevelScrollChange()

	local var_8_0 = arg_8_0:calScrollPos(arg_8_0._targetLevel)

	if arg_8_1 then
		local var_8_1 = true
		local var_8_2 = arg_8_0._scrolllv.horizontalNormalizedPosition

		if arg_8_0._heroMO then
			local var_8_3 = arg_8_0:getHeroLevel()
			local var_8_4 = 1 / (CharacterModel.instance:getrankEffects(arg_8_0._heroMO.heroId, arg_8_0._heroMO.rank)[1] - var_8_3)

			var_8_1 = math.abs(var_8_0 - var_8_2) > var_8_4 / 100
		end

		if var_8_1 then
			arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_8_2, var_8_0, var_0_3, arg_8_0.tweenFrame, arg_8_0.tweenFinish, arg_8_0)
		end
	else
		arg_8_0._scrolllv.horizontalNormalizedPosition = var_8_0
	end
end

function var_0_0._onMaxLevelClick(arg_9_0)
	arg_9_0:_onClickLevel(arg_9_0._maxCanUpLevel)
end

function var_0_0._onUpLevelLongPress(arg_10_0)
	local var_10_0 = arg_10_0:getHeroLevel()

	if arg_10_0._targetLevel - var_10_0 == 1 then
		arg_10_0.longPress = true

		arg_10_0:_onUpLevelClick()
	end
end

function var_0_0._onClickUp(arg_11_0)
	if not arg_11_0._heroMO or not arg_11_0.longPress then
		return
	end

	arg_11_0.longPress = false

	arg_11_0:_localLevelUpConfirmSend()
end

function var_0_0._onUpLevelClick(arg_12_0)
	local var_12_0 = UIBlockMgr.instance:isBlock()
	local var_12_1 = arg_12_0:checkScrollMove(true)

	if var_12_0 or not arg_12_0._heroMO or arg_12_0._isDrag or arg_12_0._tweenId or not var_12_1 then
		return
	end

	local var_12_2 = arg_12_0:getHeroLevel()
	local var_12_3 = var_12_2 < arg_12_0._targetLevel
	local var_12_4 = CharacterModel.instance:isHeroLevelReachCeil(arg_12_0._heroMO.heroId, var_12_2)

	if var_12_3 and not var_12_4 then
		arg_12_0:_localLevelUp(arg_12_0._targetLevel)

		if GuideController.instance:isGuiding() and GuideModel.instance:getDoingGuideId() == CharacterEnum.LevelUpGuideId then
			arg_12_0:_localLevelUpConfirmSend()
		end
	else
		arg_12_0._btnuplevellongpress:RemoveLongPressListener()
		arg_12_0._btnuplevel:RemoveClickListener()
		arg_12_0._btnuplevel:RemoveClickUpListener()
		arg_12_0:_refreshView()

		if not arg_12_0.longPress then
			AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
		end
	end
end

function var_0_0._localLevelUp(arg_13_0, arg_13_1)
	if not arg_13_0._heroMO then
		return
	end

	local var_13_0 = arg_13_0._heroMO.heroId
	local var_13_1 = arg_13_0:getHeroLevel(true)
	local var_13_2 = arg_13_0:getHeroLevel()
	local var_13_3 = arg_13_1 or var_13_2 + 1

	if var_13_3 > CharacterModel.instance:getrankEffects(var_13_0, arg_13_0._heroMO.rank)[1] or var_13_3 <= var_13_2 then
		return
	end

	local var_13_4 = HeroConfig.instance:getLevelUpItems(var_13_0, var_13_1, var_13_3)

	if var_13_4 then
		local var_13_5, var_13_6, var_13_7 = ItemModel.instance:hasEnoughItems(var_13_4)

		if not var_13_6 then
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, var_13_7, var_13_5)
			arg_13_0:_localLevelUpConfirmSend()

			return
		end
	end

	arg_13_0._lastHeroLevel = var_13_2

	arg_13_0:playLevelUpEff(var_13_3)
	arg_13_0.viewContainer:setLocalUpLevel(var_13_3)
	TaskDispatcher.cancelTask(arg_13_0._delayRefreshView, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._delayRefreshView, arg_13_0, var_0_4)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, var_13_4)

	if CharacterModel.instance:isHeroLevelReachCeil(var_13_0, var_13_3) then
		arg_13_0._btnuplevellongpress:RemoveLongPressListener()
		arg_13_0._btnuplevel:RemoveClickListener()
		arg_13_0._btnuplevel:RemoveClickUpListener()
		arg_13_0:_localLevelUpConfirmSend(true)
	end
end

function var_0_0._delayRefreshView(arg_14_0)
	arg_14_0:_refreshView()

	local var_14_0 = arg_14_0._heroMO.heroId
	local var_14_1 = arg_14_0:getHeroLevel()
	local var_14_2 = true

	if not arg_14_0.longPress then
		var_14_2 = false

		local var_14_3 = arg_14_0._lastHeroLevel and var_14_1 - arg_14_0._lastHeroLevel == 1
		local var_14_4 = CharacterModel.instance:isHeroLevelReachCeil(var_14_0, var_14_1)

		if var_14_3 and not var_14_4 then
			local var_14_5 = arg_14_0:getHeroLevel(true)
			local var_14_6 = HeroConfig.instance:getLevelUpItems(var_14_0, var_14_5, var_14_1 + 1)

			if var_14_6 then
				local var_14_7, var_14_8, var_14_9 = ItemModel.instance:hasEnoughItems(var_14_6)

				var_14_2 = var_14_8
			end
		end
	end

	arg_14_0._lastHeroLevel = nil

	arg_14_0:_resetLevelScrollPos(var_14_2)
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUpAttribute, var_14_1, var_14_0)
end

function var_0_0._localLevelUpConfirmSend(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0._heroMO.heroId
	local var_15_1 = arg_15_0:getHeroLevel()
	local var_15_2 = var_15_1 > arg_15_0:getHeroLevel(true)
	local var_15_3 = CharacterModel.instance:isHeroLevelReachCeil(var_15_0)

	if var_15_2 and not var_15_3 then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem, {}, true)
		HeroRpc.instance:sendHeroLevelUpRequest(var_15_0, var_15_1, arg_15_0._localLevelUpConfirmSendCallback, arg_15_0)
		arg_15_0.viewContainer:setWaitHeroLevelUpRefresh(true)
	elseif arg_15_1 then
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
		arg_15_0:_refreshView()
	end
end

function var_0_0._localLevelUpConfirmSendCallback(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.viewContainer:setWaitHeroLevelUpRefresh(false)
	arg_16_0.viewContainer:setLocalUpLevel()
	CharacterController.instance:dispatchEvent(CharacterEvent.levelUplocalItem)
end

function var_0_0._btninsightOnClick(arg_17_0)
	local function var_17_0()
		CharacterController.instance:openCharacterRankUpView(arg_17_0._heroMO)
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.showCharacterRankUpView, var_17_0)
	arg_17_0:closeThis()
end

function var_0_0._btnitemOnClick(arg_19_0, arg_19_1)
	local var_19_0 = tonumber(arg_19_1.type)
	local var_19_1 = tonumber(arg_19_1.id)
	local var_19_2 = {
		type = var_19_0,
		id = var_19_1,
		quantity = tonumber(arg_19_1.quantity),
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	}

	MaterialTipController.instance:showMaterialInfo(var_19_0, var_19_1, false, nil, nil, var_19_2)
	arg_19_0:_localLevelUpConfirmSend()
end

function var_0_0._onItemChanged(arg_20_0)
	if arg_20_0.viewContainer:getWaitHeroLevelUpRefresh() then
		return
	end

	arg_20_0:_refreshConsume()
	arg_20_0:_refreshMaxCanUpLevel()
end

function var_0_0._onClickHeroEditItem(arg_21_0, arg_21_1)
	if not arg_21_1 or arg_21_1.heroId ~= arg_21_0._heroMO.heroId then
		arg_21_0:closeThis()
	end
end

function var_0_0._onClickLevel(arg_22_0, arg_22_1)
	if not arg_22_1 or not arg_22_0._heroMO then
		return
	end

	local var_22_0 = arg_22_1 > CharacterModel.instance:getrankEffects(arg_22_0._heroMO.heroId, arg_22_0._heroMO.rank)[1]
	local var_22_1 = arg_22_1 < arg_22_0:getHeroLevel()

	if var_22_0 or var_22_1 then
		return
	end

	arg_22_0._targetLevel = arg_22_1

	local var_22_2 = arg_22_0:calScrollPos(arg_22_0._targetLevel)
	local var_22_3 = arg_22_0._scrolllv.horizontalNormalizedPosition

	arg_22_0:killTween()

	arg_22_0._tweenId = ZProj.TweenHelper.DOTweenFloat(var_22_3, var_22_2, var_0_2, arg_22_0.tweenFrame, arg_22_0.tweenFinish, arg_22_0)
end

function var_0_0.tweenFrame(arg_23_0, arg_23_1)
	if not arg_23_0._scrolllv then
		return
	end

	arg_23_0._scrolllv.horizontalNormalizedPosition = arg_23_1
end

function var_0_0.tweenFinish(arg_24_0)
	arg_24_0._tweenId = nil

	arg_24_0:_selectToNearLevel()
end

function var_0_0.calScrollLevel(arg_25_0)
	local var_25_0

	if arg_25_0._scrolllv and arg_25_0._heroMO then
		local var_25_1 = arg_25_0:getHeroLevel()
		local var_25_2 = CharacterModel.instance:getrankEffects(arg_25_0._heroMO.heroId, arg_25_0._heroMO.rank)[1]
		local var_25_3 = var_25_2 - var_25_1
		local var_25_4 = arg_25_0._scrolllv.horizontalNormalizedPosition
		local var_25_5 = 1 / var_25_3

		var_25_0 = var_25_1

		for iter_25_0 = 1, var_25_3 do
			if var_25_4 < (iter_25_0 - 0.5) * var_25_5 then
				break
			end

			var_25_0 = var_25_1 + iter_25_0
		end

		var_25_0 = Mathf.Clamp(var_25_0, var_25_1, var_25_2)
	end

	return var_25_0
end

function var_0_0.calScrollPos(arg_26_0, arg_26_1)
	local var_26_0 = 0

	if arg_26_1 and arg_26_0._heroMO then
		local var_26_1 = arg_26_0:getHeroLevel()
		local var_26_2 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, arg_26_0._heroMO.rank)[1]

		var_26_0 = (arg_26_1 - var_26_1) / (var_26_2 - var_26_1)
		var_26_0 = Mathf.Clamp(var_26_0, 0, 1)
	end

	return var_26_0
end

function var_0_0._editableInitView(arg_27_0)
	arg_27_0._tips = arg_27_0:getUserDataTb_()

	for iter_27_0 = 1, 3 do
		arg_27_0._tips[iter_27_0] = gohelper.findChild(arg_27_0._gotips, "tips" .. tostring(iter_27_0))
	end

	arg_27_0._txtfulllevel = gohelper.findChild(arg_27_0._tips[1], "full")
	arg_27_0._tipitems = {}

	for iter_27_1 = 1, var_0_1 do
		local var_27_0 = arg_27_0:getUserDataTb_()

		var_27_0.go = gohelper.findChild(arg_27_0._tips[2], "item" .. tostring(iter_27_1))
		var_27_0.icon = gohelper.findChildSingleImage(var_27_0.go, "icon")
		var_27_0.value = gohelper.findChildText(var_27_0.go, "value")
		var_27_0.btn = gohelper.findChildButtonWithAudio(var_27_0.go, "bg")
		var_27_0.type = nil
		var_27_0.id = nil
		arg_27_0._tipitems[iter_27_1] = var_27_0
	end
end

function var_0_0.onUpdateParam(arg_28_0)
	arg_28_0:onOpen()
end

function var_0_0.onOpen(arg_29_0)
	arg_29_0:clearVar()

	arg_29_0._heroMO = arg_29_0.viewParam.heroMO
	arg_29_0._enterViewName = arg_29_0.viewParam.enterViewName

	arg_29_0:_setView()
	arg_29_0:_refreshView()
	arg_29_0:_resetLevelScrollPos(true, true)
end

function var_0_0.clearVar(arg_30_0)
	arg_30_0:killTween()

	arg_30_0._targetLevel = nil
	arg_30_0.previewLevel = nil
	arg_30_0._isDrag = false
	arg_30_0.longPress = false
	arg_30_0._lastHeroLevel = nil
	arg_30_0._skipScrollAudio = nil
	arg_30_0._maxCanUpLevel = nil
end

function var_0_0.killTween(arg_31_0)
	if arg_31_0._tweenId then
		ZProj.TweenHelper.KillById(arg_31_0._tweenId)

		arg_31_0._tweenId = nil
	end
end

function var_0_0._setView(arg_32_0)
	local var_32_0 = arg_32_0._enterViewName == ViewName.HeroGroupEditView

	if var_32_0 then
		arg_32_0._animGO.transform.anchorMin = Vector2(0, 0.5)
		arg_32_0._animGO.transform.anchorMax = Vector2(0, 0.5)
		arg_32_0._gorighttop.transform.anchorMin = Vector2(0, 1)
		arg_32_0._gorighttop.transform.anchorMax = Vector2(0, 1)

		recthelper.setAnchor(arg_32_0._animGO.transform, 677.22, -50.4)
		recthelper.setAnchor(arg_32_0._gorighttop.transform, 683, 1)
	else
		arg_32_0._animGO.transform.anchorMin = Vector2(1, 0.5)
		arg_32_0._animGO.transform.anchorMax = Vector2(1, 0.5)
		arg_32_0._gorighttop.transform.anchorMin = Vector2(1, 1)
		arg_32_0._gorighttop.transform.anchorMax = Vector2(1, 1)

		recthelper.setAnchor(arg_32_0._animGO.transform, 0, 0)
		recthelper.setAnchor(arg_32_0._gorighttop.transform, -50, -50)
	end

	gohelper.setActive(arg_32_0._btnclose.gameObject, not var_32_0)
	gohelper.setActive(arg_32_0._goherogroupbg, var_32_0)
	gohelper.setActive(arg_32_0._gocharacterbg, not var_32_0)
end

function var_0_0._refreshView(arg_33_0)
	arg_33_0:_refreshLevelHorizontal()
	arg_33_0:_refreshLevelScroll()
	arg_33_0:_refreshMaxCanUpLevel()
end

function var_0_0._refreshLevelScroll(arg_34_0)
	local var_34_0 = arg_34_0._heroMO.heroId
	local var_34_1 = arg_34_0:getHeroLevel()
	local var_34_2 = CharacterModel.instance:isHeroLevelReachCeil(var_34_0, var_34_1)

	if var_34_2 then
		local var_34_3 = HeroConfig.instance:getShowLevel(var_34_1)

		arg_34_0._txtfulllvnum.text = var_34_3

		gohelper.setActive(arg_34_0._tips[2], false)
		gohelper.setActive(arg_34_0._tips[3], false)
		gohelper.setActive(arg_34_0._goupgrade, false)
		gohelper.setActive(arg_34_0._golevelupbeffect, false)

		local var_34_4 = CharacterModel.instance:isHeroRankReachCeil(var_34_0)

		gohelper.setActive(arg_34_0._btninsight.gameObject, not var_34_4)
		CharacterController.instance:dispatchEvent(CharacterEvent.levelUpChangePreviewLevel, var_34_1)
	else
		gohelper.setActive(arg_34_0._btninsight.gameObject, false)
		CharacterLevelListModel.instance:setCharacterLevelList(arg_34_0._heroMO, var_34_1)
		TaskDispatcher.cancelTask(arg_34_0.dispatchLevelScrollChange, arg_34_0)
		TaskDispatcher.runDelay(arg_34_0.dispatchLevelScrollChange, arg_34_0, var_0_5)
	end

	gohelper.setActive(arg_34_0._tips[1], var_34_2)
	gohelper.setActive(arg_34_0._golv, not var_34_2)
	gohelper.setActive(arg_34_0._golvfull, var_34_2)
end

function var_0_0.getContentOffset(arg_35_0)
	return transformhelper.getLocalPos(arg_35_0._translvcontent)
end

function var_0_0.dispatchLevelScrollChange(arg_36_0)
	local var_36_0 = arg_36_0:getContentOffset()

	CharacterController.instance:dispatchEvent(CharacterEvent.levelScrollChange, var_36_0)
end

function var_0_0._refreshConsume(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0._heroMO.heroId
	local var_37_1 = arg_37_0:getHeroLevel()

	if CharacterModel.instance:isHeroLevelReachCeil(var_37_0, var_37_1) then
		return
	end

	local var_37_2 = arg_37_1 or arg_37_0._targetLevel
	local var_37_3 = var_37_2 == var_37_1

	gohelper.setActive(arg_37_0._tips[2], not var_37_3)

	if var_37_3 then
		gohelper.setActive(arg_37_0._golevelupbeffect, false)

		return
	end

	local var_37_4 = true
	local var_37_5 = HeroConfig.instance:getLevelUpItems(var_37_0, var_37_1, var_37_2)
	local var_37_6 = arg_37_0:getLocalCost()

	for iter_37_0, iter_37_1 in ipairs(var_37_5) do
		local var_37_7 = arg_37_0._tipitems[iter_37_0]

		if var_37_7 then
			local var_37_8 = tonumber(iter_37_1.type)
			local var_37_9 = tonumber(iter_37_1.id)
			local var_37_10 = var_37_7.type == var_37_8
			local var_37_11 = var_37_7.id == var_37_9

			if not var_37_10 or not var_37_11 then
				local var_37_12, var_37_13 = ItemModel.instance:getItemConfigAndIcon(var_37_8, var_37_9)

				var_37_7.icon:LoadImage(var_37_13)
				var_37_7.btn:RemoveClickListener()
				var_37_7.btn:AddClickListener(arg_37_0._btnitemOnClick, arg_37_0, iter_37_1)

				var_37_7.type = var_37_8
				var_37_7.id = var_37_9
			end

			local var_37_14 = ItemModel.instance:getItemQuantity(var_37_8, var_37_9)

			if var_37_6 and var_37_6[var_37_8] and var_37_6[var_37_8][var_37_9] then
				var_37_14 = var_37_14 - var_37_6[var_37_8][var_37_9]
			end

			local var_37_15 = tonumber(iter_37_1.quantity)

			if var_37_14 < var_37_15 then
				var_37_7.value.text = "<color=#cc492f>" .. tostring(GameUtil.numberDisplay(var_37_15)) .. "</color>"
				var_37_4 = false
			else
				var_37_7.value.text = tostring(GameUtil.numberDisplay(var_37_15))
			end

			gohelper.setActive(var_37_7.go, true)
		end
	end

	local var_37_16 = #var_37_5

	if var_37_16 < var_0_1 then
		for iter_37_2 = var_37_16 + 1, var_0_1 do
			local var_37_17 = arg_37_0._tipitems[iter_37_2]

			gohelper.setActive(var_37_17 and var_37_17.go, false)
		end
	end

	gohelper.setActive(arg_37_0._golevelupbeffect, var_37_4)
	ZProj.UGUIHelper.SetGrayscale(arg_37_0._goupgrade, not var_37_4)
	ZProj.UGUIHelper.SetGrayscale(arg_37_0._goupgradetexten, not var_37_4)
end

function var_0_0._refreshLevelHorizontal(arg_38_0)
	if not arg_38_0._heroMO then
		return
	end

	local var_38_0 = arg_38_0._heroMO.heroId
	local var_38_1 = 0
	local var_38_2 = arg_38_0:getHeroLevel()
	local var_38_3

	if CharacterModel.instance:isHeroLevelReachCeil(var_38_0, var_38_2) then
		var_38_3 = 1
	else
		local var_38_4 = arg_38_0._heroMO.rank
		local var_38_5 = CharacterModel.instance:getrankEffects(var_38_0, var_38_4 - 1)[1]
		local var_38_6 = CharacterModel.instance:getrankEffects(var_38_0, var_38_4)[1]

		var_38_3 = (var_38_2 - var_38_5) / (var_38_6 - var_38_5)
	end

	if arg_38_0._lvCtrl then
		arg_38_0._lvCtrl.float_01 = var_38_3

		arg_38_0._lvCtrl:SetProps()
	end
end

function var_0_0._refreshPreviewLevelHorizontal(arg_39_0, arg_39_1)
	if not arg_39_0._heroMO then
		return
	end

	local var_39_0 = arg_39_1 or arg_39_0._targetLevel
	local var_39_1 = 0
	local var_39_2 = arg_39_0._heroMO.heroId
	local var_39_3 = arg_39_0:getHeroLevel()
	local var_39_4 = CharacterModel.instance:isHeroLevelReachCeil(var_39_2, var_39_3)
	local var_39_5 = arg_39_1 == var_39_3

	if var_39_4 or var_39_5 then
		gohelper.setActive(arg_39_0._goprevieweff, false)

		return
	end

	local var_39_6 = arg_39_0._heroMO.rank
	local var_39_7 = CharacterModel.instance:getrankEffects(var_39_2, var_39_6 - 1)[1]
	local var_39_8 = CharacterModel.instance:getrankEffects(var_39_2, var_39_6)[1]
	local var_39_9 = (var_39_0 - var_39_7) / (var_39_8 - var_39_7)

	if arg_39_0._previewlvCtrl then
		arg_39_0._previewlvCtrl.float_01 = var_39_9

		arg_39_0._previewlvCtrl:SetProps()
	end

	gohelper.setActive(arg_39_0._goprevieweff, true)
end

function var_0_0._refreshMaxCanUpLevel(arg_40_0)
	arg_40_0._maxCanUpLevel = nil

	if arg_40_0._heroMO then
		local var_40_0 = arg_40_0._heroMO.heroId
		local var_40_1 = arg_40_0:getLocalCost()
		local var_40_2 = arg_40_0:getHeroLevel()
		local var_40_3 = CharacterModel.instance:getrankEffects(var_40_0, arg_40_0._heroMO.rank)[1]

		for iter_40_0 = var_40_2 + 1, var_40_3 do
			local var_40_4 = true
			local var_40_5 = HeroConfig.instance:getLevelUpItems(var_40_0, var_40_2, iter_40_0)

			for iter_40_1, iter_40_2 in ipairs(var_40_5) do
				local var_40_6 = tonumber(iter_40_2.type)
				local var_40_7 = tonumber(iter_40_2.id)
				local var_40_8 = tonumber(iter_40_2.quantity)
				local var_40_9 = ItemModel.instance:getItemQuantity(var_40_6, var_40_7)

				if var_40_1 and var_40_1[var_40_6] and var_40_1[var_40_6][var_40_7] then
					var_40_9 = var_40_9 - var_40_1[var_40_6][var_40_7]
				end

				if var_40_9 < var_40_8 then
					var_40_4 = false

					break
				end
			end

			if not var_40_4 then
				break
			end

			arg_40_0._maxCanUpLevel = iter_40_0
		end
	end

	local var_40_10 = arg_40_0._maxCanUpLevel and HeroConfig.instance:getShowLevel(arg_40_0._maxCanUpLevel) or ""

	arg_40_0._txtmax.text = formatLuaLang("v1a5_aizila_level", var_40_10)

	arg_40_0:_refreshMaxBtnStatus()
end

function var_0_0._refreshMaxBtnStatus(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_1 or arg_41_0._targetLevel

	if not arg_41_0._heroMO or not var_41_0 or not arg_41_0._maxCanUpLevel then
		gohelper.setActive(arg_41_0._gomax, false)

		return
	end

	gohelper.setActive(arg_41_0._gomax, var_41_0 ~= arg_41_0._maxCanUpLevel)
	gohelper.setActive(arg_41_0._gomaxlarrow, var_41_0 > arg_41_0._maxCanUpLevel)
	gohelper.setActive(arg_41_0._gomaxrarrow, var_41_0 < arg_41_0._maxCanUpLevel)
end

function var_0_0._resetLevelScrollPos(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0:killTween()

	arg_42_0.previewLevel = nil

	if not arg_42_0._scrolllv then
		return
	end

	arg_42_0._skipScrollAudio = true

	local var_42_0 = arg_42_0:getHeroLevel()

	if arg_42_0._heroMO and arg_42_1 then
		local var_42_1 = arg_42_0._heroMO.heroId
		local var_42_2 = arg_42_0._heroMO.rank
		local var_42_3 = CharacterModel.instance:getrankEffects(var_42_1, var_42_2)[1]

		arg_42_0._targetLevel = math.min(var_42_0 + 1, var_42_3)

		if arg_42_2 then
			TaskDispatcher.cancelTask(arg_42_0.delaySetScrollPos, arg_42_0)
			TaskDispatcher.runDelay(arg_42_0.delaySetScrollPos, arg_42_0, var_0_5)
		else
			local var_42_4 = arg_42_0:calScrollPos(arg_42_0._targetLevel)

			arg_42_0._scrolllv.horizontalNormalizedPosition = var_42_4
		end
	else
		arg_42_0._scrolllv.horizontalNormalizedPosition = 0
		arg_42_0._targetLevel = var_42_0 or 0
	end
end

function var_0_0.delaySetScrollPos(arg_43_0)
	local var_43_0 = arg_43_0:calScrollPos(arg_43_0._targetLevel)

	arg_43_0._scrolllv.horizontalNormalizedPosition = var_43_0
end

function var_0_0.getHeroLevel(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0.viewContainer:getLocalUpLevel()

	if not var_44_0 or arg_44_1 then
		var_44_0 = arg_44_0._heroMO and arg_44_0._heroMO.level
	end

	return var_44_0
end

function var_0_0.getLocalCost(arg_45_0)
	local var_45_0 = {}

	if arg_45_0._heroMO then
		local var_45_1 = arg_45_0:getHeroLevel(true)
		local var_45_2 = arg_45_0:getHeroLevel()
		local var_45_3 = HeroConfig.instance:getLevelUpItems(arg_45_0._heroMO.heroId, var_45_1, var_45_2)

		for iter_45_0 = 1, #var_45_3 do
			local var_45_4 = var_45_3[iter_45_0]

			var_45_0[var_45_4.type] = var_45_0[var_45_4.type] or {}
			var_45_0[var_45_4.type][var_45_4.id] = (var_45_0[var_45_4.type][var_45_4.id] or 0) + var_45_4.quantity
		end
	end

	return var_45_0
end

function var_0_0.playLevelUpEff(arg_46_0, arg_46_1)
	if arg_46_0._anim then
		arg_46_0._anim:Play(UIAnimationName.Click, 0, 0)
	end

	if arg_46_0._waveAnimation then
		arg_46_0._waveAnimation:Stop()
		arg_46_0._waveAnimation:Play()
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_upgrade_2)
	CharacterController.instance:dispatchEvent(CharacterEvent.characterLevelItemPlayEff, arg_46_1)
end

function var_0_0.onClose(arg_47_0)
	arg_47_0:removeEvents()
	arg_47_0:clearVar()
	TaskDispatcher.cancelTask(arg_47_0.dispatchLevelScrollChange, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0.delaySetScrollPos, arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._delayRefreshView, arg_47_0)
	arg_47_0:_localLevelUpConfirmSend()
end

function var_0_0.onDestroyView(arg_48_0)
	for iter_48_0 = 1, 2 do
		local var_48_0 = arg_48_0._tipitems[iter_48_0]

		var_48_0.icon:UnLoadImage()
		var_48_0.btn:RemoveClickListener()

		var_48_0.type = nil
		var_48_0.id = nil
	end
end

return var_0_0

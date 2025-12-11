module("modules.logic.fight.view.FightPreDisplayView", package.seeall)

local var_0_0 = class("FightPreDisplayView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._obj = gohelper.findChild(arg_1_0.viewGO, "root/predisplay")
	arg_1_0._text = gohelper.findChildText(arg_1_0._obj, "#txt_CardNum")
	arg_1_0._btn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/predisplay")
	arg_1_0._ani = SLFramework.AnimatorPlayer.Get(arg_1_0._btn.gameObject)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnCameraFocusChanged, arg_2_0._onCameraFocusChanged, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.AddPlayOperationData, arg_2_0._onAddPlayOperationData, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_2_0._onResetCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_2_0.onStageChange, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillExpand, arg_2_0._onClothSkillExpand, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnClothSkillShrink, arg_2_0._onClothSkillShrink, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btn, arg_2_0._onBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onBtnClick(arg_5_0)
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	ViewMgr.instance:openView(ViewName.FightCardDeckView, {
		selectType = FightCardDeckView.SelectType.PreCard
	})
end

function var_0_0.onRefreshViewParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	gohelper.setActive(arg_7_0._obj, false)
	arg_7_0:_refreshUI()
end

function var_0_0._onResetCard(arg_8_0)
	gohelper.setActive(arg_8_0._obj, false)
	arg_8_0:_refreshUI()

	arg_8_0._lastCount = arg_8_0._curCardCount
	arg_8_0._isVisible = false
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0._cardList = FightHelper.getNextRoundGetCardList()
	arg_9_0._curCardCount = #arg_9_0._cardList
	arg_9_0._text.text = luaLang("multiple") .. arg_9_0._curCardCount
end

function var_0_0._onAddPlayOperationData(arg_10_0)
	if FightDataHelper.fieldMgr:isDouQuQu() then
		return
	end

	arg_10_0:_refreshUI()

	if arg_10_0._curCardCount > 0 then
		arg_10_0._isVisible = true
	end

	if arg_10_0._lastCount then
		if #arg_10_0._cardList > arg_10_0._lastCount then
			arg_10_0:_playAni("fiy")
		end
	elseif #arg_10_0._cardList > 0 then
		arg_10_0:_playAni("open")
	end

	arg_10_0._lastCount = #arg_10_0._cardList
end

function var_0_0._playAni(arg_11_0, arg_11_1)
	arg_11_0._state = arg_11_1

	gohelper.setActive(arg_11_0._obj, true)
	arg_11_0._ani:Play(arg_11_1, arg_11_0._aniDone, arg_11_0)
end

function var_0_0._aniDone(arg_12_0)
	if arg_12_0._state == "close" then
		gohelper.setActive(arg_12_0._obj, false)
	end
end

function var_0_0._setActive(arg_13_0, arg_13_1)
	if arg_13_1 then
		if arg_13_0._isVisible then
			arg_13_0:_playAni("open")
		end
	elseif arg_13_0._isVisible then
		arg_13_0:_playAni("close")
	end
end

function var_0_0._hide(arg_14_0)
	if arg_14_0._isVisible then
		arg_14_0:_playAni("close")
	end
end

function var_0_0._onCameraFocusChanged(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0:_setActive(false)
	else
		arg_15_0:_setActive(true)
	end
end

function var_0_0.onStageChange(arg_16_0, arg_16_1)
	if arg_16_1 == FightStageMgr.StageType.Play then
		gohelper.setActive(arg_16_0._obj, false)

		arg_16_0._isVisible = false
		arg_16_0._lastCount = nil
	end
end

function var_0_0._onClothSkillExpand(arg_17_0)
	arg_17_0:_setActive(false)
end

function var_0_0._onClothSkillShrink(arg_18_0)
	arg_18_0:_setActive(true)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

return var_0_0

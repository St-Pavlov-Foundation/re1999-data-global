module("modules.logic.turnback.view.TurnbackSignInItem", package.seeall)

slot0 = class("TurnbackSignInItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gonormalBG = gohelper.findChild(slot0.go, "Root/#go_normalBG")
	slot0._gocangetBG = gohelper.findChild(slot0.go, "Root/#go_cangetBG")
	slot0._btncanget = gohelper.findChildButtonWithAudio(slot0.go, "Root/#go_getclick")
	slot0._txtday = gohelper.findChildText(slot0.go, "Root/#txt_day")
	slot0._txtdayEn = gohelper.findChildText(slot0.go, "Root/#txt_dayEn")
	slot0._gotomorrowTag = gohelper.findChild(slot0.go, "Root/#go_tomorrowTag")
	slot0._goitemContent = gohelper.findChild(slot0.go, "Root/#go_itemContent")
	slot0._gohasget = gohelper.findChild(slot0.go, "Root/#go_hasget")
	slot0._gogetIconContent = gohelper.findChild(slot0.go, "Root/#go_hasget/#go_getIconContent")
	slot0._gogeticon = gohelper.findChild(slot0.go, "Root/#go_hasget/#go_getIconContent/#go_geticon")
	slot0._animator = slot0.go:GetComponent(typeof(UnityEngine.Animator))
	slot0._goEffectCube = gohelper.findChild(slot0.go, "Root/#go_cangetBG/kelinqu")

	gohelper.setActive(slot0.go, false)
	gohelper.setActive(slot0._gogeticon, false)

	slot0._itemsTab = {}
	slot0._firstEnter = true
	slot0._openAnimTime = 0.97
end

function slot0.addEventListeners(slot0)
	slot0._btncanget:AddClickListener(slot0._btncangetOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btncanget:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	if slot1 == nil then
		return
	end

	slot0.mo = slot1

	slot0:_refreshUI()

	slot0._delayTime = slot0._index * 0.03

	if slot0._firstEnter then
		TaskDispatcher.runDelay(slot0._playOpenAnim, slot0, slot0._delayTime)
	end
end

function slot0._refreshUI(slot0)
	slot0:_refreshBonus()

	slot0._txtday.text = string.format("%02d", slot0.mo.id)
	slot0._txtdayEn.text = string.format("DAY\n%s", GameUtil.getEnglishNumber(slot0.mo.id))

	gohelper.setActive(slot0._gocangetBG, slot0.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._btncanget.gameObject, slot0.mo.state == TurnbackEnum.SignInState.CanGet)
	gohelper.setActive(slot0._gohasget, slot0.mo.state == TurnbackEnum.SignInState.HasGet)
	gohelper.setActive(slot0._gotomorrowTag, TurnbackModel.instance:getCurSignInDay() + 1 == slot0.mo.id and slot2 ~= GameUtil.getTabLen(TurnbackSignInModel.instance:getSignInInfoMoList()))
end

function slot0._refreshBonus(slot0)
	slot0.config = slot0.mo.config

	gohelper.setActive(slot0._goEffectCube, #string.split(slot0.config.bonus, "|") < 2)

	for slot5 = 1, #slot1 do
		if not slot0._itemsTab[slot5] then
			table.insert(slot0._itemsTab, {
				item = IconMgr.instance:getCommonPropItemIcon(slot0._goitemContent),
				getIcon = gohelper.clone(slot0._gogeticon, slot0._gogetIconContent)
			})
		end

		slot7 = string.split(slot1[slot5], "#")

		slot6.item:setMOValue(slot7[1], slot7[2], slot7[3])
		slot6.item:setHideLvAndBreakFlag(true)
		slot6.item:hideEquipLvAndBreak(true)
		slot6.item:setCountFontSize(40)
		slot6.item:setPropItemScale(0.76)
		gohelper.setActive(slot0._itemsTab[slot5].item.go, true)
		gohelper.setActive(slot6.getIcon, true)
	end

	for slot5 = #slot1 + 1, #slot0._itemsTab do
		gohelper.setActive(slot0._itemsTab[slot5].item.go, false)
		gohelper.setActive(slot0._itemsTab[slot5].getIcon, false)
	end
end

function slot0._btncangetOnClick(slot0)
	if slot0.mo.state == TurnbackEnum.SignInState.CanGet then
		TurnbackRpc.instance:sendTurnbackSignInRequest(slot0.mo.turnbackId, slot0.mo.id)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_OK)
	end
end

function slot0._playOpenAnim(slot0)
	gohelper.setActive(slot0.go, true)
	slot0._animator:Play(UIAnimationName.Open, 0, slot0:_getOpenAnimPlayProgress())

	slot0._firstEnter = false
end

function slot0._getOpenAnimPlayProgress(slot0)
	return Mathf.Clamp01((UnityEngine.Time.realtimeSinceStartup - TurnbackSignInModel.instance:getOpenTimeStamp() - slot0._delayTime) / slot0._openAnimTime)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._playOpenAnim, slot0)
end

return slot0

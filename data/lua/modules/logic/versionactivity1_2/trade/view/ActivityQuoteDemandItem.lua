module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteDemandItem", package.seeall)

slot0 = class("ActivityQuoteDemandItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot0._simagebg = gohelper.findChildSingleImage(slot0.go, "simage_bg")

	slot0._simagebg:LoadImage(ResUrl.getVersionTradeBargainBg("img_changguidi"))

	slot0.goFinish = gohelper.findChild(slot0.go, "go_finish")
	slot0.txtCurProgress = gohelper.findChildTextMesh(slot0.go, "layout/left/txt_curcount")
	slot0.txtMaxProgress = gohelper.findChildTextMesh(slot0.go, "layout/right/txt_curcount")
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.go, "txt_desc")
	slot0.txtPricerange = gohelper.findChildTextMesh(slot0.go, "bargain/txt_pricerange")
	slot0.btnJump = gohelper.findChildButtonWithAudio(slot0.go, "btn_jump", AudioEnum.UI.play_ui_petrus_mission_skip)

	slot0.btnJump:AddClickListener(slot0.onClickJump, slot0)

	slot0.btnCancel = gohelper.findChildButtonWithAudio(slot0.go, "btn_cancel", AudioEnum.UI.Play_UI_Rolesback)

	slot0.btnCancel:AddClickListener(slot0.onClickCancel, slot0)

	slot0.btnBargain = gohelper.findChildButtonWithAudio(slot0.go, "btn_bargain")

	slot0.btnBargain:AddClickListener(slot0.onClickStartBargain, slot0)

	slot0._simageclickbg = gohelper.findChildSingleImage(slot0.go, "click/bg")

	slot0._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	slot0.index = slot3
	slot0.count = slot4
	slot0.callback = slot5
	slot0.callbackObj = slot6

	gohelper.setActive(slot0.go, true)

	slot7 = slot1:isProgressEnough()
	slot8 = slot1.hasGetBonus

	if slot1.id == Activity117Model.instance:getSelectOrder(slot1.activityId) then
		gohelper.setActive(slot0.btnCancel, true)
		gohelper.setActive(slot0.goFinish, false)
		gohelper.setActive(slot0.btnJump, false)
		gohelper.setActive(slot0.btnBargain, false)
	elseif slot2 then
		gohelper.setActive(slot0.goFinish, true)
		gohelper.setActive(slot0.btnJump, false)
		gohelper.setActive(slot0.btnBargain, false)
		gohelper.setActive(slot0.btnCancel, false)
	else
		gohelper.setActive(slot0.goFinish, slot8)
		gohelper.setActive(slot0.btnJump, not slot7 and not slot8)
		gohelper.setActive(slot0.btnBargain, slot7 and not slot8)
		gohelper.setActive(slot0.btnCancel, false)
	end

	slot0.txtCurProgress.text = (slot7 or slot8) and "1" or "0"
	slot0.txtMaxProgress.text = "1"
	slot0.txtDesc.text = slot1:getDesc() or ""
	slot0.txtPricerange.text = string.format("%s-%s", slot1.minScore, slot1.maxScore)

	if not slot0.playedAnim then
		slot0.playedAnim = true
		slot0.anim.speed = 0

		if (slot3 - 1) * 0.06 and slot10 > 0 then
			TaskDispatcher.runDelay(slot0.playOpenAnim, slot0, slot10)
		else
			slot0:playOpenAnim()
		end
	else
		slot0:checkDoCallback()
	end
end

function slot0.playOpenAnim(slot0)
	TaskDispatcher.cancelTask(slot0.playOpenAnim, slot0)

	slot0.anim.speed = 1

	slot0.anim:Play(UIAnimationName.Open, 0, 0)
	slot0:checkDoCallback()
end

function slot0.checkDoCallback(slot0)
	if slot0.index == slot0.count and slot0.callback then
		slot0.callback(slot0.callbackObj)

		slot0.callback = nil
	end
end

function slot0.onAllAnimFinish(slot0)
	if slot0.data then
		slot1 = gohelper.findChild(slot0.btnBargain.gameObject, "huan")

		gohelper.setActive(slot1, false)
		gohelper.setActive(slot1, true)
	end
end

function slot0.onClickStartBargain(slot0)
	if not slot0.data then
		return
	end

	slot1 = slot0.data
	slot2 = slot1.activityId

	Activity117Model.instance:setSelectOrder(slot2, slot1.id)
	Activity117Model.instance:setInQuote(slot2)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, slot2)
end

function slot0.onClickJump(slot0)
	if not (slot0.data and slot0.data.jumpId) then
		return
	end

	GameFacade.jump(slot1, nil, , {
		jumpId = 10011205,
		special = true,
		desc = luaLang("versionactivity_1_2_tradedemand"),
		sceneType = SceneType.Main,
		checkFunc = slot0.data.isProgressEnough,
		checkFuncObj = slot0.data
	})
end

function slot0.onClickCancel(slot0)
	if not slot0.data then
		return
	end

	slot1 = slot0.data.activityId

	Activity117Model.instance:setSelectOrder(slot1)
	Activity117Model.instance:setInQuote(slot1)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, slot1)
end

function slot0.destory(slot0)
	if slot0.btnBargain then
		slot0.btnBargain:RemoveClickListener()
	end

	if slot0.btnJump then
		slot0.btnJump:RemoveClickListener()
	end

	if slot0.btnCancel then
		slot0.btnCancel:RemoveClickListener()
	end

	slot0._simagebg:UnLoadImage()
	slot0._simageclickbg:UnLoadImage()
	TaskDispatcher.cancelTask(slot0.playOpenAnim, slot0)
	slot0:__onDispose()
end

return slot0

module("modules.logic.versionactivity2_5.act186.view.Activity186GameBiscuitsView", package.seeall)

slot0 = class("Activity186GameBiscuitsView", BaseView)

function slot0.onInitView(slot0)
	slot0.goUnopen = gohelper.findChild(slot0.viewGO, "unopen")
	slot0.goOpened = gohelper.findChild(slot0.viewGO, "opened")
	slot0.txtReward = gohelper.findChildTextMesh(slot0.viewGO, "opened/#txt_reward")
	slot0.anim = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addTouchEvents()
end

function slot0.removeEvents(slot0)
	if not gohelper.isNil(slot0._touchEventMgr) then
		TouchEventMgrHepler.remove(slot0._touchEventMgr)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.config = slot0.viewParam.config
	slot0.act186Id = slot0.viewParam.act186Id
	slot0.actId = slot0.config.activityId
	slot0.id = slot0.config.id
	slot0.status = Activity186Enum.GameStatus.Start

	if Activity186SignModel.instance:getSignStatus(slot0.actId, slot0.act186Id, slot0.id) == Activity186Enum.SignStatus.Canplay then
		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_help_switch)
		slot0.anim:Play("open")
		slot0:startGame()
	else
		slot0.anim:Play("open1")
		slot0:showResult()
	end
end

function slot0.startGame(slot0)
	slot0.status = Activity186Enum.GameStatus.Playing
end

function slot0.showResult(slot0)
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_cookies_open)

	slot0.status = Activity186Enum.GameStatus.Result

	Activity186Model.instance:setLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, slot0.act186Id, slot0.id, 1)

	slot0.txtReward.text = luaLang(string.format("act186_signview_day%s", slot0.id))
end

function slot0.addTouchEvents(slot0)
	if slot0._touchEventMgr then
		return
	end

	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0.viewGO)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnlyTouch(true)
	slot0._touchEventMgr:SetOnClickCb(slot0.onClickBtnClose, slot0)
	slot0._touchEventMgr:SetOnDragEndCb(slot0._onDragEnd, slot0)
end

function slot0._onDragEnd(slot0)
	if slot0.status == Activity186Enum.GameStatus.Playing then
		slot0.anim:Play("opened")
		slot0:showResult()
	end
end

function slot0.onClose(slot0)
	if slot0.status == Activity186Enum.GameStatus.Result and slot0.actId and slot0.id and ActivityType101Model.instance:isType101RewardCouldGet(slot0.actId, slot0.id) then
		Activity101Rpc.instance:sendGet101BonusRequest(slot0.actId, slot0.id)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0

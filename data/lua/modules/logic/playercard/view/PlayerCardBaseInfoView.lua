module("modules.logic.playercard.view.PlayerCardBaseInfoView", package.seeall)

slot0 = class("PlayerCardBaseInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btntips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_tips")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "#go_tips")
	slot0._btntipsclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tips/#btn_close")
	slot0._txtchoose = gohelper.findChildText(slot0.viewGO, "#btn_confirm/#txt_choose")
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._tipopen = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btntips:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0._btntipsclose:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SelectNumChange, slot0._onNumChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btntips:RemoveClickListener()
	slot0._btntipsclose:RemoveClickListener()
end

function slot0._btnconfirmOnClick(slot0)
	PlayerCardBaseInfoModel.instance:confirmData()
	slot0:closeThis()
end

function slot0._btntipsOnClick(slot0)
	slot0._tipopen = not slot0._tipopen

	gohelper.setActive(slot0._gotips, slot0._tipopen)
end

function slot0._btncloseOnClick(slot0)
	slot0.viewContainer:checkCloseFunc()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.playercardinfo = slot0.viewParam

	slot0.animator:Play("open")
	PlayerCardBaseInfoModel.instance:initSelectData(slot0.playercardinfo)
	slot0:refreshView()
	slot0:refreshNum()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)
end

function slot0.refreshView(slot0)
	PlayerCardBaseInfoModel.instance:refreshList()
end

function slot0._onNumChange(slot0)
	slot0:refreshNum()
end

function slot0.refreshNum(slot0)
	slot0._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		PlayerCardBaseInfoModel.instance:getSelectNum(),
		PlayerCardEnum.MaxBaseInfoNum
	})
end

function slot0.onClose(slot0)
	slot0.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBaseInfoView)
end

function slot0.onDestroyView(slot0)
end

return slot0

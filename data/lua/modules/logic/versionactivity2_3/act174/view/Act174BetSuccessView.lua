module("modules.logic.versionactivity2_3.act174.view.Act174BetSuccessView", package.seeall)

slot0 = class("Act174BetSuccessView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._txtRule = gohelper.findChildText(slot0.viewGO, "#txt_Rule")
	slot0._imageHpPercent = gohelper.findChildImage(slot0.viewGO, "hp/bg/fill")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.maxHp = tonumber(lua_activity174_const.configDict[Activity174Enum.ConstKey.InitHealth].value)
	slot0.hpEffList = slot0:getUserDataTb_()

	for slot4 = 1, slot0.maxHp do
		slot0.hpEffList[#slot0.hpEffList + 1] = gohelper.findChild(slot0.viewGO, "hp/bg/#hp0" .. slot4)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._imageHpPercent.fillAmount = Activity174Model.instance:getActInfo():getGameInfo().hp / slot0.maxHp

	for slot6 = 1, slot0.maxHp do
		gohelper.setActive(slot0.hpEffList[slot6], slot6 == slot2.hp)
	end

	TaskDispatcher.runDelay(slot0.closeThis, slot0, 3)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

return slot0

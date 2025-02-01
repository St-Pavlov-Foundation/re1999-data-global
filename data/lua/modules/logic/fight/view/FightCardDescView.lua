module("modules.logic.fight.view.FightCardDescView", package.seeall)

slot0 = class("FightCardDescView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._gocardlist = gohelper.findChild(slot0.viewGO, "#go_cardlist")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	for slot4, slot5 in ipairs(lua_card_description.configList) do
		slot0:_addCardItem(slot5, slot4 == #lua_card_description.configList)
	end
end

function slot0._addCardItem(slot0, slot1, slot2)
	MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocardlist), FightCardDescItem):onUpdateMO(slot1, slot2)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
